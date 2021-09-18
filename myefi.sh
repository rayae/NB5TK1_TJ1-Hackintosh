#!/bin/sh
cwd=$(dirname $0)
config=$cwd/OC/config.plist
config4k=$cwd/OC/config_4k.plist
backup_path=~/UUID-Backup
getUUID(){
	if test ! -f $backup_path/$1;then
		echo null
		return
	fi
	echo `cat $backup_path/$1`
}
getValue(){
	if test ! -f $config;then
		echo "config 文件不存在"
		return
	fi
	p=`grep -n "<key>$1</key>" $config|head -n 1|cut -d ':' -f1`
	let p=p+1
	value=`sed "${p}q;d" $config|sed "s#$(echo '\t')\+>##"`
	value=`echo $value|sed  "s#<##"|sed "s#/>##"`
	if [[ $value == true || $value == false ]]; then
		echo $value
		return
	fi
	value=`echo $value|sed "s#<.*>##"|sed "s#.*>##"`
	echo $value
}
setValue(){
	p=`grep -n "<key>$1</key>" $config|head -n 1|cut -d ':' -f1`
	let p=p+1
	sed -i "" "${p}s#<.*>#$2#" $config
}
mlb=`getUUID MLB`
rom=`getUUID ROM`
ssn=`getUUID SystemSerialNumber`
uuid=`getUUID SystemUUID`

usage(){
echo "
  $0 <make|reset_uuid|clear_uuid|push|rmf(remove_macos_files)> [extra arguments...]
"
}
change_config(){
if test -z $1;then
	echo "less than 1 arguments"
	exit 1
fi
/usr/bin/sed -i "" "s/$1/$2/g" $config
}
reset_uuid(){
setValue MLB "<string>${mlb}</string>"
setValue ROM "<data>${rom}</data>"
setValue SystemSerialNumber "<string>${ssn}</string>"
setValue SystemUUID "<string>${uuid}</string>"
echo "UUID 已恢复"
}
clear_uuid(){
remove_macos_files
setValue MLB "<string>000000000000000000000</string>"
setValue ROM "<data>00000000</data>"
setValue SystemSerialNumber "<string>000000000000</string>"
setValue SystemUUID "<string>00000000-0000-0000-0000-000000000000</string>"
echo "UUID 已清除"
}
enable_4k(){
	echo "为 4K 屏幕设置参数"
	setValue dpcd-max-link-rate "<data>FAAAAA==</data>"
	setValue UIScale "<data>Ag==</data>"
}
disable_4k(){
	echo "为 1080P 屏幕设置参数"
	setValue dpcd-max-link-rate "<data>CgAAAA==</data>"
	setValue UIScale "<data>AQ==</data>"
}
enable_picker(){
	echo "启用 ShowPicker"
	setValue ShowPicker "<true/>"
	setValue Timeout "<integer>5</integer>"
}
disable_picker(){
	echo "禁用 ShowPicker"
	setValue ShowPicker "<false/>"
	setValue Timeout "<integer>0</integer>"
}
usemy(){
	echo "恢复我的配置文件"
	cp -f $config4k $config
	rm -f $config4k
	enable_4k
	disable_picker
	reset_uuid
}
autoconfig(){
	clear_uuid
	cp -f $config $config4k
	echo "已生成 4K屏 配置文件\t: $config4k"
	disable_4k
	enable_picker
	echo "已生成 1080P屏 配置文件\t: $config"
}
make(){
if test -z "$1";then
	echo "指定输出文件名"
	exit 1
fi
autoconfig
remove_macos_files
cd ..
zip -qr "$1" EFI/BOOT EFI/OC EFI/附加工具 EFI/README.md
cd - >/dev/null
usemy
}
push(){
if test -z "$2";then
	echo "less than 2 arguments"
	exit 1
fi
remove_macos_files
autoconfig
git checkout "$2"
git add .
git commit -m "$1"
git push -u origin "$2"
usemy
}
remove_macos_files(){
	find "$cwd/.." -name "._*" -exec rm -rf {} \;
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
		push "$2" OpenCore
elif [[ "$1"x == "push-dev"x ]];then
		push "$2" dev
elif [[ "$1"x == "rmf"x ]];then
		remove_macos_files
fi



