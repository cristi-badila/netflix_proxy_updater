Dim WinScriptHost, FSO, WinDir, AppDataDir, BashPath, LauncherTargetDir, BashCommand, RemoveUpdaterDirCommand

Set WinScriptHost = CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

CONST ProductName = "netflix_proxy_updater"
CONST BashRelativeDir = "\System32\bash.exe"

WinDir = WinScriptHost.ExpandEnvironmentStrings("%windir%")
AppDataDir = WinScriptHost.ExpandEnvironmentStrings("%AppData%")

BashPath = FSO.BuildPath(WinDir, BashRelativeDir)
BashCommand = """" & BashPath & """ ~ -c "
RemoveUpdaterDirCommand = BashCommand & """rm -rf " & ProductName & """"
WinScriptHost.Run RemoveUpdaterDirCommand, 0

LauncherTargetDir = FSO.BuildPath(AppDataDir, ProductName)
FSO.DeleteFile(LauncherTargetDir & "\*")
FSO.DeleteFolder(LauncherTargetDir)

WinScriptHost.RegDelete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\NetflixProxyUpdate"

Set WinScriptHost = Nothing