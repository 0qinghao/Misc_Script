#NoEnv
#SingleInstance Force
SetBatchLines, -1  ; ���ýű���Ӧ�ٶ�
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

