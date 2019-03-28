#MaxHotkeysPerInterval 200
SetCapsLockState, AlwaysOff 

; Caps Lock sent through double press
*CapsLock::			
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 300 && A_TimeSincePriorHotkey > 100)
	{
		TogCapsLockState()
	}
Return

; Send Caps Lock normally if no hotkey sent
/*
CapsLock Up::
	if (A_PriorHotkey == "*CapsLock")
	{
		TogCapsLockState()
	}
Return
*/

; Check that Caps Lock is being held down
#If GetKeyState("CapsLock","P")

Esc::Suspend

/* Shift::
	TogCapsLockState()
Return
*/

F1::
msg =
(
Caps+F1		Help
Caps+F5		Reload
Caps+Shift	Caps Lock
Caps+``		Command Shell
Caps+1		Volume Mixer
Caps+2		On-Screen Keyboard
Caps+3		Magnifier
Caps+4		Character Map
Caps+X		Replace Selection
Caps+C		Append Selection to Clipboard
Caps+V		Emulate Typing Clipboard
Caps+Space	Screen Off
Caps+Wheel Up	Volume Up
Caps+Wheel Down	Volume Down
Caps+Middle Click	Mute
)
MsgBox, 262144, Capsmod Help, %msg%
Return

F5::Reload

`::Run CMD

1::Run SndVol

2::Run osk

3::Run Magnify

4::Run charmap

Numpad1::Run "C:\Program Files (x86)\DisplayFusion\DisplayFusionCommand.exe" -monitorloadprofile "Extend",, Hide

Numpad2::Run "C:\Program Files (x86)\DisplayFusion\DisplayFusionCommand.exe" -monitorloadprofile "Duplicate",, Hide

Numpad3::Run "C:\Program Files (x86)\DisplayFusion\DisplayFusionCommand.exe" -monitorloadprofile "TV",, Hide

; Selected text / clipboard to upper case
q::
	toUpper()
Return

; Selected text / clipboard to lower case
a::
	toLower()
Return

; Selected text / clipboard to title case
w::
	toTitle()
Return

; Selected text / clipboard to sentence case
s::
	toSentence()
Return

; Selected text / clipboard invert case
e::
	toInvert()
Return

; Selected text / clipboard reverse
d::
	toReverse()
Return

(::
)::
	encase("(",")")
Return

[::
]::
	encase("[","]")
Return

{::
}::
	encase("{","}")
Return

'::
	encase("'","'")
Return

"::
	;"
	encase("""","""")
Return

<::
>::
	encase("<",">")
Return

/::
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	wordCount(Clipboard)
	;wc := wordCount(Clipboard)
	;Clipboard := ori
	;ToolTip %wc%, A_CaretX, A_CaretY
	;KeyWait CapsLock
	;KeyWait /
	;ToolTip
Return

; Active window show process name
y::
	WinGet, proc, ProcessName, A
	ToolTip, %proc%, 0, 0
	KeyWait CapsLock
	KeyWait y
	ToolTip
Return

; Active window kill task
z::
	WinGet, pro, ProcessName, A
	if (pro = "explorer.exe")
	{
		Return
	}
	WinGet, PID, PID, A
	Run cmd /c Taskkill /PID %PID% /F /T,, Hide
Return

; Selected text switch with clipboard
x::
	switchClip()
Return

; Selected text append to clipboard
c::
	ori := Clipboard
	Send ^c
	ClipWait, 1
	if (Clipboard != ori)
	{
		Clipboard = %ori% %Clipboard%
	}
Return

; Simulated typing of clipboard
v::SendInput % RegExReplace(Clipboard, "\r\n?|\n", " ")

; Simulated typing of clipboard preserving line breaks
+v::SendInput % RegExReplace(Clipboard, "\r\n?|\n", "`n")

; Active window show time
Tab::
	FormatTime, time
	ToolTip, %time%, 0, 0
	KeyWait CapsLock
	KeyWait Tab
	ToolTip
Return

; Adjust volume
WheelUp::Volume_Up
WheelDown::Volume_Down
MButton::
	RunWait cmd /c Taskkill /IM SndVol.exe /F /T,, Hide
	CoordMode, Mouse, Screen
	MouseGetPos, xpos, ypos
	pos := ypos * 65536 + xpos
	Run SndVol.exe -f %pos%
Return

; Turn off Screen
Space::
	KeyWait CapsLock
	KeyWait Space
	SendMessage, 0x112, 0xF170, 2,, Program Manager
Return

PrintScreen::Run SnippingTool

TogCapsLockState()
{
	if (GetKeyState("CapsLock", "T"))
	{
		SetCapsLockState, Off  
	}
	else
	{
		SetCapsLockState, On
	}
}

toUpper()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	StringUpper Clipboard, Clipboard
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

toLower()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	StringLower Clipboard, Clipboard
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

toTitle()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	StringUpper Clipboard, Clipboard, T
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

toSentence()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	chars := ""
	loop, parse, Clipboard
	{
		if (A_Index = 1)
		{
			StringUpper char, A_LoopField
		}
		else
		{
			char := A_LoopField
		}
		chars = %chars%%char%
	}
	Clipboard := chars
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

toInvert()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	chars := ""
	loop, parse, Clipboard
	{
		if A_LoopField is upper
		{
			StringLower char, A_LoopField
		}
		else
		{
			StringUpper char, A_LoopField
		}
		chars = %chars%%char%
	}
	Clipboard := chars
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

toReverse()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	StringSplit, clipa, Clipboard
	chars := ""
	loop, %clipa0%
	{
		num := clipa0-A_Index+1
		char := clipa%num%
		chars = %chars%%char%
	}
	Clipboard := chars
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

switchClip()
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	new = %Clipboard%
	Clipboard := ori
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := new
	KeyWait %A_ThisHotkey%
}

encase(o,c)
{
	ori := ClipboardAll
	Send ^c
	ClipWait, 1
	Clipboard = %o%%Clipboard%%c%
	StringLen len, Clipboard
	Send ^v
	SendInput +{LEFT %len%}
	Clipboard := ori
	KeyWait %A_ThisHotkey%
}

wordCount(w)
{
	MsgBox % w
	w := RegExMatch(w, "O)\b[a-z-']+\b", Match)
	c := Match.Value
	MsgBox %c%
	;Return count
}
