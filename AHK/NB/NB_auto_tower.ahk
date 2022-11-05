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
		ImageSearch, pX, pY, 1423, 61, 1916, 117, *16 tower_pad.bmp
		if(ErrorLevel=0)
		{
			Click, 1405, 728, 30 ; 族群
;			Click, 1405, 915, 30 ; 1层
			sleep, 100
			Click, 1224, 780
			sleep, 100
			Click, 1686, 1035
		}

		ImageSearch, Px, Py, 920, 700, 960, 1030, *90 start.bmp ; 搜索【开始战斗】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 开始, 256, 256
		}		
		
		ImageSearch, Px, Py, 805, 815, 890, 850, *32 继续挑战.bmp ; 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 继续挑战, 256, 256
		}
		
		ImageSearch, Px, Py, 500, 830, 900, 920, *32 战斗中绿脸.bmp ; 
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
		
		ImageSearch, Px, Py, 770, 125, 1100, 650, *32 tower_clear_npc.bmp ; 
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