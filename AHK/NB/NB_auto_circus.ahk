#Include <FindText>
; SetDefaultMouseSpeed, 0
CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

; search range
sr_minigame:=[2243, 355, 2558, 782]
sr_minigameobj:=[732, 259, 1838, 852]
sr_full:=[0,0,2560,1080]
sr_elite:=[]
sr_boss:=[]
sr_animation:=[]
sr_next_game_pad:=[]
sr_oyaji_shop:=[]

; search text
Text_hp_bar_start:="|<hp_bar>##0$0/0/001829,0/1/00212E,1/0/E7690B,4/-2/FF9532,5/4/002B3F"
Text_hp_bar_mid:="|<hp_bar>##0$0/0/FF9532,0/1/ED6600,1/1/00111F,0/3/EB6304,1/3/00101E,0/4/E55C04,1/4/00121E"
Text_c2_boss_icon:="|<boss>*53$35.00007UAM00T00001y60664wD3wtF8NzzrUElyTblVTsy3X2Tbb7Q1xlu7s07607c0w00SE3o00R17800q3Ak01A7F002MD2004kS00U9kwE301lkEU03nUY007b1U001i1U000t3002My6007t"
Text_elite_jv:="|<elite>0xFDAD2B@0.60$10.zy080zzzs0U20Dzzy080U3zs"
Text_elite_xin1:="|<elite>*120$17.zrzzjz00TyzzxzU00001"
Text_elite_xin2:="|<elite>*160$7.irPhqvxyszw"
Text_elite_per1:="|<elite>*210$6.vryhxRxyU"
Text_elite_per2:="|<elite>*120$8.bNaPYXFYvAnQU"
Text_elite_per3:="|<elite>#39@0.60$9.vyTqQVdXANbAwA"
Text_elite_x1:="|<elite>*170$7.nNCDD39AiM"
Text_elite_x2:="|<elite>EFECE6-828080$10.3QDUw3UT1gAlXgCU"
Text_minigame1:="|<minigame>##0$0/0/040404,0/11/040404,62/11/000000,62/0/000000"
Text_minigame2:="|<minigame>*113$8.tk3btyQ0tyTb003zU"
Text_minigame_obj:="|<>##0$0/0/565453,18/0/565453,40/0/565453,-12/9/565553,-12/13/565553"
Text_animation:=
Text_next_game_pad1:=
Text_next_game_pad2:=

; init
Text_hp_bar:=""
Text_elite:=""
Text_boss:=""
Text_minigame:=""
Text_next_game_pad:=""
Text_hp_bar.=Text_hp_bar_start
Text_hp_bar.=Text_hp_bar_mid
Text_elite.=Text_elite_jv
Text_elite.=Text_elite_xin1
;Text_elite.=Text_elite_xin2
Text_elite.=Text_elite_per1
Text_elite.=Text_elite_per2
Text_elite.=Text_elite_per3
Text_elite.=Text_elite_x1
Text_elite.=Text_elite_x2
Text_boss.=Text_c2_boss_icon
;Text_minigame.=Text_minigame1
Text_minigame.=Text_minigame2

; Text_all:=""
; Text_all.=Text_hp_bar
; Text_all.=Text_elite
; Text_all.=Text_boss
; Text_all.=Text_minigame

stop_flg:=0
stat:="idle"
ret_pos:=[0,0]

