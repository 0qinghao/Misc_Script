;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include <FindText>
SetDefaultMouseSpeed, 2
SetMouseDelay 21
SetStoreCapsLockMode, Off

flg:=0

Text_yongquan:="|<>*104$29.Dzy0Azzy0Nzzw0Lzzs0jzzkFTzzU2zzz04zzy0tzzs4Vzzk33zz021zw0d1zk0bVTs1AYUM0tNkk/modUXb3EU7CC00CKMa0QsEA0w"
Text_zhixia:="|<>*81$25.3tTjXhjrluDzsiDbwZzzSTxzzHyvzddTzxrjrxtrzwwvzzuhzzAaQzaniTnNLDtgDjywrrzyPzlz7zkTnzs8"
Text_shuiyao:="|<>*129$26.0RU1kTs0AS707y0s7w0C3w033j80tXk0DUw03kT03k7kTM1xT60zy1UDyUM7z861zq1Uzt0MTyE47z413zk0Fzw04zz01Dzk07zy"
Text_mingxie:="|<>*46$26.1zzztzzzs7zzzsTzzmTzzo0zzySDzzylzzy0bzzknzzzoDyzUjzTy6Dzzb3zjwcTzz09xzgATjxS0xztUDjx80xz00DzxU3nz00yzm01Lzk0c"
Text_lizhuo:="|<>*34$26.yfrmPKTx3PxzgvTxxjvyzBvjMtjugTDxjOvzzgTzzqBrzjaDzxn4zzpWjzwl7zzsXDzwFVzz8kKmpN3KygEMrWE36sS0sq8UB2WG"


`::
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
				stat:=2
			}
		case 2:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_zhixia))
			{
				X2:=X
				Y2:=Y
				Click, %X% %Y% Right
				stat:=3
			}
		case 3:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_shuiyao))
			{
				X3:=X
				Y3:=Y
				Click, %X% %Y% Right
				stat:=4
			}
		case 4:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_lizhuo))
			{
				X4:=X
				Y4:=Y
				Click, %X% %Y% Right
				stat:=5
			}
		case 5:
			if (ok:=FindText(X, Y, 33, 562, 296, 617, 0, 0, Text_mingxie))
			{
				X5:=X
				Y5:=Y
				Click, %X% %Y% Right
				Click, %xsrc%, %ysrc%, 0
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

F4::Reload

