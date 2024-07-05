
flg = 0
^c:: flg := !flg

^x::
Loop 
{
	If (flg)
	{
		flg=0
		break
	}
		
    RandSleep(500,1500)
    Send, {esc}
    RandSleep(500,1500)
    Send, {enter}
    RandSleep(500,1500)
    Send, {Right}
    RandSleep(500,1500)
    Send, {enter}
    RandSleep(8000,15000)
    
    loop 30
    {
		Send, {v}
		RandSleep(50,150)
		Send, {space}
		RandSleep(50,150)
    }
}
return

RandSleep(x,y) {
Random, rand, %x%, %y%
Sleep %rand%
}