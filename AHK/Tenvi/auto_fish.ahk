#NoEnv
#SingleInstance Force
SetBatchLines, -1  ; 设置脚本响应速度
SetStoreCapsLockMode, Off

; 配置搜索区域和鱼上钩的图像文件
search_top := 650
search_left := 1080
search_bottom := 750
search_right := 1250
fish_images := ["fish_eating1.bmp", "fish_eating2.bmp", "fish_eating3.bmp", "fish_eating4.bmp", "fish_eating5.bmp", "fish_eating6.bmp"]
channel_switch_interval := 00 ; 配置切换频道的周期（单位：秒），设置为 0 表示不切换频道

^f::
    ; 获取开始时间，记录周期的开始
    last_switch_time := A_TickCount
    
	ToolTip, left_top, search_left, search_top, 20
	ToolTip, right_bottom, search_right, search_bottom, 19

    Loop
    {
        ; 如果设定的频道切换周期大于0，则检查是否到达切换频道的时间
        if (channel_switch_interval > 0 && A_TickCount - last_switch_time > channel_switch_interval * 1000)
        {
			; 检查是否遗留拾取绑定确认
			Click, 0, 0, 0
			ImageSearch, FoundX, FoundY, 0, 0, 5000, 5000, *90 yes_button.bmp
			if (ErrorLevel = 0)
			{
				Click, %FoundX%, %FoundY%
				Sleep, 1000
				continue
			}
			
            ; 切换频道操作
            ToolTip, Switching channel...
            Send, {Esc}  ; 按下 ESC 键
            Sleep, 500
            Send, {Enter}  ; 按下 Enter 键
            Sleep, 500
            Send, {Right}  ; 按下右方向键
            Sleep, 500
            Send, {Enter}  ; 按下 Enter 键
            ToolTip, Channel switched! ; 提示频道切换成功
            Sleep, 2000

            ; 更新最后切换时间
            last_switch_time := A_TickCount
        }

        ; 抛竿操作
        Send, d  ; 按下 'd' 键抛竿
        ToolTip, Casting rod... ; 提示抛竿操作
        Sleep, 1000  ; 等待抛竿动画完成

        ; 设置最大等待时间，用于判断是否成功抛竿
        start_time := A_TickCount

        ; 检测鱼是否上钩
        Loop
        {
            ToolTip, Checking for fish...
            
            ; 遍历所有图像文件进行搜索
            for index, fish_image in fish_images
            {
                ImageSearch, FoundX, FoundY, search_left, search_top, search_right, search_bottom, *90 %fish_image%
                if (ErrorLevel = 0)
                {
                    Send, v  ; 收杆
                    ToolTip, Fish Hooked!
                    Sleep, 0  ; 等待收杆动作完成

                    ; 增加拾取功能
                    ToolTip, Picking up the fish...
                    Send, {Space}  ; 按下空格键拾取
                    ToolTip, Fish picked up! ; 提示成功拾取

                    break 2  ; 直接退出两层循环
                }
            }

            ; 如果超时未检测到鱼，重新抛竿
            if (A_TickCount - start_time > 20000)  ; 超过12秒未检测到鱼
            {
                ToolTip, Failed to catch fish _ retrying ; 提示错误信息
                break
            }
        }
    }
