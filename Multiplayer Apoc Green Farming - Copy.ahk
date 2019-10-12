#SingleInstance Force
#InstallMouseHook
CoordMode, pixel, Screen
CoordMode, Mouse, Screen

;Uncomment lines 9, 10 and 11 (Delete the ;)to enable the script to run as admin.
;Usually needed if Windows 10 throws a tantrum and blocks the clicks.
;If that doesn't work, compile the script and run as administrator.
;SetWorkingDir %A_ScriptDir%
;if not A_IsAdmin
	;Run *RunAs "%A_ScriptFullPath%"

;All pixel coordinates in this section must use the "Screen (less often used)" value.
;All colours in this section should be of the format 0xRRGGBB

;The amount of time, in minutes, you want the script to wait while in the battle before it decides something has gone wrong and triggers the crash handling.
Battle_Timeout := 5

;The amount of time, in seconds, you want the script to wait in menus before it decides something has gone wrong and triggers the crash handling.
Menu_Timeout := 30

;A Purple pixel on the top right corner of the "(Apocalypse +)" dungeon button.
Apoc_Purple := [1802,513,0x270625]

;A Blue pixel on the "Enter Dungeon" button.
Enter_Dungeon_Blue := [1792,955,0x0D2ECC]

;A Brown pixel on the "Solo Raid" button.
Solo_Raid_Brown := [1324,587,0x4B1F0F]

;A White pixel on the "Next" button.
Next_Blue := [1631,959,0x0725B4]

;A Brown pixel on the "Remove" button of the first Roaming Warrior.
;This script is intended for farming, if you need to rely on Cloud USB1 this script isn't for you.
;If you really want to use the top RW, change the "Use_RW" variable to 1
Remove_Brown := [1822,502,0x582612]
Use_RW := 0

;A Blue pixel on the "GO!" button.
Go_Blue := [1627,952,0x1238D2]

;A Yellow pixel on the "1" underneath the word "Stamina".
One_Yellow := [1524,510,0xFFDD8E]

;A Blue pixel directly above the first "t" in "Begin Battle".
;Make sure it's closer to the top of the button than the top of the "t" so the orange search below works.
;If it stalls on the orange button set the pixel a little higher.
Battle_Blue := [1718,658,0x1F76E2]

;The same pixel but the ORANGE of the spend gems dialogue, to enter slow mode when out of stamina.
;The macro should work without you changing this thanks to variation matching but it's worth double checking.
;In any case it shouldn't spend gems even if it does click as Loop9 is looking for red, not blue.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 50 stamina fight if needs be.
Battle_Orange := 0xDE701E 

;A BLUE pixel on the "Back" button when you've run out of stamina.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 50 stamina fight if needs be.
Back_Blue := [1526,841,0x02186E]

;A WHITE pixel in the bottom right corner border of the Battle Results Screen (the one with the Champion Rainbow bar, so it detects the end of the battle).
;The colour code should be 0xFFFFFF unless you've got a really weird setup.
Corner_White := [1861,995,0xFFFFFF]

;A WHITE pixel in the "Next" button text after the battle is won, will be used for all the next buttons.
;The colour code should be 0xFFFFFF unless you've got a really weird setup.
Next_White := [1859,994,0xFFFFFF]

;Crash Handling
;This will enable the macro to recover for when (yes, when) FFRK crashes.
;It can handle either the infinite black loading screen or a total crash to home screen.
;This only works for emulators with a tab-like switcher at the top of the screen, like MeMu.
;However, since this relies on exact positioning, the emulator needs to be at the same position each time.
Enable_Crash_Handle := 1

;A pixel on the X that closes the current tab (this is for the infinite black loading screen crash).
Crash_Close_pixel := [1480,7,0x0DC5A0]

;The position of the FFRK launcher icon. For best results, select a WHITE pixel somewhat centered.
;Please note that when you close an app on MeMu it will go to the default launcher, not Nova Launcher
;As such please use the position of the app on the default launcher.
Crash_App_Launch := [1801,338,0xFFFFFF]

