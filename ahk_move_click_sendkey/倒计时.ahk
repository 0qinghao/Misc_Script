; XButton1::
`::
    Tick := 44
    SetTimer, Timer1, 1000
Return

Timer1:
    if Tick--
    {
        Tooltip, % Format("{:02d}:{:02d}", Tick/60 , Mod(Tick,60)), 50, 10
        If (Tick == 10)
        {
            SoundBeep, 4000, 500 ;frequency duration
        }
    }
    else
    {
        SetTimer, Timer1, Off
        Tooltip
    }
Return

F5::Suspend