stat_decide(ByRef ret_pos)
{
    ; 优先级：minigame - boss - elite - animation - next_game_pad - hp_bar
    global sr_minigame, sr_full, sr_boss, sr_elite, Text_hp_bar, Text_elite, Text_boss, Text_minigame

    if (ok:=FindText(X,Y,sr_minigame[1],sr_minigame[2],sr_minigame[3],sr_minigame[4],0,0,Text_minigame,,,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, minigame, v[1], v[2], i
            }
        }
        ret_pos:=[ok[1].x,ok[1].y]
        return "minigame"
    }

    if (ok:=FindText(X,Y,sr_boss[1],sr_boss[2],sr_boss[3],sr_boss[4],0,0,Text_boss,,,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, boss, v[1], v[2], i
            }
        }
        ret_pos:=[ok[1].x,ok[1].y]
        return "boss"
    }

    if (ok:=FindText(X,Y,sr_elite[1],sr_elite[2],sr_elite[3],sr_elite[4],0,0,Text_elite,,,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, elite, v[1], v[2], i
            }
        }
        ret_pos:=[ok[1].x,ok[1].y]
        return "elite"
    }

    if (ok:=FindText(X,Y,sr_animation[1],sr_animation[2],sr_animation[3],sr_animation[4],0,0,Text_animation,,,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, animation, v[1], v[2], i
            }
        }
        ret_pos:=[ok[1].x,ok[1].y]
        return "animation"
    }

    if (ok:=FindText(X,Y,sr_next_game_pad[1],sr_next_game_pad[2],sr_next_game_pad[3],sr_next_game_pad[4],0,0,Text_next_game_pad,,,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, next_game_pad, v[1], v[2], i
            }
        }
        ret_pos:=[ok[1].x,ok[1].y]
        return "next_game_pad"
    }

    if (ok:=FindText(X,Y,sr_full[1],sr_full[2],sr_full[3],sr_full[4],0,0,Text_hp_bar,,,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, hp_bar, v[1], v[2], i
            }
        }
        cent_ind:=(ok.MaxIndex()+1)>>1
        ret_pos:=[ok[cent_ind].x,ok[cent_ind].y]
        return "hp_bar"
    }

    return "idle"
}

play_minigame()
{
    global sr_minigameobj, Text_minigame_obj

    PixelSearch, X, Y, sr_minigameobj[1], sr_minigameobj[2], sr_minigameobj[3], sr_minigameobj[4], 0x1dbffd, 2, Fast
    if (ErrorLevel==0)
        FindText().Click(X, Y, Left)
    else 
    {
        PixelSearch, X, Y, sr_minigameobj[1], sr_minigameobj[2], sr_minigameobj[3], sr_minigameobj[4], 0xa0c0ee, 2, Fast
        if (ErrorLevel==0)
            FindText().Click(X, Y, Left)

        if (ok:=FindText(X,Y,sr_minigameobj[1],sr_minigameobj[2],sr_minigameobj[3],sr_minigameobj[4],0,0,Text_minigame_obj,,,,,,9))
        {
            for i,v in ok
            {
                if (i<=19)
                {
                    ToolTip, minigame_obj, v[1], v[2], i
                }
            }
            Random, rand_ind, 1, ok.MaxIndex()
            FindText().Click(ok[rand_ind].x+55, ok[rand_ind].y+120, Left)
        }
    }
}

clear_tooltip()
{
    Loop, 19
    {
        ToolTip, , 0, 0, %A_Index%
    }
}

do_sth_b4_next_game()
{
}

switch_role()
{
}

buy_oyaji()
{
}

check_maintenance()
{
}

^h:: stop_flg := !stop_flg

^g::
    Loop
    {
        If (stop_flg)
        {
            stop_flg=0
            ToolTip, , 0, 0, 20 
            break
        }

        ; WinActive("WinTitle" [, "WinText", "ExcludeTitle", "ExcludeText"])
        stat:=stat_decide(ret_pos)

        switch stat
        {
        case "idle":
            ToolTip, s_idle,,,20
            check_maintenance()
        case "minigame":
            ToolTip, s_minigame,,,20
            play_minigame()
        case "boss":
            ToolTip, s_boss,,,20
        case "elite":
            ToolTip, s_elite,,,20
        case "hp_bar":
            ToolTip, s_hp_bar,,,20
        case "animation":
            ToolTip, s_animation,,,20
        case "next_game_pad":
            ToolTip, s_next_game_pad,,,20
            do_sth_b4_next_game()
        }

        clear_tooltip()
    }
