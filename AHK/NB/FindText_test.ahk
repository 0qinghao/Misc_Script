#NoEnv
#SingleInstance Force
#Include <FindText>
; SetDefaultMouseSpeed, 0
CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off

; DBG switch
DBG:=true
; DBG:=false

; safe click range
SAFE_RANGE:={x0:0, y0:0, x1:1840, y1:850}

; hp_bar to hit box offset
hp_bar_2_hit_box_offset:={x:75, y:130}

; search range
; x0,y0---------------------
; --------------------------
; --------------------------
; --------------------------
; ---------------------x1,y1
sr_minigame:={x0:2243, y0:355, x1:2558, y1:782}
sr_minigameobj:={x0:732, y0:259, x1:1838, y1:852}
sr_full:={x0:0, y0:0, x1:2560, y1:1080}
sr_elite:={x0:0, y0:0, x1:0, y1:0}
sr_boss:={x0:0, y0:0, x1:0, y1:0}
sr_animation:={x0:2465, y0:1020, x1:2505, y1:1060}
sr_between_2_game:={x0:0, y0:0, x1:0, y1:0}
sr_oyaji_shop:={list_x0:0, list_y0:0, list_x1:0, list_y1:0, confirm_x0:0, confirm_y0:0, confirm_x1:0, confirm_y1:0}

; all search text
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
Text_minigame_obj:="|<minigame_obj>##0$0/0/565453,18/0/565453,40/0/565453,-12/9/565553,-12/13/565553"
Text_animation:="|<animation_E>*83$5.zzs07CQ03bC07zzU"
Text_between_2_game1:=
Text_between_2_game2:=

; create Text
Text_hp_bar:=""
Text_hp_bar.=Text_hp_bar_start
Text_hp_bar.=Text_hp_bar_mid
Text_elite:=""
Text_elite.=Text_elite_jv
Text_elite.=Text_elite_xin1
;Text_elite.=Text_elite_xin2
Text_elite.=Text_elite_per1
Text_elite.=Text_elite_per2
Text_elite.=Text_elite_per3
Text_elite.=Text_elite_x1
Text_elite.=Text_elite_x2
Text_boss:=""
Text_boss.=Text_c2_boss_icon
Text_minigame:=""
;Text_minigame.=Text_minigame1
Text_minigame.=Text_minigame2
Text_between_2_game:=""
; Text_all:=""
; Text_all.=Text_hp_bar
; Text_all.=Text_elite
; Text_all.=Text_boss
; Text_all.=Text_minigame

; skill key
; key_list_full:=["1","2","3","q","w","e","r","a","s","d"]
key_list_full:=["1","2","space","q","w","e","r","a","s","d"]

; init
stop_flg:=0
stat:="idle"
ret_pos:={x:0, y:0}

