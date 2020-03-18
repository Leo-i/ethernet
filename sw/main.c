/*
 * main.c
 *
 *  Created on: 6 марта 2020 г.
 *      Author: lev_i
 */

#include  "xuartlite.h"
#include  "xuartlite_l.h"
#include  "led_controller.h"
#include  "sleep.h"
#include  "xintc.h"

#include  "ethernet.h"

//==== defines ============
#define UARTLITE_DEVICE_ID      XPAR_UARTLITE_0_DEVICE_ID
#define INTC_DEVICE_ID          XPAR_INTC_0_DEVICE_ID
#define UARTLITE_INT_IRQ_ID     XPAR_INTC_0_UARTLITE_0_VEC_ID

void initiaize();
void uart_send_32(u32 data);
int SetupInterruptSystem(XUartLite *UartLitePtr);
void RecvHandler(void *CallBackRef, unsigned int EventData);


XUartLite UartLite;
XIntc InterruptController;
u32	Rx_buff;

u32 i;
int main(void){

	i = 0x321A5683;
	initiaize();

	ETHERNET_TX_mWriteReg(0x441A0000,
	        0, 0x12345678);

	while (1){

		LED_CONTROLLER_mWriteReg(0x44A00000,LED_CONTROLLER_S00_AXI_SLV_REG0_OFFSET,i);
		sleep(1);
		i = i + 1;
		//uart_send_32(i);
	}
}

void initiaize(){
	XUartLite_Initialize(&UartLite,UARTLITE_DEVICE_ID);
	SetupInterruptSystem(&UartLite);
	XUartLite_SetRecvHandler(&UartLite, RecvHandler, &UartLite);
	XUartLite_EnableInterrupt(&UartLite);
};

void uart_send_32(u32 data){
	XUartLite_SendByte(0x40600000,data>>24);
	XUartLite_SendByte(0x40600000,data>>16);
	XUartLite_SendByte(0x40600000,data>>8);
	XUartLite_SendByte(0x40600000,data);
}
u8 rx_data_step = 0;

void RecvHandler(void *CallBackRef, unsigned int EventData)
{

	u8 data = XUartLite_RecvByte(0x40600000);
	if ( rx_data_step == 0){
		switch ( data ){
		case 0x00: uart_send_32(0xFFFFFFFF); break; // check uart
		case 0x01: rx_data_step = 4; break;  		//write to buff
		case 0x02: uart_send_32(Rx_buff); break;	//read buff
		case 0x03: i = i & 0x0000000F; break;
		case 0x04: i = i | 0x000000F0; break;
		case 0x05: uart_send_32(i); break;
		default	 : uart_send_32(data);
		}
	} else {
		switch ( rx_data_step ){
		case 4: Rx_buff = data; rx_data_step--; break;
		case 3: Rx_buff = ( Rx_buff << 8 ) + data; rx_data_step--; break;
		case 2: Rx_buff = ( Rx_buff << 8 ) + data; rx_data_step--; break;
		case 1: Rx_buff = ( Rx_buff << 8 ) + data; rx_data_step--; break;
		default: rx_data_step = 0;
		}
	}
}

int SetupInterruptSystem(XUartLite *UartLitePtr)
{

	int Status;


	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	Status = XIntc_Initialize(&InterruptController, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	/*
	 * Connect a device driver handler that will be called when an interrupt
	 * for the device occurs, the device driver handler performs the
	 * specific interrupt processing for the device.
	 */
	Status = XIntc_Connect(&InterruptController, UARTLITE_INT_IRQ_ID,
			   (XInterruptHandler)XUartLite_InterruptHandler,
			   (void *)UartLitePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Start the interrupt controller such that interrupts are enabled for
	 * all devices that cause interrupts, specific real mode so that
	 * the UartLite can cause interrupts through the interrupt controller.
	 */
	Status = XIntc_Start(&InterruptController, XIN_REAL_MODE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Enable the interrupt for the UartLite device.
	 */
	XIntc_Enable(&InterruptController, UARTLITE_INT_IRQ_ID);

	/*
	 * Initialize the exception table.
	 */
	Xil_ExceptionInit();

	/*
	 * Register the interrupt controller handler with the exception table.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)XIntc_InterruptHandler,
			 &InterruptController);

	/*
	 * Enable exceptions.
	 */
	Xil_ExceptionEnable();

	return XST_SUCCESS;
}
