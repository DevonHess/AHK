#NoEnv
SendMode Input

pro :=  % A_Args[1]
If WinExist("ahk_exe " . pro) {
	If WinActive() {
		WinActivateBottom, ahk_exe %pro%
	} else {
		WinActivate
	}
} else {
	Run, %pro%, % RegExReplace(pro, "(.+)//.+", "$1")
}
