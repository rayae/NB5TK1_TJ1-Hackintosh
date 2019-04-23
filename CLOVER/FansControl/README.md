#风扇控制
修改自:[ClevoControl](https://github.com/datasone/ClevoControl "ClevoControl")
**`ClevoControl.kext`** 是用来控制风扇的内核扩展
**`CFControl`**  是控制风扇的命令，自行查看**`CFControl -h`** 
**`setupfan `** 是我调配好的风扇转速与阈值
```
/usr/bin/CFControl --spt=30 --stt=60 --speed=25
/usr/bin/CFControl --spt=40 --stt=60 --speed=35
/usr/bin/CFControl --spt=50 --stt=60 --speed=50
/usr/bin/CFControl --spt=60 --stt=60 --speed=65
/usr/bin/CFControl --spt=70 --stt=60 --speed=75
/usr/bin/CFControl --spt=80 --stt=60 --speed=100
```
复制**`ClevoControl.kext`** 到**`/Library/Extensions`** 并更新缓存/，不可以是SLE和Clover，否则kerne panic
用终端**`sudo cp -r CFControl /usr/bin/ && sudo chmod a+x /usr/bin/CFControl `** 安装
然后把**`setupfan`** 放到macOS系统盘的的任意目录下面，不会的放到桌面，
在 **系统偏好设置-用户与群组-登录项**-点加号，然后选中**`setupfan`** ，就可以开机自动执行了


