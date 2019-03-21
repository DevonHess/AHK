#MaxHotkeysPerInterval 300
df := "C:\Program Files (x86)\DisplayFusion\DisplayFusionCommand.exe" 
nc := "A:\Software\nirsoft_package\NirSoft\nircmd.exe"

*CapsLock::Return

; Check that Caps Lock is being held down
#If GetKeyState("CapsLock","P")
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

	p::
		pro := "sndvol.exe"
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

	'::
		SetTitleMatchMode, 2
		WinGet, id, List,,, Program Manager
		Loop, %id%
		{
			this_id := id%A_Index%
			WinActivate, ahk_id %this_id%
			WinGetClass, this_class, ahk_id %this_id%
			WinGetTitle, this_title, ahk_id %this_id%
			MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
			IfMsgBox, NO, break
		}
		SetTitleMatchMode, 1
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
	WheelUp::
		SendInput, {Volume_Up}
		QSV()
	Return
	WheelDown::
		SendInput, {Volume_Down}
		QSV()
	Return
	MButton::
		SendInput, {Volume_Mute}
		QSV()
	Return

	f & WheelUp::
		MouseGetPos,,,pos
  		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% changeappvolume /%PID% 0.05
		QSV()
	Return

	f & WheelDown::
		MouseGetPos,,,pos
  		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% changeappvolume /%PID% -0.05
		QSV()
	Return

	f & MButton::
		MouseGetPos,,,pos
  		WinGet, PID, PID, ahk_id %pos%
		Run, %nc% muteappvolume /%PID% 2
		QSV()
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
	Numpad1::Send {x Down}{1 Down}
	Numpad1 Up::Send {x Up}{1 Up}
	Numpad2::Send {x Down}{2 Down}
	Numpad2 Up::Send {x Up}{2 Up}
	Numpad3::Send {x Down}{3 Down}
	Numpad3 Up::Send {x Up}{3 Up}
	Numpad4::Send {x Down}{4 Down}
	Numpad4 Up::Send {x Up}{4 Up}
	Numpad5::Send {x Down}{5 Down}
	Numpad5 Up::Send {x Up}{5 Up}
	Numpad6::Send {x Down}{6 Down}
	Numpad6 Up::Send {x Up}{6 Up}
	Numpad7::Send {x Down}{7 Down}
	Numpad7 Up::Send {x Up}{7 Up}
	Numpad8::Send {x Down}{8 Down}
	Numpad8 Up::Send {x Up}{8 Up}
	Numpad9::Send {x Down}{9 Down}
	Numpad9 Up::Send {x Up}{9 Up}

	Numpad0::Send {F3 Down}{N Down}
	Numpad0 Up::Send {F3 Up}{N Up}
#If
