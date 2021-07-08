#NoTrayIcon
#SingleInstance Force
#Warn All, Off
Try
{
SetWorkingDir %A_ScriptDir%
if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
}
Catch, AdminFalse
{
	ExitApp
}
Verbose = 0
Gui -MaximizeBox -MinimizeBox
Gui, Add, Text, y5 x10, File Path:
Gui, Add, Edit,  x10 y28 w200 r1 vAppxFile
Gui, Add, Button, y24 w70 h30 gSelectAppx, Select
Gui Add, Button, y65 x10 w70 h30 gAppxInstall, Install
Gui, Add, Text, y73 x87 vStatus, No Appx File Selected
Gui, Add, CheckBox, y73 x205 gGetVerbose , Verbose Mode
Gui, Show, w300 h110, APPX Installer
return

GetVerbose:
If (Verbose = 0){
	Verbose = 1
}
else if (Verbose = 1)
{
 	Verbose = 0
}
return

SelectAppx:
FileSelectFile, SelectedAppxFile,,, Select .Appx File to Install, *.Appx
guicontrol,, AppxFile, %SelectedAppxFile%
guicontrol,, Status, Appx File Selected
return

AppxInstall:
     If (Verbose = 0)
	{
		guicontrol,, Status, Installing...
		Run, "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" Add-AppxPackage '%SelectedAppxFile%' -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown,, Hide
		Process, WaitClose, powershell.exe
		guicontrol,, Status, Installed!
		SoundPlay, *48
		sleep, 5000
		AppxFile =
		guicontrol,, AppxFile,
		guicontrol,, Status, No Appx File Selected
		SelectedAppxFile = 
		return
	}
	else if (Verbose = 1)
	{
		guicontrol,, Status, Installing...
		Run, cmd /k "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" Add-AppxPackage '%SelectedAppxFile%' -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown
		Process, WaitClose, cmd.exe
		guicontrol,, Status, Installed!
		SoundPlay, *48
		sleep, 5000
		AppxFile =
		guicontrol,, AppxFile,
		guicontrol,, Status, No Appx File Selected
		SelectedAppxFile = 
		return
	}
	return
	
GuiClose:
ExitApp
	
