#SingleInstance Force
#InstallMouseHook
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

;Build 20191212
;All pixel coordinates in this section must use the "Screen (less often used)" value.
;Unless otherwise specified, the search range will be a 3x3 box centered on the specified pixel.
;All colours in this section should be of the format 0xRRGGBB
;If the script won't run for you in Windows 10, you need to set your variables, compile the script as an EXE then run the EXE as Administrator.
;Alternitively set the AHK.exe main executable to always run as Administrator.

;The amount of time, in minutes, you want the script to wait while in the battle before it decides something has gone wrong and triggers the crash handling.
;(Default := 5)
Battle_Timeout := 1

;The amount of time, in seconds, you want the script to wait in menus before it decides something has gone wrong and triggers the crash handling.
;(Default := 30)
Menu_Timeout := 30

;The amount of time, in milliseconds, the script will wait between finding a pixel and clicking.
;Due to FFRK's habit of drawing menus before they are clickable, setting this bellow 400ms will generally result in the script stalling, if the default causes stalling increase until it stops stalling.
;(Default := 400)
Click_Timeout := 400

;A Yellow Pixel on the yellow crossed swords of Fabul Castle - 1st Battle.
;This will search a 3x3 square centred on the given pixel for the given colour.
Yellow_Swords := [1470,671,0xF2DF3D]

;A Blue Pixel directly above the first "t" in "Begin Battle".
;Make sure it's closer to the top of the button than the top of the "t" so the orange search below works.
;If it stalls on the orange button set the pixel a little higher.
Battle_Blue := [1761,646,0x2493F5]

