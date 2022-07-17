; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen

flg = 0

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

		ImageSearch, Px, Py, 335, 380, 1600, 935, *16 watermelon.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			Click, %Px%, %Py%, Left
		}
	}
return
