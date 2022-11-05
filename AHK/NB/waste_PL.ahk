; SetDefaultMouseSpeed, Left
; CoordMode, ToolTip, Screen

flg = 0

started := 0

^e:: flg := !flg

^w::
	flg = 0
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		ImageSearch, Px, Py, 0,0,2560,1080, *64 start.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left, 20
			started:=1
		}
		ImageSearch, Px, Py, 0,0,2560,1080, *64 esc.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			if(started==1)
				Send, {F2}
		}
		ImageSearch, Px, Py, 0,0,2560,1080, *64 daily_quest_start.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 0,0,2560,1080, *64 daily_x.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left, 4
		}
		ImageSearch, Px, Py, 0,0,2560,1080, *90 入场.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
		ImageSearch, Px, Py, 0,0,2560,1080, *90 入场2.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
			started := 0
		}
	}
return
