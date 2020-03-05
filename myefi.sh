#!/bin/sh
cwd=$(dirname $0)
config=$cwd/OC/config.plist
config1k=$cwd/OC/config_1080p.plist
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
xhange_config "4722C446-40BF-4AEE-B7BD-72EA8994525C" "UUID0000"
echo "UUID 已恢复"
}
clear_uuid(){
change_config "C02727130CDHWVPJC" "MLB0000"
change_config "U08lML6w" "ROM0000"
change_config "C02V10AFHV29" "SSN0000"
change_config "4722C446-40BF-4AEE-B7BD-72EA8994525C" "UUID0000"
echo "UUID 已清除"
}
autoconfig(){
	#生成1080p的config_1080p.config
	cp -f $config $config1k
	echo "去除 4K 启动参数\t: -igfxmlr -cdfon"
	/usr/bin/sed -i "" "s/ -igfxmlr -cdfon//g" $config1k
	echo "修改为 1080p 分辨率\t: 3840×2160 -> 1920x1080"
	/usr/bin/sed -i "" "s/3840×2160/1920x1080/g" $config1k
	echo "已生成 1080p 配置文件\t: $config1k"
}
make(){
if test -z "$1";then
	echo "less than 1 arguments"
	exit 1
fi
clear_uuid
autoconfig
cd ..
zip -qr "$1" EFI/BOOT EFI/OC EFI/README.md
cd - >/dev/null
reset_uuid
}
push(){
if test -z "$1";then
	echo "less than 1 arguments"
	exit 1
fi
clear_uuid
autoconfig
git add .
git commit -m "$1"
git push -u origin OpenCore
reset_uuid
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