; todo: update stat_prev, to check timeout
stat_decide(ByRef ret_pos)
{
    ; 优先级：minigame - boss - elite - animation - between_2_game - hp_bar
    global sr_minigame, sr_full, sr_boss, sr_elite, Text_hp_bar, Text_elite, Text_boss, Text_minigame, hp_bar_2_hit_box_offset

    ; Nine directions for searching:
    ; 1 ==> ( Left to Right ) Top to Bottom
    ; 2 ==> ( Right to Left ) Top to Bottom
    ; 3 ==> ( Left to Right ) Bottom to Top
    ; 4 ==> ( Right to Left ) Bottom to Top
    ; 5 ==> ( Top to Bottom ) Left to Right
    ; 6 ==> ( Bottom to Top ) Left to Right
    ; 7 ==> ( Top to Bottom ) Right to Left
    ; 8 ==> ( Bottom to Top ) Right to Left
    ; 9 ==> From center outwards
    if (ok:=FindText(X,Y,sr_minigame.x0,sr_minigame.y0,sr_minigame.x1,sr_minigame.y1,0,0,Text_minigame,,0,,,,8))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("minigame",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x
        ret_pos.y:=ok[1].y
        return "minigame"
    }

    if (ok:=FindText(X,Y,sr_boss.x0,sr_boss.y0,sr_boss.x1,sr_boss.y1,0,0,Text_boss,,0,,,,1))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("boss",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x
        ret_pos.y:=ok[1].y
        return "boss"
    }

    if (ok:=FindText(X,Y,sr_elite.x0,sr_elite.y0,sr_elite.x1,sr_elite.y1,0,0,Text_elite,,0,,,,1))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("elite",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x
        ret_pos.y:=ok[1].y
        return "elite"
    }

    if (ok:=FindText(X,Y,sr_animation.x0,sr_animation.y0,sr_animation.x1,sr_animation.y1,0,0,Text_animation,,0,,,,8))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("animation",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x
        ret_pos.y:=ok[1].y
        return "animation"
    }

    if (ok:=FindText(X,Y,sr_between_2_game.x0,sr_between_2_game.y0,sr_between_2_game.x1,sr_between_2_game.y1,0,0,Text_between_2_game,,0,,,,8))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("between_2_game",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x
        ret_pos.y:=ok[1].y
        return "between_2_game"
    }

    if (ok:=FindText(X,Y,sr_full.x0,sr_full.y0,sr_full.x1,sr_full.y1,0,0,Text_hp_bar,,0,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("hp_bar",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x+hp_bar_2_hit_box_offset.x
        ret_pos.y:=ok[1].y+hp_bar_2_hit_box_offset.y
        return "hp_bar"
    }

    return "idle"
}

; todo: clip x,y
play_minigame()
{
    global sr_minigameobj, Text_minigame_obj

    ; PixelSearch, X, Y, sr_minigameobj.x0, sr_minigameobj.y0, sr_minigameobj.x1, sr_minigameobj.y1, 0x1dbffd, 2, Fast ; 金黄色
    PixelSearch, X, Y, sr_minigameobj.x0, sr_minigameobj.y0, sr_minigameobj.x1, sr_minigameobj.y1, 0x1a75ec, 2, Fast ; 金黄色
    if (ErrorLevel==0)
    {
        if(clip_xy(X,Y)) ; 1 means safe
        {
            ; FindText().Click(X, Y, "L")
            Click,%X%,%Y%
        }
    }
    else
    {
        ; PixelSearch, X, Y, sr_minigameobj.x0, sr_minigameobj.y0, sr_minigameobj.x1, sr_minigameobj.y1, 0xa0c0ee, 2, Fast ; 淡黄肤色
        PixelSearch, X, Y, sr_minigameobj.x0, sr_minigameobj.y0, sr_minigameobj.x1, sr_minigameobj.y1, 0xa7b9ea, 2, Fast ; 淡黄肤色
        if (ErrorLevel==0)
        {
            if(clip_xy(X,Y)) ; 1 means safe
            {
                ; FindText().Click(X, Y, "L")
                Click,%X%,%Y%
            }
        }

        ; if (ok:=FindText(X,Y,sr_minigameobj[1],sr_minigameobj[2],sr_minigameobj[3],sr_minigameobj[4],0,0,Text_minigame_obj,,,,,,9))
        ; {
        ;     for i,v in ok
        ;     {
        ;         if (i<=19)
        ;         {
        ;             tooltip_dbg("minigame_obj",v[1],v[2],i)
        ;         }
        ;     }
        ;     Random, rand_ind, 1, ok.MaxIndex()
        ;     X_off:=ok[rand_ind].x+55
        ;     Y_off:=ok[rand_ind].y+120
        ;     Click,%X_off%,%Y_off%
        ; }
    }
}

tooltip_dbg(txt,x,y,n)
{
    global DBG

    if(DBG)
    {
        ToolTip, %txt%, %x%, %y%, %n%
    }
}

clear_tooltip()
{
    global DBG

    if(DBG)
    {
        Loop, 19
        {
            ToolTip, , 0, 0, %A_Index%
        }
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

fight_boss()
{}

fight_elite()
{}

; todo: clip x,y
; todo: 能否做到两次进入 minion 状态之间保持鼠标down
; todo: 左键点击位置无法产生移动时按住 shift 强制攻击
fight_minion(pos)
{
    global key_list_full, sr_full, Text_hp_bar

    x:=pos.x
    y:=pos.y

    ; todo: check if jump twice
    Click,%x%,%y%,Right,2
    Click,%x%,%y%,Down
    if (ok:=FindText(X,Y,sr_full.x0,sr_full.y0,sr_full.x1,sr_full.y1,0,0,Text_hp_bar,,0,,,,9))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                ToolTip, hp_bar, v[1], v[2], i
            }
        }
        x:=ok[1].x+hp_bar_2_hit_box_offset.x
        y:=ok[1].y+hp_bar_2_hit_box_offset.y
    }
    Click,%x%,%y%,Down
    cast_rand_skill(key_list_full)
    ; cast_rand_skill(key_list_full)
    Click,%x%,%y%,UP
}

cast_rand_skill(key_list)
{
    Random, rand_ind, 1, key_list.MaxIndex()
    skill:=key_list[rand_ind]
    if (skill=="space")
        Send, {space}
    else
        Send, %skill%
}

; todo: set move strategy, move around whole map
rand_move()
{
    Random, x, 930, 1630
    Random, y, 290, 790
    Click,%x%,%y%
    Sleep, 500
}

skip_animation(pos)
{
    x:=pos.x
    y:=pos.y
    Click,%x%,%y%
}

check_hp_mp()
{
}

clip_xy(ByRef x, ByRef y)
{
    global SAFE_RANGE

    x := (x<SAFE_RANGE.x0) ? SAFE_RANGE.x0 : ((x>SAFE_RANGE.x1) ? SAFE_RANGE.x1 : x)
    y := (y<SAFE_RANGE.y0) ? SAFE_RANGE.y0 : ((y>SAFE_RANGE.y1) ? SAFE_RANGE.y1 : y)

    If (x==SAFE_RANGE.x0 || x==SAFE_RANGE.x1 || y==SAFE_RANGE.y0 || y==SAFE_RANGE.y1 )
    {
        return 0
    }
    else
    {
        return 1
    }
}

CoordMode, ToolTip, Screen
`::
    if (ok:=FindText(X,Y,0,0,sr_animation.x1,sr_animation.y1,0,0,Text_animation,,0,,,,8))
    {
        for i,v in ok
        {
            if (i<=19)
            {
                tooltip_dbg("animation",v[1],v[2],i)
            }
        }
        ret_pos.x:=ok[1].x
        ret_pos.y:=ok[1].y
        skip_animation(ret_pos)
    }