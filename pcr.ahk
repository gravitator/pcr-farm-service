#Include FindText.ahk

global Bottom_lb_x = 10
global Bottom_lb_y = 760
global Bottom_home_home_x = 134
global Bottom_home_home_y = 733
global Bottom_home_character_x = 286
global Bottom_home_character_y = 733
global Bottom_home_advanture_x = 654
global Bottom_home_advanture_y = 733
global Bottom_home_guild_x = 830
global Bottom_home_guild_y = 733
global Bottom_gacha_home_x = 997
global Bottom_gacha_home_y = 733
global Bottom_home_menu_x = 1160
global Bottom_home_menu_y = 733
global Bottom_home_shop_x = 814
global Bottom_home_shop_y = 627
global Bottom_home_union_x = 922
global Bottom_home_union_y = 627
global Bottom_home_info_x = 1020
global Bottom_home_info_y = 627
global Bottom_home_quest_x = 1113
global Bottom_home_quest_y = 627
global Bottom_home_gift_x = 1222
global Bottom_home_gift_y = 627
global Bottom_home_energyplus_x = 430
global Bottom_home_energyplus_y = 95
global Bottom_ok_x = 790
global Bottom_ok_y = 545


GetAccount(File)
{
	if File.AtEOF
		return 0
	
	account_pwd := File.ReadLine()
	account_pwd := StrSplit(account_pwd, ",")
	
	return account_pwd
}


OpenSim()
{

	; open simulater
	If WinExist("ahk_class LDPlayerMainFrame")
	{
		WinActivate
	} else {
		Run C:\ChangZhi\dnplayer2\dnplayer.exe
		WinWaitActive ahk_class LDPlayerMainFrame
	}

	; move simulator windwos to [0,0,1280,720]
	WinGetTitle, SimTitle, A
	WinMove, %SimTitle%,,0,0
	
	; check Android System started
	Text_dots:="|<>*137$32.zzzzzwDwDwC1y1y1UTUTUM7s7s61y1y1kzkzkzzzzzy"
	Loop
	{
		if (ok := FindText(0, 0, 1400, 720, 0, 0, Text_dots))
		{
			Sleep, 800
			Click, 5, 765
			Sleep, 500
			break
		}
	}

	; click home
	Click, 1310, 676
	
	; check battery icon
	Text_battery := "|<>*151$12.003s7s7k7k7U7UDw1s1k3U302040000000U"

	Loop
	{
		Sleep, 300
		
		if (ok := FindText(0, 0, 1280, 720, 0, 0, Text_battery))
		{
			Sleep, 500
			return
		}

		if (A_Index=50)
		{
			MsgBox, Cannot find battery icon
			ExitApp
		}
	}

}


Login(account,pwd) 
{
	
	CloseAll()
	
	; click pcr app
	Click, 175, 210

	LoginNewAccount(account, pwd)

}


SwitchAccount(account,pwd)
{
	global Bottom_home_menu_x
	global Bottom_home_menu_y
	
	
	GoHome()

	Sleep, 1000

	; click main menu
	Click, %Bottom_home_menu_x%, %Bottom_home_menu_y%
	Sleep, 3000

	; click back to logo page
	Click, 200, 600
	Sleep, 1000

	; click OK
	Click, 700, 550
	Sleep, 1000
	
	LoginNewAccount(account, pwd)
}


LoginNewAccount(account, pwd)
{
	; click switch account
	Loop
	{
		Sleep, 200
		Click, 1219, 87

		; search pcr bilibili login bottom
		PixelGetColor, color, 560, 460, RGB
		if (color = 0x23ADE5)
			break
	}
	
	; slect all --> account
	MouseMove, 480, 310
	Sleep, 100
	Send, {LButton Down}
	Sleep, 1000
	Send, {LButton Up}
	Sleep, 100
	
	; delete --> account
	Send, {BS}
	Sleep, 100
	
	; send --> account
	Send, %account%
	Sleep, 100
	
	; slect all --> pwd
	MouseMove, 480, 390
	Sleep, 100
	Send, {LButton Down}
	Sleep, 1000
	Send, {LButton Up}
	Sleep, 100
	
	; delete --> pwd
	Send, {BS}
	Sleep, 100
	
	; send --> pwd
	Send, %pwd%
	Sleep, 100
	
	; click login
	Click, 650, 450
	Sleep, 100
	
	; wait login 1
	Loop 
	{
		Sleep 1000
		Click, %Bottom_lb_x%, %Bottom_lb_y%
		Sleep 100
		
		; ------- ID certification
		IDcertification()
		
		; ------- LanDeSuoErBei --------
		LanDeSuoErBei()
		
		if (IsHome())
		{
			break
		}
		
	}
	
	; wait login 2
	Loop 
	{
		Sleep 1000
		Click, %Bottom_lb_x%, %Bottom_lb_y%
		Sleep 100
		
		if (IsHome())
		{
			break
		}
		
	}
}


