/*
 * DIGISCREENini.c
 *
 * Created: 08/07/2025 10:38:58
 *  Author: igwnu
 */ 

#include "SPI.h"


void digiScreen_ini(void)
{
		spi_sendByte(0x09, 0);				//NO DECODE FOR DIGITS 0-7
		
		spi_sendByte(0x0C, 1);				//NORMAL OPERATION MODE
		
		spi_sendByte(0x0F, 0);				//NORMAL OPERATION
		
		spi_sendByte(0x0B, 7);				//DISPLAY DIGITS FROM 0-7
		
		for (char i = 1; i <= 8; i++)
		{
			spi_sendByte(i,0);
		}
};