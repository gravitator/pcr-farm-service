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


AddMana(times)
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

	Loop, times
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


DonateMana(character_num)
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
	
	; click dungeon icon
	Click, 1161, 248
	
	Sleep, 1000
	
	; ènter the dungeon (normal level)
	Loop
	{
		Sleep, 1000
		
		; click the dungeon (normal level)
		Click, 333, 555
		
		; textfind: OK
		Text_OK:="|<>*180$39.zzzzzzzw1ztzvz23yDwDVyDlz3wTsyDsz7z3lyDszwSDXyDzXlszlzwCCDyDzVlXzlzyC0DyDzlk1zlzyC37yDzVkwTlzwCDXyDzXlyDszwSDsz7z3lz3wTsyDwTVyDlzVy03yDyDw0ztzvzzzzzzzzzzzzzU"

		if (ok:=FindText(0, 0, 786+150000, 547+150000, 0, 0, Text_OK))
		{
			Sleep, 500
			CoordMode, Mouse
			X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
			Click, %X%, %Y%
			Sleep, 500
			break
		}
	}
	
	; check loading --> Help
	Loop
	{
		; find color: help
		Sleep, 500
		PixelSearch, Px, Py, 1051, 101, 1051, 101, 0x4A8EF7, 10, Fast RGB
		if (ErrorLevel = 0)
			break
		
		; find icon: menu
		Text_menu:="|<>*204$38.0000001zzzzzkzzzzzyTzzzzzbzzzzztzzzzzyDzzzzz00000000000000000000000000zzzzzwTzzzzzbzzzzztzzzzzyDzzzzzVzzzzzk0000000000000000000TzzzzwDzzzzzbzzzzztzzzzzyDzzzzzXzzzzzk000000U"
		if (ok:=FindText(0, 0, 786+150000, 547+150000, 0, 0, Text_menu))
		{
			Sleep, 2000
			; click menu
			Click, 1222, 110
			Sleep, 1000
			; click skip
			Click, 1069, 110
			Sleep, 1000
			; click skip (confirm)
			Click, 789, 543
		}
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
	
	character_pos_x := 146 + 138*(character_num-1)
	; click 1st character
	Click, %character_pos_x%, 290
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
				
				Loop
				{
					; click donate
					Click, %X%, %Y%
					
					Sleep, 2000
					
					; textfind: QuXiao
					Text_cancel:="|<>*164$55.00000000000000000000000003000000613UUzzU03llksTzjzUwssw3XrzkCCQQ1ls0s33CA0swkQ007U0TyMC01zz0DzA761zzs77b7Xks0w3XlXkSQ0C1lslk7C070swQs1703UTyCw03zzkDz3Q01k0s77Vy08s0Q3XkS0AQ0C1lsD06C071sy7U37zzVzy7s3XU1kzz3y1lk0sTbXjVks0Q03nXssQ0C01vUwwC1z00PUCQ71zU0A0003000000000001"
					if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_cancel))
					{
						Sleep, 1000
						break
					}
				}
				
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
	
	; check loading --> union master
	Loop
	{
		Sleep, 1000
		
		; click member
		Click, 317, 524
		
		Sleep, 1000
		
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

	Sleep, 1000
	
	Loop, 20
	{
		Loop
		{
			Sleep, 1000
			; click member management
			Click, 985, 320
			
			Sleep, 1000
			
			; text find: fire
			Text_KaiChu:="|<>*180$44.0000000000000E00001sC0Dzzlz3k3zzsRlq070s7QQk1kC1qCC0Q3URb1s70s7Hzy1kC1xjwUQ3URUQ1zzzbM70TzzlnTz0Q3UQzzs70s7A701kC1nBo0M3UTrRUC0s7xbA30C1klnVk3UQAQMs0s74T0M0C1k7U00000002"
			if (ok:=FindText(868-150000, 282-150000, 868+150000, 282+150000, 0, 0, Text_KaiChu))
			{
				CoordMode, Mouse
				X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
				Sleep, 500
				Click, %X%, %Y%
				break
			}
		}
		
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
	
	}
	
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

