; SetDefaultMouseSpeed, 0
; CoordMode Pixel

flg = 0

^r::flg := !flg

^t::
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		Click, 800, 1020, Left
		Click, 1140, 590, Left
		Click, 590, 1020, Left
	}
return
