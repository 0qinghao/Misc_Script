#NoEnv
#SingleInstance Force
SetBatchLines, -1  ; 设置脚本响应速度
SetStoreCapsLockMode, Off


flg = 0
prev = 0

^g:: flg := !flg

^f::
	DllCall("QueryPerformanceFrequency","Int64*",QuadPart)

	; 开始检测鱼上钩
	Loop
	{
		ToolTip, start, 0, 700
		ToolTip, end, 2100, 1100
	
		ToolTip, 1
		ImageSearch, FoundX, FoundY, 0, 700, 2100, 1100, *97 fish_eating1.bmp
		if (ErrorLevel = 0)
		{
			Send, v
		}
		ToolTip, 2
		ImageSearch, FoundX, FoundY, 0, 700, 2100, 1100, *97 fish_eating2.bmp
		if (ErrorLevel = 0)
		{
			Send, v
		}
		ToolTip, 3
		ImageSearch, FoundX, FoundY, 0, 700, 2100, 1100, *97 fish_eating3.bmp
		if (ErrorLevel = 0)
		{
			Send, v
		}
		ToolTip, 4
		ImageSearch, FoundX, FoundY, 0, 700, 2100, 1100, *97 fish_eating4.bmp
		if (ErrorLevel = 0)
		{
			Send, v
		}
		ToolTip, 5
		ImageSearch, FoundX, FoundY, 0, 700, 2100, 1100, *97 fish_eating5.bmp
		if (ErrorLevel = 0)
		{
			Send, v
		}
		ToolTip, 6
		ImageSearch, FoundX, FoundY, 0, 700, 2100, 1100, *97 fish_eating6.bmp
		if (ErrorLevel = 0)
		{
			Send, v
		}
		
;		DllCall("QueryPerformanceCounter","Int64*",now)
;		if (Round((now-prev)/QuadPart) > 20)
;		{
;			prev := now
;			Send, 4
;			Send, {Space}
;			Send, 5
;		}
		
		if (flg)
		{
			ToolTip
			break
		}
	}

