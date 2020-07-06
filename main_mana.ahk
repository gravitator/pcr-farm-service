#Include pcr.ahk

UnionName := "GaryFarm"
CowAccountFile := "account_mana.txt"

; get account info
FileName := "account_manager.txt"
File := FileOpen(FileName, "r-d") ;
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}
account_pwd := GetAccount(File)
FarmManagerAccount := account_pwd[1]
FarmManagerPwd := account_pwd[2]
File.Close()

; open file: COwAccountFile
File := FileOpen(CowAccountFile, "r-d") ;
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}

; open LeiDian simulator
OpenSim()

Loop, 20
{
	account_pwd := GetAccount(File)
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
	
	JoinUnion(UnionName)
	GetGift()
	DonateMana()
	OutputDebug, %account% (%name%) has donated its milk
}

; login --> Farm Manager
SwitchAccount(FarmManagerAccount, FarmManagerPwd)
RemoveToolman()

Loop, 20
{
	account_pwd := GetAccount(File)
	if (account_psd = 0)
	{
		File.Close()
		break
	}
	account := account_pwd[1]
	pwd := account_pwd[2]
	name := account_pwd[3]
	
	SwitchAccount(account,pwd)
	
	JoinUnion(UnionName)
	GetGift()
	DonateMana()
	OutputDebug, %account% (%name%) has donated its milk
}

; login --> Farm Manager
SwitchAccount(FarmManagerAccount, FarmManagerPwd)
RemoveToolman()

OutputDebug, All cows' milk have donated!

ExitApp



; functions
JoinUnion(UnionName)
{
	GoHome()

	; click union
	Click, %Bottom_home_union_x%, %Bottom_home_union_y%

	; check loading --> union search
	Loop
	{
		Sleep, 500
		; Search
		PixelSearch, Px, Py, 680, 103, 680, 103, 0xFFFFFF, 10, Fast RGB
		if (ErrorLevel = 0)
			P_search := 0
		else
			P_search := 1
		; member numbers
		PixelSearch, Px, Py, 675, 149, 675, 149, 0x5A96EF, 10, Fast RGB
		if (ErrorLevel = 0)
			P_m := 0
		else
			P_m := 1
		; F5
		PixelSearch, Px, Py, 1230, 152, 1230, 152, 0x6B9EFF, 5, Fast RGB
		if (ErrorLevel = 0)
			P_F5 := 0
		else
			P_F5 := 1
		check_error := P_search + P_m + P_F5
		if (check_error = 0)
			break
	}
	
	; click setting
	Click, 1150, 162
	
	Sleep, 500
	
	; click union name
	Click, 627, 288
	
	Sleep, 1000
	
	; send union name
	Send, %UnionName%
	Sleep, 500
	Send, {Enter}
	
	Sleep, 1000
	
	; click search
	Click, 792, 632
	
	Loop
	{
		Sleep, 100
		
		; text find --> GaryFarm
		Text_GaryFarm:="|<>*150$67.0000000000000000000000000000000000Dw0000003zwC70000001k0C1k000000k0C0M000000M060A1s4804A03003z3SA7603U03VVy63301k01Uss3XVzwsDk0QM0lUzyQ0Q0SA0MkM0C0C7r60CsA030773X03M601k7b1lU1w300Q3nUsk0w1U0D3tkwM0C0k03zQTqA070M00S47V60304000000003U0000000003U0000000003k001"
		 if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_GaryFarm))
		 {
		   CoordMode, Mouse
		   X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
		   break
		 }
		 
		 ; figure find --> kokoro hair
		 figure_kokoro:="|<>*160$58.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy01zzzzzzzU01zzzzzzs003zzzzzz0007zzzzzw000DzzzzzU000Tzzzzw0001zzzzzlzs07zzzzyTzs0Dz0Dzzzzs0zU0Dzzzzk1w00TzzzzU7U00zzzzz0Q001zzzzy1k003zzzzs607z7zzzzk03zzTzzzz00Tzzzzzzy07zzzzzzzs0zzzzzzzzU7zzzs"
		if (ok := FindText(0, 0, 1280, 720, 0, 0, figure_kokoro))
		{
			CoordMode, Mouse
			X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
			Loop, 4
			{
				Sleep, 500
				Click, %Bottom_lb_x%, %Bottom_lb_y%
			}
		}
	}
	
	Sleep, 500
	
	; click union
	Click, 1190, 266
	
	; check load --> join condition
	Loop
	{
		Sleep, 100
		
		; text find --> GaryFarm
		Text_HuoDongFangZhen:="|<>*200$71.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzznzzbztzbw1zzbzzDznz607k7DzyTz7z7lzzyTk00C1zzXzzk3U00Qzzz7zzl3wTznzb00TznbwzzUDXwTk3bDtzzlTbszszCTk0zXzzlzlyQz7szbzw0TbstyDls3zk0TBlnwTXk7xbwwvbbtz7sznDttnDDnyDtzaTnb6STDwTnyQzb01wwTszZwtzCD3tlzly3lk0TzA37k3wDzzzzyzSzxzxzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
		 if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_HuoDongFangZhen))
		 {
		   CoordMode, Mouse
		   X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
		   break
		 }
	}
	
	; click join
	Click, 1117, 638
	
	Sleep, 1000
	
	; click confirm
	Click, 786, 546
	
	; check load --> ok
	Loop
	{
		Sleep, 100
		
		; text find --> OK
		Text_ok:="|<>*200$45.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw3zlznzy77yDwTzXwDlz3zszkyDkzz7z7lwDzlzsSD3zyDzXlkzzlzwSADzwDzXlXzzXzwC0TzwTzVkFzzXzwS77zwDzXlszzlzwSDXzyDzXlyDzlzwSDlzz7z7lz7zszkyDsTzXyDlzXzy73yDyDzw1zlzvw"

		 if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_ok))
		   break
	}
	
}