;A BLUE pixel on the blue "Play" button when FFRK launches.
Crash_Play_Blue := [1613,782,0x0B2096]

;A BROWN pixel on the "Cancel" button when resuming an interrupted fight (This is for the battle load crash).
Crash_Cancel_Brown := [1448,692,0x422209]

;A YELLOW pixel on the yellow dome in the top left of the Event Dungeon button, without moving the home screen after pressing the "Home" button.
;Because of the particle effects the colour likes to jump around and this was the most stable place I could find.
Crash_Home_Screen_Yellow := [1854,635,0xFFFF84]

;A YELLOW pixel in the word "Battle" when you're In Battle in an event dungeon.
;To force this screen, enter any event battle staging screen, and before going into the battle itself, press "Home".
Crash_Event_Battle_Yellow := [1547,657,0xFEFEAF]

;A WHITE pixel on the white hair of the Bartz lookalike in the "Raid Dungeons" button.
Crash_Raid_Dungeons_White := [1719,98,0xFCFEFE]

;A GREEN pixel on the green hair of the Bartz lookalike in the "Event Dungeons" button.
Crash_Event_Dungeons_Green := [1764,98,0x89E810]

;Any pixel on the banner of the event you are farming.
Crash_Farm_Dungeon := [1601,475,0x9D16CB]

;*******************************************************************;
;**Do not edit below this line unless you know what you are doing.**;
;*****************Or do, I'm a comment, not a cop.******************;
;*******************************************************************;

