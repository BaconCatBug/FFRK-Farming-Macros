#SingleInstance Force
#InstallMouseHook
CoordMode, pixel, Screen
CoordMode, Mouse, Screen

;All pixel coordinates in this section must use the "Screen (less often used)" value.
;Unless otherwise specified, the search range will be a 3x3 box centered on the specified pixel.
;All colours in this section should be of the format 0xRRGGBB
;If the script won't run for you in Windows 10, you need to set your variables, compile the script as an EXE then run the EXE as Administrator.
;Alternitively set the AHK.exe main executable to always run as Administrator.

;The amount of time, in minutes, you want the script to wait while in the battle before it decides something has gone wrong and triggers the crash handling.
;(Default := 5)
Battle_Timeout := 4

;The amount of time, in seconds, you want the script to wait in menus before it decides something has gone wrong and triggers the crash handling.
;(Default := 30)
Menu_Timeout := 30

;The amount of time, in milliseconds, the script will wait between finding a pixel and clicking.
;Due to FFRK's habit of drawing menus before they are clickable, setting this bellow 350ms will generally result in the script stalling, if the default causes stalling increase until it stops stalling.
;(Default := 350)
Click_Timeout := 350

;A PURPLE pixel on the top right corner of the "(Apocalypse +)" dungeon button.
Apocalypse_Purple := [1802,513,0x270625]

;A BLUE pixel on the "Enter Dungeon" button.
Enter_Dungeon_Blue := [1792,955,0x0D2ECC]

;A BROWN pixel on the "Solo Raid" button.
Solo_Raid_Brown := [1324,587,0x4B1F0F]

;A BLUE pixel on the "Next" button.
Next_Blue := [1631,959,0x0725B4]

;A BROWN pixel on the "Remove" button of the first Roaming Warrior.
;This script is intended for farming, if you need to rely on Cloud USB1 this script isn't for you.
;If you really want to use the top RW, change the "Use_RW" variable to 1
Remove_Brown := [1822,502,0x582612]
Use_RW := 0

;A BLUE pixel on the "GO!" button.
Go_Blue := [1627,952,0x1238D2]

;A YELLOW pixel on the "1" underneath the word "Stamina".
;Searches a 50x50 box on the specified pixel.
One_Yellow := [1524,510,0xFFDD8E]

;A BLUE pixel directly above the first "t" in "Begin Battle".
;Make sure it's closer to the top of the button than the top of the "t" so the orange search below works.
;If it stalls on the orange button set the pixel a little higher.
Battle_Blue := [1718,658,0x1F76E2]

;The same pixel but the ORANGE of the spend gems dialogue, to enter slow mode when out of stamina.
;The macro should work without you changing this thanks to variation matching but it's worth double checking.
;In any case it shouldn't spend gems even if it does click as Loop_BattleEnd is looking for red, not blue.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 50 stamina fight if needs be.
Battle_Orange := 0xDE701E 

;A BLUE pixel on the "Back" button when you've run out of stamina.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 50 stamina fight if needs be.
Back_Blue := [1526,841,0x02186E]

;A WHITE pixel in the bottom right corner border of the Battle Results Screen (the one with the Champion Rainbow bar, so it detects the end of the battle).
;The colour code should be 0xFFFFFF unless you've got a really weird setup.
;Searches a 50x50 box on the specified pixel.
Corner_White := [1865,986,0xFFFFFF]

;A WHITE pixel in the "Next" button text after the battle is won, will be used for all the next buttons.
;The colour code should be 0xFFFFFF unless you've got a really weird setup.
;Black_Loading_Screen_Colour is the black of the loading screen when returning to menu in case your one is weird.
Next_White := [1543,921,0xFFFFFF]
Black_Loading_Screen_Colour := 0x000000

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
;Searches a 50x50 box on the specified pixel.
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
Crash_Farm_Dungeon := [1541,475,0xFED735]

;*******************************************************************;
;**Do not edit below this line unless you know what you are doing.**;
;*****************Or do, I'm a comment, not a cop.******************;
;*******************************************************************;

;Define MenuPixelFinder
MenuPixelFinder(posX,posY,colour_value,crash_handle,menu_timeout,click_timeout,battle_timeout,resumed:=0,battle_crash:=0,expanded:=0,use_rw:=0) {
	timeout_start := A_TickCount
	loop{
		if (resumed || battle_crash || use_rw){
			return 0
		}
		if(expanded == 0){
		pixelSearch, XX, YY, posX-1, posY-1, posX+1, posY+1, colour_value, 5, Fast RGB
		} else {
		pixelSearch, XX, YY, posX-24, posY-24, posX+24, posY+24, colour_value, 5, Fast RGB
		}
		if (XX != ""){
			sleep click_timeout
			BlockInput, MouseMove
			sleep 100
			MouseClick, Left, posX, posY, 1, 0
			sleep 100
			BlockInput, MouseMoveOff
			return 0
		}
		now := A_TickCount-timeout_start
		if (now > menu_timeout*1000 && crash_handle == 1){
			return 1
		}
	}
}

