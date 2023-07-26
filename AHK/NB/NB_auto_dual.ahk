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
		
    Click, 1800, 700, Left
    Sleep, 1000
    Send, {x}
    Sleep, 1000
    Click, 1280, 850, Left
    Sleep, 1000
}
return