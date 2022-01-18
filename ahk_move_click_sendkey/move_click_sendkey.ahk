SetDefaultMouseSpeed, 0

; XButton1::
`::
    MouseGetPos, src_x, src_y 
    Send, I
    Click, 1700 700 Right
    Send, I
    Click, %src_x%, %src_y%, 0
Return

F5::Suspend