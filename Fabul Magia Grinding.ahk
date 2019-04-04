#SingleInstance Force
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

;SetWorkingDir %A_ScriptDir%
;if not A_IsAdmin
	;Run *RunAs "%A_ScriptFullPath%"
	
;A Yellow Pixel on the "Champion" image of Fabul Castle - 1st Battle.
;This will search a 3x3 square centered on the given pixel for the given colour.
;All colours in this section should be of the format 0xRRGGBB
Loop1_Pixel_X = 1476
Loop1_Pixel_Y = 649
Loop1_Pixel_C = 0xF9ED5D


;A Blue Pixel directly above the first "t" in "Begin Battle".
;This will search a 2x2 square, with top left corner on the provided values.
Loop2_Pixel_X = 1757
Loop2_Pixel_Y = 646
Loop2_Pixel_C = 0x1A73ED 

;The same Pixel but the orange of the spend gems dialog, to exit the macro when you're out of stamina.
;The macro should work without you changing this thanks to variation matching but it's worth double checking.
;In any case it shouldn't spend gems even if it does click as Loop3 is looking for red, not blue.
Loop2_Pixel_O = 0xE26B20

;A Red pixel on the Champion Rainbow bar (so it clicks and skips the exp scrolling)
;This will search a 1x1 square centered on the given pixel for the given colour.
Loop3_Pixel_X = 1856
Loop3_Pixel_Y = 555
Loop3_Pixel_C = 0xFF4B01

;A White Pixel in the "Next" button text, will be used for all the next buttons
;This will search a 3x3 square centered on the given pixel for the given colour.
Loop4Plus_Pixel_X = 1568
Loop4Plus_Pixel_Y = 895
Loop4Plus_Pixel_C = 0xFFFFFF

Loop0:
loop{	
	Loop1:
	loop{
		;tooltip, 1
		PixelSearch, XX, YY, Loop1_Pixel_X-1, Loop1_Pixel_Y-1, Loop1_Pixel_X+1, Loop1_Pixel_Y+1, %Loop1_Pixel_C%, 1, Fast, RGB
		
		if (XX !=""){
		sleep 500
		MouseClick, Left, Loop1_Pixel_X, Loop1_Pixel_Y, 1, 0
		break Loop1
		}
		sleep 1
		}
		sleep 600

	Loop2:
	loop{
		;tooltip, 2
		PixelSearch, ZZ, YY, Loop2_Pixel_X, Loop2_Pixel_Y, Loop2_Pixel_X+1, Loop2_Pixel_Y+1, Loop2_Pixel_O, 5, Fast, RGB
		if (ZZ !=""){
		SoundBeep, 523, 250
		SoundBeep, 523, 250
		exitapp
		}
		
		PixelSearch, XX, YY, Loop2_Pixel_X, Loop2_Pixel_Y, Loop2_Pixel_X+1, Loop2_Pixel_Y+1, Loop2_Pixel_C, 2, Fast, RGB
		if (XX !=""){
		sleep 150
		MouseClick, Left, Loop2_Pixel_X, Loop2_Pixel_Y, 1, 0
		break Loop2
		}
		sleep 1
		}
		sleep 250

	Loop3:
	loop{
		;tooltip, 3
		PixelSearch, XX, YY, Loop3_Pixel_X, Loop3_Pixel_Y, Loop3_Pixel_X, Loop3_Pixel_Y, Loop3_Pixel_C, 2, Fast, RGB
		if (XX !=""){
		sleep 250
		MouseClick, Left, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 1, 0
		break Loop3
		}
		sleep 1
		}
		sleep 250

	count2 = 0
	LoopB:
	loop{
		
		PixelSearch, ZZ, YY, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 0x000000, 0, Fast, RGB
		;tooltip, ZZ
		if (ZZ !=""){
		break LoopB
		}
		count = 0
		Loop4:
		loop{
			;tooltip, 4
			PixelSearch, XX, YY, Loop4Plus_Pixel_X-1, Loop4Plus_Pixel_Y-1, Loop4Plus_Pixel_X+1, Loop4Plus_Pixel_Y+1, Loop4Plus_Pixel_C, 2, Fast, RGB
			count++
			if (XX !=""){
			MouseClick, Left, Loop4Plus_Pixel_X, Loop4Plus_Pixel_Y, 1, 0
			sleep 100
			;tooltip, %count%
			break Loop4
			}
			sleep 1
			count2++
			} until count >10 
		;tooltip, %count2%
		} until count2 > 100
		;tooltip, Jobs Done
		sleep 750
}

^Space::exitapp