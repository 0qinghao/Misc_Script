; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen

flg = 0
last_f11 = 0

^t:: flg := !flg

^r::
	DllCall("QueryPerformanceFrequency","Int64*",QuadPart)
	flg = 0
	last_f11 = 0
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		ImageSearch, Px, Py, 920, 700, 960, 1030, *90 start.bmp ; 搜索【开始战斗】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			Sleep, 300
			Click, 600, 70, Left ; 送死
			ImageSearch, Px, Py, 1380, 830, 1440, 900, *4 repair.bmp ; 搜索耐久黄色警告，Threshold=2
			if (ErrorLevel=0 and flg=0) 
			{
				Click, %Px%, %Py%, Left
				 Sleep, 1000
				 Click, 880, 600, Left
			}
;			else if(ErrorLevel=2)
;				MsgBox 找不到图片 repair.bmp，截取【耐久警告】黄色背景色保存到脚本目录
		}
;		else if(ErrorLevel=2)
;			MsgBox 找不到图片 start.bmp，截取【开始战斗】按钮的背景色保存到脚本目录

		ImageSearch, Px, Py, 900, 670, 930, 700, *16 f11.bmp ; 搜索【再次挑战】快捷键图片
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			Sleep, 300
			DllCall("QueryPerformanceCounter","Int64*",last_f11)
		}
;		else if(ErrorLevel=2)
;			MsgBox 找不到图片 f11.bmp，截取【再次挑战】按钮后方的快捷键图片保存到脚本目录

		ImageSearch, Px, Py, 900, 580, 925, 610, *16 f.bmp ; 搜索【再次挑战-确定】快捷键图片
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
;		else if(ErrorLevel=2)
;			MsgBox 找不到图片 f.bmp，截取【确定】按钮后方的快捷键图片保存到脚本目录
			
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