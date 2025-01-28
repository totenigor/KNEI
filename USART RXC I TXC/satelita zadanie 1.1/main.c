/*
 * Satelita zadanie 1.c
 *
 * Created: 15/01/2025 12:20:27
 * Author : igwnu
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

char table[] = "SOS";

void SendData(char []);

char ByteNr = 0;										//CHECK HOW MANY BYTES THERE ARE IN A DATA FRAME

ISR(USART0_RXC_vect)								//PRZERWANIE WYKONUJE SIE PO ODEBRANIU JEDNEGO BAJTU
{
	static char CheckSum;							//CHECK COMMAND		
	char RcvdByte = USART0.RXDATAL;					//Received Byte
		
	
	
	if(RcvdByte == 'A' && ByteNr == 0)
	{
		CheckSum	= RcvdByte;
	}else if(RcvdByte == 'T' && ByteNr == 1)
	{
		CheckSum	^= RcvdByte;
	}else if(RcvdByte	== '+' && ByteNr == 2)
	{
		CheckSum	^= RcvdByte;
	}else if ( ByteNr >= 3 && ByteNr <= 5)
	{
		CheckSum	^= RcvdByte;
	}else if(ByteNr == 6 && RcvdByte == CheckSum)
	{
		PORTA.OUTTGL	= PIN7_bm;						//(GREEN) MEANS CONTROL SUM IS THE SAME IN RECEIVER AS IN TRANSMITTER
		ByteNr = -1;
	}else if(RcvdByte == 'S' && ByteNr == 0)
	{
		CheckSum	= RcvdByte;
	}else if (RcvdByte == 'T' && ByteNr == 1)
	{
		CheckSum ^= RcvdByte;
	}else if (RcvdByte == '+' && ByteNr == 2)
	{
		CheckSum ^= RcvdByte;
	}else if (ByteNr >= 3 && ByteNr <= 7)
	{
		CheckSum ^= RcvdByte;
	}else if (ByteNr == 8 && RcvdByte == CheckSum)
	{
		PORTC.OUTTGL = PIN2_bm;					//(BLUE) MEANS CONTROL SUM IS THE SAME IN RECEIVER AS IN TRANSMITTER
		ByteNr = -1;
	}else
	{
		ByteNr = -1;
		USART0.STATUS	|= USART_RXCIF_bm;
		PORTC.OUTTGL	= PIN1_bm;					//(YELLOW) CHECK IF CONTROL SUM IS THE SAME IN RECEIVER AS IN TRANSMITTER
	}
	
	
	
	ByteNr++;
	USART0.STATUS	|= USART_RXCIF_bm;				//EXITTING THE INTERRUPTION
	//ramka: 65 84 43 83 79 83 113
	//ramka2: 83 84 43 83 73 71 77 65 /125
}


int main(void)
{
	//////////==PINS==/////////
	PORTC.DIRSET = PIN0_bm | PIN1_bm | PIN2_bm;		//PC0-2 set to output
	PORTA.DIRSET = PIN7_bm;							//PA7 set to output
	
	
	//////==USART==////////////
	
	USART0.CTRLC	|= USART_CMODE_ASYNCHRONOUS_gc;	//USART OPERATING ON ASYNCHRONOUS
	USART0.CTRLC	|= USART_PMODE_DISABLED_gc;		//USART ODD PARITY 
	USART0.CTRLC	|= USART_SBMODE_1BIT_gc;		//USART 1 STOP BIT
	USART0.CTRLC	|= USART_CHSIZE_8BIT_gc;		//SETTING USART TO 8 BIT DATA TRANSFER
	PORTA.DIRSET	= PIN0_bm;						//SETTING TxD PIN TO OUTPUT
	USART0.CTRLB	|= USART_TXEN_bm;				//ENABLING USART TRANSMITTER
	USART0.CTRLB	|= USART_RXEN_bm;				//ENABLING USART RECEIVER
	USART0.CTRLA	|= USART_RXCIE_bm;				//ENABLING USART RECEIVE INTERRUPT
	USART0.BAUD		= 1667;								//CALCULATED BAUD
	
		
	sei();												//ENABLING INTERRUPTIONS							
	
    while (1) 
    {
		PORTC.OUTTGL = PIN0_bm;							//(RED) TOGGLE
		_delay_ms(1000);
		//SendData(table);
		//USART0.TXDATAL = 'A';
		
    }
}

void SendData(char *t)
{
	char CtrlSum;
	
	while(!(USART0.STATUS & USART_DREIF_bm));
	USART0.TXDATAL = 'A';						
	CtrlSum = USART0.TXDATAL;
	while(!(USART0.STATUS & USART_DREIF_bm));
	USART0.TXDATAL = 'T';						
	CtrlSum = CtrlSum ^ USART0.TXDATAL;
	while(!(USART0.STATUS & USART_DREIF_bm));
	USART0.TXDATAL = '+';						
	CtrlSum = CtrlSum ^ USART0.TXDATAL;
	
	while(*t != 0)										//every data frame at the end of its adress has a zero ex.: "300->S,301->O,302->S,303->0"
	{
		while(!(USART0.STATUS & USART_DREIF_bm));
		USART0.TXDATAL = *t++;							//transmitted data
		CtrlSum = CtrlSum ^ USART0.TXDATAL;
	}
	while(!(USART0.STATUS & USART_DREIF_bm));
	USART0.TXDATAL = CtrlSum;	
}
