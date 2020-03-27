#!/bin/sh
cwd=$(dirname $0)
config=$cwd/OC/config.plist
config4k=$cwd/OC/config_4k.plist
usage(){
echo "
  $0 <make|reset_uuid|clear_uuid|push> [extra arguments...]
"
}
change_config(){
if test -z $1;then
	echo "less than 1 arguments"
	exit 1
fi
/usr/bin/sed -i "" "s/$1/$2/g" $config
}
xhange_config(){
change_config "$2" "$1"
}
setCode(){
	p=`grep -n "<key>$1</key>" $config|head -n 1|cut -d ':' -f1`
	let p=p+1
	sed -i "" "${p}s#<.*>#$2#" $config
}
reset_uuid(){
setCode MLB "<string>C02727130CDHWVPJC</string>"
setCode ROM "<data>U08lML6w</data>"
setCode SystemSerialNumber "<string>C02V10AFHV29</string>"
setCode SystemUUID "<string>F0960000-0000-1000-8000-80FA5B6077D1</string>"
echo "UUID 已恢复"
}
clear_uuid(){
setCode MLB "<string>000000000000000000000</string>"
setCode ROM "<data>00000000</data>"
setCode SystemSerialNumber "<string>000000000000</string>"
setCode SystemUUID "<string>00000000-0000-0000-0000-000000000000</string>"
echo "UUID 已清除"
}
open_uiscale(){
	echo "修改 UISCale 为\t: 02"
	setCode UIScale "<data>Ag==</data>"
}
close_uiscale(){
	echo "修改 UISCale 为\t: 01"
	setCode UIScale "<data>AQ==</data>"
}
resmy(){
	echo "清除我的配置文件"
	cp -f $config $config4k
	echo "删除 2160p 启动参数\t: -igfxmlr -cdfon"
	/usr/bin/sed -i "" "s/-alcid=29 -igfxmlr -cdfon/-alcid=29/g" $config
	close_uiscale
	clear_uuid
	echo "已生成 1080p 配置文件\t: $config"
}
usemy(){
	echo "使用我的配置文件"
	cp -f $config4k $config
	open_uiscale
	reset_uuid
}
autoconfig(){
	resmy
	cp -f $config $config4k
	echo "增加 2160p 启动参数\t: -igfxmlr -cdfon"
	/usr/bin/sed -i "" "s/-alcid=29/-alcid=29 -igfxmlr -cdfon/g" $config4k
	echo "已生成 2160p 配置文件\t: $config4k"
}
make(){
if test -z "$1";then
	echo "less than 1 arguments"
	exit 1
fi
autoconfig
cd ..
zip -qr "$1" EFI/BOOT EFI/OC EFI/1.常用命令 EFI/README.md
cd - >/dev/null
usemy
}
push(){
if test -z "$1";then
	echo "less than 1 arguments"
	exit 1
fi
autoconfig
git add .
git commit -m "$1"
git push -u origin OpenCore
usemy
}


if test -z $1;then
	usage
elif [[ "$1"x == "clear_uuid"x ]];then
		clear_uuid
elif [[ "$1"x == "reset_uuid"x ]];then
		reset_uuid
elif [[ "$1"x == "make"x ]];then
		make "$2"
elif [[ "$1"x == "push"x ]];then
		push "$2"
fi





