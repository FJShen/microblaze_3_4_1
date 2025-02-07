/*
 * my_xtft.c
 *
 *  Created on: 2018��6��19��
 *      Author: AsFrG
 */

#include "xtft.h"
#include "my_xtft_charcode.h"

void my_XTft_WriteChar(XTft* InstancePtr,
			u8 CharValue,
			u32 ColStartVal,
			u32 RowStartVal,
			u32 FgColor,
			u32 BgColor)
{
	u32 PixelVal;
	u32 ColIndex;
	u32 RowIndex;
	u8 BitMapVal;

	/*
	 * Assert validates the input arguments.
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(ColStartVal <= (XTFT_DISPLAY_WIDTH - 1));
	Xil_AssertVoid(RowStartVal <= (XTFT_DISPLAY_HEIGHT - 1));

	/*
	 * Checks whether the given character value is more than or equal to
	 * space character value, as our character array starts with space.
	 */
	Xil_AssertVoid((u32) CharValue >= XTFT_ASCIICHAR_OFFSET);

	/*
	 * Gets the 12 bit value from the character array defined in
	 * charcode.c file and regenerates the bitmap of that character.
	 * It draws that character on screen by setting the pixel either
	 * with the foreground or background color depending on
	 * whether value is 1 or 0.
	 */
	for (RowIndex = 0; RowIndex < XTFT_CHAR_HEIGHT; RowIndex++) {
		BitMapVal = my_XTft_VidChars[(u32) CharValue -
					XTFT_ASCIICHAR_OFFSET][RowIndex];
		for (ColIndex = 0; ColIndex < XTFT_CHAR_WIDTH; ColIndex++) {
			if (BitMapVal &
				(1 << (XTFT_CHAR_WIDTH - ColIndex - 1))) {
				PixelVal = FgColor;
			} else {
				PixelVal = BgColor;
			}

			/*
			 * Sets the color value to pixel.
			 */
			XTft_SetPixel(InstancePtr, ColStartVal+ColIndex,
					RowStartVal+RowIndex, PixelVal);
		}
	}
	return;

}
