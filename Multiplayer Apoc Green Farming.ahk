#SingleInstance Force
#InstallMouseHook
CoordMode, pixel, Screen
CoordMode, Mouse, Screen
;Build 20200126
;All pixel coordinates in this section must use the "Screen (less often used)" value.
;Unless otherwise specified, the search range will be a 3x3 box centered on the specified pixel.
;All colours in this section should be of the format 0xRRGGBB
;If the script won't run for you in Windows 10, you need to set your variables, compile the script as an EXE then run the EXE as Administrator.
;Alternitively set the AHK.exe main executable to always run as Administrator.
;Note: To stop the script, either close the script by right clicking the icon in the system tray or press Control+Space

;The amount of time, in minutes, you want the script to wait while in the battle before it decides something has gone wrong and triggers the crash handling.
;(Default := 5)
Battle_Timeout := 5

;The amount of time, in seconds, you want the script to wait in menus before it decides something has gone wrong and triggers the crash handling.
;(Default := 30)
Menu_Timeout := 30

;The amount of time, in milliseconds, the script will wait between finding a pixel and clicking.
;Due to FFRK's habit of drawing menus before they are clickable, setting this bellow 400ms will generally result in the script stalling, if the default causes stalling increase until it stops stalling.
;(Default := 400)
Click_Timeout := 400

;A variable to adjust the "sensitivity" of the Skip Button Detection. The higher it is, the more times it needs to "confirm" the button exists, so will click the button slower, but will be less likely to false trigger. The lower it it, the less times it needs to "confirm" the button exists, so will click the button faster but it might trigger falsely. I highly recommend not lowering it, only increasing it.
;(Default := 3)
Skip_Sensitivity := 3

;A PURPLE pixel on the top right corner of the "(Apocalypse +)" dungeon button.
Apocalypse_Purple := [1805,506,0x41012F]

;A BLUE pixel on the "Enter Dungeon" button.
Enter_Dungeon_Blue := [1664,992,0x0E31CE]

;A BROWN pixel on the "Solo Raid" button.
Solo_Raid_Brown := [1300,611,0x4C1F0F]

;A BLUE pixel on the "Next" button.
Next_Blue := [1588,995,0x0D2ECC]

;A BROWN pixel on the "Remove" button of the first Roaming Warrior.
;This script is intended for farming, if you need to rely on Cloud USB1 this script isn't for you.
;If you really want to use the top RW, change the "Use_RW" variable to 1
Remove_Brown := [1787,524,0x582612]
Use_RW := 0

;A BLUE pixel on the "GO!" button.
Go_Blue := [1591,1001,0x0724B1]

;A YELLOW pixel on the "1" underneath the word "Stamina" or on the word Stamina itself.
;Hint: The pixel should have a red value of FF
;Searches a 50x50 box on the specified pixel.
One_Yellow := [1505,549,0xFFDD8E]

;A BLUE pixel directly above the first "t" in "Begin Battle".
;Make sure it's closer to the top of the button than the top of the "t" so the orange search below works.
;If it stalls on the orange button set the pixel a little higher.
Battle_Blue := [1606,715,0x1F5DE2]

;The a nearby (preferably the same) pixel but the ORANGE of the spend gems dialogue, allow retries when out of stamina.
;In any case it shouldn't spend gems even if it does click as Loop_BattleEnd is looking for white, not blue.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 50 stamina fight if needs be.
Battle_Orange := [1719,756,0xE26B20]

;A BLUE pixel on the "Back" button when you've run out of stamina.
;Get to <=49 Stamina and trigger the stamina refresh dialogue on a 50 stamina fight if needs be.
Back_Blue := [1564,947,0x071D74]

;Differently coloured pixels in the Skip Button
;For best results pick two different blue ones and a white one.
Top_Skip 	:= [1786,938,0x2A3CBE]
Middle_Skip := [1778,966,0xFFFFFF]
Bottom_Skip := [1788,1001,0x051A70]