IDcertification()
{
	IDFile := "./config/CNID.txt"
; Findtext: ShiMIngRenZheng
Text_certification:="|<>*190$54.00000000000000000010300000030300sDzw3U300QTzw1k300ADzw0k300A0A00U30000A00030000A00030000A0TU303sAA0TU303sAA01U300MAA01U3U0MADs1U7U0MADs1U7U0MADs1U7k0MAA01U6k0MAA01UCM0MAA01UAM0MAA01YQA0NAA01gsC0TAA01tk70SAA01vk7USzzw0bU3kBzzy0701U0zzw000000000000000000U"

	if (ok:=FindText(736-150000, 202-150000, 736+150000, 202+150000, 0, 0, Text_certification))
	{
		clipboard =  ; 让剪贴板初始为空
		Run, .\config\CNID.txt
		WinWaitActive ahk_class PX_WINDOW_CLASS
		Click, 162, 85
		Sleep, 100
		Click, 162, 85
		Sleep, 500
		Send, ^c
		Sleep, 500
		Send, !{F4}
		
		Sleep, 1000
		Click, 472, 388
		Send, ^v
		Sleep, 1000
		Click, 472, 488
		Send, 330102199712151815
		Sleep, 1000
		Click, 600, 560
	}
}


LanDeSuoErBei()
{
	; find text --> select character 
	Text_QingXuanZe:="|<>0x424552@0.73$71.000000000000000000000000000E002020000M1U33A0ATy00lzz76M0Mzy00k606As0kkQ00UC06Tz7slk007zk1X0Dkr0000k026060w00wzzb0A0A3w00M00DDzsMQT00k006DyUl2601XzsAAM3sC00360kMMkD7zk06A1UklaS0s00ATz1VXAA1k00Mk6366MM3U00rzw6MDknzy01v0sT001UC003a0lXU030Q006ADX3zyS0s000E0400000U000000000000000000000000000000000001"

	 if (ok:=FindText(538-150000, 195-150000, 538+150000, 195+150000, 0, 0, Text_QingXuanZe))
	 {
		; click 1st character
		Click, 1038, 459
		Sleep, 1000
		
		; click start
		Click, 1123, 707
		
		Sleep, 5000
		
		; click skip
		Click, 1220, 93
		
	 }
}


IsHome() 
{
	Text_zoom:="|<>0x6B9EFF@0.88$18.00000800Q00w61y73w7bs7zkDzUDz0Dy0Dz0DzUTzkTzkTz0Tk0M00000U"
	if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_zoom))
		return 1
	else
		return 0
}

GoHome()
{
	global Bottom_home_home_x
	global Bottom_home_home_y
	if (IsHome())
		return
	
	Loop 
	{
		Sleep, 1000
		if (IsHome())
			return
		Send, {Esc}
	}
		
}


AddEnergy(times)
{
	global Bottom_home_guild_x
	global Bottom_home_guild_y

	Loop, %times%
	{
		
		GoHome()
		
		; click energy plus
		Click, %Bottom_home_energyplus_x%, %Bottom_home_energyplus_y%
		Sleep, 1000
		
		; click OK
		Click, 790, 545
		Sleep, 1000
		
		; Text Find --> OK
		Text_OK:="|<>*155$39.00000000000000Tk1k1UDjUC0S3US1k7Us1sC1s7071kS1k0wC7UC03Vls3k0QCS0S03lrU3k0SDw0S03lzk3k0SDb0S03lks3k0QC3UC03VkS1k0wC1s7071k70w1sC0w3kS1k3kDzUC0C0zs1k1U0000000000004"
		Loop
		{
			if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_OK))
			{
				CoordMode, Mouse
				X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
				
				Sleep, 1000
				; click OK
				Click, %X%, %Y%
				break
			}
		}
	}
	
	GoHome()
	
	; click home of guild
	Click, %Bottom_home_guild_x%, %Bottom_home_guild_y%
	
	Sleep, 2000
	
	; find text --> 1st floor
	Text_1F:="|<>*160$29.zzzzzzzzzzzzzzzzs03znU03z7DzbsCTzDwQ00TstzzzlnzzzXY07z7DzzyCTzzwQU0TstkzzlXbDzXCTDziM0Dzxk7Dzzzzzzzzzzzzzzs"
	Loop
	{
		; skip story
		if (A_Index>20)
		{
			Click, 1220, 105
			Sleep, 1000
			Click, 1080, 105
		}
		
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_1F))
			break
	}
	
	; click get all
	Click, 1200, 619
	
	; find text --> close
	Text_GuanBi:="|<>*167$55.0000000000000060000D0D07U0007U7U1lzzU1s7U0Qzzs0Q3U0600w063U0k0MC3zzzkw0Q71zzzsS0C3U07U0D07Vk03k07jzws01s03nzyQ00w01s3sC00S00w3w73zzzwS3y3VzzzyD1r1k07s07VnUs03w03llkQ03r01tksC01tk0xkQ701sQ0SkC3U1sDUD071k1s3w7UzUs3s0zXkTkw7k07ts07y7U01ss03y0000000000000000002"
	Loop
	{
		Sleep, 100
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_GuanBi))
			break
		
		if (A_Index>30)
			break
	}
	
	; click close
	Click, 636, 686
	
	GoHome()
	
}


