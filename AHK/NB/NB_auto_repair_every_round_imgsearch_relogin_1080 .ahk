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

		ImageSearch, Px, Py, 920, 700, 960, 1030, *90 start.bmp ; ��������ʼս������ť
;		ImageSearch, Px, Py, 845, 680, 930, 1070, *8 start_bg.bmp ; ��������ʼս������ť
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, ��ʼ, 256, 256
			Sleep, 100
			Click, 600, 70, Left ; ����
			ToolTip, ����, 256, 256
			Sleep, 100
			Click, 1860, 1020, Left ; �˵�
			ToolTip, �˵����, 256, 256
			Click, 960,540,0
		}

		ImageSearch, Px, Py, 590, 430, 670, 510, *96 �ξ�ף��.bmp ; �������ξ�ף������ť
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, �ξ�ף��, 256, 256
			Sleep, 100
			Click, 960,540,0
		}
		ImageSearch, Px, Py, 850, 720, 910, 770, *96 ����.bmp ; �������ξ�ף��-������ť
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 1
			ToolTip, ����, 256, 256
			Sleep, 100
			Click, 960,540,0
		}
		ImageSearch, Px, Py, 910, 235, 990, 265, *96 װ������.bmp ; �������ξ�ף��-����-װ��������ť
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			; ImageSearch, tPx, tPy, 900, 580, 925, 610, *16 f.bmp 
			; if(ErrorLevel=1 and flg=0)
			; {
			Click, %Px%, %Py%, Left
			ToolTip, װ�������ǩ��, 256, 256
			Sleep, 100
			Click, 960,540,0
			; }
		}
		ImageSearch, Px, Py, 1130, 800, 1220, 840, *96 ȫ������.bmp ; �������ξ�ף��-����-װ������-ȫ��������ť
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 0
			ToolTip, ȫ������, 256, 256
			Sleep, 400
			Click, 960,540,0
		}
		; else
		; {
		; 	ImageSearch, Px, Py, 1130, 800, 1220, 840, *96 ȫ������w.bmp ; �������ξ�ף��-����-װ������-ȫ��������ť
		; 	if (ErrorLevel=0 and flg=0) 
		; 	{
		; 		Click, %Px%, %Py%, Left
		; 		Sleep, 100
		; 	}
		; }
		; ImageSearch, Px, Py, 970, 800, 1090, 840, *96 �������.bmp ; �������ξ�ף��-����-װ������-�����������ť
		; if (ErrorLevel=0 and flg=0) 
		; {
		; 	Click, %Px%, %Py%, Left
		; 	Sleep, 100
		; }
		ImageSearch, Px, Py, 900, 670, 930, 700, *16 f11.bmp ; �������ٴ���ս����ݼ�ͼƬ
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, �ٴ���ս, 256, 256
			Sleep, 100
			DllCall("QueryPerformanceCounter","Int64*",last_f11)
			Click, 960,540,0
		}

		ImageSearch, Px, Py, 900, 580, 925, 610, *16 f.bmp ; ������ȷ������ݼ�ͼƬ
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, ȷ��, 256, 256
			Sleep, 100
			SendInput, {Escape}
			; ToolTip, ESC, 256, 256
			Click, 960,540,0
		}

		DllCall("QueryPerformanceCounter","Int64*",now)
		if (last_f11!=0 and Round((now-last_f11)/QuadPart) > 5)
		{
			if WinExist("�������ξ�")
				WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
		}
		if ((last_f11!=0 and Round((now-last_f11)/QuadPart) > 60) or (not WinExist("�������ξ�")))
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
	WinKill, �������ξ�, , 1
	Sleep, 10000

	Run, C:\Users\qhlin\Desktop\�������ξ�.lnk

	Loop
	{	
		Click, 960,540,0
		Sleep, 5000
		ImageSearch, pX, pY, 1200, 666, 1385, 758, *16 ������Ϸ.bmp
		if(ErrorLevel=0)
		{
			Click, %pX%, %pY%
			break
		}
		ImageSearch, pX, pY, 1400, 666, 1685, 758, *16 ������Ϸ.bmp
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
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
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
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
		ImageSearch, pX, pY, 1540, 570, 1800, 605, *16 login.bmp
		if(ErrorLevel=0)
		{
			Click, %pX%, %pY%
			Sleep, 5000
		}
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
		ImageSearch, pX, pY, 820, 13, 1060, 60, *16 ������.bmp
		if(ErrorLevel=0)
		{
			break
		}
	}

	Loop
	{	
		Click, 960,540,0
		Sleep, 5000
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
		ImageSearch, pX, pY, 820, 13, 1060, 60, *16 ������.bmp
		if(ErrorLevel=0)
		{
			Click, 977, 1022
			Sleep, 1000
			Click, 960,540,0
		}
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
		ImageSearch, pX, pY, 300, 142, 467, 183, *16 �����.bmp
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
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
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
		if WinExist("�������ξ�")
			WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
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