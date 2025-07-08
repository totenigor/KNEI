/*
 * SPI-DIGISCREEN.c
 *
 * Created: 23/06/2025 18:29:50
 * Author : igwnu
 */ 

#include <avr/io.h>
#include <stdio.h>
#include <util/delay.h>
#include "SPI.h"
#include "DIGISCREENini.h"


char specialNums[4] = {6,9, 121, 166};
	
char oneByOne[8] = {1, 2, 4, 8, 16, 32, 64, 128};
	
//FILL & ERASE funcs

void fill(char x, char y)
{
	_delay_ms(1000);
	spi_sendByte(x, oneByOne[y-1]);
}

void erase(char x, char y)
{
	_delay_ms(1000);
}

int main(void)
{
	spi_ini();
	digiScreen_ini();
	
	//TESTING FUNCTIONS
	spi_sendByte(4,255);
	erase(4,8);
	
	//PLAYING WITH THE DISPLAY
	/*
	spi_sendByte(1, 255);				//START OF THE FRAME
	
	for(char i = 2; i < 8; i++)
	{
		spi_sendByte(i, 129);
	}
	
	spi_sendByte(8, 255);				//END OF THE FRAME
	*/
	
	//DFRAME

	/*int j = 0;
	char i = 1;
	while (i < 9)
	{
		if (i <= 4)
		{
			spi_sendByte(i,specialNums[j]);
			j++;
		} 
		else if(i >= 5 && i <= 8)
		{
			j--;
			spi_sendByte(i,specialNums[j]);
		}
		i++;
	}*/
	
	
	//DROP EFFECT
	
	/*
	char j;
	char addUp = 0;
	for (signed char k = 7; k >= 0; k--)
	{		
			for (char i = 1; i <= 8; i++)
			{
				for (j = 0; j <= k; j++)
				{
					_delay_ms(200);
					spi_sendByte(i,oneByOne[j]+addUp);
					if(j == k && i == 8)
					{
						addUp += oneByOne[j];
					}
				}
			}
	}
	
	for (char k = 0; k < 5; k++)
	{
		_delay_ms(300);
		for (char i = 1; i <= 8; i++)
		{
			spi_sendByte(i, 0);
		}
		_delay_ms(300);
		for (char i = 1; i <= 8; i++)
		{
			spi_sendByte(i, 255);
		}
	}
	*/


	
	
    while (1) 
    {
	
    }
}

//DO ZROBIENIA ERASE
