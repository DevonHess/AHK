#MaxHotkeysPerInterval 300
df := "C:\Program Files (x86)\DisplayFusion\DisplayFusionCommand.exe" 
nc := "A:\Software\nirsoft_package\NirSoft\nircmd.exe"

*CapsLock::Return

; Check that Caps Lock is being held down
#If GetKeyState("CapsLock", "P")
	Shift::
		If GetKeyState("CapsLock", "T") {
			SetCapsLockState, Off
		} else {
			SetCapsLockState, On
		}
	Return


	; Vim commands
	h::Left
	j::Down
	k::Up
	l::Right
	w::^Right
	b::^Left
	i::Home
	a::End

	; App launching

	`;::
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

	m::
		WinGet, exe, ProcessPath, A
		WinGetClass, cla, A
		WinActivateBottom, ahk_exe %exe% ahk_class %cla%
	Return
	
	,::
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

	.::
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

	/::
		pro := "C:\Users\Devon\AppData\Local\Discord\app-0.0.305\Discord.exe"
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

	u::
		SendInput, {LAlt Down}{Tab}
	Return

	u Up::
		KeyWait, CapsLock
		SendInput, {LAlt Up}
	Return

	i::
		pro := "cmd.exe"
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
	
	o::
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

	p::^+!#F1

	d::
		pro := "sndvol.exe"
		If WinExist("ahk_exe " . pro) {
			If WinActive() {
				WinClose
			} else {
				WinActivate
			}
		} else {
			Run, %pro%,, Max
		}
	Return

	NumpadSub::
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
	Up::Launch_Media
	Down::Media_Play_Pause
	Left::Media_Prev
	Right::Media_Next

	; Displayfusion montior profiles
	;Numpad1::Run, %df% -monitorloadprofile "Extend",, Hide
	;Numpad2::Run, %df% -monitorloadprofile "Duplicate",, Hide
	;Numpad3::Run, %df% -monitorloadprofile "Console",, Hide
	;Numpad4::Run, %df% -monitorloadprofile "Extend 2",, Hide

	; Active window kill task
	z::
		WinGet, pro, ProcessPath, A
		if (pro != "explorer.exe") {
			WinGet, PID, PID, A
			Run, cmd /c Taskkill /PID %PID% /F /T,, Hide
		}
	Return

	; Active window show time
	t::
		FormatTime, time
		ToolTip, %time%, 0, 0
		KeyWait CapsLock
		KeyWait Tab
		ToolTip
	Return

	; Adjust volume
	WheelUp::Volume_Up
	WheelDown::Volume_Down
	MButton::Volume_Mute

	f & WheelUp::
		MouseGetPos,,,pos
  		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% changeappvolume /%PID% 0.05
	Return

	f & WheelDown::
		MouseGetPos,,,pos
  		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% changeappvolume /%PID% -0.05
	Return

	f & MButton::
		MouseGetPos,,,pos
  		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% muteappvolume /%PID% 2
	Return

	QSV() {
		If !WinExist("ahk_exe sndvol.exe") {
			Run, sndvol.exe,, Max
		}
		SetTimer, CSV, -750
	}

	CSV:
		WinClose, ahk_exe sndvol.exe
	Return

	; Turn off Screen
	Space::
		KeyWait CapsLock
		KeyWait Space
		SendMessage, 0x112, 0xF170, 2,, Program Manager
	Return

	; Function Keys
	F1::F13
	F2::F14
	F3::F15
	F4::F16
	F5::F17
	F6::F18
	F7::F19
	F8::F20
	F9::F21
	F10::F22
	F11::F23
	F12::F24

	Esc::Suspend

#If

#IfWinActive ahk_class Vim
	CapsLock::Escape
#If

#IfWinActive Minecraft ahk_exe javaw.exe
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
