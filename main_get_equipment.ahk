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
	
	if (A_Index = 1)
	{
		if (IsHome())
			SwitchAccount(account,pwd)
		else
			Login(account,pwd)
	}
	else
		SwitchAccount(account,pwd)
	
	GoHome()
	Sleep, 1000
	AddEnergy(3)
	Sleep, 1000
	GetGift()
	Sleep, 1000
	GetReward()
	Sleep, 1000
	GetLastestEquipment(3)
	Sleep, 1000
	GetReward()
	Sleep, 1000
}

GoHome()

ExitApp


GetLastestEquipment(per_times)
{
	global Bottom_lb_x
	global Bottom_lb_y
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
	
	Sleep, 1000
	
	; click main stage
	Click, 751, 448
	
	; text find --> hard
	Text_hard:="|<>*160$68.00000000000204000000001s3k3k1zsDz0S0w1w0zz3zw7UD0T0S1tsDVs3k7s7UDS1wS0w3i1s3rUD7UD0nkS0xs1tzzkQw7USS0STzw67VyTbU7bzz1VsTzVs1ts3ksC7zkS0SS0wDzlsw7U7bUD3zwS7Vs3ls3lzzbUwS0wS0wM1tsDbUz7UDC0SS1xzz1s3nU3bUDDzUA0Mk0ss1ly000000000000000000000000000000000008"
	Loop
	{
		Sleep, 100
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_hard))
			break
	}
	
	; goto the lastest map
	Loop, 15
	{
		start_x = 300
		start_y = 300
		end_x = 400
		end_y = 630
		
		if (Mod(A_Index,2)=1)
			x := start_x
		else
			x := end_x
		
		y := end_y - (end_y-start_y)/15 * A_Index
		
		Click, %x%, %y%
		Sleep, 500
		
		; text find --> dare
		Text_dare:="|<>*196$59.zzzzzTzzzTzzzzzzzzzzzzzzzzzzzzwzrDzvzjzztz6TzXyCzznyAzz7wQzzbwNzyDswzz6MnbwTlzzk4lbDs3XzzUAXAzlz3vzkt6NzXw07znsA7z7UDzzbwMzyDszzzDsnzwTtxzyTlXzsznlzsDX7y0DXbzUw63wQD6Dy1kAltwS8zw64Nnnsw1zzANnrblw7zyTnbzDXsTzwz7DyT7ltztyCSQyD3nznswwtwQ3jzbnttnsn2TyDDlXU1T0zkQzUDUDz3zzvzzzzzzjzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_dare))
		{
			Sleep, 1000
			; move to the latest map
			MouseMove, 1234, 391
			Loop, 10
			{
				Sleep, 300
				MouseClick
			}
			break
		}
		
	}
	
	; text find --> dare
	Text_dare:="|<>*196$59.zzzzzTzzzTzzzzzzzzzzzzzzzzzzzzwzrDzvzjzztz6TzXyCzznyAzz7wQzzbwNzyDswzz6MnbwTlzzk4lbDs3XzzUAXAzlz3vzkt6NzXw07znsA7z7UDzzbwMzyDszzzDsnzwTtxzyTlXzsznlzsDX7y0DXbzUw63wQD6Dy1kAltwS8zw64Nnnsw1zzANnrblw7zyTnbzDXsTzwz7DyT7ltztyCSQyD3nznswwtwQ3jzbnttnsn2TyDDlXU1T0zkQzUDUDz3zzvzzzzzzjzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
	Loop
	{
		Sleep, 100
		if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_dare))
			break
	}
	
	; main loop
	Loop
	{
		; sweep per_times
		MouseMove, 1169, 500
		Loop, %per_times%
		{
			if (A_index=1)
				continue
			Sleep, 300
			MouseClick
		}
		
		Sleep, 1000
		
		; click sweep
		Click, 1000, 500
		
		Sleep, 1000
		
		; click ok
		Click, 790, 550
		
		; click ok
		Loop
		{
			if (A_index=1)
				Sleep, 1000
			else
				Sleep, 300
			
			Click, 630, 710

			Sleep, 1000
			
			; check no energy
			Text_noenergy := "|<>0xD66173@0.73$27.00001zszwDzbzk000000004" ;--
			if (ok:=FindText(0, 0, 1280, 720, 0, 0, Text_noenergy))
			{
				GoHome()
				return
			}
			
			; check daration finished
			PixelGetColor, color, 1171, 495, Fast RGB
			if (color=0x6B9EFF)
				break
			
		}
		
		Sleep, 100
		
		; click previous page
		Click, 36, 387
		Sleep, 1000
	}
	
}