#NoEnv
#SingleInstance Force
#Include <FindText>
; SetDefaultMouseSpeed, 0
CoordMode, ToolTip, Screen
SetStoreCapsLockMode, Off
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative

; DBG switch
DBG:=true
; DBG:=false

; safe click range
SAFE_RANGE:={x0:0, y0:0, x1:1280, y1:720}

; search range
; x0,y0---------------------
; --------------------------
; --------------------------
; --------------------------
sr_full:={x0:0, y0:0, x1:1280, y1:720}
sr_tanwei:={x0:0, y0:0, x1:1280, y1:720}

; all search text
Text_tanwei_red:="|<>0xC00508@0.90$3.zw"
Text_tanwei_aoi:="|<>0x03C4D1@0.90$3.zw"

NPC_POS:={x:640, y:360}

; init
stop_flg:=0
stat:="idle"
ret_pos:={x:0, y:0}

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

flg = 0
can_click_sure = 0

^t:: 
flg := !flg
can_click_sure = 0
clear_tooltip()
return

^r::
Loop
{
    If (flg)
    {
        flg=0
        clear_tooltip()
        break
    }		

    ImageSearch, Px, Py, sr_tanwei.x0, sr_tanwei.y0, sr_tanwei.x1, sr_tanwei.y1, *32 hpmp.png 
    if (ErrorLevel=0 and flg=0) 
    {
        Click, 640, 360
        tooltip_dbg("NPC",640,360,1)
        Sleep, 100

        ImageSearch, Px, Py, sr_tanwei.x0, sr_tanwei.y0, sr_tanwei.x1, sr_tanwei.y1, *32 gmtw.png 
        if (ErrorLevel=0 and flg=0) 
        {
            Click, %Px%, %Py%, Left
            tooltip_dbg("Rent_Map",%Px%,%Py%,1)
            Sleep, 100
        }
    }
    else
    {
        if (ok:=FindText(X,Y,sr_tanwei.x0,sr_tanwei.y0,sr_tanwei.x1,sr_tanwei.y1,0,0,Text_tanwei_red,,0,,,,9))
        {
            ; for i,v in ok
            ; {
                ; tooltip_dbg("R",v[1],v[2],Mod(i,20)+1)
                ; X:=ok[i].x
                ; Y:=ok[i].y
                ; Click,%X%,%Y%
            ; }
            Random, i, 1, Round(ok.Length())
            tooltip_dbg("R",ok[i].x,ok[i].y,1)
        }

        if (ok:=FindText(X,Y,sr_tanwei.x0,sr_tanwei.y0,sr_tanwei.x1,sr_tanwei.y1,0,0,Text_tanwei_aoi,,0,,,,9))
        {
            ; for i,v in ok
            ; {
                X:=ok[1].x
                Y:=ok[1].y
                tooltip_dbg("B",X,Y,1)
                Click,%X%,%Y%
                Sleep, 100
                Click, 0, 0, 0
            ; }
        }
        else
        {
            ImageSearch, Px, Py, sr_tanwei.x0, sr_tanwei.y0, sr_tanwei.x1, sr_tanwei.y1, *32 close.png 
            if (ErrorLevel=0 and flg=0) 
            {
                Click, %Px%, %Py%, Left
                tooltip_dbg("Close",%Px%,%Py%,1)
                Sleep, 100
            }
        }


        ; ImageSearch, Px, Py, sr_tanwei.x0, sr_tanwei.y0, sr_tanwei.x1, sr_tanwei.y1, *32 12h.png 
        ; if (ErrorLevel=0 and flg=0) 
        ; {
        ;     Px_off:=Px+240
        ;     ; Click, %Px_off%, %Py%, Left
        ;     tooltip_dbg("12h",Px_off,Py,1)
        ;     Sleep, 100

            ImageSearch, Px, Py, sr_tanwei.x0, sr_tanwei.y0, sr_tanwei.x1, sr_tanwei.y1, *32 cz.png 
            if (ErrorLevel=0 and flg=0) 
            {
                Click, %Px%, %Py%, Left
                tooltip_dbg("Rent",Px,Py,1)
                Sleep, 100
                can_click_sure:=1
            }
        ; }

        ImageSearch, Px, Py, sr_tanwei.x0, sr_tanwei.y0, sr_tanwei.x1, sr_tanwei.y1, *32 sure.png 
        if (ErrorLevel=0 and flg=0 and can_click_sure=1) 
        {
            Click, %Px%, %Py%, Left
            tooltip_dbg("Sure",Px,Py,1)
            Sleep, 100

            flg := !flg
            can_click_sure = 0
        }
    }
}
return