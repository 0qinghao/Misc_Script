#NoEnv
#SingleInstance Force
SetBatchLines, -1  ; 设置脚本响应速度
SetStoreCapsLockMode, Off


flg = 0
prev = 0

^f:: flg := 1

^d::
	Loop
	{
		click, 2
		
		if (flg)
		{
			flg = 0
			break
		}
	}

