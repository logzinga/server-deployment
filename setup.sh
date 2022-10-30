#!/bin/bash



while getopts 'lh:' OPTION; do
  case "$OPTION" in
    l)
      echo "Setting up for Desktop..."
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

pacstrap -K /mnt base linux linux-firmware openssh networkmanager nano grub efibootmgr

genfstab -U /mnt >> /mnt/etc/fstab

cp setup2.sh /mnt/usr/bin/setup
chmod +777 /mnt/usr/bin/setup

echo $SERVERNAME >> /mnt/etc/hostname 

echo "When ready, type 'setup' to continue"
arch-chroot /mnt

      ;;
    h)
      echo "Setting up for VM..."
      echo "What do you want to name this server? (no special characters)"
read SERVERNAME
      parted /dev/vda mklabel gpt
parted /dev/vda mkpart "EFI" fat32 1MiB 301MiB
parted /dev/vda set 1 esp on
parted /dev/vda mkpart "swap" linux-swap 301MiB 16GiB
parted /dev/vda mkpart "root" ext4 16GiB 100%

mkfs.ext4 /dev/vda3
mkswap /dev/vda2
mkfs.fat -F 32 /dev/vda1

mount /dev/vda3 /mnt
swapon /dev/vda2 
mount --mkdir /dev/vda1 /mnt/boot

pacstrap /mnt base linux linux-firmware openssh networkmanager nano grub efibootmgr git

genfstab -U /mnt >> /mnt/etc/fstab

cp setup2.sh /mnt/usr/bin/setup
chmod +777 /mnt/usr/bin/setup

echo $SERVERNAME >> /mnt/etc/hostname 

echo "When ready, type 'setup' to continue"
arch-chroot /mnt
      ;;
  esac
done
shift "$(($OPTIND -1))"




