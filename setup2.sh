!#/bin/bash

ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime

hwclock --systohc

cp files/locale.gen /etc/locale.gen
locale-gen

cp files/locale.conf /etc/locale.conf

mkinitcpio -P

echo "Root Password"
passwd