!#/bin/bash

echo "What do you want to name this server? (no special characters)"
read SERVERNAME

parted /dev/sda mklabel gpt
parted /dev/sda mkpart "EFI" fat32 1MiB 301MiB
parted /dev/sda set 1 esp on
parted /dev/sda mkpart "swap" linux-swap 301MiB 16GiB
parted /dev/sda mkpart "root" ext4 16GiB 100%

mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.fat -F 32 /dev/sda1

mount /dev/sda3 /mnt
swapon /dev/sda2 
mount --mkdir /dev/sda1 /mnt/boot

pacstrap -K /mnt base linux linux-firmware openssh networkmanager nano

genfstab -U /mnt >> /mnt/etc/fstab

cp setup2.sh /mnt/usr/bin/setup
chmod +777 /mnt/usr/bin/setup

echo $SERVERNAME >> /mnt/etc/hostname 

echo "When ready, type 'setup' to continue"
arch-chroot /mnt


