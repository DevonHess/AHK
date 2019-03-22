#IfWinActive ahk_class #32770
	^g::
		ControlFocus, Edit1, ahk_exe explorer.exe ahk_class CabinetWClass
		ControlSend, Edit1, ^l{Escape}, ahk_exe explorer.exe ahk_class CabinetWClass
		ControlGetText, loc, Edit1, ahk_exe explorer.exe ahk_class CabinetWClass
		SendInput,!d^a%loc%{Enter}
		KeyWait, g
	Return
#If
