; AutoHotkey Script to repeatedly double-click and press 'V'

#Persistent ; Keeps the script running
#SingleInstance Force ; Ensures only one instance of the script runs

; The timer is initially off and will not run until activated
SetTimer, DoubleClickAndPressV, Off
return

DoubleClickAndPressV:
    Click 2 ; Simulate a double-click
    Sleep, 50 ; Wait 200ms (adjust as needed)
    Send, v ; Simulate pressing 'V'
    return

^q:: ; Use Ctrl+S to start the timer
    SetTimer, DoubleClickAndPressV, On
    return

^w:: ; Use Ctrl+X to stop the timer
    SetTimer, DoubleClickAndPressV, Off
    return
