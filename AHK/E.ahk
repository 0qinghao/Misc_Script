~e::
loop
{
    Send {e}
    Sleep, 1
    if !GetKeyState("e", "P")
	break
}
return

f5::suspend