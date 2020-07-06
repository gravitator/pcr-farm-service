#Include pcr.ahk

BasicName := "cow"

FileName := "account_new.txt"
File := FileOpen(FileName, "r-d")
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for reading.
	return
}

Loop
{

	account_pwd := GetAccount(File)
	if (account_pwd = 0)
	{
		File.Close()
		return
	}
	account := account_pwd[1]
	pwd := account_pwd[2]
	
	If WinExist("ahk_class LDPlayerMainFrame")
	{
		WinActivate
	} else {
		Run C:\ChangZhi\dnplayer2\dnplayer.exe
		WinWaitActive ahk_class LDPlayerMainFrame
	}
	
	GoHome()
	SwitchAccount(account, pwd)
	
	; click menu
	Click, %Bottom_home_menu_x%, %Bottom_home_menu_y%

	; find text Short info. --> click
	Text_Jianjie:="|<>*150$54.0000000000000000000k1U006001k3U00D001znzk0T003zrzk0TU0366A00wk067AC01ss0A28403kS01k0007UDU0tzz0D07k0M07Uw01w3003Vn0Aw7083X3UQ877zXU3UQ0773XU3UQ0761XU3UQ0773XU3UQ077zXU3UQ0761XU70Q0761XU70Q077/XU70Q077zXUC0Q07003UC0Q07007UQ0Q0701z0k0Q0300000080000000000000000000U"
	Loop
	{
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_jianjie))
		{
			CoordMode, Mouse
			X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
			Sleep, 1000
			Click, %X%, %Y%
			break
		}
	}

	; find text ID copy --> click
	Text_IDcopy:="|<>*200$67.000000000000000000000000000k00101U0000s00Bk1kszs0zzzCs0sQTz0zzz7zbQCC3kQ003zzi770wTzzXbVr3XUCTzzlXUvVlk7Vk0s1kRkss3kzzwTzysQQ1sQ0SDzzQCC0wD0D0C3i770S7zzU71r3XUD0w00zyvVlk7UzzkTzxkss3UzzwCtysQQ3kz0w7QzQCC3kttw3iQC77zkkDw1rC73XzU0Dzkvb3U0001zzyNnDk0003y0z0s7k0000000000000000000000E"
	Loop
	{
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_IDcopy))
			break
	}
	Sleep, 1000

	; click ID copy
	Click, 1140, 619
	Sleep, 1000
	
	; click --> edit name
	Click, 1200, 240
	Sleep, 1000

	; click --> name box
	Click, 590, 420
	Sleep, 1000

	; select all
	Send, ^a
	Sleep, 100
	Send, %BasicName%%A_Index%
	Sleep, 100
	Send, {Enter}
	Sleep, 500

	; click --> change
	Click, 778, 544
	Sleep, 1000
	
	; Output
	OutputDebug, %account%,%pwd%,%BasicName%%A_Index%,%clipboard%
	
}