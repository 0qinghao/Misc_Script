; #include <FindText>
;Text:="|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8" ; Image of the "auto" part in "autohotkey.com". Id of the image is "auto" (between < and > characters).
;ok := FindText(outX, outY,,,,,,,Text) ; Call FindText to look for the "auto" image. outX and outY will be set to X and Y coordinates for the first found result. Search range coordinates, err1 and err0 are left empty to use the default values (searching the whole screen, and looking for an exact match). Results will be stored in the "ok" variable.
;if ok { ; Check if "ok" is not set to 0
;    MsgBox, The image (Text) was first found at coordinates X: %outX% Y: %outY% ; Display outX and outY
;    MsgBox, % ok.MaxIndex() " results were found." ; ok.MaxIndex() and ok.Length() should return how many search results were found.
;    MsgBox, % "The first found image is located at X" ok[1][1] " Y" ok[1][2] ". It has a width of " ok[1][3] " and a height of " ok[1][4] ". Additionally it has a id of " ok[1].id
;    if ok[2] ; ok[1] contains the first result, ok[2] contains the second result, etc... Check if ok[2] exists and if yes, display some of its contents.
;        MsgBox, % "The second found image is located at X" ok[2][1] " Y" ok[2][2] " and it has a width of " ok[2][3] " and a height of " ok[2][4] ". Additionally it has a comment text of " ok[2].id
;} else {
;    MsgBox, The image/Text was not found. Is everything set up correctly and the image is visible in Paint? ; It seems "ok" was left empty, so nothing was found.
;}

;#include <FindText>

;if (ok := FindText(outX, outY, 0, 0, A_ScreenWidth, A_ScreenHeight, 0.05, 0.05, "|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8")) { ; Call FindText to look for the "auto" image. outX and outY will be set to X and Y coordinates for the first found result. Search ranges top left corner is (0;0) and bottom right corner (A_ScreenWidth; A_ScreenHeight), which should search the whole screen, but might not work properly if using multiple monitors. Error margins are set to 5% for both "1"s and "0"s. Results will be stored in the "ok" variable. If "ok" contains results, then the "if" condition will be successful.
;    for k, v in ok { ; Loop over all the search results in "ok". "k" will be the nth result, and "v" will contain the result itself.
;        MsgBox, % "Result number " k " is located at X" v[1] " Y" v[2] " and it has a width of " v[3] " and a height of " v[4] ". Additionally it has a comment text of " v.id ; v[1] is equivalent to ok[k][1], v.id is equivalent to ok[k].id, and so on.
;    }
;} else {
;    MsgBox, The image/Text was not found. Is everything set up correctly and the image is visible in Paint? ; It seems "ok" was left empty, so nothing was found.
;}

; #include <FindText>
; Text:="|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8" ; Image of the "auto" part in "autohotkey.com". Id of the image is "auto" (between < and > characters).
; Text.="|<hot>*152$29.U00010000200014000280004Hk7kzxktktVVUkX161V43A3286M24EAkA8UNUMF0lUUW1Xb1g31s1s" ; Append an image of the "hot" part in "autohotkey.com" to the Text variable (note the ".=" operator which appends, when previously we used ":=" to set). Id of the image is "hot".
; ; The last two lines are the same as Text:="|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8|<hot>*152$29.U00010000200014000280004Hk7kzxktktVVUkX161V43A3286M24EAkA8UNUMF0lUUW1Xb1g31s1s"

; WinGetPos, pX, pY, pW, pH, ahk_class MSPaintApp ; Get the Paint application location and size.

; if !(ok := FindText(X, Y, pX, pY, pX+pW, pY+pH, 0.000001,, Text)) { ; Call FindText to look for either "auto" or "hot" images. X and Y will be set to X and Y coordinates for the first found result. The search range will be only the Paint application. Setting one or both of the error margins to a small non-zero value will avoid the second search with 5% error margins. Results will be stored in the "ok" variable. If "ok" doesn't contain anything ("!" is the "not" operator) then exit, otherwise continue on.
;     MsgBox, The image/Text was not found. Is everything set up correctly and the image is visible in Paint? ; It seems "ok" was left empty, so nothing was found.
;     ExitApp
; }
; ; Anything after this part will happen only if any of the Text was found (either "hot" or "auto" image).

