#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include <FindText>
;SetDefaultMouseSpeed, 3
SetMouseDelay 30
; CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

flg:=0

Text_yongquan:="|<>*111$29.0zXzy31nzw00Fzs001zk000zU004z0001y0005w0001s0000k7k00dzs0AbzsUATzs0Mzzs0nzzu1bzzkFTzzU2zzz15zzy0/zzwYHzzsHbzzUGE"
Text_zhixia:="|<>*78$22.QBtxwjLyazTx7zysyTmzvjzrzxzRzqZrrvrPzbRzyRzzerzy3CTvCtzgfbykizy/vzsjz7XzsDDzUU"
Text_shuiyao:="|<>*129$23.y0s7U1kQ033d07AE0DUU0S303k63v0BT60zkA1yUM7t0kDq1Uz833yE47sU8Tk0FzU0bz01Dy00zw09zw"
Text_mingxie:="|<>*42$26.CzzwUzzzwDzzN3zzzACzzt7zzn0TxzT6zzn8Twz03yTsETzzO7zTkHzjy27zjnVhKy4DfzU4yzo63ryj0Ozk03rwY0Cz007rsE1q"
Text_lizhuo:="|<>*45$29.zzzznzTzxXzzzxbzzztjzzztTzzrtzzzytzzzXtzzzDnzxztnzzvhDzzioDzyvoTzzAMTzwFUzzxaFLzxN0yrpYEOrqEkQr1H0wq8C1sQk60vjGE"


~F1::
if (flg==0)
{
	Send, {Tab}
	MouseGetPos, xsrc, ysrc 
	stat:=1
	Loop
	{
		Switch stat
		{
		case 1:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_yongquan))
			{
				X1:=X
				Y1:=Y
				Click, %X% %Y% Right
				FindText().Click(X, Y+30, 0)
				stat:=2
			}
		case 2:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_zhixia))
			{
				X2:=X
				Y2:=Y
				Click, %X% %Y% Right
				FindText().Click(X, Y+30, 0)
				stat:=3
			}
		case 3:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_shuiyao))
			{
				X3:=X
				Y3:=Y
				Click, %X% %Y% Right
				FindText().Click(X, Y+30, 0)
				stat:=4
			}
		case 4:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_mingxie))
			{
				X4:=X
				Y4:=Y
				Click, %X% %Y% Right
				FindText().Click(X, Y+30, 0)
				stat:=5
			}
		case 5:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_lizhuo))
			{
				X5:=X
				Y5:=Y
				Click, %X% %Y% Right
				FindText().Click(xsrc, ysrc, 0)
				flg:=1
				break
			}
		}
	}
}
else
{
	flg:=0
	Click, %X5% %Y5% Right
	Click, %X4% %Y4% Right
	Click, %X3% %Y3% Right
	Click, %X2% %Y2% Right
	Click, %X1% %Y1% Right
	FindText().Click(xsrc, ysrc, 0)
	Send, {Tab}
}
return

F4::Suspend

