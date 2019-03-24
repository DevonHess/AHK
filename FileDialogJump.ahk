#IfWinActive ahk_class #32770
	^g::
		ControlGetText, loc, ToolbarWindow323, ahk_exe explorer.exe ahk_class CabinetWClass
		loc := StrReplace(loc, "Address: ")
		SendInput, !d^a{Text}%loc%
		SendInput, {Enter}
		KeyWait, g
	Return
#If
