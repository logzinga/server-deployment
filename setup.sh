!#/bin/bash

echo "What do you want to name this server? (no special characters)"
read SERVERNAME

parted /dev/sda mklabel gpt
parted /dev/sda mkpart "EFI" fat32 1MiB 301MiB
parted /dev/sda set 1 esp on
parted /dev/sda mkpart "swap" linux-swap 301MiB 16GiB
parted /dev/sda mkpart "root" ext4 16GiB 100%


