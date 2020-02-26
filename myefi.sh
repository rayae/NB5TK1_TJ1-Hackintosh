#!/bin/sh
cwd=$(dirname $0)
config=$cwd/OC/config.plist

usage(){
echo "
  $0 <make|reset_uuid|clear_uuid> [extra arguments...]
"
}
change_config(){
if test -z $2;then
	echo "less than 2 arguments"
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
make(){
if test -z $1;then
	echo "less than 1 arguments"
	exit 1
fi
cd ..
zip -r "$1" EFI/BOOT EFI/OC EFI/README.md
}

if test -z $1;then
	usage
elif [[ "$1"x == "clear_uuid"x ]];then
		clear_uuid
elif [[ "$1"x == "reset_uuid"x ]];then
		reset_uuid
elif [[ "$1"x == "make"x ]];then
		make $2
fi