; for key, value in ok { ; Loop over all the search results in "ok". "key" will be the nth result, and "value" will contain the result itself.
;     FindText().MouseTip(value.x, value.y) ; Show a blinking red box at the center of the result.
;     MsgBox, % "Result number " key " is located at X" value[1] " Y" value[2] " and it has a width of " value[3] " and a height of " value[4] ". Additionally it has a comment text of " value.id ; value[1] is equivalent to ok[k][1], value.id is equivalent to ok[k].id, and so on.
;     if (value.id == "auto")
;         MsgBox, Here we found the "auto" image.
; }

; #NoEnv
; #SingleInstance Force

; #include <FindText>

; ; First some character sets for numbers, uppercase characters and lowercase characters (taken from Notepad font Consolas, Regular, 11)

; if (A_ScreenDPI = 96) {
;     numbers := "|<0>**50$8.03laNwTDyyBWNXk0U|<1>**50$7.06D5UkMA631Xy0U|<2>**50$7.0DAkMA667773y0U|<3>**50$6.0y333S3333y0U|<4>**50$8.00sS7XMaNgPz1UM0U|<5>**50$6.0zkkky3333y0U|<6>**50$7.07a631ynMwSNs0U|<7>**50$7.0TkMMAA66331U0U|<8>**50$7.0DgqPgwzNwSNs0U|<9>**50$8.03laFgBbDkM637U0U"
;     uppercase := "|<A>*150$8.61kI92MWMbt3kE0008|<B>*150$6.yXVXyXVVXy000U|<C>*150$6.DEkUUUUkED000U|<D>*150$7.yFcIC73VkcrU000E|<E>*150$5.z24DkV27k01|<F>*150$5.z248TV24001|<G>*150$6.DEUUUbVVlD000U|<H>*150$6.VVVVzVVVVV000U|<I>*150$6.zAAAAAAAAz000U|<J>*150$4.wF4F4Fs02|<K>*150$7.VF9YXVkYH8oA000E|<L>*150$5.V248EV27k01|<M>*150$8.EaRbNphNqQ71kE0008|<N>*150$6.lltddZZXXX000U|<O>*150$7.SNcIC73Vkgnk000E|<P>*150$6.yXVVXyUUUU000U|<Q>*150$7.SNcIC73VkgnkE93k|<R>*150$7.yNgKPtgmNAKA000E|<S>*150$6.TkUkQ6113y000U|<T>*150$7.za31UkMA631U000E|<U>*150$6.VVVVVVVVnS000U|<V>*150$7.UksK/AYGD31U000E|<W>*150$7.UkMAirOdNgqM000E|<X>*150$6.VnGSAASGnV000U|<Y>*150$7.VkgnEsMA631U000E|<Z>*150$6.z1264A8EEz000U"
;     lowercase := "|<a>**50$6.00Sn3Tnnz00U|<b>**50$7.kMDrP7XltjU01|<c>**50$6.00DskkksT00U|<d>**50$6.33TnnXnrT00U|<e>**50$7.007aP7zkM7k01|<f>**50$7.631bwMA631U01|<g>**50$8.000zNaNaT61yMyC|<h>**50$6.kkzvnnnnn00U|<i>**50$7.A0D1UkMA6Ds01|<j>**50$5.63slX6AMtk|<k>**50$7.kMAynlsyPgs01|<l>**50$7.A631UkMA6Ds01|<m>*150$7.00CqiL/ZmtM01|<n>**50$6.00zvnnnnn00U|<o>**50$8.000wNYD3kqMw002|<p>**50$7.00DrP7Xltja31|<q>**50$6.00TnnXnrT33U|<r>**50$7.00DrD7UkMA001|<s>**50$6.00TksS33y00U|<t>**50$8.A33zA30kA3UT002|<u>**50$6.00nnnnnnT00U|<v>**50$8.0033NaMaD3kM002|<w>**50$8.0033kxjPLqta002|<x>**50$8.001bBXkMD6Pb002|<y>**50$8.0033NaMYD3kM632|<z>**50$7.00DkMMM8ADs01"

; } else if (A_ScreenDPI = 144) {
;     numbers :="|<0>*139$10.7Uza6MD1wDnjQz3sD0q6DkS8|<1>*139$9.73sv4M30M30M30M30MzzzU|<2>*139$9.D7wlk60k61UQ71kQ70zzzU|<3>*139$8.TDu70kA6D3s30E43zjm|<4>*139$11.1k3UD0q1g6MMkVX37zzzUM0k1W|<5>*139$9.zryk60k60z7y0k70kCzbsU|<6>*139$10.3sTXUM1U5wzvVw3kBUq6DsS8|<7>*139$10.zzzk30M1UA0k60M30A1U60k8|<8>*139$10.7lza6MBVbCDkT7CMD0y7Tsz8|<9>*139$10.7Vz66kP0w3sRznv081UATVw8"
;     uppercase := "|<A>**50$12.000000003k3k3s7M6M6QCQCAACTyTyM7s7s30000000000U|<B>**50$10.0000003zDysvVy6svzDyszVy7sTzjw000000008|<C>**50$10.0000000TXzSDUC0s30A0s3UC0SAzly000000008|<D>**50$11.0000000DsTwkxUv0y1w3s7kDUP1q7jyTk000000000E|<E>**50$9.000000zzzk60k60zryk60k60zzz00000004|<F>**50$9.000000zzzk60k60zryk60k60k6000000004|<G>**50$11.00000000z3zC6s1k30CDwTs6sBkPknzVy000000000E|<H>**50$10.00000030w3kD0w3kDzzzkD0w3kD0w3000000008|<I>**50$9.000000zzz60k60k60k60k60kzzz00000004|<J>**50$8.00000Dzz1kQ71kQ71kQ7Xjvw0000002|<K>**50$10.0000003VyCsnbCsz3sDUz3iCQsvXi7000000008|<L>**50$9.000000s70s70s70s70s70s70zzz00000004|<M>**50$12.00000000QCQCKOSSSLPrPrPrtbs7s7s7s7s70000000000U|<N>**50$10.0000003Uz3wDsxXrDgyntjayTszXy7000000008|<O>**50$12.000000007sDwSSQ6M7s7s7s7s7M7QCSSDw7s0000000000U|<P>**50$10.0000003zDyszVy3sTXzyzXUC0s3UC0000000008|<Q>**50$12.000000007sDwSSQ6M7s7s7s7s7M7QCSSDw7s1U1n0z0S00U|<R>**50$10.0000003yDwlv3gClnyDknX7AQkv3g7000000008|<S>**50$10.0000000z7ywPUC0S0y0y0w1k7kTzbw000000008|<T>**50$10.0000003zzz30A0k30A0k30A0k30A0k000000008|<U>**50$10.00000030w3kD0w3kD0w3kD0y7sxzXw000000008|<V>**50$12.00000000s3s7M6Q6QCACCACQ6Q6M7s3s3k3k0000000000U|<W>**50$11.k7UD0y1w3tbnjjPSqxhDSSwxsu|<X>**50$11.sDktnVr3w3k7UD0z1y7CCCsRUS|<Y>**50$11.kDUTVnX7C7MDkD0C0M0k1U3062|<Z>**50$10.0000003zzz0M3UQ1UC0k60s30M3zzz000000008"
;     lowercase := "|<a>**50$10.000000003wTtVk7Dxzy7sTXrzDQ0000008|<b>**50$10.03UC0s3UCwzvty7sDUy3sTXzyTU0000008|<c>**50$10.000000001yDxsr0M3UC0M1knz7s0000008|<d>**50$10.001k70Q1lzTxly7sT1y7sTbrzDQ0000008|<e>**50$10.000000001wTtly3zzzy0s1k7zDw0000008|<f>**50$11.003wDss1k3UzxzsQ0s1k3U70C0Q0s00000002|<g>**50$11.0000000007zTytnVX77yDss1k3zXzi3wCzwzW|<h>**50$10.03UC0s3UCwzvtz7sTVy7sTVy7sQ0000008|<i>**50$9.71s70007sz0s70s70s70szzz000000U|<j>**50$9.1kD1k003yTk60k60k60k60k60qCzXsU|<k>**50$9.060k60k67lqQr7ky6sr6Qlq7000000U|<l>**50$9.07sz0s70s70s70s70s70szzz000000U|<m>**50$11.000000000TizxrTCyNwntbnDaTAyNk0000002|<n>**50$10.00000000Cwzvtz7sTVy7sTVy7sQ0000008|<o>**50$10.000000003wTvny7kD0w3sTnryDk0000008|<p>**50$10.00000000Cwzvty7sDUy3sTXzyzXUC0s3U8|<q>**50$10.000000001zTxly7sT1y7sTbrzDQ1k70Q1s|<r>**50$9.00000006yzzbsS0k60k60k60000000U|<s>**50$9.00000003wzr6s7UTUS0y6zrw000000U|<t>**50$11.0000A0s1kTzzyC0Q0s1k3U7070DsDk0000002|<u>**50$10.00000000C7sTVy7sTVy7sRrrzDQ0000008|<v>**50$10.00000000A3sTVq6QsnXADkO1s7U0000008|<w>**50$12.0000000000s3s7s7NbNqPqPqOKSSSSCS00000000U|<x>**50$10.00000000C7QRnXw7US1wDlnb7sQ0000008|<y>**50$12.0000000000M7QCQCAACQ6M7M7s3k3k1U3U70z0w0U|<z>**50$10.000000007zTs3UQ1UA1UC1k7zzw0000008"
; } else {
;     MsgBox, Your current screen DPI is not supported! Exiting...
;     ExitApp
; }

