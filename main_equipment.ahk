#Include pcr.ahk
FileName := "./config/account_equipment.txt"
File := FileOpen(FileName, "r-d") ;
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}

OpenSim()

Loop
{
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
	{
		if (IsHome())
			SwitchAccount(account,pwd)
		else
			Login(account,pwd)
	}
	else
		SwitchAccount(account,pwd)
	
	Sleep, 1000
	GetGift()
	Sleep, 1000
	DonateEquipment()
	
	OutputDebug, %account% (%name%) has donated the equipments.

	Sleep, 1000
}

ExitApp
