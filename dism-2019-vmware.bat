REM Modify boot.wim
dism /Mount-Wim /WimFile:E:\2019\boot.wim /Index:1 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2019\boot.wim /Index:2 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
REM Modify install.wim 
dism /Mount-Wim /WimFile:E:\2019\install.wim /Index:1 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\pvscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmxnet3.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmmouse.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmrawdisk.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmusbmouse.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2019\install.wim /Index:2 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\pvscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmxnet3.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmmouse.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmrawdisk.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmusbmouse.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2019\install.wim /Index:3 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\pvscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmxnet3.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmmouse.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmrawdisk.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmusbmouse.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2019\install.wim /Index:4 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\pvscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmxnet3.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmmouse.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmrawdisk.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\vmware\vmusbmouse.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit