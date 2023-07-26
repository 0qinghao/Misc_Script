; SetDefaultMouseSpeed, 0
; CoordMode Pixel

flg = 0

^l::flg := !flg

^k::
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		Send, {space}
		Send, {space}
		Send, q
		Send, e
		Send, r
		Send, f
		Send, {F3}
	}
return
