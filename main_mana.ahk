#Include pcr.ahk

CowAccountFile := ".\config\account_mana.txt"
ManagerFile := ".\config\account_manager.txt"
UnionFile := ".\config\farm_name.txt"

; get farm name
File := FileOpen(UnionFile, "r-d") ;
if !IsObject(File)
{
	MsgBox Can't open "%UnionFile%" for reading.
	return
}
UnionName := File.ReadLine()
File.Close()

; get manager account info
File := FileOpen(ManagerFile, "r-d") ;
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}
account_pwd := GetAccount(File)
FarmManagerAccount := account_pwd[1]
FarmManagerPwd := account_pwd[2]
File.Close()

; open file: CowAccountFile
File := FileOpen(CowAccountFile, "r-d") ;
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}

; open LeiDian simulator
OpenSim()

; main Loop
Loop, 2
{

	Loop, 20
	{
		Sleep, 1000

		account_pwd := GetAccount(File)

		if (account_pwd = 0)
		{
			File.Close()
			break
		}

		account := account_pwd[1]
		pwd := account_pwd[2]
		name := account_pwd[3]
		
		if (A_Index = 1)
			Login(account,pwd)
		else
			SwitchAccount(account,pwd)
		
		JoinUnion(UnionName)
		Sleep, 1000
		GetGift()
		Sleep, 1000
		DonateMana(1)
		OutputDebug, %account% (%name%) has donated its milk
	}

	; login --> Farm Manager
	SwitchAccount(FarmManagerAccount, FarmManagerPwd)
	RemoveToolman()
}

ExitApp
