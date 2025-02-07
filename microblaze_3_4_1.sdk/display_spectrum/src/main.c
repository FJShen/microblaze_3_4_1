/*
 * main.c
 *
 *  Created on: 2018��6��6��
 *      Author: AsFrG
 */


/*
 * top_hw_platform_3: without windowing
 * top_hw_platform_4: with 2048-point Hamming windowing.
 * top_hw_platform_5: with Hamming window, plus 32 frame averaging module
 * top_hw_platform_6: updated FIR, dismissed floating-point sqrt module
 */


#include "xparameters.h"
#include "xsysmon.h"
#include "xil_exception.h"
//#include "microblaze_sleep.h"
//#include "sleep.h"
#include "math.h"
#include "stdio.h"
#include "xil_printf.h"
#include <stdio.h>
#include "malloc.h"
#include "xtft.h"
#include "my_xtft.h"
#include "color.h"
#include "xgpio.h"
/************************** Constant Definitions ****************************/
/*
* The following constants map to the XPAR parameters created in the
* xparameters.h file. They are defined here such that a user can easily
* change all the needed parameters in one place.
*/
#define XADC_DEVICE_ID XPAR_XADC_WIZ_0_DEVICE_ID
#define XADC_CHANNEL (XSM_CH_AUX_MIN + 3)
#define ADC_CONVERT_TO_ACTUAL(Vadc) (Vadc/0.09157)
#define FFT_ADDR 0
#define FFT_ADDR_1 XPAR_HIER_MOD_DATA_1_AXI_BRAM_CTRL_MOD_READ_S_AXI_BASEADDR
#define FFT_ADDR_2 XPAR_HIER_MOD_DATA_2_AXI_BRAM_CTRL_MOD_READ_S_AXI_BASEADDR
#define TFT_FRAME_ADDR_1	0x87E00000//XPAR_AXI_TFT_0_DEFAULT_TFT_BASE_ADDR//XPAR_MIG_7SERIES_0_HIGHADDR - 0x001FFFFF
#define TFT_FRAME_ADDR_2 	0x87C00000

/**************************** Type Definitions ******************************/
/***************** Macros (Inline Functions) Definitions ********************/
/************************** Function Prototypes *****************************/
int XAdc_Init(void);
int XAdc_OtainAdcVoltage(void);
void activate_dtmv_transc();
void fetch_spectrum(char*, int);
void draw_spectrum();
void draw_spectrogram();
void draw_sepctrogram_scan_mode(int fft_source);
void XTft_Init(XTft*);
void draw_line(int row);
void XGpio_Init();
#define XSysMon_RawToTemperature(AdcData)				\
	((((float)(AdcData)/65536.0f)/0.00198421639f ) - 273.15f)
/************************** Variable Definitions ****************************/
static XSysMon XAdcInst; /* XADC driver instance */
static XTft TftInstance;
static XGpio GpioInst;
static XGpio_Config* GpioCfg;
static short height[640]={};
static int col;
/****************************************************************************/
/**
* Main function
*
*****************************************************************************/

