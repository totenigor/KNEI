#include <avr/io.h>
#include <util/delay.h>

#include "spi.h"


int main(void)
{
	char num = 1;
	
	spi_ini();
    while (1) 
    {
		while(num <= 255)
		{
			num++;
			_delay_ms(100);
			spi_sendByte(num);
			if(num == 255)
			{
				num = 1;
			}
		}
    }
}

//WYSWIETLACZ, SPI, BIBLIOTEKA
//DORD, MBco? - SZUKAC W REJESTRZE SPI

