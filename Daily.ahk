#MaxHotkeysPerInterval 200
SetTitleMatchMode, 2
SetCapsLockState, AlwaysOff 
df := "C:\Program Files (x86)\DisplayFusion\DisplayFusionCommand.exe" 
nc := "A:\Software\nirsoft_package\NirSoft\nircmd.exe"

CapsLock & Enter::
	If GetKeyState("CapsLock", "T") {
		SetCapsLockState, AlwaysOff 
	} Else {
		SetCapsLockState, AlwaysOn
	}
Return

CapsLock & q::Media_Prev

CapsLock & w::
	pro := "A:\Software\foobar2000\foobar2000.exe"
	If WinExist("ahk_exe " . pro) {
		If WinActive() {
			WinMinimize
		} else {
			WinActivate
		}
	} else {
		Run, %pro%
	}
Return

CapsLock & e::Media_Play_Pause

CapsLock & r::Media_Next

; Active window show time
CapsLock & t::
	FormatTime, time
	ToolTip, %time%, 0, 0
	KeyWait, CapsLock
	ToolTip
Return

CapsLock & y::SendInput, !{Escape}

CapsLock & u::
	SendInput, {Blind}{LAlt Down}{Tab}
Return

CapsLock & u Up::
	KeyWait, CapsLock
	SendInput, {LAlt Up}
Return

CapsLock & i::
	pro := "cmd.exe"
	If WinExist("ahk_exe " . pro) {
		If WinActive() {
			WinClose
		} else {
			WinActivate
		}
	} else {
		Run, %pro%
	}
Return

CapsLock & o::
	pro := "A:\Software\SpeedCrunch\speedcrunch.exe"
	If WinExist("ahk_exe " . pro) {
		If WinActive() {
			WinClose
		} else {
			WinActivate
		}
	} else {
		Run, %pro%
	}
Return

CapsLock & p::SendInput, {Blind}{PrintScreen}

; Adjust volume
CapsLock & a::Return

CapsLock & WheelUp::
	If !GetKeyState("a", "P") {
		SendInput, {Volume_Up}
	} Else {
		MouseGetPos,,,pos
		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% changeappvolume /%PID% 0.02
	}
Return

CapsLock & WheelDown::
	If !GetKeyState("a", "P") {
		SendInput, {Volume_Down}
	} Else {
		MouseGetPos,,,pos
		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% changeappvolume /%PID% -0.02
	}
Return

CapsLock & MButton::
	If !GetKeyState("a", "P") {
		SendInput, {Volume_Mute}
	} Else {
		MouseGetPos,,,pos
		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% muteappvolume /%PID% 2
	}
Return

CapsLock & s::
	pro := "sndvol.exe"
	Run, %pro%,, Max
	KeyWait, s
	WinClose, ahk_exe sndvol.exe
Return

CapsLock & d::
	pro := "sndvol.exe"
	;pos := % A_ScreenHeight * 65536
	Run, %pro% -m %pos%
	WinWait, ahk_exe sndvol.exe
	WinMove, ahk_exe sndvol.exe,,,, %A_ScreenWidth%
	KeyWait, d
	WinClose, ahk_exe sndvol.exe
Return

CapsLock & f::
	pro := "explorer.exe"
	If WinExist("ahk_exe " . pro . " ahk_class CabinetWClass") {
		If WinActive() {
			SendInput, ^{tab}
		} else {
			WinActivate
		}
	} else {
		Run, %pro%
	}
Return

CapsLock & g::
	WinActivate, ahk_class #32770
	If WinActive("ahk_class #32770") {
		ControlGetText, loc, ToolbarWindow323, ahk_exe explorer.exe ahk_class CabinetWClass
		loc := StrReplace(loc, "Address: ")
		ControlFocus, Edit1
		SendInput,!d^a{Text}%loc%
		SendInput, {Enter}
	}
	KeyWait, g
Return

; Vim commands
CapsLock & h::Left
CapsLock & j::Down
CapsLock & k::Up
CapsLock & l::Right

