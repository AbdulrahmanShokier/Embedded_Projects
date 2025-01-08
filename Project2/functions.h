#include <REG51.H>
#include <util/delay.h>


sBIT RS =P2^0;
sBIT RW =P2^1;
sBIT EN =P2^2;


void LCD_Init(void);
void DispOn(void);
void ClearDisp(void);
void CursorOnLine1(void);
void CursorOnLine2(void);
void SendData(char data);
void ShiftCursor(void);





void LCD_Init(void)
{
	P0=0x38;
	RS=0;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;
}



void DispOn(void)
{
	P0=0x0E;
	RS=0;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;
}


void ClearDisp(void)
{
	P0=0x01;
	RS=0;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;	
}

void CursorOnLine1(void)
{
	P0=0x80;
	RS=0;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;	
}


void CursorOnLine2(void)
{
	P0=0xC0;
	RS=0;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;	
}


void ShiftCursor(void)
{
	P0=0x06;
	RS=0;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;	
}

void SendData(char data)
{
	P0=data;
	RS=1;
	RW=0;
	EN=1;
	_delay_ms(10);
	EN=0;	
}






