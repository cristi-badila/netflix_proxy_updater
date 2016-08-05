Dim WinScriptHost, FSO, WinDir, Command

CONST ProductName = "netflix_proxy_updater"
CONST UpdaterFileName = "update_ip.sh"
CONST BashRelativeDir = "\System32\bash.exe"
CONST LinuxPathSeparator = "/"

Set WinScriptHost = CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

WinDir = WinScriptHost.ExpandEnvironmentStrings("%windir%")

BashPath = FSO.BuildPath(WinDir, BashRelativeDir)
BashCommand = """" & BashPath & """ ~ -c "
UpdateCommand = BashCommand & """" & ProductName & LinuxPathSeparator & UpdaterFileName & """"
WinScriptHost.Run UpdateCommand, 0

Set WinScriptHost = Nothing