CapsLock & `;::
	pro := "gvim.exe"
	If WinExist("ahk_exe " . pro) {
		If WinActive() {
			WinActivateBottom, ahk_exe %pro%
		} else {
			WinActivate
		}
	} else {
		Run, %pro%
	}
Return

; Active window kill task
CapsLock & z::
	WinGet, pro, ProcessName, A
	if (pro != "explorer.exe") {
		WinGet, PID, PID, A
		Run, Taskkill /PID %PID% /F /T,, Hide
	}
Return

CapsLock & x::
	WinGet, ID, ID, A
	WinMinimize, ahk_id %ID%
	KeyWait, x
	WinRestore, ahk_id %ID%
	WinActivate, ahk_id %ID%
Return

CapsLock & c::
	If WinExist(" - YouTube - Google Chrome") {
		ControlFocus
		ControlSend,, k
	} Else If WinExist("ahk_exe mpv.exe") {
		ControlFocus
		ControlSend,, {Space}
	} else {
		;ControlFocus,, - Google Chrome
		;ControlSend,, {Space}, - Google Chrome
		SendInput, {Media_Play_Pause}
	}
Return

CapsLock & v::
	Winget, con, ControlList, A
	MsgBox, %con%
Return

CapsLock & b::
	WinGet, exe, ProcessPath, A
	Run, explorer.exe /select`,"%exe%"
Return


CapsLock & n::Return

CapsLock & m::
	WinGet, exe, ProcessPath, A
	WinGetClass, cla, A
	WinActivateBottom, ahk_exe %exe% ahk_class %cla%
Return

CapsLock & ,::
	pro := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	If WinExist("ahk_exe " . pro) {
		If WinActive() {
			SendInput, ^{tab}
		} else {
			WinActivate
		}
	} else {
		Run, %pro%
	}
Return

CapsLock & .::Return

CapsLock & /::^+!#F1

CapsLock & NumpadSub::
	WinGet, id, List,,, Program Manager
	Loop, %id% {
		this_id := id%A_Index%
		WinActivate, ahk_id %this_id%
		WinGetClass, this_class, ahk_id %this_id%
		WinGetTitle, this_title, ahk_id %this_id%
		MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
		IfMsgBox, NO, break
	}
Return

; Media keys
CapsLock & Up::Launch_Media
CapsLock & Down::Media_Play_Pause
CapsLock & Left::Media_Prev
CapsLock & Right::Media_Next

; Turn off Screen
CapsLock & Space::
	KeyWait, Space
	KeyWait, CapsLock
	SendMessage, 0x112, 0xF170, 2,, Program Manager
Return

; Function Keys
CapsLock & F1::F13
CapsLock & F2::F14
CapsLock & F3::F15
CapsLock & F4::F16
CapsLock & F5::F17
CapsLock & F6::F18
CapsLock & F7::F19
CapsLock & F8::F20
CapsLock & F9::F21
CapsLock & F10::F22
CapsLock & F11::F23
CapsLock & F12::F24

CapsLock & Esc::Suspend

#If WinActive("ahk_class Vim")
       CapsLock::Escape
#If

#If WinActive("Minecraft ahk_exe javaw.exe")
	Numpad1::
		SendInput, {x Down}{1 Down}
		KeyWait, Numpad1
		SendInput, {1 Up}{x Up}
	Return
	Numpad2::
		SendInput, {x Down}{2 Down}
		KeyWait, Numpad2
		SendInput, {2 Up}{x Up}
	Return
	Numpad3::
		SendInput, {x Down}{3 Down}
		KeyWait, Numpad3
		SendInput, {3 Up}{x Up}
	Return
	Numpad4::
		SendInput, {x Down}{4 Down}
		KeyWait, Numpad4
		SendInput, {4 Up}{x Up}
	Return
	Numpad5::
		SendInput, {x Down}{5 Down}
		KeyWait, Numpad5
		SendInput, {5 Up}{x Up}
	Return
	Numpad6::
		SendInput, {x Down}{6 Down}
		KeyWait, Numpad6
		SendInput, {6 Up}{x Up}
	Return
	Numpad7::
		SendInput, {x Down}{7 Down}
		KeyWait, Numpad7
		SendInput, {7 Up}{x Up}
	Return
	Numpad8::
		SendInput, {x Down}{8 Down}
		KeyWait, Numpad8
		SendInput, {8 Up}{x Up}
	Return
	Numpad9::
		SendInput, {x Down}{9 Down}
		KeyWait, Numpad9
		SendInput, {9 Up}{x Up}
	Return
	Numpad0::
		SendInput, {F3 Down}{n Down}
		KeyWait, Numpad0
		SendInput, {F3 Up}{n Up}
	Return
	NumpadAdd::
		SendInput, {F3 Down}{b Down}
		KeyWait, NumpadAdd
		SendInput, {F3 Up}{b Up}
	Return
	NumpadEnter::
		SendInput, {F3 Down}{g Down}
		KeyWait, NumpadEnter
		SendInput, {F3 Up}{g Up}
	Return
#If
