CoordMode, Mouse, Screen
SetDefaultMouseSpeed, 7

^d::
    ; click, 1240, 685
    ; click, 511, 514
	; Loop
	; {
	; 	ImageSearch, Px, Py, 580,350,650,420, *128 x720.bmp 
	; 	if (ErrorLevel=0) 
	; 	{
	; 		Click, %Px%, %Py%, Left
    ;         break
	; 	}
    ; }

    ; click, 2517, 686
    ; click, 1784, 514
	; Loop
	; {
	; 	ImageSearch, Px, Py, 1860,350,1910,420, *128 x720.bmp 
	; 	if (ErrorLevel=0) 
	; 	{
	; 		Click, %Px%, %Py%, Left
    ;         break
	; 	}
    ; }

	Loop
	{
		ImageSearch, Px, Py, 2530,0,2560,30, *128 M720.bmp 
		if (ErrorLevel=0) 
		{
            click, 1240, 680
            click, 769, 229
            click, 577, 178, Right
            sleep, 500
            click, 615, 233, 0
            sleep, 500
            click, 615, 233, 5
            click, 1915, 395
            click, 1210, 85
            break
		}
    }

	Loop
	{
		ImageSearch, Px, Py, 363,575,483,675, *64 kelusi.bmp 
		if (ErrorLevel=0) 
		{
            Loop 
            {
			    Send, X
                Sleep, 200
                ImageSearch, Px, Py, 550,435,620,468, *128 ruchang.bmp 
                if (ErrorLevel=0) 
                {
                    break
                }
            }
            break
		}
    }

    click, 590, 450
    click, 1868, 437

return
