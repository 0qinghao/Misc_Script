; SetDefaultMouseSpeed, 0
; CoordMode Pixel

flg = 0

^w::flg := !flg

^q::
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}
		PixelGetColor, complete_color, 1591, 308 ,RGB ; 检查任务状态
		if (Not(complete_color=0xffbe73 or complete_color=0xe7e7de) And flg=0)
		{
			Click, 1591, 308, Left
			Sleep, 500
			Click, 1278, 656, Left
			Sleep, 700
			Continue
		}

		PixelGetColor, complete_color, 1450, 259 ,RGB ; 检查任务状态
		if(complete_color=0xf7b04e)
			Click, 1194, 230, Left
		else
			Click, 1140, 230, Left
		Sleep, 300
	}
return
