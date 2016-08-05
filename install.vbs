Dim WinScriptHost, FSO, WinDir, AppDataDir, CurrentDir, CurrentDirParts, CurrentDirMounted, BashPath
Dim LauncherTargetDir, LauncherSourcePath, LauncherTargetPath, BashCommand, CreateUpdaterDirCommand, CopyUpdaterCommand

Set WinScriptHost = CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

CONST ProductName = "netflix_proxy_updater"
CONST UpdaterFileName = "update_ip.sh"
CONST LauncherFileName = "update_ip.vbs"
CONST BashRelativeDir = "\System32\bash.exe"
CONST WindowsPathSeparator = "\"
CONST LinuxPathSeparator = "/"

WinDir = WinScriptHost.ExpandEnvironmentStrings("%windir%")
AppDataDir = WinScriptHost.ExpandEnvironmentStrings("%AppData%")
CurrentDir = WinScriptHost.CurrentDirectory

CurrentDirParts = Split(CurrentDir, ":")
CurrentDirParts(0) = LCase(CurrentDirParts(0))
CurrentDirMounted = "/mnt/" & Replace(Join(CurrentDirParts, ""), WindowsPathSeparator, LinuxPathSeparator)
BashPath = FSO.BuildPath(WinDir, BashRelativeDir)
BashCommand = """" & BashPath & """ ~ -c "
CreateUpdaterDirCommand = BashCommand & """mkdir " & ProductName & """"
CopyUpdaterCommand = BashCommand & """cp " & CurrentDirMounted & LinuxPathSeparator & UpdaterFileName & " " & ProductName & LinuxPathSeparator & UpdaterFileName & """"
WinScriptHost.Run CreateUpdaterDirCommand, 0
WinScriptHost.Run CopyUpdaterCommand, 0

LauncherTargetDir = FSO.BuildPath(AppDataDir, ProductName)
LauncherTargetPath = FSO.BuildPath(LauncherTargetDir, LauncherFileName)
LauncherSourcePath = FSO.BuildPath(CurrentDir, LauncherFileName)
If Not FSO.FolderExists(LauncherTargetDir) Then
  FSO.CreateFolder LauncherTargetDir
End If
FSO.CopyFile LauncherSourcePath, LauncherTargetPath

WinScriptHost.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\NetflixProxyUpdate", """" & LauncherTargetPath & """", "REG_SZ"

Set WinScriptHost = Nothing