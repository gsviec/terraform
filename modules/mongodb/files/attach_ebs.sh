#!/bin/bash
mkfs -t ext4 /dev/xvdg
mkdir /mnt/mongodb
mount /dev/xvdg /mnt/mongodb
chown mongodb:mongodb /mnt/mongodb
service mongod restart
echo /dev/xvdg  /mnt/mongodb ext4 defaults,nofail 0 2 >> /etc/fstab