check_wired_connection() {
WIRED_INTERFACE=$(ip link show | grep -E '^[0-9]+: (eth|en)' | awk -F: '{print $2}' | tr -d ' ')
IP4_ADDRESS=$(ip addr show $WIRED_DEVICE | awk '$1 == "inet" && $2 != "127.0.0.1/8" {gsub(/\/.*$/, "", $2); print $2}')
if [ -n "$WIRED_INTERFACE" ] && [ -n "$IP4_ADDRESS" ]; then
    echo "Wired Connection Detected (IP Address = ${IP4_ADDRESS})"
    sleep 1
    echo "Skipping WiFi Setup"
    sleep 1
    check_network_connection
else
	echo "No Wired Connection Detected! Trying WiFi Instead! "
	sleep 1
connect_to_wifi
fi
}

check_for_wifi_device() {
echo "Checking For A Wi-Fi Device..."
WIFI_DEVICE=$(iwctl device list | awk '/wlan/{print $2}')
if [ -n "$WIFI_DEVICE" ]; then
	echo "WiFi Device Detected: ${WIFI_DEVICE}"
	sleep 1
	connect_to_wifi
else
	echo "No WiFi Device Detected! "
	sleep 1
	echo "Cannot Continue With Installation Script Unless A Valid Internet Connection Can Be Established! "
	return 1
fi
}

connect_to_wifi() {
echo "Let's Connect To A Wi-Fi Network"
sleep 1
echo "Enter The SSID For Your Wi-Fi Network:"
read SSID
echo "Enter Your SSID Password:"
read -s SSID_PASSWORD
sleep 1
echo "Connecting To Wi-Fi SSID - ${SSID}..."
OUTPUT=$(iwctl station "${WIFI_DEVICE}" connect "${SSID}" -P "${SSID_PASSWORD}" 2>&1)
sleep 1
if [ -n "$OUTPUT" ]; then
	echo "Error Connecting To WiFi SSID - ${SSID}! "
	sleep 1
	on_error_try_again
	if [ $? -eq 0 ]; then
	connect_to_wifi
	else
	return 1
	fi
fi
}

on_error_try_again() {
while true; do
	echo "Would You Like To Try Again Or Exit The Installation Script? (Y)es Or (N)o"
	sleep 1
	read USER_INPUT
	case $USER_INPUT in
		Y|y)
			return 0
		;;
		N|n)
			echo "Exiting The Installation Script :("
			return 1
		;;
		*)
			echo "Invalid Input Detect, Please Enter 'Y/y', Or 'N/n'"
			;;
	esac
done
}

check_network_connection() {
    local TEST_HOST="archlinux.org"
    echo "Testing Network Connection - Pinging ${TEST_HOST}..."
    sleep 1
    if ping -c 1 $TEST_HOST &>/dev/null; then
        echo "Ping Sucessfull - Network Connection Is Good :)"
        return 0
    else
		echo "Unable To Reach ${TEST_HOST}! "
		sleep 1
		on_error_try_again
		if [ $? -eq 0 ]; then
		check_network_connection
		else
		return 1
		fi
	fi
}
