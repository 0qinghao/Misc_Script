SetTimer PressScrollLock, 120000   ; 设置定时器，每2分钟（120000毫秒）执行一次PressScrollLock函数

PressScrollLock()
{
	Send "{ScrollLock}"   ; 发送Scroll Lock键
	return
}