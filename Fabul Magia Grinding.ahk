#SingleInstance Force
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

;SetWorkingDir %A_ScriptDir%
;if not A_IsAdmin
	;Run *RunAs "%A_ScriptFullPath%"
	
;A Yellow Pixel on the "Champion" image of Fabul Castle - 1st Battle.
;This will search a 5x5 square centered on the given pixel for the given colour.
;All colours in this section should be of the format 0xRRGGBB
Loop1_Pixel_X = 1428
Loop1_Pixel_Y = 653
Loop1_Pixel_C = 0xF9ED5D


;A Blue Pixel directly above the first "t" in "Begin Battle".
;This will search a 2x2 square, with top left corner on the provided values.
Loop2_Pixel_X = 1712
Loop2_Pixel_Y = 644
Loop2_Pixel_C = 0x197DEE

;The same Pixel but the orange of the spend gems dialog, to exit the macro when you're out of stamina.
;The macro should work without you changing this thanks to variation matching but it's worth double checking.
;In any case it shouldn't spend gems even if it does click as Loop3 is looking for red, not blue.
Loop2_Pixel_O = 0xE26B20

;A Red pixel on the Champion Rainbow bar (so it clicks and skips the exp scrolling)
;This will search a 1x1 square centered on the given pixel for the given colour.
Loop3_Pixel_X = 1813
Loop3_Pixel_Y = 556
Loop3_Pixel_C = 0xFF4B01

;A White Pixel in the "Next" button text, will be used for all the next buttons
;This will search a 3x3 square centered on the given pixel for the given colour.
Loop4Plus_Pixel_X = 1521
Loop4Plus_Pixel_Y = 898
Loop4Plus_Pixel_C = 0xFFFFFF

Loop0:
loop{	
	Loop1:
	loop{
		;tooltip, 1
		PixelSearch, XX, YY, %Loop1_Pixel_X%-3, %Loop1_Pixel_Y%-3, %Loop1_Pixel_X%+2, %Loop1_Pixel_Y%+2, %Loop1_Pixel_C%, 1, Fast, RGB
		if (XX !=""){
		sleep 150
		MouseClick, Left, %Loop1_Pixel_X%, %Loop1_Pixel_Y%, 1, 0
		break Loop1
		}
		sleep 1
		}
		sleep 600

	Loop2:
	loop{
		;tooltip, 2
		PixelSearch, ZZ, YY, %Loop2_Pixel_X%, %Loop2_Pixel_Y%, %Loop2_Pixel_X%+1, %Loop2_Pixel_Y%+1, %Loop2_Pixel_O%, 5, Fast, RGB
		if (ZZ !=""){
		SoundBeep, 523, 250
		SoundBeep, 523, 250
		exitapp
		}
		
		PixelSearch, XX, YY, %Loop2_Pixel_X%, %Loop2_Pixel_Y%, %Loop2_Pixel_X%+1, %Loop2_Pixel_Y%+1, %Loop2_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 150
		MouseClick, Left, %Loop2_Pixel_X%, %Loop2_Pixel_Y%, 1, 0
		break Loop2
		}
		sleep 1
		}
		sleep 500

	Loop3:
	loop{
		;tooltip, 3
		PixelSearch, XX, YY, %Loop3_Pixel_X%, %Loop3_Pixel_Y%, %Loop3_Pixel_X%, %Loop3_Pixel_Y%, %Loop3_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 500
		MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
		break Loop3
		}
		sleep 1
		}
		sleep 500

	Loop4:
	loop{
		;tooltip, 4
		PixelSearch, XX, YY, %Loop4Plus_Pixel_X%-1, %Loop4Plus_Pixel_Y%-1, %Loop4Plus_Pixel_X%+1, %Loop4Plus_Pixel_Y%+1, %Loop4Plus_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 500
		MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
		break Loop4
		}
		sleep 1
		}
		sleep 750

	MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
	count = 0
	Loop5:
	loop{
		;tooltip, 5
		count++
		PixelSearch, XX, YY, %Loop4Plus_Pixel_X%-1, %Loop4Plus_Pixel_Y%-1, %Loop4Plus_Pixel_X%+1, %Loop4Plus_Pixel_Y%+1, %Loop4Plus_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 500
		MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
		break Loop5
		}
		sleep 1
		} until count > 10
		sleep 750
		
	MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
	count = 0
	Loop6:
	loop{
		;tooltip, 6
		count++
		PixelSearch, XX, YY, %Loop4Plus_Pixel_X%-1, %Loop4Plus_Pixel_Y%-1, %Loop4Plus_Pixel_X%+1, %Loop4Plus_Pixel_Y%+1, %Loop4Plus_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 500
		MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
		break Loop6
		}
		sleep 1
		} until count > 10
		sleep 750
		
	MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
	count = 0
	Loop7:
	loop{
		;tooltip, 7
		count++
		PixelSearch, XX, YY, %Loop4Plus_Pixel_X%-1, %Loop4Plus_Pixel_Y%-1, %Loop4Plus_Pixel_X%+1, %Loop4Plus_Pixel_Y%+1, %Loop4Plus_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 500
		MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
		break Loop7
		}
		sleep 1
		} until count > 10
		sleep 750
	MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
	
	count = 0
	Loop8:
	loop{
		;tooltip, 8
		count++
		PixelSearch, XX, YY, %Loop4Plus_Pixel_X%-1, %Loop4Plus_Pixel_Y%-1, %Loop4Plus_Pixel_X%+1, %Loop4Plus_Pixel_Y%+1, %Loop4Plus_Pixel_C%, 2, Fast, RGB
		if (XX !=""){
		sleep 500
		MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
		break Loop8
		}
		sleep 1
		} until count > 10
		sleep 750
	MouseClick, Left, %Loop4Plus_Pixel_X%, %Loop4Plus_Pixel_Y%, 1, 0
}

^Space::exitapp