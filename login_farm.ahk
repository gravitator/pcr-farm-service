#Include pcr.ahk

; get account info
FileName := "account_manager.txt"
File := FileOpen(FileName, "r-d") ;
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}
account_pwd := GetAccount(File)
account := account_pwd[1]
pwd := account_pwd[2]
File.Close()

OpenSim()
Login(account, pwd)
GoHome()

OutputDebug, au670402 login OK

ExitApp