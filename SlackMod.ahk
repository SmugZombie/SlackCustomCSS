#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

slack_base := "c:\Users\" . A_UserName . "\AppData\Local\slack\"
mod_1 = resources\app.asar.unpacked\src\static\index.js
mod_2 = resources\app.asar.unpacked\src\static\ssb-interop.js
;MsgBox, % slack_base

if !FileExist(jspatch.js){
	MsgBox, Unable to locate jspatch.js in script dir. Rename one of the provided files to jspatch.js to use. `n Exiting!
	ExitApp
}
Else
{
	FileRead, JSSrc, jspatch.js
}

FileSelectFolder, SelectedFolder , %slack_base%, , Select Latest Slack Version
SelectedFolder := SelectedFolder . "\"

if (SelectedFolder = ){
    MsgBox, The user didn't select anything. Exiting!
    ExitApp
}

if !FileExist(SelectedFolder . mod_1 . ".bak")
	if FileExist(SelectedFolder . mod_1){
		FileCopy, %SelectedFolder%%mod_1%, %SelectedFolder%%mod_1%.bak
		FileAppend, %JSSrc%, %SelectedFolder%%mod_1%
	}	
	else
		MsgBox, Unable to locate %mod_1%
Else
	MsgBox, Fix appears to be in place already. If slack updated rename `n%SelectedFolder%%mod_1%.bak to: `n%SelectedFolder%%mod_1% 

if !FileExist(SelectedFolder . mod_2 . ".bak")
	if FileExist(SelectedFolder . mod_2){
		FileCopy, %SelectedFolder%%mod_2%, %SelectedFolder%%mod_2%.bak
		FileAppend, %JSSrc%, %SelectedFolder%%mod_2%
	}
	else
		MsgBox, Unable to locate %mod_2%
Else
	MsgBox, Fix appears to be in place already. If slack updated rename `n%SelectedFolder%%mod_2%.bak to: `n%SelectedFolder%%mod_2%

return

