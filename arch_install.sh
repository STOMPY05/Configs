#!/bin/bash source arch_install_functions.sh

set -e

# Just For Testing
test_script() {

  # Script Variables ##################################################
  KEYMAP="uk"
  FONT="ter-116b"
  TIME_ZONE="America/Sao_Paulo"
  DISK="/dev/sda"

  # Installer Checks  ##################################################
  # Check That KEYMAP Is Valid
  if ! find /usr/share/kbd/keymaps/ -type f -name "${KEYMAP}.map.gz" -print -quit | grep -q .; then
    echo "Error - Invalid Key Map Detected! Exiting The Installer Script :("
    return 1
  fi

  #Check That TIME_ZONE Is Valid
  if ! timedatectl list-timezones | grep "^${TIME_ZONE}"$; then
    echo "Error - Invalid Time Zone Detected! Exiting The Installer Script :("
    return 1
  fi

  # Check That DISK Is Valid
  if [ ! -e "$DISK" ]; then
    echo "Error - Device $DISK Does Not Exist! Exiting The Installer Script :("
    return 1
  fi

  # Load Key Map & Set Console Font ##################################################
  echo "Loading ${KEYMAP} Key Map..."
  loadkeys ${KEYMAP}

  sleep 2
  echo ""
  echo ""

  # Set Terminal Font ##################################################
  echo "Setting Terminal Font To ${FONT}..."
  setfont ${FONT}

  sleep 2
  echo ""
  echo ""

  # Verify Boot Mode ##################################################
  echo "Checking The Current Systems Boot Mode..."
  BOOT_MODE=$(cat /sys/firmware/efi/fw_platform_size)
  if [ -z "$BOOT_MODE" ]; then
    echo "Boot Mode: BIOS"
  else
    echo "Boot Mode: UEFI ${BOOT_MODE}-Bit"
  fi

  sleep 2
  echo ""
  echo ""

  # Check For An Active Network Connection ##################################################

  # The Script Will Not Continue Unless One Is Present
  # The Below Script Is Sourced From "Functions.sh"
  check_wired_connection

  sleep 2
  echo ""
  echo ""

  # Update The System Clock & Set The TimeZone ##################################################
  echo "Enabling NTP..."
  timedatectl set-ntp true
  sleep 1
  echo "Setting Time Zone To ${TIME_ZONE}..."
  timedatectl set-timezone ${TIME_ZONE}
  echo ""
  timedatectl status

  sleep 5
  echo ""
  echo ""

  # Set The Root Account Password ##################################################
  echo "Let's Set The Root Account Password! "
  while true; do
    echo "Please Enter The New Root Password: "
    passwd root
    if [ $? -eq 0 ]; then
      break
    fi
  done

  sleep 2
  echo ""
  echo ""

  # Disk Partitioning ##################################################
  echo "I Will Now Parition Your Disk! "
  echo ""
  echo "Starting Disk Partitioning On ${DISK}..."

  sleep 2
  echo ""

  # Wipe The Disk & Create A GPT Parition Table
  echo "Wiping Disk & Creating GTP Partition Table..."
  parted --script "${DISK}" mklabel gpt

  sleep 2
  echo ""

  # Create Boot Partition (260MiB)
  echo "Creating EFI, FAT32 Disk Partion Of Size - 260MiB..."
  parted --script "${DISK}" mkpart EFI fat32 1MiB 261MiB

  sleep 2
  echo ""

  # Mark Boot Partition As Bootable
  echo "Marking EFI Partition As Bootable..."
  parted --script "${DISK}" set 1 esp on

  sleep 2
  echo ""

  # Create System Partition Using Remaining Disk Space
  echo "Creating BTRFS Disk Partition Using Remaing Disk Space..."
  parted --script "${DISK}" mkpart System btrfs 261MiB 100%

  sleep 2
  echo ""

  # Check Alignment Of Partitions
  echo "Checking Alignment Of The EFI Partition..."
  parted "${DISK}" align-check min 1

  sleep 1
  echo ""

  echo "Checking Alignment Of The System Parition..."
  parted "${DISK}" align-check min 2

  sleep 1
  echo ""

  # Confirm Partition Layout
  echo "Partitions Created! "
  parted --script "${DISK}" print

  echo "Disk Partitioning Completed! "

  sleep 2
  echo ""
  echo ""
}
