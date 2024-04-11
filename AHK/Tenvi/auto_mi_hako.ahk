#NoEnv
#SingleInstance Force
SetStoreCapsLockMode, Off

^j:: flg := !flg

^h::
	DllCall("QueryPerformanceFrequency","Int64*",QuadPart)
	flg = 0
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		send, v
		sleep, 100
;		send, c
;		sleep, 100000
		send, {space}
		sleep, 100
;		send, 4
;		sleep, 100000
	}
return