;The same (doesn't need to be identical but it needs to be close) Pixel but the orange of the spend gems dialogue, to enter slow mode when out of stamina.
;The macro should work without you changing the colour thanks to variation matching but it's worth double checking.
;In any case it shouldn't spend gems even if it does click as Loop3 is looking for red, not blue.
;Get to < 90 Stamina and trigger the stamina refresh dialogue on a 5* Mote stamina fight if needs be.
Battle_Orange :=  [1708,676,0xDE701E] 

;The position of the "Back" button when you've run out of stamina.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 5* Mote stamina fight if needs be.
Battle_Back := [1542,952,0x02186E]

;A White pixel on the "Skip" button text at the end of the battle.
;Unlike the Apoc farming scripts this only checks for a single pixel and triggers once it sees it.
;Please set your farming team to not use any abilities, only use the AOE attack Record Materia.
Skip_White := [1788,967,0xFFFFFF]

;A White pixel in the "Next" button text.
Next_White := [1527,965,0xFFFFFF]

;Crash Handling
;This will enable the macro to recover for when (yes, when) FFRK crashes.
;It can handle either the infinite black loading screen or a total crash to home screen.
;This only works for emulators with a tab-like switcher at the top of the screen, like MeMu.
;However, since this relies on exact positioning, the emulator needs to be at the same position each time.
Enable_Crash_Handle := 1

;A pixel on the tab that brings up the home screen (not the X, since there is no X you can't close this tab)
Crash_Home_Tab_Pixel := [1423,16,0xDEF2F1]

;A pixel on the X that closes the current tab (this is for the infinite black loading screen crash).
Crash_Close_Pixel := [1459,6,0xFFFFFF]

;The position of the FFRK launcher icon.
;Please note that when you close an app on MeMu it will go to the default launcher, not Nova Launcher
;As such please use the position of the app on the default launcher.
Crash_App_Launch := [1781,346,0xE1ACBB]

;The position and colour of the blue "Play" button when FFRK launches.
Crash_Play := [1579,811,0x0824B0]

;The position and colour of the blue "OK" button when resuming an interrupted fight (This is for the battle load crash).
Crash_OK := [1651,723,0x133CD2]

;The position and colour of the center of the bottom edge of the scroll that says "Realm Dungeons".
Crash_In_Battle := [1365,587,0xEABE5B]


;******************************************************************;
;**Do not edit below this line unless you know what you are doing**;
;******************************************************************;

Loop0:
loop{	
	start1 := A_TickCount 
	Loop1:
	loop{
		if (resumed = 1){
		break Loop1
		}
		PixelSearch, XX, YY, Yellow_Swords[1]-1, Yellow_Swords[2]-1, Yellow_Swords[1]+1, Yellow_Swords[2]+1, Yellow_Swords[3], 1, Fast RGB
		if (XX != ""){
		sleep Click_Timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Yellow_Swords[1], Yellow_Swords[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop1
		}
		now1 := A_TickCount-start1
		if (now1 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep Click_Timeout
		
	start2 := A_TickCount 
	Loop2:
	loop{
		if (resumed = 1){
		break Loop2
		}
		;tooltip, 2
		PixelSearch, ZZ, YY, Battle_Blue[1]-1, Battle_Blue[2]-1, Battle_Blue[1]+1, Battle_Blue[2]+1, Battle_Orange[3], 5, Fast RGB
		if (ZZ != ""){
		sleep 1000
		MouseClick, Left, Battle_Back[1], Battle_Back[2], 1, 0
		Sleep 180000
		Reload
		}
		PixelSearch, XX, YY,Battle_Blue[1]-1, Battle_Blue[2]-1, Battle_Blue[1]+1, Battle_Blue[2]+1, Battle_Blue[3], 2, Fast RGB
		if (XX != ""){
		sleep Click_Timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Battle_Blue[1], Battle_Blue[2], 1, 0
		BlockInput, MouseMoveOff
		break Loop2
		}
		now2 := A_TickCount-start2
		if (now2 > Menu_Timeout*1000  && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep Click_Timeout
		
	start3 := A_TickCount 
	Loop3:
	loop{
		resumed := 0
		PixelSearch, XX, YY, Skip_White[1]-1, Skip_White[2]-1, Skip_White[1]+1, Skip_White[2]+1, Skip_White[3], 2, Fast RGB
		if (XX != ""){
		sleep Click_Timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Skip_White[1], Skip_White[2], 1, 0
		BlockInput, MouseMoveOff
		break Loop3
		}
		now3 := A_TickCount-start3
		if (now3 > Battle_Timeout*1000*60 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep Click_Timeout

	count2 = 0
	LoopB:
	loop{
		PixelSearch, ZZ, YY, Next_White[1]-1, Next_White[2]-1, Next_White[1]+1, Next_White[2]+2, 0x000000, 0, Fast RGB
		if (ZZ != ""){
		break LoopB
		}
		count = 0
		Loop4:
		loop{
			PixelSearch, XX, YY, Next_White[1]-1, Next_White[2]-1, Next_White[1]+1, Next_White[2]+1, Next_White[3], 2, Fast RGB
			count++
			if (XX !=""){
			sleep 100
			BlockInput, MouseMove
			MouseClick, Left, Next_White[1], Next_White[2], 1, 0
			sleep 100
			MouseClick, Left, Next_White[1], Next_White[2], 1, 0
			BlockInput, MouseMoveOff
			break Loop4
			}
			count2++
			} until count > 20
		} until count2 > 150
		sleep Click_Timeout
}

CrashHandle:
sleep 600
MouseClick, Left, Crash_Home_Tab_Pixel[1], Crash_Home_Tab_Pixel[2], 1, 0
sleep 600
MouseClick, Left, Crash_Close_Pixel[1], Crash_Close_Pixel[2], 1, 0
sleep 600
start1 := A_TickCount
LoopC1:
Loop{
	now1 := A_TickCount-start1
	PixelSearch, XX, YY, Crash_App_Launch[1]-25, Crash_App_Launch[2]-25, Crash_App_Launch[1]+25, Crash_App_Launch[2]+25, 0xFFFFFF, 5, Fast RGB
	if (XX != ""){
	sleep Click_Timeout
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_App_Launch[1], Crash_App_Launch[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC1
		}
	} until now1 > Menu_Timeout*1000
if(now1 > Menu_Timeout*1000){
goto CrashHandle
}
start2 := A_TickCount 
LoopC2:
Loop{
	now2 := A_TickCount-start2
	PixelSearch, XX, YY, Crash_Play[1]-2, Crash_Play[2]-2, Crash_Play[1]+2, Crash_Play[2]+2, Crash_Play[3], 2, Fast RGB
	if (XX != ""){
	sleep Click_Timeout
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Play[1], Crash_Play[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC2
		}
	} until now2 > Menu_Timeout*1000
if(now2 > Menu_Timeout*1000){
goto CrashHandle
}
resumed := 0

start3 := A_TickCount
LoopC3:
Loop{
	now3 := A_TickCount-start3
	PixelSearch, XX, YY, Crash_OK[1]-2, Crash_OK[2]-2, Crash_OK[1]+2, Crash_OK[2]+2, Crash_OK[3], 2, Fast RGB
	if (XX != ""){
	sleep Click_Timeout
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_OK[1], Crash_OK[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	resumed := 1
	break LoopC3
		}
	} until now3 > 10000

start4 := A_TickCount
LoopC4:
Loop{
	if (resumed = 1){
	break LoopC4
	}
	now4 := A_TickCount-start4
	PixelSearch, XX, YY, Crash_In_Battle[1]-2, Crash_In_Battle[2]-2, Crash_In_Battle[1]+2, Crash_In_Battle[2]+2, Crash_In_Battle[3], 6, Fast RGB
	if (XX != ""){
	sleep Click_Timeout
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_In_Battle[1], Crash_In_Battle[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff

	break LoopC4
	}
	} until now4 > 10000

Goto Loop0

^Space::ExitApp
