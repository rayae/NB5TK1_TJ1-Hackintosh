#!/bin/bash

cwd=$(dirname $0)/..
config=$cwd/OC/config.plist

if test ! -f $config;then
	echo "不存在 ： $config"
	exit 1
fi

backup_path=~/UUID-Backup

getCode(){
	if test ! -f $backup_path/$1;then
		echo null
		return
	fi
	echo `cat $backup_path/$1`
}
setCode(){
	p=`grep -n "<key>$1</key>" $config|cut -d ':' -f1`
	let p=p+1
	sed -i "" "${p}s#<.*>#$2#" $config
}

mlb=`getCode MLB`
rom=`getCode ROM`
ssn=`getCode SystemSerialNumber`
uuid=`getCode SystemUUID`

if [[ "$mlb"x == "null"x || "$rom"x == "null"x || "$ssn"x == "null"x || "$uuid"x == "null"x ]];then
	echo "没备份别瞎点。。。。。"
	exit 1
fi

echo "=============================================================="
echo "MLB                : $mlb"
echo "ROM                : $rom"
echo "SystemSerialNumber : $ssn"
echo "SystemUUID         : $uuid"
echo "=============================================================="

setCode MLB "<string>${mlb}</string>"
setCode ROM "<data>${rom}</data>"
setCode SystemSerialNumber "<string>${ssn}</string>"
setCode SystemUUID "<string>${uuid}</string>"

echo "已将恢复五码到config：$backup_path"

exit 0
