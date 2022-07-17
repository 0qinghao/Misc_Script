SetDefaultMouseSpeed, 0

flg = 0
^f:: flg := !flg

^d::
Loop 
{
	If (flg)
	{
		flg=0
		break
	}
		
    Click, 1500, 700, Left
    Sleep, 1000
    Send, {f}
    Sleep, 1000
    Click, 950, 850, Left
    Sleep, 1000
    Click, 952, 598, Left
    Sleep, 1000
}
return