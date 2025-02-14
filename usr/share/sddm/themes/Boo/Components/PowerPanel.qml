import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    implicitHeight: powerButton.height
    implicitWidth: powerButton.width

    ListModel {
        id: powerModel
        ListElement { name: "" }
        ListElement { name: "" }
        ListElement { name: "" }
    }

    Button {
        id: powerButton
        height: inputHeight
        width: inputHeight
        hoverEnabled: true
        icon.source: Qt.resolvedUrl("../Icons/Power.svg")
        icon.height: height
        icon.width: width
        icon.color: config.PowerIconColor

        background: Rectangle {
            id: powerButtonBg
            color: config.PowerButtonColor
            radius: config.CornerRadius
        }

        states: [
            State {
                name: "pressed"
                when: powerButton.down
                
                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonColor, 1.2)
                }
            },
            
            State {
                name: "hovered"
                when: powerButton.hovered
                
                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonColor, 1.2)
                }
            },
            
            State {
                name: "selection"
                when: powerPopup.visible
                
                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonColor, 1.2)
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }
        }

        onClicked: {
            powerPopup.visible ? powerPopup.close() : powerPopup.open()
            powerButton.state = "pressed"
        }
    }

    Popup {
        id: powerPopup
        height: inputHeight * 1.4 + padding * 2
        x: powerButton.width + powerList.spacing
        y: -height + powerButton.height
        padding: 15

        background: Rectangle {
            radius: config.CornerRadius * 1.4
            color: config.PopupBgColor
        }

        contentItem: ListView {
            id: powerList
            implicitWidth: contentWidth
            spacing: 8
            orientation: Qt.Horizontal
            clip: true
            model: powerModel
            
            delegate: ItemDelegate {
                id: powerEntry
                height: inputHeight * 1.4
                width: inputHeight * 1.4
                display: AbstractButton.TextUnderIcon

                contentItem: Item {
                    Image {
                        id: powerIcon
                        anchors.centerIn: parent
                        source: index == 0 ? Qt.resolvedUrl("../Icons/Sleep.svg") : (index == 1 ? Qt.resolvedUrl("../Icons/Restart.svg") : Qt.resolvedUrl("../Icons/Power.svg"))
                        sourceSize: Qt.size(powerEntry.width * 0.5, powerEntry.height * 0.5)
                    }

                    ColorOverlay {
                        id: iconOverlay
                        anchors.fill: powerIcon
                        source: powerIcon
                        color: config.PopupTextFieldTextColor
                    }

                    Text {
                        id: powerText
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        font.family: config.Font
                        font.pointSize: config.GeneralFontSize
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        color: config.PopupBgColor
                        text: name
                        opacity: 0
                    }
                }

                background: Rectangle {
                    id: powerEntryBg
                    color: config.PopupHighlightColor
                    radius: config.CornerRadius
                }

                states: [
                    State {
                        name: "hovered"
                        when: powerEntry.hovered
                        
                        PropertyChanges {
                            target: powerEntryBg
                            color: config.PopupHoverColor
                        }
                        
                        PropertyChanges {
                            target: iconOverlay
                        }
                        
                        PropertyChanges {
                            target: powerText
                            opacity: 1
                        }
                    }
                ]

                transitions: Transition {
                    PropertyAnimation {
                        properties: "color, opacity"
                        duration: 150
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    
                    onClicked: {
                        powerPopup.close()
                        index == 0 ? sddm.suspend() : (index == 1 ? sddm.reboot() : sddm.powerOff())
                    }
                }
            }
        }

        enter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 400
                    easing.type: Easing.OutExpo
                }
                
                NumberAnimation {
                    property: "x"
                    from: powerPopup.x - (inputWidth * 0.1)
                    to: powerPopup.x
                    duration: 500
                    easing.type: Easing.OutExpo
                }
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }
        }
    }
}