int main(void)
{

	short ADC_volt=0;
	u16 temp;
	int temp_conv;
	int previous_frame=2;


	print("start init\n\r");
	XAdc_Init();
	XTft_Init(&TftInstance);
	XGpio_Init();

	xil_printf("********Simple Voltage meter********\n\r");


	while(1)
	{
		int switches = XGpio_DiscreteRead(&GpioInst, 1);
		int fft_source = (switches & 0x1);
		int disp_mode = (switches & 0x2);

		ADC_volt = XAdc_OtainAdcVoltage();
		temp = XSysMon_GetAdcData(&XAdcInst, XSM_CH_TEMP);
		temp_conv = XSysMon_RawToTemperature(temp);
		//activate_dtmv_transc();
		xil_printf("XADC read = %d V  temperature = %dC\n\r",ADC_volt,temp_conv);


		/*if (fft_source==0)
			xil_printf("low ");
		else xil_printf("high ");

		xil_printf("resolution, ");
*/
		if(disp_mode == 0){
			if(previous_frame==2){
				previous_frame = 1;
				XTft_SetFrameBaseAddr(&TftInstance, TFT_FRAME_ADDR_1);
				XTft_ClearScreen(&TftInstance);
				col=0;
			}
			draw_sepctrogram_scan_mode(fft_source);
			//xil_printf("spectrogram\n\r");
		}
		else{
			if(previous_frame==1){
				previous_frame = 2;
				XTft_SetFrameBaseAddr(&TftInstance, TFT_FRAME_ADDR_2);
			}
			draw_spectrum(fft_source);
			//xil_printf("spectrum\n\r");
		}

	}

	//free(buffer_ptr);
	return 0;
}
/****************************************************************************/
/*
*
* This function initializes the XADC for Single Channel mode
*
* The function does the following tasks:
* - Initiate the XADC device driver instance
* - Enter into safe mode
* - Enable ADC channel AD14
* - Set the number of samples of averaging
* - Enable averaging
* - Set Single Channel mode
* - XST_FAILURE if the example has failed.
*
****************************************************************************/
int XAdc_Init(void)
{
	XSysMon_Config *ConfigPtr;
	int status;
	/*
	* Initialize the XAdc driver.
	*/
	ConfigPtr = XSysMon_LookupConfig(XADC_DEVICE_ID);
	if (ConfigPtr == NULL) {
		xil_printf("failed to lookup config\n\r");
		return XST_FAILURE;
	}
	xil_printf("succeeded to lookup config\n\r");

	status=XSysMon_CfgInitialize(&XAdcInst, ConfigPtr, ConfigPtr->BaseAddress);
	xil_printf("CfgInitialize status = %d\n\r", status);

	XSysMon_SetSequencerMode(&XAdcInst, XSM_SEQ_MODE_SAFE);
	xil_printf("SetSequencerMode status = %d\n\r", status);

	status=XSysMon_SetSeqChEnables(&XAdcInst, XSM_SEQ_CH_AUX03);//The sequencer must be in the Safe Mode before writing to these registers.
	xil_printf("SetSeqChEnable status = %d\n\r", status);

	XSysMon_SetAvg(&XAdcInst, XSM_AVG_0_SAMPLES);
	xil_printf("XSysMon_SetAvg status = %d\n\r", status);

	status=XSysMon_SetSeqAvgEnables(&XAdcInst, XSM_SEQ_CH_AUX03);
	xil_printf("XSysMon_SetSeqAvgEnables status = %d\n\r", status);

	short i;
	for(i=0; i<32767; i++);

	XSysMon_SetSequencerMode(&XAdcInst, XSM_SEQ_MODE_INDEPENDENT);
	//XSysMon_SetSequencerMode(&XAdcInst, XSM_SEQ_MODE_SIMUL);

	/*
	 * By writing all 1's to register to set all channels to bipolar mode
	 */
	XSysMon_SetSeqInputMode(&XAdcInst, 0xffffffff);
	//xil_printf("XSysMon_SetSequencerMode status = %d\n\r", status);


	return XST_SUCCESS;
}


