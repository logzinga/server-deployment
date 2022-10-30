#!/bin/bash

systemctl enable NetworkManager 
systemctl enable sshd
cd /
git clone https://github.com/logzinga/server-deployment
cd server-deployment
git checkout vm
cd ..


ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime

hwclock --systohc

cp /server-deployment/files/locale.gen /etc/locale.gen
locale-gen

cp /server-deployment/files/locale.conf /etc/locale.conf

mkinitcpio -P

useradd -m -G wheel server

echo "The username for this computer is 'server'"
passwd server

echo "Root Password"
passwd

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg