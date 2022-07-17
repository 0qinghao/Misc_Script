; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

flg = 0
room_clear_flg = 0

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
		}

		ImageSearch, Px, Py, 1685, 92, 1865, 270, *48 r1.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Px := Px + 20
			Py := Py + 20
			Click, %Px%, %Py%, Left
			Click, 100, 100, 0
			ToolTip, r1, 128, 128
			room_clear_flg = 1
		}
		ImageSearch, Px, Py, 1685, 92, 1865, 270, *48 r2.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Px := Px + 20
			Py := Py + 20
			Click, %Px%, %Py%, Left
			Click, 100, 100, 0
			ToolTip, r2, 128, 128
			room_clear_flg = 1
		}
		ImageSearch, Px, Py, 1685, 92, 1865, 270, *48 r3.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Px := Px + 20
			Py := Py + 20
			Click, %Px%, %Py%, Left
			Click, 100, 100, 0
			ToolTip, r3, 128, 128
			room_clear_flg = 1
		}
		ImageSearch, Px, Py, 1685, 92, 1865, 270, *48 r4.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Px := Px + 20
			Py := Py + 20
			Click, %Px%, %Py%, Left
			Click, 100, 100, 0
			ToolTip, r4, 128, 128
			room_clear_flg = 1
		}
		ImageSearch, Px, Py, 1685, 92, 1865, 270, *48 r5.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Px := Px + 20
			Py := Py + 20
			Click, %Px%, %Py%, Left
			Click, 100, 100, 0
			ToolTip, r4, 128, 128
			room_clear_flg = 1
		}
		; room6 = room3
		ImageSearch, Px, Py, 1685, 92, 1865, 270, *168 r7.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Px := Px + 20
			Py := Py + 20
			Click, %Px%, %Py%, Left
			Click, 100, 100, 0
			ToolTip, r7, 128, 128
			room_clear_flg = 1
		}

		ImageSearch, Px, Py, 0, 0, 1615, 805, *24 hp.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Py := Py + 50
			Click, %Px%, %Py%, Left
			ToolTip, hp, 128, 128
			room_clear_flg = 0
		}
		else if(room_clear_flg = 0)
		{
			Random, Px, 0, 1585 
			Random, Py, 220, 810
			Click, %Px%, %Py%, Left
			Sleep, 2000
			SendInput, q
			SendInput, w
			SendInput, e
			SendInput, r
;			SendInput, a
;			SendInput, s
;			SendInput, d
;			SendInput, 1
;			SendInput, 2
;			SendInput, {Space}
		}

		ImageSearch, Px, Py, 0, 0, 1615, 805, *114 box1.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			ToolTip, box1, 128, 128
			room_clear_flg = 0
		}
		; PixelSearch, Px, Py, 909, 22, 1007, 44, 0xffb029, 3, Fast
	}
return
