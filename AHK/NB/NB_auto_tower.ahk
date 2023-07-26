;SetDefaultMouseSpeed, 1
; CoordMode, ToolTip, Screen
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
SetStoreCapsLockMode, Off

flg = 0
repair_pad_flg = 0
last_f11 = 0

^y:: flg := !flg

^t::
	DllCall("QueryPerformanceFrequency","Int64*",QuadPart)
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
		
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 1423, 61, 1916, 117, *48 tower_pad.bmp
		if(ErrorLevel=0)
		{
;			Click, 1405, 728, 30 ; 族群
			Click, 1405, 915, 30 ; 1层
			sleep, 100
;			Click, 1224, 780 ; 族群
			Click, 1224, 880 ; 1层
			sleep, 100
			Click, 1686, 1035
		}

		ImageSearch, Px, Py, 920, 700, 960, 1030, *90 start.bmp ; 搜索【开始战斗】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 开始, 256, 256
		}		
		
		ImageSearch, Px, Py, 805, 815, 890, 850, *48 继续挑战.bmp ; 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 继续挑战, 256, 256
		}
		
		ImageSearch, Px, Py, 500, 830, 900, 920, *48 战斗中绿脸.bmp ; 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, 1405, 238, 0
			Send, 1
			Send, w
			Send, r
			Send, d
			Send, 2
			Click, 972, 551
			ToolTip, 战斗中, 256, 256
		}
		
		ImageSearch, Px, Py, 770, 125, 1100, 650, *48 tower_clear_npc.bmp ; 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, 100, 100, Left
			ToolTip, tower_clear_npc, 256, 256
		}

		ImageSearch, Px, Py, 900, 580, 925, 610, *16 f.bmp ; 搜索【确定】快捷键图片
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 确定, 256, 256
			Sleep, 100
			SendInput, {Escape}
			; ToolTip, ESC, 256, 256
			Click, 960,540,0
		}

	}
return
