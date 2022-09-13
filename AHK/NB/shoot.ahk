; SetDefaultMouseSpeed, Left
; CoordMode, ToolTip, Screen

flg = 0

^d:: flg := !flg

^s::
	flg = 0
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_dst1.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_dst2.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_dst3.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_dst4.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_dst5.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_replay.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_start.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 645, 500, 1900, 900, *32 shoot_up.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
	}
return