AddMana()
{
	GoHome()

	; ok location
	ok_x = 789
	ok_y = 543

	; mana once location
	one_x = 789
	one_y = 689

	; mana 10 times location
	ten_x = 1069
	ten_y = 689

	; click manaplus
	Click, 251, 136

	; click blank
	Loop, 3
	{
		Sleep, 1000
		Click, 1180, 230
	}

	; click mana once
	Click, %one_x%, %one_y%

	Sleep, 1000

	; click ok
	Click, %ok_x%, %ok_y%

	Sleep, 5000

	Loop, 3
	{
		; click mana ten
		Click, %ten_x%, %ten_y%

		Sleep, 1000

		; click ok
		Click, %ok_x%, %ok_y%
		
		Sleep, 20000
	}
	
	GoHome()
}


GetGift()
{
	global Bottom_home_gift_x
	global Bottom_home_gift_y
	global Bottom_lb_x
	global Bottom_lb_x
	
	GoHome()
	Sleep, 1000
	
	; click gift bottom
	Click, %Bottom_home_gift_x%, %Bottom_home_gift_y%
	
	; check load --> cancel
	Text_cancel:="|<>*150$59.0000000000000000000000000U0Q00Tzk01kssM0zzzy1tllk0sQzy1lXXU1ks0Q1Vb603Vl0s00C007bX1k00y00Dz63X0zzw0SCAD7Vk1s0sQMQ7XU1k1ksMs7703U3Vklk6C0D07zVr00Tzy0Dz1y00s0w0QC3w01k0s0sQ7k1XU1k1ks7U3707U3VwD0CDzz0Dzky0MQ0S0Tz1y0ks0Q0yC7S3Vk0s00QQSD3U1k00tkSQ70zV"
	Loop
	{
		Sleep, 100
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_cancel))
			break
	}
	
	; click get all
	Click, 1080, 686
	
	Sleep, 1000
	
	; cancel
	Click, 812, 691
	
	GoHome()
	
}


GetReward()
{
	global Bottom_home_quest_x
	global Bottom_home_quest_y
	global Bottom_lb_x
	global Bottom_lb_x
	
	GoHome()
	
	Click, %Bottom_home_quest_x%, %Bottom_home_quest_y%
	
	; text find --> finish condition
	Text_finish_condition:="|<>*200$60.zzzzzzzzzzznzzzazbwzztzzzaTbszk00zzbDa01U00TzXDbwzXzwQ007303bzwQzby5szw03wzby5szw03wTbC601zzzw1aCbzzzzzwMWQb03U00QsWTaDny6DwskzaDnzCTwskza03zCTwslraDnyCSQslba03ySSRVVba03syCNzA7aDnly0PyQDaC3bzzzzzTbTzzzzzzzzzzzU"
	Loop
	{
		Sleep, 100
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_finish_condition))
			break
	}
	
	Click, 1120, 637
	
	GoHome()
}


CloseAll()
{
	MouseMove, 640, 360
	
	; click recent task
	Sleep, 1000
	Click, 1311, 735
	Sleep, 500
	
	Loop, 3
	{
		Sleep, 1000	
		MouseMove, 700, 400
		Send, {LButton Down}
		Sleep, 100
		MouseMove, 1800, 400, 10
		Send, {LButton Up}
	}
	
	Sleep, 1000
	
	Click, 1308, 677
	Sleep, 500
}

