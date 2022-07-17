; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
SetStoreCapsLockMode, Off

flg = 0
repair_pad_flg = 0
last_f11 = 0

^t:: flg := !flg

^r::
	flg = 0
	repair_pad_flg = 0
	last_f11 = 0

	Loop
	{
		If (flg)
		{
			flg=0
			ToolTip 
			break
		}

		ImageSearch, Px, Py, 600, 210, 1430, 800, *96 next_teleport.bmp ; 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 传送门, 256, 256
			Sleep, 200
		}

		ImageSearch, Px, Py, 1550, 0, 1630, 45, *96 后退.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, 1420, 240, Left
			ToolTip, 送死, 256, 256
			Sleep, 200
			Click, 1860, 1020, Left ; 菜单
			ToolTip, 菜单面板, 256, 256
		}
		
		ImageSearch, Px, Py, 590, 430, 670, 510, *96 梦境祝福.bmp ; 搜索【梦境祝福】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 梦境祝福, 256, 256
			Sleep, 200
		}
		ImageSearch, Px, Py, 850, 720, 910, 770, *96 修理.bmp ; 搜索【梦境祝福-修理】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 1
			ToolTip, 修理, 256, 256
			Sleep, 200
		}
		ImageSearch, Px, Py, 910, 235, 990, 265, *96 装备修理.bmp ; 搜索【梦境祝福-修理-装备修理】按钮
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			; ImageSearch, tPx, tPy, 900, 580, 925, 610, *16 f.bmp 
			; if(ErrorLevel=1 and flg=0)
			; {
			Click, %Px%, %Py%, Left
			ToolTip, 装备修理标签卡, 256, 256
			Sleep, 200
			; }
		}
		ImageSearch, Px, Py, 1130, 800, 1220, 840, *96 全部修理.bmp ; 搜索【梦境祝福-修理-装备修理-全部修理】按钮
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 0
			ToolTip, 全部修理, 256, 256
			Sleep, 400
		}

		ImageSearch, Px, Py, 900, 580, 925, 610, *16 f.bmp ; 搜索【确定】快捷键图片
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 确定, 256, 256
			Sleep, 200
			SendInput, {Escape}
			; ToolTip, ESC, 256, 256
		}

		DllCall("QueryPerformanceCounter","Int64*",now)
		if (last_f11!=0 and Round((now-last_f11)/QuadPart) > 5)
		{
			if WinExist("超激斗梦境")
				WinActivate ; 使用 WinExist 找到的窗口
		}
	}
return