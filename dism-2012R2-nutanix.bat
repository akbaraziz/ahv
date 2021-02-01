REM Modify boot.wim
dism /Mount-Wim /WimFile:E:\2012R2\boot.wim /Index:1 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2012R2\boot.wim /Index:2 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
REM Modify install.wim 
dism /Mount-Wim /WimFile:E:\2012R2\install.wim /Index:1 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2012R2\install.wim /Index:2 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2012R2\install.wim /Index:3 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit

Pause
dism /Mount-Wim /WimFile:E:\2012R2\install.wim /Index:4 /MountDir:E:\Mount
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\balloon.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\netkvm.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\viorng.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioscsi.inf"
dism /image:E:\Mount /Add-Driver "/driver:e:\Drivers\VirtIO\vioser.inf"
dism /Unmount-Wim /mountdir:E:\Mount /commit