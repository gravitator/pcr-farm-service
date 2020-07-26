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
WinMove, %SimTitle%, ,0 ,0