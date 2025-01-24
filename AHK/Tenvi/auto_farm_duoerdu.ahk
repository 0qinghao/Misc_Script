#Persistent  ; Keep the script running
SetTitleMatchMode, 2  ; Set window title matching to substring

; 配置变量
channelSwitchCount := 0  ; 记录频道切换次数
maxChannelSwitches := 15  ; 最大频道切换次数，达到这个次数后进入回城出售装备状态
interval := 30000  ; 每隔秒切换一次频道，单位：毫秒
monsterFarmInterval := 500  ; 刷怪操作的间隔时间，单位：毫秒

; 状态变量
isInMonsterFarmState := true  ; 当前是否在刷怪状态

; 刷怪状态：按下这些键
monsterFarmKeys := ["4", "Tab", "e", "s", "d", "f", "Ctrl", "v"]


; 热键绑定
^!F1::  ; 启动脚本，Ctrl + Alt + F1
    SetTimer, SwitchChannel, % interval  ; 启动定时器定时切换频道
    SetTimer, MonsterFarmLoop, % monsterFarmInterval  ; 启动刷怪操作的定时器
	isInMonsterFarmState := true  ; 当前是否在刷怪状态
    return

^!F2::  ; 暂停脚本，Ctrl + Alt + F2
    SetTimer, SwitchChannel, Off  ; 关闭频道切换定时器
    SetTimer, MonsterFarmLoop, Off  ; 停止刷怪定时器
    isInMonsterFarmState := false  ; 停止刷怪操作
    return

^!F3::  ; 退出脚本，Ctrl + Alt + F3
    ExitApp


; 自动刷怪：按下设置的按键
MonsterFarmLoop:
    if (isInMonsterFarmState) {
        Loop, % monsterFarmKeys.MaxIndex()
        {
            key := monsterFarmKeys[A_Index]
            if (key = "Ctrl") {
                Send, {Ctrl down}  ; 按下 Ctrl
                Sleep, 100  ; 按下 Ctrl 的持续时间
                Send, {Ctrl up}  ; 释放 Ctrl
            }
            else if (key = "Tab") {
                Send, {Tab}  ; 按下 Tab 键
            }
            else {
                Send, % key  ; 发送普通键
            }
            Sleep, 500  ; 等待0.5秒，模拟刷怪动作的延迟
        }
    }
    return


; 切换频道函数
SwitchChannel:
    if (channelSwitchCount < maxChannelSwitches) {
        Send, {Esc}  ; 按下Esc
        Sleep, 500
        Send, {Enter}  ; 按下回车
        Sleep, 500
        Send, {Left}  ; 按下左方向键（假设要向左切换）
        Sleep, 500
        Send, {Enter}  ; 再次按下回车
        channelSwitchCount++
    } else {
        ; 达到最大频道切换次数，开始回城并出售装备
        isInMonsterFarmState := false  ; 切换到回城状态
        SetTimer, SwitchChannel, Off  ; 停止频道切换
        ReturnToTown()  ; 直接回城
    }
    return

; 回城出售装备并返回刷怪地图
ReturnToTown() {
    ; 这里可以添加具体的回城操作代码   
    
    ; 返回刷怪状态并清零频道切换计数
    channelSwitchCount := 0  ; 清零频道切换计数
    isInMonsterFarmState := true  ; 返回刷怪状态
    SetTimer, SwitchChannel, % interval  ; 重新启动频道切换定时器
    SetTimer, MonsterFarmLoop, % monsterFarmInterval  ; 启动刷怪操作的定时器
    return
}