;A WHITE pixel in the "Next" button text after the battle is won, will be used for all the next buttons.
;The colour code should be 0xFFFFFF unless you've got a really weird setup.
;Black_Loading_Screen_Colour is the black of the loading screen when returning to menu in case your one is weird.
Next_White := [1509,951,0xFFFFFF]
Black_Loading_Screen_Colour := 0x000000

;************************;
;*****Crash Handling*****;
;************************;
;This will enable the macro to recover for when (yes, when) FFRK crashes.
;It can handle either the infinite black loading screen or a total crash to home screen.
;This only works for emulators with a tab-like switcher at the top of the screen, like MeMu.
;However, since this relies on exact positioning, the emulator needs to be at the same position each time.
Enable_Crash_Handle := 1

;This will cause the crash handling to go back and try the next dungeon down for when events add a new MP dungeon if it stalls on finding the Apocalypse_Purple pixel
Enable_Primitive_Event_Update_Handling := 1

;A pixel on the tab that brings up the home screen (not the X, since there is no X you can't close this tab)
Crash_Home_Tab_Pixel := [1421,14,0x6AD4BA]

;A pixel on the X that closes the current tab (this is for the infinite black loading screen crash).
Crash_Close_Pixel := [1461,9,0x797C7D]

;The position of the FFRK launcher icon. For best results, select a WHITE pixel somewhat centered.
;Please note that when you close an app on MeMu it will go to the default launcher, not Nova Launcher
;As such please use the position of the app on the default launcher.
;Searches a 50x50 box on the specified pixel.
Crash_App_Launch := [1774,341,0xFFFFFF]

;A BLUE pixel on the blue "Play" button when FFRK launches.
Crash_Play_Blue := [1513,798,0x1847DB]

;A BROWN pixel on the "Cancel" button when resuming an interrupted fight (This is for the battle load crash).
Crash_Cancel_Brown := [1430,722,0x4A1E11]

;A YELLOW pixel on the Event Dungeons scroll banner, just to the left of the word Event, without moving the home screen after pressing the "Home" button after entering the event dungeons but also while NOT in a battle.
Crash_Home_Scroll_Yellow := [1540,575,0xF2BE49]

;A YELLOW pixel in the word "Battle" when you're "In Battle" in an Event Dungeon.
;To force this screen, enter any Event Battle staging screen, and before going into the battle itself, press "Home".
Crash_Event_Battle_Yellow := [1526,687,0xFEFEAE]

;A WHITE pixel on the white hair of the Bartz lookalike in the "Raid Dungeons" button.
Crash_Raid_Dungeons_White := [1709,99,0xF2FBFE]

;A GREEN pixel on the green hair of the Bartz lookalike in the "Event Dungeons" button.
Crash_Event_Dungeons_Green := [1758,98,0x87F92C]

;A BROWN pixel on the rounded "Back" button on the Raid Dungeons screen.
Crash_Raid_Dungeons_Brown := [1261,1013,0x6C3514]

;The position of the event dungeon banner you wish to farm, 1 being the top banner.
;This is so you only need to get the pixel information for the banners once below and can edit this variable to change which dungeon you wish to farm.
Crash_Farm_Dungeons_Selection := 1

;Any pixel of each of the event dungeon banners, from top to bottom.
Crash_Farm_Dungeon_1 := [1284,300,0x947F84]
Crash_Farm_Dungeon_2 := [1284,506,0x856B92]
Crash_Farm_Dungeon_3 := [1284,688,0x121211]
Crash_Farm_Dungeon_4 := [1284,905,0x261915]

;*******************************************************************;
;**Do not edit below this line unless you know what you are doing.**;
;*****************Or do, I'm a comment, not a cop.******************;
;*******************************************************************;

;Define MenuPixelFinder
MenuPixelFinder(posX,posY,colour_value,crash_handle,menu_timeout,click_timeout,battle_timeout,resumed:=0,battle_crash:=0,expanded:=0,use_rw:=0,look_for_orange:=0,battle_orange1:=0,battle_orange2:=0,battle_orange3:=0,back1:=0,back2:=0) {
	timeout_start := A_TickCount
	loop{
		if(resumed || battle_crash || use_rw){
			return 0
		}
		if(expanded == 0){
		pixelSearch, XX, YY, posX-3, posY-3, posX+3, posY+3, colour_value, 5, Fast RGB
		} else {
		pixelSearch, XX, YY, posX-24, posY-24, posX+24, posY+24, colour_value, 5, Fast RGB
		}
		if(XX != ""){
			sleep click_timeout
			BlockInput, MouseMove
			sleep 100
			MouseClick, Left, posX, posY, 1, 0
			sleep 100
			BlockInput, MouseMoveOff
			return 0
		}
		if(look_for_orange==1){
			pixelSearch, XX, YY, battle_orange1-1, battle_orange2-1, battle_orange1+1, battle_orange2+1, battle_orange3, 5, Fast RGB
			if(XX != ""){
				sleep click_timeout
				BlockInput, MouseMove
				sleep 100
				MouseClick, Left, back1, back2, 1, 0
				sleep 100
				BlockInput, MouseMoveOff
				return 2
		}
			}
		now := A_TickCount-timeout_start
		if(now > menu_timeout*1000 && crash_handle == 1){
			return 1
		}
	}
}

;Menu clickings
Main_Loop:
loop{
	if(MenuPixelFinder(Apocalypse_Purple[1],Apocalypse_Purple[2],Apocalypse_Purple[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1 && Enable_Crash_Handle == 1) {
		if(Enable_Primitive_Event_Update_Handling == 1 && possible_new_event < 10){
			possible_new_event++
		}
		goto CrashHandle
		} else {
			possible_new_event := 0
		}
		
	sleep click_timeout
	if(MenuPixelFinder(Enter_Dungeon_Blue[1],Enter_Dungeon_Blue[2],Enter_Dungeon_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Solo_Raid_Brown[1],Solo_Raid_Brown[2],Solo_Raid_Brown[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Next_Blue[1],Next_Blue[2],Next_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle
		
	sleep click_timeout
	if(MenuPixelFinder(Remove_Brown[1],Remove_Brown[2],Remove_Brown[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash,0,Use_RW) == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle
		
	sleep click_timeout
	
	if(MenuPixelFinder(Go_Blue[1],Go_Blue[2],Go_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash) == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle
		
	battle_crash := 0
	resumed := 0
	what_do_timeout_start := A_TickCount
	
Yellow_Label:
	if(MenuPixelFinder(One_Yellow[1],One_Yellow[2],One_Yellow[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash,1) == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle
	
	
	now := A_TickCount-what_do_timeout_start
	if(now > menu_timeout*2000 && crash_handle == 1)
		goto CrashHandle
	
	what_do := 0
	what_do := MenuPixelFinder(Battle_Blue[1],Battle_Blue[2],Battle_Blue[3],Enable_Crash_Handle,Menu_Timeout,Click_Timeout,Battle_Timeout,resumed,battle_crash,0,0,1,Battle_Orange[1],Battle_Orange[2],Battle_Orange[3],Back_Blue[1],Back_Blue[2])
	if(what_do == 2){
	sleep 10000
	goto Yellow_Label
	}
	
	if(what_do == 1 && Enable_Crash_Handle == 1)
		goto CrashHandle


	;Battle End Detection
	start_timeout := A_TickCount 
	find_white_left := 0
	find_white_middle := 0
	find_white_right := 0
	Loop_BattleEnd:
	loop{
		resumed := 0
		pixelSearch, XX, YY, Bottom_Skip[1]-5, Bottom_Skip[2]-5, Bottom_Skip[1]+5, Bottom_Skip[2]+5, Bottom_Skip[3], 1, Fast RGB
		if(XX = ""){
			find_white_right := 0
		}
		if(XX != ""){
			find_white_right++
		if(find_white_left > Skip_Sensitivity && find_white_middle > Skip_Sensitivity && find_white_right > Skip_Sensitivity) {
			sleep Click_Timeout
			BlockInput, MouseMove
			sleep 100
			MouseClick, Left, Middle_Skip[1], Middle_Skip[2], 1, 0
			BlockInput, MouseMoveOff
			break Loop_BattleEnd
		}
		}
		
		pixelSearch, XX, YY, Top_Skip[1]-5, Top_Skip[2]-5, Top_Skip[1]+5, Top_Skip[2]+5, Top_Skip[3], 1, Fast RGB
		if(XX = ""){
			find_white_left := 0
		}
		if(XX != ""){
			find_white_left++
		if(find_white_left > Skip_Sensitivity && find_white_middle > Skip_Sensitivity && find_white_right > Skip_Sensitivity) {
			sleep Click_Timeout
			BlockInput, MouseMove
			sleep 100
			MouseClick, Left, Middle_Skip[1], Middle_Skip[2], 1, 0
			BlockInput, MouseMoveOff
			break Loop_BattleEnd
		}
		}
		
		
		pixelSearch, XX, YY, Middle_Skip[1]-5, Middle_Skip[2]-5, Middle_Skip[1]+5, Middle_Skip[2]+5, Middle_Skip[3], 1, Fast RGB
		if(XX = ""){
			find_white_middle := 0
		}
		if(XX != ""){
			find_white_middle++
		if(find_white_left > Skip_Sensitivity && find_white_middle > Skip_Sensitivity && find_white_right > Skip_Sensitivity) {
			sleep Click_Timeout
			BlockInput, MouseMove
			sleep 100
			MouseClick, Left, Middle_Skip[1], Middle_Skip[2], 1, 0
			BlockInput, MouseMoveOff
			break Loop_BattleEnd
		}
		}
		
		now := A_TickCount-start_timeout
		if(now > Battle_Timeout*60*1000 && Enable_Crash_Handle = 1){
			Goto CrashHandle
		}
	}
	sleep 250
		
	count2 = 0
	Loop_AfterBattle:
	loop{
		pixelSearch, ZZ, YY, Next_White[1], Next_White[2], Next_White[1], Next_White[2], Black_Loading_Screen_Colour, 1, Fast RGB
		if(ZZ != ""){
			break Loop_AfterBattle
		}
		count = 0
		Loop_AfterBattleClicker:
		loop{
			pixelSearch, XX, YY, Next_White[1]-1, Next_White[2]-1, Next_White[1]+1, Next_White[2]+1, Next_White[3], 2, Fast RGB
			count++
			if(XX !=""){
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
MouseClick, Left, Crash_Home_Tab_Pixel[1], Crash_Home_Tab_Pixel[2], 1, 0
sleep 1000
MouseClick, Left, Crash_Close_Pixel[1], Crash_Close_Pixel[2], 1, 0
sleep 1000
start_timeout := A_TickCount
LoopC1:
Loop{
	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_App_Launch[1]-24, Crash_App_Launch[2]-24, Crash_App_Launch[1]+24, Crash_App_Launch[2]+24, Crash_App_Launch[3], 5, Fast RGB
	if(XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_App_Launch[1], Crash_App_Launch[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC1
	}
} until now > Menu_Timeout*1000

if (now > Menu_Timeout*1000){
Goto CrashHandle
}
start_timeout := A_TickCount 
LoopC2:
Loop{
	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Play_Blue[1]-2, Crash_Play_Blue[2]-2, Crash_Play_Blue[1]+2, Crash_Play_Blue[2]+2, Crash_Play_Blue[3], 2, Fast RGB
	if(XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Play_Blue[1], Crash_Play_Blue[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC2
	}
} until now > Menu_Timeout*1000

if (now > Menu_Timeout*1000){
Goto CrashHandle
}
resumed := 0

start_timeout := A_TickCount
LoopC3:
Loop{
	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Cancel_Brown[1]-2, Crash_Cancel_Brown[2]-2, Crash_Cancel_Brown[1]+2, Crash_Cancel_Brown[2]+2, Crash_Cancel_Brown[3], 2, Fast RGB
	if(XX != ""){
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

if (now > Menu_Timeout*1000){
Goto CrashHandle
}
start_timeout := A_TickCount
LoopC44:
Loop{
	if(resumed = 1){
		break LoopC44
	}
	now := A_TickCount-start_timeout
		
	pixelSearch, XX, YY, Crash_Event_Battle_Yellow[1]-2, Crash_Event_Battle_Yellow[2]-2, Crash_Event_Battle_Yellow[1]+2, Crash_Event_Battle_Yellow[2]+2, Crash_Event_Battle_Yellow[3], 6, Fast RGB
	if(XX != ""){
		battle_crash := 1
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Event_Battle_Yellow[1], Crash_Event_Battle_Yellow[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC44
	}

} until now > Menu_Timeout*1000

start_timeout := A_TickCount
LoopC4:
Loop{
	if(resumed = 1){
		break LoopC4
	}

	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Home_Scroll_Yellow[1]-2, Crash_Home_Scroll_Yellow[2]-2, Crash_Home_Scroll_Yellow[1]+2, Crash_Home_Scroll_Yellow[2]+2, Crash_Home_Scroll_Yellow[3], 6, Fast RGB
	if(XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, Crash_Home_Scroll_Yellow[1], Crash_Home_Scroll_Yellow[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC4
	}
	
} until now > Menu_Timeout*1000

if (now > Menu_Timeout*1000){
Goto CrashHandle
}
start_timeout := A_TickCount
LoopC5:
Loop{
	if(resumed = 1){
		break LoopC5
	}
	if(battle_crash = 1){
		break LoopC5
	}

	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Raid_Dungeons_White[1]-2, Crash_Raid_Dungeons_White[2]-2, Crash_Raid_Dungeons_White[1]+2, Crash_Raid_Dungeons_White[2]+2, Crash_Raid_Dungeons_White[3], 6, Fast RGB
	if(XX != ""){
	sleep click_timeout
	BlockInput, MouseMove
	sleep 100
	MouseClick, Left, Crash_Raid_Dungeons_White[1], Crash_Raid_Dungeons_White[2], 1, 0
	sleep 100
	BlockInput, MouseMoveOff
	break LoopC5
	}
} until now > Menu_Timeout*1000
	
if (now > Menu_Timeout*1000){
Goto CrashHandle
}

if(possible_new_event > 4){
	Crash_Farm_Dungeons_Selection++
}
if (Crash_Farm_Dungeons_Selection > 4) {
Crash_Farm_Dungeons_Selection := 1
}
		
if(Crash_Farm_Dungeons_Selection) == 2 {
	crash_farm_selected := Crash_Farm_Dungeon_2
} else if(Crash_Farm_Dungeons_Selection) == 3 {
	crash_farm_selected := Crash_Farm_Dungeon_3
} else if(Crash_Farm_Dungeons_Selection) == 4 {
	crash_farm_selected := Crash_Farm_Dungeon_4
} else {
	crash_farm_selected := Crash_Farm_Dungeon_1
}

start_timeout := A_TickCount
LoopC6:
Loop{
	if(resumed = 1){
		break LoopC6
	}
	if(battle_crash = 1){
		break LoopC6
	}

	now := A_TickCount-start_timeout
	pixelSearch, XX, YY, Crash_Event_Dungeons_Green[1]-2, Crash_Event_Dungeons_Green[2]-2, Crash_Event_Dungeons_Green[1]+2, Crash_Event_Dungeons_Green[2]+2, Crash_Event_Dungeons_Green[3], 6, Fast RGB
	if(XX != ""){
		sleep click_timeout
		BlockInput, MouseMove
		sleep 100
		MouseClick, Left, crash_farm_selected[1], crash_farm_selected[2], 1, 0
		sleep 100
		BlockInput, MouseMoveOff
		break LoopC6
	}
} until now > Menu_Timeout*1000
if (now > Menu_Timeout*1000){
Goto CrashHandle
}
Goto Main_Loop

^Space::ExitApp
