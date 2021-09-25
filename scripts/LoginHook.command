#!/bin/bash
echo "LoginHook at : `date`" > ~/Documents/LoginHook.log
######## 自启动脚本开始 ########
password="1212"

dev=$(diskutil list|grep BOOTLOADER|awk '{print $6}')

# 挂载 EFI
echo "$password"|sudo -S mkdir /Volumes/Bootloader
echo "$password"|sudo -S mount -t msdos /dev/$dev /Volumes/Bootloader

# 去除偏好设置小红点
defaults write com.apple.systempreferences AttentionPrefBundleIDs 0

# 解锁系统目录写入
#echo "$password"|sudo -S mount -uw / && killall Finder

# 睡眠优化
echo "$password"|sudo -S pmset -a hibernatemode 0
echo "$password"|sudo -S rm -rf /var/vm/sleepimage
echo "$password"|sudo -S mkdir /var/vm/sleepimage
echo "$password"|sudo -S pmset -a standby 0
echo "$password"|sudo -S pmset -a autopoweroff 0
echo "$password"|sudo -S pmset -a proximitywake 0

######## 自启动脚本结束 ########

