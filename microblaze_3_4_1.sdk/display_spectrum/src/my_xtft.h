/*
 * my_xtft.h
 *
 *  Created on: 2018��6��19��
 *      Author: AsFrG
 */

#ifndef SRC_MY_XTFT_H_
#define SRC_MY_XTFT_H_

#include "xtft.h"
#include "xstatus.h"
#include "xtft_hw.h"

void my_XTft_WriteChar(XTft* InstancePtr, u8 CharValue,
				u32 ColStartVal, u32 RowStartVal, u32 FgColor,
				u32 BgColor);

#endif /* SRC_MY_XTFT_H_ */
