#Include pcr.ahk
FileName := "account_equipment.txt"
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
		Login(account,pwd)
	else
		SwitchAccount(account,pwd)
	
	GetGift()
	DonateEquipment()
	
	OutputDebug, %account% (%name%) has donated the equipments.
}

ExitApp


; function

DonateEquipment()
{
	global Bottom_home_union_x
	global Bottom_home_union_y
	
	GoHome()
		
	; click union
	Click, %Bottom_home_union_x%, %Bottom_home_union_y%
	
	; text find --> support setting
	Text_ZhiYuanSheDing:="|<>*170$89.0000000000000000000000000000000A00U0A60000A000Q03UzwC7z00Q000s077zkQDy1zzw7zzwCAkUMMA7zzwDzzsyMn0EkMC00s0703wNi03UkM01k0C01lzy071kE0100Q03XzwyQ3kzzy1zzs73k0QU23zzy3zzkDTzkszy01s0303USzzVnzy03U030C3wQ03X0s770030w7kzw733kCDy073k3XzsC770QTy07j077XkQ7Q0sw007w0CNz0z7k3lk00Ds0Qlw1wDU7nU00zy0v3s3kzkBzU07lzXkTy77XslzzVw0TD3kw0Q3lUzz30000A080U00000000000000000000U"
	Text_OK:="|<>*157$39.00000003y0C0A1xw1k3kQ3kC0w70D1kD0s0sC3kC07Vkw1k0QCD0S03Vnk3k0SCw0S03lzU3k0SDy0S03lws3k0SC70S03VkQ1k0QC3kC07VkD0s0sC0s7UD1k7US3kC0S1zw1k1k7z0C0A0000004"

	Loop
	{
		Sleep, 100
		
		; support setting founfd --> click ok
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_OK))
		{
			Sleep, 100
			click, 637, 541
		}
		
		; support setting founfd --> break
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_ZhiYuanSheDing))
			break
	}
	
	Sleep, 3000
	
	; click equipment mark
	Click, 481, 108
	
	Sleep, 1000
	
	; click "donate"
	Click, 1069, 529
	Sleep, 1000
	
	; click max
	Click, 860, 570
	Sleep, 1000
	
	; click ok
	Click, 793, 693
	
	; check loading --> donate complete
	Loop
	{
		Sleep, 500
		PixelSearch, Px, Py, 579, 564, 579, 564, 0xF7F7F7, 3, Fast RGB
		if (ErrorLevel = 0)
		{
			GoHome()
			break
		}
	}
	
	
}