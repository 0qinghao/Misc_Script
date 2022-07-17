; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

flg = 0

^d:: flg := !flg

^e::
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		ImageSearch, Px, Py, 2420, 1025, 2460, 1050, *48 Ìø¹ý.bmp 
		if (ErrorLevel=0 and flg=0) 
		{
			SendInput, {Escape}
			Sleep, 300
		}

	}
return
