; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

flg = 0
room_clear_flg = 1

^h:: flg := !flg

^g::
	Loop
	{
		If (flg)
		{
			flg=0
			ToolTip 
			break
		}
		ImageSearch, Px, Py, 920, 700, 960, 1030, *96 start.bmp ; 搜索【开始战斗】按钮
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, 开始, 128, 128
			room_clear_flg = 0
		}

		ImageSearch, Px, Py, 0, 0, 1615, 805, *16 hp.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Py := Py + 50
			Click, %Px%, %Py%, Left
			ToolTip, hp, 128, 128
			room_clear_flg = 0
		}

		ImageSearch, Px, Py, 785, 635, 970, 685, *16 f.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, relive, 128, 128
			room_clear_flg = 0
		}

		; PixelSearch, Px, Py, 909, 22, 1007, 44, 0xffb029, 3, Fast
		if(room_clear_flg = 0)
		{
			Random, Px, 810, 1080
			Random, Py, 280, 620
			Click, %Px%, %Py%, Left
			SendInput, q
			SendInput, w
			SendInput, e
			SendInput, r
			SendInput, a
			SendInput, s
			SendInput, d
			SendInput, 1
			SendInput, 2
			SendInput, {Space}
		}
	}
return
