pause := false

^d::  ; 按下 Ctrl+D 启动脚本
    pause := false
    SetTimer, RunLoop, 100
return

^f::  ; 按下 Ctrl+F 暂停脚本
    pause := true
return

RunLoop:
    if (pause)
        return

    Loop
    {
        ; 按下 Tab 键
        Send, {Tab}

        ; 按下 Tab 键
        Send, {Tab}

        ; 按下 Tab 键
        Send, {Tab}

        ; 按下 Tab 键
        Send, {Tab}

        ; 按下 S 键
        Send, s

        ; 按下 F 键
        Send, f

        ; 分别按下 V 键和 Ctrl 键
        Send, v
        Sleep, 50  ; 可调整延时确保按键顺序正确
        Send, {Ctrl}

        ; 延时，避免按键过快
        Sleep, 500  ; 根据需要调整延时，单位是毫秒
    }
return
