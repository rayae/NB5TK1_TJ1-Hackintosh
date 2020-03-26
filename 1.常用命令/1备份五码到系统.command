#!/bin/bash

cwd=$(dirname $0)/..
config=$cwd/OC/config.plist

if test ! -f $config;then
	echo "不存在 ： $config"
	exit 1
fi

backup_path=~/UUID-Backup

getCode(){
	p=`grep -n "<key>$1</key>" $config|cut -d ':' -f1`
	let p=p+1
	content=`cat $config|sed -n ${p}p`
	echo `echo $content|sed 's#<string>##g'|sed 's#<data>##g'|sed 's#</.*>##g'`
}

mlb=`getCode MLB`
rom=`getCode ROM`
ssn=`getCode SystemSerialNumber`
uuid=`getCode SystemUUID`

echo "=============================================================="
echo "MLB                : $mlb"
echo "ROM                : $rom"
echo "SystemSerialNumber : $ssn"
echo "SystemUUID         : $uuid"
echo "=============================================================="

mkdir $backup_path

echo $mlb >$backup_path/MLB
echo $rom >$backup_path/ROM
echo $ssn >$backup_path/SystemSerialNumber
echo $uuid >$backup_path/SystemUUID

echo "已将五码备份至：$backup_path"

sleep 1

open $backup_path

exit 0
