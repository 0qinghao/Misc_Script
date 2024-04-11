SetDefaultMouseSpeed, 0
CoordMode, ToolTip, Screen

flg = 0
last_f11 = 0

^o:: flg := !flg

^i::
	DllCall("QueryPerformanceFrequency","Int64*",QuadPart)
	flg = 0
	last_f11 = 0
	Loop
	{
		If (flg)
		{
			flg=0
			break
		}

		ImageSearch, Px, Py, 800, 600, 1300, 950, *90 home_board.bmp ; ËÑË÷
		if (ErrorLevel=0 and flg=0) 
		{
			Px:=Px+10
			Py:=Py+200
			Click, %Px%, %Py%, 0
			Sleep, 2000
			Click, 2
			Sleep, 2000	

			board_x1 = 580
			board_y1 = 425
			board_x2 = 1050
			board_y2 = 500
			Loop 10
			{
				ImageSearch, Px, Py, board_x1, board_y1, board_x2, board_y2, *90 di.bmp ; ËÑË÷
				if (ErrorLevel=0 and flg=0) 
				{
					Click, %Px%, %Py%
					Sleep, 2000
					Click, 1265, 850
					Sleep, 2000
				}
				ImageSearch, Px, Py, board_x1, board_y1, board_x2, board_y2, *90 juan.bmp ; ËÑË÷
				if (ErrorLevel=0 and flg=0) 
				{
					Click, %Px%, %Py%
					Sleep, 2000
					Click, 1265, 850
					Sleep, 2000
				}
				
				
				board_y1:=board_y1+77
				board_y2:=board_y2+77
				
				if (A_Index == 5)
				{
					; next page		
					Click, 845, 830
					Sleep, 2000
					
					board_x1 = 580
					board_y1 = 425
					board_x2 = 1050
					board_y2 = 500
				}
			}
		}
		
		ImageSearch, Px, Py, 500, 700, 900, 1000, *50 board.bmp ; ËÑË÷
		if (ErrorLevel=0 and flg=0) 
		{
			Send, {Esc}
			Sleep, 2000
		}
		
		ImageSearch, Px, Py, 800, 600, 1300, 950, *90 home_board.bmp ; ËÑË÷
		if (ErrorLevel=0 and flg=0) 
		{	
			Px:=Px+110
			Py:=Py+200
			Click, %Px%, %Py%, 0
			Sleep, 2000
			Click, 2
			Sleep, 2000	
	
			ImageSearch, Px, Py, 500, 700, 900, 1000, *50 board.bmp ; ËÑË÷
			if (ErrorLevel=0 and flg=0) 
			{
				Loop 5
				{
					Click, 820, 460
					Sleep, 2000
					Click, 1265, 850
					Sleep, 2000	
				}	
			}
		}
		
		ImageSearch, Px, Py, 500, 700, 900, 1000, *50 board.bmp ; ËÑË÷
		if (ErrorLevel=0 and flg=0) 
		{
			Send, {Esc}
			Sleep, 2000
		}
			

		if WinExist("Tenvi")
			WinActivate ; Ê¹ÓÃ WinExist ÕÒµ½µÄ´°¿Ú
	}
return

