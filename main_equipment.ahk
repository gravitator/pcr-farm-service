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



; function

DonateEquipment()
{
	global Bottom_home_union_x
	global Bottom_home_union_y
	
	GoHome()
		
	; click union
	Click, %Bottom_home_union_x%, %Bottom_home_union_y%
	
	; text find --> You are good & support setting 
	Text_ZhiYuanSheDing:="|<>*170$89.0000000000000000000000000000000A00U0A60000A000Q03UzwC7z00Q000s077zkQDy1zzw7zzwCAkUMMA7zzwDzzsyMn0EkMC00s0703wNi03UkM01k0C01lzy071kE0100Q03XzwyQ3kzzy1zzs73k0QU23zzy3zzkDTzkszy01s0303USzzVnzy03U030C3wQ03X0s770030w7kzw733kCDy073k3XzsC770QTy07j077XkQ7Q0sw007w0CNz0z7k3lk00Ds0Qlw1wDU7nU00zy0v3s3kzkBzU07lzXkTy77XslzzVw0TD3kw0Q3lUzz30000A080U00000000000000000000U"
	Text_OK:="|<>*157$39.00000003y0C0A1xw1k3kQ3kC0w70D1kD0s0sC3kC07Vkw1k0QCD0S03Vnk3k0SCw0S03lzU3k0SDy0S03lws3k0SC70S03VkQ1k0QC3kC07VkD0s0sC0s7UD1k7US3kC0S1zw1k1k7z0C0A0000004"

	Loop
	{
		Sleep, 100
		
		; text find: you are good (ok) --> click ok
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_OK))
		{
			Sleep, 100
			click, 637, 541
		}
		
		; text find: support setting --> break
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_ZhiYuanSheDing))
			break
	}
	
	Sleep, 5000
	
	; go to the bottom
	Loop, 2
	{
		Click, 1218, 559
		Sleep, 1000
		MouseMove, 855, 500
		Sleep, 500
		Send, {LButton Down}
		Sleep, 200
		MouseMove, 855, 300, 8
		Sleep, 200
		Send, {LButton Up}
	}
	
	; text: JuanZeng
	Text_donate:="|<>*180$22.zzzzzttw3rbkDASSk0N+AtYdGaGZ+N+QtYcnaGk0t/zzYjzyGs0x/7nwwTDXk0yH7Xv4zDCFstzU7zzzy"
	
	Loop, 10
	{
		; text: JuanZeng
		Text_donate:="|<>*180$22.zzzzzttw3rbkDASSk0N+AtYdGaGZ+N+QtYcnaGk0t/zzYjzyGs0x/7nwwTDXk0yH7Xv4zDCFstzU7zzzy"
		Loop
		{
			Sleep, 1000
			if (ok:=FindText(1088-150000, 537-150000, 1088+150000, 537+150000, 0, 0, Text_donate))
			{
				CoordMode, Mouse
				X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
				; click donate
				Click, %X%, %Y%
				Sleep, 1000
				; click max
				Click, 860, 570
				Sleep, 1000
				; click ok
				Click, 793, 693
				; check finish
				Loop
				{
					Text_ok:="|<>*157$41.00000000Tk1k1U3vs3U7UC1s70S0s1sC1s1k1kQ7U703ksS0C03Vls0w073bU1s0D7S03k0SDw07U0wTw0D01syQ0S03lks0w073Us0s0C71s1k0wC1s1k1kQ1k3k7Us3k3kS1k3k3zs3U3U3zU70600000000000000U"
					if (ok:=FindText(1088-150000, 537-150000, 1088+150000, 537+150000, 0, 0, Text_ok))
					{
						Sleep, 1000
						CoordMode, Mouse
						X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
						Click, %X%, %Y%
						break
					}
				}
			}
			else
				If (A_Index = 5)
					break
		}
		
		Sleep, 1000
		
		; move to previous messages
		MouseMove, 855, 200
		Sleep, 500
		Send, {LButton Down}
		Sleep, 500
		MouseMove, 855, 450, 10
		Send, {LButton Up}
		
		Sleep, 500
	}

}