; characterset := lowercase . uppercase . numbers
; ; Add our newly created character set to PicLib library
; FindText().PicLib(characterset, 1)

; return

; F1::
;     InputBox, searchPhrase, Search Notepad, % "Search Notepad for some text. To make the search case sensitive, put the search term in quotes."
;     Sleep, 500 ; Sometimes the InputBox closing animation is slow causes the search to fail, so wait for it to close

;     caseSensitive := (SubStr(searchPhrase,1,1) == """") && (SubStr(searchPhrase,0) == """")
;     if caseSensitive
;         searchPhrase := SubStr(searchPhrase,2,-1) ; For case-sensitive search remove double-quotes
;     else
;         StringLower, searchPhrase, searchPhrase ; For case-insensitive search, turn the search phrase into lowercase

;     if (ok:=FindText(X, Y,,,,, 0.1, 0.1, caseSensitive ? FindText().PicN(searchPhrase) : RegexReplace(characterset, "(?<=<)\p{L}(?=>)", "$L0"),1,1, caseSensitive ? 1 : [searchPhrase])) ; If doing a case-sensitive search, glue together the images for each character in searchphrase using PicN and use FindAll=1 to look for the resulting image. If doing case-insensitive search, replace all uppercase characters in our character set with lowercase characters (which means that FindText will use both uppercase and lowercase images in the search) and then look for the lowercase searchphrase.
;     {
;         FindText().MouseTip(X, Y)
;         ; FindText().Click(X, Y, "L")
;     }
; return

; key_list_full:=["1","2","space","q","w","e","r","a","s","d"]

; cast_rand_skill(key_list)
; {
;     Random, rand_ind, 1, key_list.MaxIndex()
;     skill:=key_list[rand_ind]
;     if (skill=="space")
;         Send, {space}
;     else
;         Send, %skill%
; }
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
sr_animation:={x0:0, y0:0, x1:0, y1:0}
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
Text_animation:=
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
PixelSearch, X, Y, 0, 0, 1920, 1080, 0x5f5f00, 10, Fast ;
if (ErrorLevel==0)
{
    if(clip_xy(X,Y)) ; 1 means safe
    {
        FindText().Click(X, Y, "L")
    }
}
; x:=500
; y:=500
; Click,%x%,%y%,Right,2
; click,365,86
; Click,%x%,%y%,Down

; x:=550
; y:=550
; Click,%x%,%y%,Down
; ; cast_rand_skill(key_list_full)
; ; cast_rand_skill(key_list_full)
; Click,%x%,%y%,UP