﻿;==================================================
;** 快捷键 Win+` 使当前窗口置顶
;==================================================
#`::
WinSet, AlwaysOnTop, toggle,A
WinGetTitle, getTitle, A
Winget, getTop,ExStyle,A
if (getTop & 0x8)
    TrayTip 已置顶, 窗口标题: `n%getTitle%,10,1
else
    TrayTip 取消置顶, 窗口标题:`n %getTitle%,10,1
return