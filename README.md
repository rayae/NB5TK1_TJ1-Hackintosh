# 神舟炫龙笔记本DC2黑苹果EFI

##笔记本配置
 * CPU i5-8400 (UHD630)
 * platform-id 为 0x3e9b0000
 
##正常工作的功能

 * CPU 睿频正常
 * 核显 UHD630 成功驱动 显存设置为 3072MB
 * USB3.0 正常
 * Audio 完美内建 layout-id为66
 * 电池正常
 * 亮度可调节
 * 睡眠唤醒正常
 * 有线网卡正常

##存在的问题
* HDMI外接显示器无法正常输出(正在研究)
* 无线网卡(AC9560)无解，使用USB网卡或者淘宝购买黑苹果M.2(NGFF) 2230半高无线网卡自行拆机更换
* 状态栏电池偶现不刷新(有时候不刷新电量，我很少遇到,插拔电源解决)


##使用的 Kexts (EFI/Clover/kexts)
- ACPIBatteryManager.kext
- AppleALC.kext
- FakeSMC_v1800_with_Sensors.kext
- GenericUSBXHCI.kext
- Lilu.kext
- RealtekRTL8111.kext
- USBInjectAll.kext
- VoodooPS2Controller_v1.8.34.kext
- WhateverGreen.kext