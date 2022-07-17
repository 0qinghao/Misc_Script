;SetDefaultMouseSpeed, 1
; CoordMode, ToolTip, Screen
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
SetStoreCapsLockMode, Off

flg = 0
repair_pad_flg = 0
last_f11 = 0

^t:: flg := !flg

^r::
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

		ImageSearch, Px, Py, 920, 700, 960, 1030, *90 start.bmp ; 搜索【开始战斗】按钮
;		ImageSearch, Px, Py, 845, 680, 930, 1070, *8 start_bg.bmp ; 搜索【开始战斗】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 开始, 256, 256
			Sleep, 100
			Click, 600, 70, Left ; 送死
			ToolTip, 送死, 256, 256
			Sleep, 100
			Click, 1860, 1020, Left ; 菜单
			ToolTip, 菜单面板, 256, 256
			Click, 960,540,0
		}

		ImageSearch, Px, Py, 590, 430, 670, 510, *96 梦境祝福.bmp ; 搜索【梦境祝福】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 梦境祝福, 256, 256
			Sleep, 100
			Click, 960,540,0
		}
		ImageSearch, Px, Py, 850, 720, 910, 770, *96 修理.bmp ; 搜索【梦境祝福-修理】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 1
			ToolTip, 修理, 256, 256
			Sleep, 100
			Click, 960,540,0
		}
		ImageSearch, Px, Py, 910, 235, 990, 265, *96 装备修理.bmp ; 搜索【梦境祝福-修理-装备修理】按钮
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			; ImageSearch, tPx, tPy, 900, 580, 925, 610, *16 f.bmp 
			; if(ErrorLevel=1 and flg=0)
			; {
			Click, %Px%, %Py%, Left
			ToolTip, 装备修理标签卡, 256, 256
			Sleep, 100
			Click, 960,540,0
			; }
		}
		ImageSearch, Px, Py, 1130, 800, 1220, 840, *96 全部修理.bmp ; 搜索【梦境祝福-修理-装备修理-全部修理】按钮
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 0
			ToolTip, 全部修理, 256, 256
			Sleep, 400
			Click, 960,540,0
		}
		; else
		; {
		; 	ImageSearch, Px, Py, 1130, 800, 1220, 840, *96 全部修理w.bmp ; 搜索【梦境祝福-修理-装备修理-全部修理】按钮
		; 	if (ErrorLevel=0 and flg=0) 
		; 	{
		; 		Click, %Px%, %Py%, Left
		; 		Sleep, 100
		; 	}
		; }
		; ImageSearch, Px, Py, 970, 800, 1090, 840, *96 修理佩戴.bmp ; 搜索【梦境祝福-修理-装备修理-修理佩戴】按钮
		; if (ErrorLevel=0 and flg=0) 
		; {
		; 	Click, %Px%, %Py%, Left
		; 	Sleep, 100
		; }
		ImageSearch, Px, Py, 900, 670, 930, 700, *16 f11.bmp ; 搜索【再次挑战】快捷键图片
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 再次挑战, 256, 256
			Sleep, 100
			DllCall("QueryPerformanceCounter","Int64*",last_f11)
			Click, 960,540,0
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

		DllCall("QueryPerformanceCounter","Int64*",now)
		if (last_f11!=0 and Round((now-last_f11)/QuadPart) > 5)
		{
			if WinExist("超激斗梦境")
				WinActivate ; 使用 WinExist 找到的窗口
		}
		if ((last_f11!=0 and Round((now-last_f11)/QuadPart) > 60) or (not WinExist("超激斗梦境")))
		{
			relogin()
			last_f11 = 0
			; ToolTip, relogin
		}

		; Click, 0, 0, 0
	}
return

relogin()
{
	CoordMode, Mouse, Screen
	CoordMode, Pixel, Screen
	WinKill, 超激斗梦境, , 1
	Sleep, 10000

	Run, C:\Users\qhlin\Desktop\超激斗梦境.lnk

	Loop
	{	
		Click, 960,540,0
		Sleep, 5000
		ImageSearch, pX, pY, 1200, 666, 1385, 758, *16 启动游戏.bmp
		if(ErrorLevel=0)
		{
			Click, %pX%, %pY%
			break
		}
		ImageSearch, pX, pY, 1400, 666, 1685, 758, *16 启动游戏.bmp
		if(ErrorLevel=0)
		{
			Click, %pX%, %pY%
			break
		}
	}
	
	CoordMode, Mouse, Relative
	CoordMode, Pixel, Relative

	Loop
	{		
		Sleep, 5000
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 1465, 500, 1525, 527, *16 password.bmp
		if(ErrorLevel=0)
		{
			SetCapsLockState, Off
			Sleep, 10000
			SendInput, 0qinghao@163
			break
		}
	}

	Loop
	{	
		Click, 960,540,0
		Sleep, 5000
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 1540, 570, 1800, 605, *16 login.bmp
		if(ErrorLevel=0)
		{
			Click, %pX%, %pY%
			Sleep, 5000
		}
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 820, 13, 1060, 60, *16 军团名.bmp
		if(ErrorLevel=0)
		{
			break
		}
	}

	Loop
	{	
		Click, 960,540,0
		Sleep, 5000
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 820, 13, 1060, 60, *16 军团名.bmp
		if(ErrorLevel=0)
		{
			Click, 977, 1022
			Sleep, 1000
			Click, 960,540,0
		}
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 300, 142, 467, 183, *16 福利活动.bmp
		if(ErrorLevel=0)
		{
			Sleep, 3000
			SendInput, {ESC}
			Sleep, 1000
			break
		}
	}

	Loop
	{	
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 1885, 0, 1918, 25, *16 map_icon.bmp
		if(ErrorLevel=0)
		{
			pX := pX + 10
			pY := pY + 10
			Click, %pX%, %pY%
			Sleep, 1000
			Click, 959, 148
			Sleep, 10000
			Click, 960,540,0
		}
		if WinExist("超激斗梦境")
			WinActivate ; 使用 WinExist 找到的窗口
		ImageSearch, pX, pY, 1423, 61, 1916, 117, *16 tower_pad.bmp
		if(ErrorLevel=0)
		{
			Click, 1405, 120, 100
			sleep, 5000
			Click, 1224, 170
			sleep, 5000
			Click, 1686, 1035
			sleep, 5000
			Click, 961, 595
			sleep, 5000
			click, 1322, 959
			break
		}
	}

	CoordMode, Mouse, Relative
	CoordMode, Pixel, Relative
}