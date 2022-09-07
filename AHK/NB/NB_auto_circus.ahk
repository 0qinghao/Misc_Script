#Include <FindText>
; SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

Text_hp_bar:="|<hp_bar>*82$69.zzzzzzzzzzzzzzzzzzzzzzzS00000000007U0000000000w00000000007U0000000000w00000000003s0000000000TzzzzzzzzzzszzzzzzzzzzzU"
Text_hp_bar_low:="|<hp_bar_low>*[0,0]80$11.zy3w7sDkTUz1zzzzw"
Text_F:="|<F>*110$12.zzzzzzw0w0w0w0w0w0zyzyzyw0w0w0w0w0w0w0w0U"

Text:=""
Text.=Text_hp_bar
Text.=Text_hp_bar_low
Text.=Text_F

flg = 0

^h:: flg := !flg

^g::
	Loop
	{
		If (flg)
		{
			flg=0
			ToolTip 
			break
		}

		if (ok:=FindText(X, Y, 0, 0, 2560, 700, 0.1, 0.1, Text))
		{
			for i,v in ok ; ok value can be get from ok:=FindText().ok
			{
				FindText().Click(ok[i].x, ok[i].y+100, Left)
				; FindText().Click(ok[i].x, ok[i].y, Left)
				if (i==Round(ok.Length()/2))
				{
					Send, q
				}
				FindText().Click(ok[i].x, ok[i].y, "R")
			}
		}

		; MsgBox, 4096, Tip, % "Found:`t" Round(ok.Length())
		; . "`n`nTime:`t" (A_TickCount-t1) " ms"
		; . "`n`nPos:`t" ok[1].x ", " ok[1].y
		; . "`n`nResult:`t<" (Comment:=ok[1].id) ">"

	}
return
