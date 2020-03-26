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
reset_uuid(){
xhange_config "C02727130CDHWVPJC" "MLB0000"
xhange_config "U08lML6w" "ROM0000"
xhange_config "C02V10AFHV29" "SSN0000"
xhange_config "F0960000-0000-1000-8000-80FA5B6077D1" "UUID0000"
echo "UUID 已恢复"
}
clear_uuid(){
change_config "C02727130CDHWVPJC" "MLB0000"
change_config "U08lML6w" "ROM0000"
change_config "C02V10AFHV29" "SSN0000"
change_config "F0960000-0000-1000-8000-80FA5B6077D1" "UUID0000"
echo "UUID 已清除"
}
resmy(){
	echo "清除我的配置文件"
	cp -f $config4k $config
	echo "删除 2160p 启动参数\t: -igfxmlr -cdfon"
	/usr/bin/sed -i "" "s/-alcid=29 -igfxmlr -cdfon/-alcid=29/g" $config
	echo "修改为 1080p 分辨率\t: 3840×2160 -> 1920x1080"
	/usr/bin/sed -i "" "s/3840×2160/1920x1080/g" $config
	echo "修改 UISCale 为\t: 01"
	/usr/bin/sed -i "" "s/Ag==/AQ==/g" $config
	echo "已生成 1080p 配置文件\t: $config"
	clear_uuid
}
usemy(){
	echo "使用我的配置文件"
	cp -f $config4k $config
	echo "修改 UISCale 为\t: 02"
	/usr/bin/sed -i "" "s/AQ==/Ag==/g" $config
	reset_uuid
}
autoconfig(){
	resmy
	cp -f $config $config4k
	echo "增加 2160p 启动参数\t: -igfxmlr -cdfon"
	/usr/bin/sed -i "" "s/-alcid=29/-alcid=29 -igfxmlr -cdfon/g" $config4k
	echo "修改为 2160p 分辨率\t: 1920x1080 -> 3840×2160"
	/usr/bin/sed -i "" "s/1920x1080/3840×2160/g" $config4k
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





