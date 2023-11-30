/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <stdio.h>
//#include "platform.h"
//#include "xil_printf.h"
//#include<stdio.h>
#include "xparameters.h"
#include "ff.h"
#include "xstatus.h"
#include <stdlib.h>
#include<xil_io.h>
#include<xil_types.h>
//#include "xil_printf.h"
#include "project_ip.h"
#define SIZE 16384
void write_data(u32 data,u32 reg);
void write_address(u32 address);
u32 concatenateBinaries(u32 bin1, u32 bin2, u32 bin3);

int main()
{
	init_platform();
	//printf("hi\n");
	printf("Image processing zynq......\n");
	    static const char *sdcard = "0:/";
	    	static FATFS fs;
	    	static FIL file,write;
	    	FRESULT result;
	    	unsigned int nBytes;
	    	//u32 addr=0;
	    	//init_platform();
	    	PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
	    				PROJECT_IP_S00_AXI_SLV_REG0_OFFSET,
	    				0);
	    	/*PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
	    				INPUT_IMAGE_CONTROLLER_IP_S00_AXI_SLV_REG1_OFFSET,
	    				0);*/

	    	//ddr variables
	    	//u32* image = (u32*)XPAR_PS7_DDR_0_S_AXI_BASEADDR;
	    	u32 image[128*128]={0};

	    	//sd card
	    	result = f_mount(&fs, sdcard, 1);
	    	if(result==0) printf("Card mounting done\n");

	    	result = f_open(&file, "image.txt", FA_READ);
	    	if(result==0) printf("File opening done\n");

	    	result = f_read(&file, image, SIZE*sizeof(u32), &nBytes);
	    	if(result==0) printf("File reading done\n");

	    	result = f_close(&file);
	    	if(result==0) printf("Closing file\n");

	    	//printf("%u\n %u\n %u\n",image[0],&image+1,&image);

	    	//transferring ddr data to block ram of PL
	    	//PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
	    		//	INPUT_IMAGE_CONTROLLER_IP_S00_AXI_SLV_REG0_OFFSET,
	    		//	1);*/
	    	for(u32 i=0;i<SIZE;i++)
	    	{
	    		//printf("%d \n",image[i]);



	    	write_address(i);
	    	write_data(image[i],2);




	    	}

	    	PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
	    					PROJECT_IP_S00_AXI_SLV_REG0_OFFSET,
	    					1);
	    	printf("Done sending image data to PL\n");
/*
	    	result = f_open(&write, "done.txt", FA_WRITE | FA_CREATE_ALWAYS);
	    	printf("File opening for write: %d\n", result);

	    	if(result == FR_OK){
	    			result = f_write(&write, "Done", 4*sizeof(u32), &nBytes);
	    			printf("File writing: %d\n", result);

	    			result = f_close(&write);
	    			printf("Closing file: %d\n", result);
	    		}*/
	    	result = f_unmount(sdcard);
	    		printf("Card unmounting done");

	    	    //cleanup_platform();
	    	    //return 0;


	    cleanup_platform();
	    return 0;
}

void write_data(u32 data,u32 reg)
{
	if(reg==2)
	{
		PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
			    				PROJECT_IP_S00_AXI_SLV_REG2_OFFSET,
			    				data);
	}
	else if(reg==3)
	{
		PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
			    				PROJECT_IP_S00_AXI_SLV_REG3_OFFSET,
			    				data);
	}
	else if(reg==4)
	{
		PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
			    				PROJECT_IP_S00_AXI_SLV_REG4_OFFSET,
			    				data);
	}
}

void write_address(u32 address)
{
	PROJECT_IP_mWriteReg(XPAR_PROJECT_IP_0_S00_AXI_BASEADDR,
		    				PROJECT_IP_S00_AXI_SLV_REG1_OFFSET,
		    				address);
}

u32 concatenateBinaries(u32 bin1, u32 bin2, u32 bin3)
{
    // Concatenate three 8-bit binary numbers into a single 24-bit binary number
    u32 result = 0;

    // Shift and concatenate
    result = (bin1 << 16) | (bin2 << 8) | bin3;

    return result;
}
