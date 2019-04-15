#SingleInstance Force
#InstallMouseHook
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

;Uncomment lines 9, 10 and 11 (Delete the ;)to enable the script to run as admin.
;Usually needed if Windows 10 throws a tantrum and blocks the clicks.
;SetWorkingDir %A_ScriptDir%
;if not A_IsAdmin
	;Run *RunAs "%A_ScriptFullPath%"


;A Yellow Pixel on the yellow crossed swords of Fabul Castle - 1st Battle.
;This will search a 3x3 square centered on the given pixel for the given colour.
;All colours in this section should be of the format 0xRRGGBB
Loop1_Pixel_X := 1435
Loop1_Pixel_Y := 650
Loop1_Pixel_C := 0xF9ED5D

;A Blue Pixel directly above the first "t" in "Begin Battle".
;This will search a 2x2 square, with top left corner on the provided values.
Loop2_Pixel_X := 1722
Loop2_Pixel_Y := 649
Loop2_Pixel_C := 0x1E51EA

;The same Pixel but the orange of the spend gems dialog, to enter slow mode when out of stamina.
;The macro should work without you changing this thanks to variation matching but it's worth double checking.
;In any case it shouldn't spend gems even if it does click as Loop3 is looking for red, not blue.
;Get to 59 Stamina and trigger the stamina refresh dialog on a 60 stamina fight if needs be.
Loop2_Pixel_O := 0xDE701E 

;The position of the "Back" button when you've run out of stamina.
;Get to 59 Stamina and trigger the stamina refresh dialog on a 60 stamina fight if needs be.
Loop2_Pixel_X_B := 1557
Loop2_Pixel_Y_B := 810

;A Red pixel on the Champion Rainbow bar (so it clicks and skips the exp scrolling)
;This will search a 1x1 square centered on the given pixel for the given colour.
Loop3_Pixel_X := 1821
Loop3_Pixel_Y := 554
Loop3_Pixel_C := 0xFF4900

;A Pixel (white one preferably) in the "Next" button text, will be used for all the next buttons
;This will search a 3x3 square centered on the given pixel for the given colour.
Loop4Plus_Pixel_X := 1526
Loop4Plus_Pixel_Y := 900
Loop4Plus_Pixel_C := 0xFFFFFF

;Crash Handling
;This will enable the macro to recover for when (yes, when) FFRK crashes.
;It can handle either the infinite black loading screen or a total crash to home screen.
;This only works for emulators with a tab-like switcher at the top of the screen, like MuMu or MeMu.
;However, since this relies on exact positioning, the emulator needs to be at the same position each time.
;Please visit https://redd.it/b9xn3z for instructions on how to force MuMu into the same position each time.
Enable_Crash_Handle := 1

;The position of the X that closes the current tab (this is for the infinite black loading screen crash)
Crash_Close_Pixel_X := 1480
Crash_Close_Pixel_Y := 8

;The position of the FFRK launcher icon. This searches for a white pixel so put the coordinates somewhere in the middle.
;Please note that when you close an app on MeMu it will go to the default launcher, not Nova Launcher
;As such please use the position of the app on the default launcher.
Crash_App_Launch_X := 1790
Crash_App_Launch_Y := 187
;The position and colour of the blue "Play" button when FFRK launches.
Crash_Play_X := 1563
Crash_Play_Y := 740
Crash_Play_C := 0x1D95F7
;The position and colour of the blue "OK" button when resuming an interupted fight (This is for the battle load crash).
Crash_OK_X := 1693
Crash_OK_Y := 660
Crash_OK_C := 0x1D95F7
;The position and colour of the weird greenish lamp thing in the top left of the Realm Dungeon button where it says "In Battle"
;Because of the particle effects the colour likes to jump around and this was the most stable place I could find.
Crash_In_Battle_X := 1313
Crash_In_Battle_Y := 583
Crash_In_Battle_C := 0x7DCBBB

