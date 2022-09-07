#Include <FindText>
SetDefaultMouseSpeed, 0
; CoordMode, ToolTip, Screen


Text:="|<>*156$68.zszzzyDzrbbzwDzzzXzskkz001y0Mzw4A0k00TU00Tk00A007zy07y0037zVzzU1zk0zlzsTzyATaD0Q007k0X7kXk7001w08ly001lzzzkyATm0sQTzzw3X7zUAD001z0ElzMU0U00TV4ATU808007sF37s2020zVy01ly8X7WDsT00QTU8lkU07s007k6AQ801yT21w007a00TzlUz611zXzDzyNzxcky"

flg = 0
cnt = 0

^m:: flg := !flg

^l::
multilogin()
{

	Loop
	{	
		if (not WinExist("NGP游戏平台"))
		{
			Run, C:\Users\qhlin\Desktop\超激斗梦境.lnk
			Sleep, 5000
		}
			
;		if (WinExist("NGP游戏平台"))
;			WinActivate ; 使用 WinExist 找到的窗口
			
;		Click, 960,540,0
;		ImageSearch, pX, pY, 1200, 666, 1385, 758, *32 启动游戏.bmp
;		if(ErrorLevel=0)
;		{
;			Click, %pX%, %pY%
;			break
;		}
;		ImageSearch, pX, pY, 1400, 666, 1685, 758, *32 启动游戏.bmp
;		if (ok:=FindText(pX, pY, 1400, 666, 1685, 758, 0.1, 0.1, Text))
;		{
;			Click, %pX%, %pY%
;			WinKill, NGP游戏平台, , 1
;		}
	}
}