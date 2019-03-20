SetControlDelay -1
cx := 0
cy := 0
win := 
autoclick := false

Loop
{
	While (autoclick = true)
	{
		GetKeyState, test, LButton
		if (test = "U")
		{
			ToolTip, x, %cx%, %cy%
			ControlClick, x%cx% y%cy%, ahk_id %win%,,,, NA
			SetTimer, RemoveToolTip, -100
		}
	}
}

XButton1::
	autoclick := !autoclick
Return

XButton2::
	MouseGetPos, cx, cy, win
	ToolTip, x, %cx%, %cy%
	SetTimer, RemoveToolTip, -1000
Return

RemoveToolTip:
	ToolTip,,,, 1
Return
