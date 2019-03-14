# 神舟炫龙笔记本DC2黑苹果EFI

#笔记本配置
 * CPU i5-8400 (UHD630)
 * platform-id 为 ~~0x3e9b0000~~ 0x3ea5004
 * SMBIOS MacBookPro15,2
 
#正常工作的功能

 * CPU 睿频正常
 * 核显 UHD630 成功驱动 显存设置为 3072MB
 * USB3.0 正常
 * Audio 完美内建 layout-id为66
 * 电池正常
 * 亮度可调节
 * 睡眠唤醒正常
 * 有线网卡正常
 * HDMI视频+音频(接HDMI时内屏不工作)

#存在的问题
* ~~HDMI外接显示器无法正常输出(正在研究)~~
* 无线网卡(AC9560)无解，使用USB网卡或者淘宝购买黑苹果M.2(NGFF) 2230半高无线网卡自行拆机更换
* 状态栏电池偶现不刷新(有时候不刷新电量，我很少遇到,插拔电源解决)

#HDMI
HDMI视频不是很完美，有bug,可能出现闪屏黑屏

* 在开机之前接上HDMI，笔记本不关盖子，HDMI亮，内屏黑，然后盖上盖子，外屏正常完美工作
* 在开机之前接上HDMI，笔记本按下开机键后关上盖子，开机后，闪屏花屏，但是不会黑屏，打开盖子后不盖上外屏恢复正常，可以看到系统识别到了双屏，但是内屏不亮，而且会导致系统卡顿
* 不接HDMI直接开机，笔记本所有功能完美正常


#使用的 Kexts (EFI/Clover/kexts)
- ACPIBatteryManager.kext
- AppleALC.kext
- FakeSMC_v1800_with_Sensors.kext
- GenericUSBXHCI.kext
- Lilu.kext
- RealtekRTL8111.kext
- USBInjectAll.kext
- VoodooPS2Controller_v1.8.34.kext
- WhateverGreen.kext
