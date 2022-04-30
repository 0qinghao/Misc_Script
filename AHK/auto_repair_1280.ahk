;SetDefaultMouseSpeed, 0

flg = 0

^r::
Loop
{
	If (flg)
	{
		flg=0
		break
	}
    Click, 880, 680, Left ; 再次挑战
    RandSleep()
    Click, 880, 600, Left ; 再次挑战确定/修理确定
    RandSleep()
    If (flg)
	{
		flg=0
		break
	}
	Click, 960, 730, Left ; 开始战斗 - 0任务
	Click, 960, 770, Left ; 开始战斗 - 1任务
	Click, 960, 800, Left ; 开始战斗 - 2任务
	Click, 960, 870, Left ; 开始战斗 - 3、4任务
    RandSleep()
    Click, 1400, 870, Left ; 修理
    RandSleep()
}
return

^t::flg := !flg

RandSleep() {
	Random, rand, 1010, 1050
	Sleep %rand%
}