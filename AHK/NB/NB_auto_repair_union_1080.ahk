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
			ToolTip, ������, 256, 256
			Sleep, 200
		}

		ImageSearch, Px, Py, 1550, 0, 1630, 45, *96 ����.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, 1420, 240, Left
			ToolTip, ����, 256, 256
			Sleep, 200
			Click, 1860, 1020, Left ; �˵�
			ToolTip, �˵����, 256, 256
		}
		
		ImageSearch, Px, Py, 590, 430, 670, 510, *96 �ξ�ף��.bmp ; �������ξ�ף������ť
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, �ξ�ף��, 256, 256
			Sleep, 200
		}
		ImageSearch, Px, Py, 850, 720, 910, 770, *96 ����.bmp ; �������ξ�ף��-������ť
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 1
			ToolTip, ����, 256, 256
			Sleep, 200
		}
		ImageSearch, Px, Py, 910, 235, 990, 265, *96 װ������.bmp ; �������ξ�ף��-����-װ��������ť
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			; ImageSearch, tPx, tPy, 900, 580, 925, 610, *16 f.bmp 
			; if(ErrorLevel=1 and flg=0)
			; {
			Click, %Px%, %Py%, Left
			ToolTip, װ�������ǩ��, 256, 256
			Sleep, 200
			; }
		}
		ImageSearch, Px, Py, 1130, 800, 1220, 840, *96 ȫ������.bmp ; �������ξ�ף��-����-װ������-ȫ��������ť
		if (ErrorLevel=0 and repair_pad_flg=1 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			repair_pad_flg = 0
			ToolTip, ȫ������, 256, 256
			Sleep, 400
		}

		ImageSearch, Px, Py, 900, 580, 925, 610, *16 f.bmp ; ������ȷ������ݼ�ͼƬ
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, ȷ��, 256, 256
			Sleep, 200
			SendInput, {Escape}
			; ToolTip, ESC, 256, 256
		}

		DllCall("QueryPerformanceCounter","Int64*",now)
		if (last_f11!=0 and Round((now-last_f11)/QuadPart) > 5)
		{
			if WinExist("�������ξ�")
				WinActivate ; ʹ�� WinExist �ҵ��Ĵ���
		}
	}
return