;Menu clickings
Main_Loop:
loop{
	if(MenuPixelFinder(Apocalypse_Purple[1],Apocalypse_Purple[2],Apocalypse_Purple[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Enter_Dungeon_Blue[1],Enter_Dungeon_Blue[2],Enter_Dungeon_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Solo_Raid_Brown[1],Solo_Raid_Brown[2],Solo_Raid_Brown[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Next_Blue[1],Next_Blue[2],Next_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Remove_Brown[1],Remove_Brown[2],Remove_Brown[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash,Use_RW) == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Go_Blue[1],Go_Blue[2],Go_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1)
		goto CrashHandle
		
	battle_crash := 0
	resumed := 0

	if(MenuPixelFinder(One_Yellow[1],One_Yellow[2],One_Yellow[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash,1) == 1)
		goto CrashHandle

	if(MenuPixelFinder(Battle_Blue[1],Battle_Blue[2],Battle_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1)
		goto CrashHandle


	;Battle End Detection
	start_timeout := A_TickCount 
	find_white := 0
	Loop_BattleEnd:
	loop{
		resumed := 0
		pixelSearch, XX, YY, Corner_White[1], Corner_White[2], Corner_White[1], Corner_White[2], Corner_White[3], 1, Fast RGB
		if (XX = ""){
			find_white := 0
		}
		if (XX != ""){
			find_white++
		if (find_white>20) {
			sleep Click_Timeout
			BlockInput, MouseMove
			sleep 100
			MouseClick, Left, Next_White[1], Next_White[2], 1, 0
			BlockInput, MouseMoveOff
			break Loop_BattleEnd
		}
		}
		now := A_TickCount-start_timeout
		if (now > Battle_Timeout*60*1000 && Enable_Crash_Handle = 1){
			Goto CrashHandle
		}
	}
	sleep 250
		
	count2 = 0
	Loop_AfterBattle:
	loop{
		pixelSearch, ZZ, YY, Next_White[1], Next_White[2], Next_White[1], Next_White[2], Black_Loading_Screen_Colour, 1, Fast RGB
		if (ZZ != ""){
			break Loop_AfterBattle
		}
		count = 0
		Loop_AfterBattleClicker:
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
				break Loop_AfterBattleClicker
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
start_timeout := A_TickCount
LoopC1:
Loop{
	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_App_Launch[1]-24, Crash_App_Launch[2]-24, Crash_App_Launch[1]+24, Crash_App_Launch[2]+24, Crash_App_Launch[3], 5, Fast RGB
	if (XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_App_Launch[1], Crash_App_Launch[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC1
	}
} until now > Menu_Timeout*1000
	
start_timeout := A_TickCount 
LoopC2:
Loop{
	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Play_Blue[1]-2, Crash_Play_Blue[2]-2, Crash_Play_Blue[1]+2, Crash_Play_Blue[2]+2, Crash_Play_Blue[3], 2, Fast RGB
	if (XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Play_Blue[1], Crash_Play_Blue[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC2
	}
} until now > Menu_Timeout*1000

resumed := 0

start_timeout := A_TickCount
LoopC3:
Loop{
	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Cancel_Brown[1]-2, Crash_Cancel_Brown[2]-2, Crash_Cancel_Brown[1]+2, Crash_Cancel_Brown[2]+2, Crash_Cancel_Brown[3], 2, Fast RGB
	if (XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Cancel_Brown[1], Crash_Cancel_Brown[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		resumed := 1
		break LoopC3
	}
} until now > 10000

start_timeout := A_TickCount
LoopC4:
Loop{
	if (resumed = 1){
		break LoopC4
	}

	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Home_Screen_Yellow[1]-2, Crash_Home_Screen_Yellow[2]-2, Crash_Home_Screen_Yellow[1]+2, Crash_Home_Screen_Yellow[2]+2, Crash_Home_Screen_Yellow[3], 6, Fast RGB
	if (XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Home_Screen_Yellow[1], Crash_Home_Screen_Yellow[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC4
	}
	
	pixelSearch, XX, YY, Crash_Event_Battle_Yellow[1]-2, Crash_Event_Battle_Yellow[2]-2, Crash_Event_Battle_Yellow[1]+2, Crash_Event_Battle_Yellow[2]+2, Crash_Event_Battle_Yellow[3], 6, Fast RGB
	if (XX != ""){
		battle_crash := 1
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Event_Battle_Yellow[1], Crash_Event_Battle_Yellow[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC4
	}
} until now > Menu_Timeout*1000

start_timeout := A_TickCount
LoopC5:
Loop{
	if (resumed = 1){
		break LoopC5
	}
	if (battle_crash = 1){
		break LoopC5
	}

	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Raid_Dungeons_White[1]-2, Crash_Raid_Dungeons_White[2]-2, Crash_Raid_Dungeons_White[1]+2, Crash_Raid_Dungeons_White[2]+2, Crash_Raid_Dungeons_White[3], 6, Fast RGB
	if (XX != ""){
	sleep click_timeout
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Raid_Dungeons_White[1], Crash_Raid_Dungeons_White[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC5
	}
} until now > Menu_Timeout*1000
	
	
start_timeout := A_TickCount
LoopC6:
Loop{
	if (resumed = 1){
		break LoopC6
	}
	if (battle_crash = 1){
		break LoopC6
	}

	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Event_Dungeons_Green[1]-2, Crash_Event_Dungeons_Green[2]-2, Crash_Event_Dungeons_Green[1]+2, Crash_Event_Dungeons_Green[2]+2, Crash_Event_Dungeons_Green[3], 6, Fast RGB
	if (XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Farm_Dungeon[1], Crash_Farm_Dungeon[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC6
	}
} until now > Menu_Timeout*1000
	
Goto Main_Loop

^Space::ExitApp
