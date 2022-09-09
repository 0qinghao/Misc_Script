#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#Include <FindText>
;SetDefaultMouseSpeed, 3
SetMouseDelay 30
; CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

flg:=0

Text_shuiyao:="|<>*129$23.y0s7U1kQ033d07AE0DUU0S303k63v0BT60zkA1yUM7t0kDq1Uz833yE47sU8Tk0FzU0bz01Dy00zw09zw"

~F1::
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
				if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_shuiyao))
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
		Send, {Tab}
		flg:=0
	}
return

F4::Suspend

