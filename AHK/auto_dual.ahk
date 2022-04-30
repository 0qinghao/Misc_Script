SetDefaultMouseSpeed, 0

^d::
; `::
    ; MouseGetPos, src_x, src_y 
    ; Send, i
    ; Sleep, 150
    ; Send, {Esc}
    ; Click, %src_x%, %src_y%, 0
  
Loop 
{
    Click, 1800, 700, Left
    Sleep, 1000
    Send, {x}
    Sleep, 1000
    Click, 1280, 850, Left
    Sleep, 1000
}

F4::pause