; SetDefaultMouseSpeed, Left
; CoordMode, ToolTip, Screen

flg = 0

^n:: flg := !flg

^m::
	flg = 0
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		ImageSearch, Px, Py, 1045, 370, 2045, 1080, *80 creat.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left, 10
		}
		ImageSearch, Px, Py, 1045, 370, 2045, 1080, *32 X.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left, 10
		}
		Click, 0, 0, 0

	}
return
