SetControlDelay -1
cx := 0
cy := 0
win := 
autoclick := false

Loop
{
	While (autoclick = true)
	{
		If !GetKeyState("LButton")
		{
			ToolTip, x, %cx%, %cy%
			ControlClick, x%cx% y%cy%, ahk_id %win%,,,, NA
		}
	}
}

XButton1::
	autoclick := !autoclick
	ToolTip
Return

XButton2::
	While GetKeyState("XButton2", "P") {
		MouseGetPos, cx, cy
		ToolTip, x, %cx%, %cy%
	}
	MouseGetPos, cx, cy, win
	ToolTip
Return
