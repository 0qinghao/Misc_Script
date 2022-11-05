;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include <FindText>
;SetDefaultMouseSpeed, 3
;SetMouseDelay 20
SetStoreCapsLockMode, Off

flg:=0

Text_shuiyao:="|<>##0$0/0/A8F2F2,0/5/A8F2F2"
Text_shuiyao.="|<>*130$26.Uzk0EwC0Bw1kDs0Q7k067QE1n700T1s07Uy47UDUyk3myA1zw30Tx0kDyEA3zg31zm0kzwU8Dy837zU"


`::
	if (flg==0)
	{
		Send, {Tab}
		flg:=1
		MouseGetPos, xsrc, ysrc 
		stat:=5
		Loop
		{
			Switch stat
			{
			case 5:
				if (ok:=FindText(X, Y, 1969, 749, 2248, 888, 0, 0, Text_shuiyao))
				{
					X5:=X
					Y5:=Y
					Click, %X% %Y% Right
					FindText().Click(xsrc, ysrc, 0)
					break
				}
			}
		}
	}
	else
	{
		Click, %X5% %Y5% Right
		FindText().Click(xsrc, ysrc, 0)
;		Send, {Tab}
		flg:=0
	}
return

F4::Reload

