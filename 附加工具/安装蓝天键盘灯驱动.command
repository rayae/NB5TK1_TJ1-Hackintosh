#!/bin/bash

cur="$(cd `dirname "$0"`;pwd -P)"
cd $cur

sudo cp -rf Others/ClevoControl.kext /Library/Extensions
sudo cp -rf Others/ClevoKBFanControl.app /Applications/

sudo rm -rf /System/Library/PrelinkedKernels/prelinkedkernel
sudo rm -rf /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache
sudo chmod -R 755 /System/Library/Extensions
sudo chmod -R 755 /Library/Extensions
sudo chown -R root:wheel /System/Library/Extensions
sudo chown -R root:wheel /Library/Extensions
sudo touch /System/Library/Extensions
sudo touch /Library/Extensions
sudo kextcache -q -update-volume /
sudo kextcache -system-caches
sudo kextcache -i /

sudo kextload /Library/Extensions/ClevoControl.kext

echo 安装完成