DonateMana()
{
	global Bottom_home_advanture_x
	global Bottom_home_advanture_y
	
	GoHome()
	
	; click advanture
	Click, %Bottom_home_advanture_x%, %Bottom_home_advanture_y%
	
	; text find --> mainstory
	Text_mainstory:="|<>*160$66.00000000000000000000000000000000000C0006060000D00070CC000D000D0D70007000D0D70003U00C0D30001U00Q0D003zzzz0QEDTk3zzzz0svzzk007U00lzzU0007U01lsD00007U03zk700007U03zk700007U017U7Xs007U0070Dzs007U00D7zy0007U00C7zU01zzzy0Q07Vk0zzzy0s07Xk007U01zs3bk007U03zU3zU007U01y03z0007U00U03y8007U00003sA007U0008DsQ007U007szwM007U03znwys7zzzzXz7UTsDzzzzns00Dk7zzzzU0007k0000000003U0000000000000000000000U"
	Loop
	{
		Sleep, 100
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_mainstory))
			break
	}
	
	Sleep, 2000
	
	; click luna tower
	Click, 1161, 248
	
	; check loading 1
	Loop
	{
		PixelGetColor, p1_color, 273, 558, RGB
		if (p1_color = 0x63AAE7)
			break
		
		Click, 10, 500
		Sleep, 1000
	}
	
	; check loading 2
	Loop
	{
		PixelGetColor, p1_color, 273, 558, RGB
		if (p1_color = 0x63AAE7)
			break
		
		Click, 10, 500
		
		Sleep, 1000
	}
	
	; click normal tower
	Click, 273, 558
	
	Sleep, 2000
	
	; click OK
	Click, 788, 542
	
	; check loading --> Help
	Loop
	{
		Sleep, 500
		PixelSearch, Px, Py, 1051, 101, 1051, 101, 0x4A8EF7, 10, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	Sleep, 1000
	
	; click 1st floor
	Click, 942, 495
	
	; check loading --> KeYongZhanDouJueSe
	Loop
	{
		PixelSearch, Px, Py, 925, 572, 925, 572, 0x639AF7, 10, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	Sleep, 1000
	
	; click dare
	Click, 1123, 658
	
	; check loading
	Loop
	{
		Sleep, 500
		PixelSearch, Px, Py, 915, 171, 915, 171, 0x6BA2FF, 10, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	Sleep, 1000
	
	; click support
	Click, 642, 172
	
	Sleep, 1000
	
	; click 1st character
	Click, 146, 290
	Sleep, 1000
	
	; click 2nd character
	Click, 284, 290
	Sleep, 1000
	
	; click start
	Click, 1117, 653
	
	; support check
	Loop
	{
		Sleep, 500
		PixelSearch, Px, Py, 476, 345, 476, 345, 0x5A96EF, 10, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	Sleep, 1000
	
	; click OK
	Click, 789, 696
	
	; check loading --> ">>" bottom
	Loop
	{
		Sleep, 500
		PixelSearch, Px, Py, 1213, 717, 1213, 717, 0x293042, 15, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	Sleep, 1000
	
	; click menu
	Click, 1205, 87
	Sleep, 1000
	
	; click give up
	Click, 848, 553
	Sleep, 1000
	
	; click give up
	Click, 848, 553
	
	; check loading --> YunHaiDeShanMai
	Loop
	{
		Sleep, 500
		PixelSearch, Px, Py, 35, 87, 35, 87, 0x6BA2FF, 10, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	Sleep, 1000
	
	; click retreat
	Click, 1074, 624
	Sleep, 1000
	
	; click ok
	Click, 790, 550
	Sleep, 3000
	
	GoHome()
	
}


RemoveToolman()
{
	global Bottom_home_union_x
	global Bottom_home_union_y
	
	GoHome()
	
	; click union
	Click, %Bottom_home_union_x%, %Bottom_home_union_y%
	
	; check loading --> return (union)
	Loop
	{
		; find --> return bottom
		Sleep, 100
		PixelSearch, Px, Py, 34, 85, 34, 85, 0x6BA2FF, 10, Fast RGB
		if (ErrorLevel = 0)
			break
		
		; find text --> OK (You are good)
		Text:="|<>*155$39.00000000000000Tk1k1UDjUC0S3US1k7Us1sC1s7071kS1k0wC7UC03Vls3k0QCS0S03lrU3k0SDw0S03lzk3k0SDb0S03lks3k0QC3UC03VkS1k0wC1s7071k70w1sC0w3kS1k3kDzUC0C0zs1k1U0000000000004"
		if (ok:=FindText(638-150000, 546-150000, 638+150000, 546+150000, 0, 0, Text))
		{
			CoordMode, Mouse
			X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
			Click, %X%, %Y%
		}

	}
	
	Sleep, 1000
	
	; click member
	Click, 317, 524
	
	; check loading --> union master
	Loop
	{
		Sleep, 100
		PixelSearch, Px, Py, 113, 559, 113, 559, 0x5A96EF, 10, Fast RGB
		if (ErrorLevel = 0)
			break
	}
	
	Sleep, 1000
	
	; click options
	Click, 940, 174
	
	Sleep, 1000
	
	; click all chracters' power
	Click, 385, 460
	
	Sleep, 1000
	
	; click ok
	Click, 789, 548
	
	Sleep, 1000
	
	; check Z-A
	Loop
	{
		Sleep, 100
		PixelSearch, Px, Py, 1201, 169, 1201, 169, 0xFFFFFF, 10, Fast RGB
		if (ErrorLevel = 0)
			break
		; click Z-A
		Click, 1201, 169
	}
	
	Loop, 20
	{
		; click member management
		Click, 985, 320
		
		Sleep, 1000
		
		; click remove member
		Click, 867, 284
		
		Sleep, 1000
		
		; click ok
		Click, 787, 547
		
		; check finish
		Loop
		{
			Sleep, 500
			; O
			PixelSearch, Px, Py, 621, 546, 621, 546, 0x424152, 10, Fast RGB
			if (ErrorLevel = 0)
				P_O := 0
			else
				P_O := 1
			; K
			PixelSearch, Px, Py, 649, 542, 649, 542, 0x424152, 10, Fast RGB
			if (ErrorLevel = 0)
				P_K := 0
			else
				P_K := 1
			; kai
			PixelSearch, Px, Py, 594, 243, 594, 243, 0xFFFFFF, 5, Fast RGB
			if (ErrorLevel = 0)
				P_kai := 0
			else
				P_kai := 1
			; edge
			PixelSearch, Px, Py, 717, 228, 717, 228, 0xD6AE68, 5, Fast RGB
			if (ErrorLevel = 0)
				P_edge := 0
			else
				P_edge := 1
			check_error := P_O + P_K + P_kai + P_edge
			if (check_error = 0)
				break
		}
		
		; click ok
		Click, 640, 550
		
		Sleep, 1000
	
	}
	
	GoHome()
}

