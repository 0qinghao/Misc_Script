SetDefaultMouseSpeed, 0

~XButton1::
; `::
    MouseGetPos, src_x, src_y 
    ;Send, i
    Sleep, 300
    Click, 2025 1050 Right
    ;Send, {Esc}
    Click, %src_x%, %src_y%, 0
Return

F4::Suspend