;*****************************************************************;
;**Do not edit below this line (or do, I'm a comment, not a cop)**;
;*****************************************************************;

Loop0:
loop{	
	start1 := A_TickCount 
	Loop1:
	loop{
		if (resumed = 1){
		break Loop1
		}
		PixelSearch, XX, YY, Loop1_Pixel_X-1, Loop1_Pixel_Y-1, Loop1_Pixel_X+1, Loop1_Pixel_Y+1, %Loop1_Pixel_C%, 1, Fast, RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Loop1_Pixel_X, Loop1_Pixel_Y, 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop1
		}
		now1 := A_TickCount-start1
		if (now1 > 30000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
		
	start2 := A_TickCount 
	Loop2:
	loop{
		if (resumed = 1){
		break Loop2
		}
		;tooltip, 2
		PixelSearch, ZZ, YY, Loop2_Pixel_X, Loop2_Pixel_Y, Loop2_Pixel_X+1, Loop2_Pixel_Y+1, Loop2_Pixel_O, 5, Fast, RGB
		if (ZZ != ""){
		sleep 1000
		MouseClick, Left, Loop2_Pixel_X_B, Loop2_Pixel_Y_B, 1, 0
		Sleep 180000
		Reload
		}
		PixelSearch, XX, YY, Loop2_Pixel_X, Loop2_Pixel_Y, Loop2_Pixel_X+1, Loop2_Pixel_Y+1, Loop2_Pixel_C, 2, Fast, RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Loop2_Pixel_X, Loop2_Pixel_Y, 1, 0
		BlockInput, MouseMoveOff
		break Loop2
		}
		now2 := A_TickCount-start2
		if (now2 > 30000  && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
		
	start3 := A_TickCount 
	Loop3:
	loop{
		resumed := 0
		PixelSearch, XX, YY, Loop3_Pixel_X, Loop3_Pixel_Y, Loop3_Pixel_X, Loop3_Pixel_Y, Loop3_Pixel_C, 2, Fast, RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 1, 0
		BlockInput, MouseMoveOff
		break Loop3
		}
		now3 := A_TickCount-start3
		if (now3 > 30000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 250

	count2 = 0
	LoopB:
	loop{
		PixelSearch, ZZ, YY, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 0x000000, 0, Fast, RGB
		if (ZZ != ""){
		break LoopB
		}
		count = 0
		Loop4:
		loop{
			PixelSearch, XX, YY, Loop4Plus_Pixel_X-1, Loop4Plus_Pixel_Y-1, Loop4Plus_Pixel_X+1, Loop4Plus_Pixel_Y+1, Loop4Plus_Pixel_C, 2, Fast, RGB
			count++
			if (XX !=""){
			sleep 100
			BlockInput, MouseMove
			MouseClick, Left, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 1, 0
			sleep 100
			MouseClick, Left, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 1, 0
			BlockInput, MouseMoveOff
			break Loop4
			}
			count2++
			} until count >10 
		} until count2 > 100
		sleep 750
}

CrashHandle:
sleep 500
MouseClick, Left, Crash_Close_Pixel_X, Crash_Close_Pixel_Y, 1, 0
sleep 50
MouseClick, Left, Crash_Close_Pixel_X, Crash_Close_Pixel_Y+50, 1, 0
sleep 500
start1 := A_TickCount
LoopC1:
Loop{
	now1 := A_TickCount-start1
	PixelSearch, XX, YY, Crash_App_Launch_X-25, Crash_App_Launch_Y-25, Crash_App_Launch_X+25, Crash_App_Launch_Y+25, 0xFFFFFF, 5, Fast, RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_App_Launch_X, Crash_App_Launch_Y, 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC1
		}
	} until now1 > 30000
	
start2 := A_TickCount 
LoopC2:
Loop{
	now2 := A_TickCount-start2
	PixelSearch, XX, YY, Crash_Play_X-2, Crash_Play_Y-2, Crash_Play_X+2, Crash_Play_Y+2, Crash_Play_C, 2, Fast, RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Play_X, Crash_Play_Y, 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC2
		}
	} until now2 > 30000

resumed := 0

start3 := A_TickCount
LoopC3:
Loop{
	now3 := A_TickCount-start3
	PixelSearch, XX, YY, Crash_OK_X-2, Crash_OK_Y-2, Crash_OK_X+2, Crash_OK_Y+2, Crash_OK_C, 2, Fast, RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_OK_X, Crash_OK_Y, 1, 0
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
	PixelSearch, XX, YY, Crash_In_Battle_X-2, Crash_In_Battle_Y-2, Crash_In_Battle_X+2, Crash_In_Battle_Y+2, Crash_In_Battle_C, 6, Fast, RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_In_Battle_X, Crash_In_Battle_Y, 1, 0
	sleep 100
	BlockInput, MouseMoveOff

	break LoopC4
	}
	} until now4 > 10000

Goto Loop0

^Space::ExitApp