void XTft_Init(XTft* TftInstance){
	XTft_Config *TftConfigPtr;

	/*
	 * Get address of the XTft_Config structure for the given device id.
	 */
	TftConfigPtr = XTft_LookupConfig(XPAR_TFT_0_DEVICE_ID);
	if (TftConfigPtr == (XTft_Config *)NULL) {
		return XST_FAILURE;
	}

	/*
	 * Initialize all the TftInstance members and fills the screen with
	 * default background color.
	 */
	int Status = XTft_CfgInitialize(TftInstance, TftConfigPtr,
				 	TftConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	while (XTft_GetVsyncStatus(TftInstance) !=
						XTFT_IESR_VADDRLATCH_STATUS_MASK);
	XTft_SetFrameBaseAddr(TftInstance, TFT_FRAME_ADDR_1);
	xil_printf("Clearing screen 1\n\r");
	XTft_ClearScreen(TftInstance);

	XTft_SetFrameBaseAddr(TftInstance, TFT_FRAME_ADDR_2);
	xil_printf("Clearing screen 2\n\r");
	XTft_ClearScreen(TftInstance);

	xil_printf("Finish clearing screen\n\r");
}


void XGpio_Init(){
	GpioCfg = XGpio_LookupConfig(XPAR_GPIO_0_DEVICE_ID);
	XGpio_CfgInitialize(&GpioInst, GpioCfg, XPAR_GPIO_0_BASEADDR);
}


/****************************************************************************/
/*
*
* This function obtain a ADC readings from the auxiliary channel specified by
* XADC_CHANNEL and converts it into voltage.
*
* @param None.
* @return Voltage of the auxiliary channel
*
****************************************************************************/
int XAdc_OtainAdcVoltage(void)
{
	int ADC_Data;
	/*
	* Note: The ADC always produce a 16-bit conversion result.
	* The 12-bit data correspond to the 12 MSBs (most significant) in the 16-bit status registers.
	* The unreferenced LSBs can be used to minimize quantization effects or improve resolution
	* through averaging or filtering.
	*/
	ADC_Data = XSysMon_GetAdcData(&XAdcInst, XADC_CHANNEL);
	return ADC_Data;
}

/*
 * Write spectrum data to buffer. Interval stands for the interval between the points to print from the spectrum
 * i.e.: interval = 3 <==> print X[0],X[3],X[6],... to buffer
 */
/*void fetch_spectrum(char* buffer, int interval)
{
	buffer = (char*)realloc(buffer, (5+1)*1024/interval*sizeof(char)+sizeof(char));
	char* current = buffer;
	int i;
	int N = 1024/interval;
	int value;
	for(i=0; i<N; i++)
	{
		value = Xil_In32(FFT_ADDR+i*interval*4);
		current+=sprintf(current, "%5d ", value);
	}
	sprintf(current, "\0");
}*/


void draw_spectrum(int fft_source)
{
	short i,j;
	int value;
	float value_f;
	int max_index=0;
	int max_value=0;
	int current_height;
	unsigned int fft_addr = (fft_source==0)?FFT_ADDR_1:FFT_ADDR_2;
	for(i=0; i<640; i++)
	{
		//clear the previous dot
		//Xil_Out32(TFT_FRAME_ADDR+i*4+1024*4*(height[i]), 0x0);

		//calculate the current height
		value = Xil_In32(fft_addr+i*4); //0<=value<=46332^2

		/*if(value>max_value){
			max_value = value;
			max_index = i;
		}*/

		value_f = (float)value;
		value_f = log10(value_f+1)*50+25; //0<100*log10(value+1)<467
		value = (int)value_f;
		current_height = (int)value_f;

		if(current_height>height[i])
		{
			for(j=height[i]; j<current_height; j++)
				Xil_Out32(TFT_FRAME_ADDR_2+i*4+1024*4*(480-j), 0xffff);
		}
		else
		{
			for(j=current_height; j<height[i]; j++)
				Xil_Out32(TFT_FRAME_ADDR_2+i*4+1024*4*(480-j), 0x0);
		}
		height[i]=current_height;
		//xil_printf("%d, %d\n\r", i, value);
		//Xil_Out32(TFT_FRAME_ADDR+i*4+1024*4*(value), 0xffff);
	}

	//xil_printf("max idx %d, max value %d\n\r", max_index, max_value);

	return;
}

/*
void draw_spectrogram()
{
	int row, col;
	//XTft_SetFrameBaseAddr(&TftInstance, SCROLL_FRAME_2);
	//draw frame 1
		//copy from frame 2
		for(row=0; row<480; row++){
			for(col = 1; col<640; col++){
				int temp = Xil_In32(SCROLL_FRAME_2+(row<<12)+(col<<2));
				Xil_Out32(SCROLL_FRAME_1+(row<<12)+((col-1)<<2), temp);
			}
		}
		//add last col
		for(row=0; row<480; row++){
			col = 639;
			int value = Xil_In32(FFT_ADDR+(row<<2)); //0<value<46632^2
			float value_f = (float)value;
			value_f = log10(value_f+1)*100;//0<log10(value_f+1)*100<467
			value_f = 240-(value_f/467*240);
			value = (int)value_f;
			Xil_Out32(SCROLL_FRAME_1+(row<<12)+(col<<2), hue2rgb(value));
			//xil_printf("%x ", hue2rgb(value));
		}
		xil_printf("\n\r");
	//set display frame 1
	XTft_SetFrameBaseAddr(&TftInstance, SCROLL_FRAME_1);
	//draw frame 2
		//copy from frame 1
		for(row=0; row<480; row++){
			for(col = 1; col<640; col++){
				int temp = Xil_In32(SCROLL_FRAME_1+(row<<12)+(col<<2));
				Xil_Out32(SCROLL_FRAME_2+(row<<12)+((col-1)<<2), temp);
			}
		}
		//draw last col
		for(row=0; row<480; row++){
			col = 639;
			int value = Xil_In32(FFT_ADDR+(row<<2));
			float value_f = (float)value;
			value_f = log10(value_f+1)*100;//0<log10(value_f+1)*100<467
			value_f = 240-(value_f/467*240);
			value = (int)value_f;
			Xil_Out32(SCROLL_FRAME_2+(row<<12)+(col<<2), hue2rgb(value));
			//xil_printf("%x ", hue2rgb(value));
		}
		xil_printf("\n\r");
	//set display frame 2
	XTft_SetFrameBaseAddr(&TftInstance, SCROLL_FRAME_2);
}*/

void draw_sepctrogram_scan_mode(int source){
	int row;
	unsigned int baseaddr = (source==0)?FFT_ADDR_1:FFT_ADDR_2;
	for(row=0; row<480; row++){
		int value = Xil_In32(baseaddr+(row<<2));//0<value<46632^2
		float value_f = (float)value;
		value_f = log10(value_f+1)*100;//0<log10(value_f+1)*100<933
		value_f = 240-(value_f/467*240);
		value = (int)value_f;
		Xil_Out32(TFT_FRAME_ADDR_1+((480-row)<<12)+(col<<2), hue2rgb(value));
		//Xil_Out32(TFT_FRAME_ADDR_1+((480-row)<<12)+((col+1)<<2), hue2rgb(value));
		if(row%3==0)Xil_Out64(TFT_FRAME_ADDR_1+((480-row)<<12)+((col+2)<<2), 0xffffffffffffffff);
	}
	//xil_printf("drew col %d\n\r", col);
	col= (col<639)?col+1:0;
}



void draw_line(int row){
	int i,j;
	for(j=row-1;j<row+2; j++){
		for(i=0; i<640; i++){
			Xil_Out32(TFT_FRAME_ADDR_1+(j<<12)+(i<<2), 0xffffff00);
		}
	}
}