Loop0:
loop{	
	start1 := A_TickCount 
	Loop1:
	loop{
		if (resumed = 1){
		break Loop1
		}
		if (battlecrash = 1){
		break Loop1
		}
		pixelSearch, XX, YY, Apoc_Purple[1]-1, Apoc_Purple[2]-1, Apoc_Purple[1]+1, Apoc_Purple[2]+1, Apoc_Purple[3], 5, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Apoc_Purple[1], Apoc_Purple[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop1
		}
		now1 := A_TickCount-start1
		if (now1 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
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
		if (battlecrash = 1){
		break Loop2
		}
		pixelSearch, XX, YY, Enter_Dungeon_Blue[1]-1, Enter_Dungeon_Blue[2]-1, Enter_Dungeon_Blue[1]+1, Enter_Dungeon_Blue[2]+1, Enter_Dungeon_Blue[3], 4, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Enter_Dungeon_Blue[1], Enter_Dungeon_Blue[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop2
		}
		now2 := A_TickCount-start2
		if (now2 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
		
	start3 := A_TickCount 
	Loop3:
	loop{
		if (resumed = 1){
		break Loop3
		}
		if (battlecrash = 1){
		break Loop3
		}
		pixelSearch, XX, YY, Solo_Raid_Brown[1]-1, Solo_Raid_Brown[2]-1, Solo_Raid_Brown[1]+1, Solo_Raid_Brown[2]+1, Solo_Raid_Brown[3], 4, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Solo_Raid_Brown[1], Solo_Raid_Brown[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop3
		}
		now3 := A_TickCount-start3
		if (now3 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500

	start4 := A_TickCount 
	Loop4:
	loop{
		if (resumed = 1){
		break Loop4
		}
		if (battlecrash = 1){
		break Loop4
		}
		pixelSearch, XX, YY, Next_Blue[1]-1, Next_Blue[2]-1, Next_Blue[1]+1, Next_Blue[2]+1, Next_Blue[3], 4, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Next_Blue[1], Next_Blue[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop4
		}
		now4 := A_TickCount-start4
		if (now4 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500

	start5 := A_TickCount 
	Loop5:
	loop{
		if (resumed = 1){
		break Loop5
		}
		if (battlecrash = 1){
		break Loop5
		}
		pixelSearch, XX, YY, Remove_Brown[1]-1, Remove_Brown[2]-1, Remove_Brown[1]+1, Remove_Brown[2]+1, Remove_Brown[3], 4, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		if(Use_RW = 0) {
		MouseClick, Left, Remove_Brown[1], Remove_Brown[2], 1, 0
		}
		sleep 100
		BlockInput, MouseMoveOff
		break Loop5
		}
		now5:= A_TickCount-start5
		if (now5 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
		
		
	start6 := A_TickCount 
	Loop6:
	loop{
		if (resumed = 1){
		break Loop6
		}
		if (battlecrash = 1){
		break Loop6
		}
		pixelSearch, XX, YY, Go_Blue[1]-1, Go_Blue[2]-1, Go_Blue[1]+1, Go_Blue[2]+1, Go_Blue[3], 4, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Go_Blue[1], Go_Blue[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop6
		}
		now6:= A_TickCount-start6
		if (now6 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
		
	start7 := A_TickCount 
	Loop7:
	loop{
		battlecrash := 0
		pixelSearch, XX, YY, One_Yellow[1]-4, One_Yellow[2]-4, One_Yellow[1]+4, One_Yellow[2]+4, One_Yellow[3], 4, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, One_Yellow[1], One_Yellow[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break Loop7
		}
		now7 := A_TickCount-start7
		if (now7 > Menu_Timeout*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
		
	start8 := A_TickCount 
	Loop8:
	loop{
		pixelSearch, ZZ, YY, Battle_Blue[1]-1, Battle_Blue[2]-1, Battle_Blue[1]+1, Battle_Blue[2]+1, Battle_Orange, 5, Fast RGB
		if (ZZ != ""){
		sleep 1000
		MouseClick, Left, Back_Blue[1], Back_Blue[2], 1, 0
		Sleep 180000
		Reload
		}
		pixelSearch, XX, YY, Battle_Blue[1]-1, Battle_Blue[2]-1, Battle_Blue[1]+1, Battle_Blue[2]+1, Battle_Blue[3], 8, Fast RGB
		if (XX != ""){
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Battle_Blue[1], Battle_Blue[2], 1, 0
		BlockInput, MouseMoveOff
		break Loop8
		}
		now8 := A_TickCount-start8
		if (now8 > Menu_Timeout*1000  && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 500
	
	start9 := A_TickCount 
	findwhite := 0
	Loop9:
	loop{
		resumed := 0
		pixelSearch, XX, YY, Corner_White[1], Corner_White[2], Corner_White[1], Corner_White[2], Corner_White[3], 1, Fast RGB
		;tooltip, %findwhite%
		if (XX = ""){
		findwhite := 0
		}
		if (XX != ""){
		findwhite++
		if (findwhite>20) {
		sleep 400
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Next_White[1], Next_White[2], 1, 0
		BlockInput, MouseMoveOff
		break Loop9
		}
		}
		now9 := A_TickCount-start9
		if (now9 > Battle_Timeout*60*1000 && Enable_Crash_Handle = 1){
		Goto CrashHandle
		}
		}
		sleep 250
		
	count2 = 0
	LoopB:
	loop{
		pixelSearch, ZZ, YY, Next_White[1], Next_White[2], Next_White[1], Next_White[2], 0x000000, 1, Fast RGB
		if (ZZ != ""){
		break LoopB
		}
		count = 0
		Loop10:
		loop{
			pixelSearch, XX, YY, Next_White[1]-1, Next_White[2]-1, Next_White[1]+1, Next_White[2]+1, Next_White[3], 2, Fast RGB
			count++
			if (XX !=""){
			sleep 100
			BlockInput, MouseMove
			MouseClick, Left, Next_White[1], Next_White[2], 1, 0
			sleep 100
			MouseClick, Left, Next_White[1], Next_White[2], 1, 0
			BlockInput, MouseMoveOff
			break Loop10
			}
			count2++
			} until count > 20
		} until count2 > 400
		sleep 750

}
CrashHandle:
sleep 1000
MouseClick, Left, Crash_Close_pixel[1], Crash_Close_pixel[2], 1, 0
sleep 1000
MouseClick, Left, Crash_App_Launch[1], Crash_App_Launch[2]+25, 1, 0
sleep 1000
start1 := A_TickCount
LoopC1:
Loop{
	now1 := A_TickCount-start1
	pixelSearch, XX, YY, Crash_App_Launch[1]-25, Crash_App_Launch[2]-25, Crash_App_Launch[1]+25, Crash_App_Launch[2]+25, Crash_App_Launch[3], 5, Fast RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_App_Launch[1], Crash_App_Launch[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC1
		}
	} until now1 > Menu_Timeout*1000
	
start2 := A_TickCount 
LoopC2:
Loop{
	now2 := A_TickCount-start2
	pixelSearch, XX, YY, Crash_Play_Blue[1]-2, Crash_Play_Blue[2]-2, Crash_Play_Blue[1]+2, Crash_Play_Blue[2]+2, Crash_Play_Blue[3], 2, Fast RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Play_Blue[1], Crash_Play_Blue[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC2
		}
	} until now2 > Menu_Timeout*1000

resumed := 0

start3 := A_TickCount
LoopC3:
Loop{
	now3 := A_TickCount-start3
	pixelSearch, XX, YY, Crash_Cance_Brown[1]-2, Crash_Cance_Brown[2]-2, Crash_Cance_Brown[1]+2, Crash_Cance_Brown[2]+2, Crash_Cance_Brown[3], 2, Fast RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Cance_Brown[1], Crash_Cance_Brown[2], 1, 0
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
	pixelSearch, XX, YY, Crash_Home_Screen_Yellow[1]-2, Crash_Home_Screen_Yellow[2]-2, Crash_Home_Screen_Yellow[1]+2, Crash_Home_Screen_Yellow[2]+2, Crash_Home_Screen_Yellow[3], 6, Fast RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Home_Screen_Yellow[1], Crash_Home_Screen_Yellow[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff

	break LoopC4
	}
	
	pixelSearch, XX, YY, Crash_Event_Battle_Yellow[1]-2, Crash_Event_Battle_Yellow[2]-2, Crash_Event_Battle_Yellow[1]+2, Crash_Event_Battle_Yellow[2]+2, Crash_Event_Battle_Yellow[3], 6, Fast RGB
	if (XX != ""){
	battlecrash := 1
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Event_Battle_Yellow[1], Crash_Event_Battle_Yellow[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff

	break LoopC4
	}
	} until now4 > Menu_Timeout*1000

start5 := A_TickCount
LoopC5:
Loop{
	if (resumed = 1){
	break LoopC5
	}
	if (battlecrash = 1){
	break LoopC5
	}
	
	now5 := A_TickCount-start5
	pixelSearch, XX, YY, Crash_Raid_Dungeons_White[1]-2, Crash_Raid_Dungeons_White[2]-2, Crash_Raid_Dungeons_White[1]+2, Crash_Raid_Dungeons_White[2]+2, Crash_Raid_Dungeons_White[3], 6, Fast RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Raid_Dungeons_White[1], Crash_Raid_Dungeons_White[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff

	break LoopC5
	}
	} until now5 > Menu_Timeout*1000
	
	
start6 := A_TickCount
LoopC6:
Loop{
	if (resumed = 1){
	break LoopC6
	}
	if (battlecrash = 1){
	break LoopC6
	}
	now6 := A_TickCount-start6
	pixelSearch, XX, YY, Crash_Event_Dungeons_Green[1]-2, Crash_Event_Dungeons_Green[2]-2, Crash_Event_Dungeons_Green[1]+2, Crash_Event_Dungeons_Green[2]+2, Crash_Event_Dungeons_Green[3], 6, Fast RGB
	if (XX != ""){
	sleep 400
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Farm_Dungeon[1], Crash_Farm_Dungeon[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff

	break LoopC6
	}
	} until now6 > Menu_Timeout*1000
	
Goto Loop0

^Space::ExitApp
