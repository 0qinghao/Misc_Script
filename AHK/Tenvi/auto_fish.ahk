#NoEnv
#SingleInstance Force
SetBatchLines, -1  ; 设置脚本响应速度
SetStoreCapsLockMode, Off

; 配置搜索区域和鱼上钩的图像文件
search_top := 700
search_left := 0
search_bottom := 1100
search_right := 2100
fish_images := ["fish_eating1.bmp", "fish_eating2.bmp", "fish_eating3.bmp", "fish_eating4.bmp", "fish_eating5.bmp", "fish_eating6.bmp"]

flg = 0

^f::
    DllCall("QueryPerformanceFrequency", "Int64*", QuadPart)

    ; 全自动钓鱼流程
    Loop
    {
        ; 抛竿操作
        Send, d  ; 按下 'd' 键抛竿
        ToolTip, Casting rod... ; 提示抛竿操作
        Sleep, 1000  ; 等待抛竿动画完成

        ; 设置最大等待时间，用于判断是否成功抛竿
        start_time := A_TickCount
        fish_caught := false  ; 标记是否检测到鱼上钩

        ; 检测鱼是否上钩
        Loop
        {
            ToolTip, Checking for fish...

            ; 遍历所有图像文件进行搜索
            for index, fish_image in fish_images
            {
                ImageSearch, FoundX, FoundY, search_left, search_top, search_right, search_bottom, *97 %fish_image%
                if (ErrorLevel = 0)
                {
                    Send, v  ; 收杆
                    ToolTip, Fish Hooked!
                    Sleep, 100  ; 等待收杆动作完成
                    fish_caught := true
                    break
                }
            }

            ; 如果鱼未上钩，检查超时机制，认为抛竿失败
            if (A_TickCount - start_time > 12000)  ; 超过12秒未检测到鱼，认为抛竿失败
            {
                ToolTip, Failed to catch fish _ retrying ; 提示错误信息
                Send, d  ; 重新抛竿
                break
            }

            ; 若成功捕捉到鱼，退出循环
            if (fish_caught)
                break
        }
    }