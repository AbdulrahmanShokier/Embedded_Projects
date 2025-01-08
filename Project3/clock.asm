ORG 0h	
	
MOV A,#38H 		;initiating the LCD
Acall CommFunc 	;sending the command
Acall SmallDelay		;give the LCD time to process

MOV A,#0EH 		;Display on, cursor blinking
Acall CommFunc 
Acall SmallDelay 

MOV A,#01 		;Clear display screen
Acall CommFunc 
Acall SmallDelay


	
mov R1,#0			;_0:00:00
mov R2,#0			;0_:00:00
mov R3,#0			;00:_0:00
mov R4,#0			;00:0_:00
mov R5,#0			;00:00:_0
mov R6,#0			;00:00:0_
	
	
	loop:	
	
MOV A,#80H 		;Force cursor to beginning to 1st line 
Acall CommFunc 
Acall SmallDelay


MOV A,R1 		;Printing "_0:00:00"
Acall DataFunc 
Acall SmallDelay	
Acall MoveTheCursor		;to shift the cursor
	
MOV A,R2 		;Printing ";0_:00:00"
Acall DataFunc 
Acall SmallDelay	
Acall MoveTheCursor		;to shift the cursor

MOV A,#':' 		;Printing ":"
Acall DoubleDotFunc 
Acall SmallDelay
Acall MoveTheCursor		;to shift the cursor
	
MOV A,R3 		;Printing "00:_0:00"
Acall DataFunc 
Acall SmallDelay	
Acall MoveTheCursor		;to shift the cursor
	
MOV A,R4 		;Printing ";00:0_:00"
Acall DataFunc 
Acall SmallDelay	
Acall MoveTheCursor		;to shift the cursor	
	
MOV A,#':' 		;Printing ":"
Acall DoubleDotFunc 
Acall SmallDelay
Acall MoveTheCursor		;to shift the cursor	
	
MOV A,R5 		;Printing "00:00:_0"
Acall DataFunc 
Acall SmallDelay	
Acall MoveTheCursor		;to shift the cursor
	
MOV A,R6 		;Printing ";00:00:0_"
Acall DataFunc 
Acall SmallDelay	
Acall MoveTheCursor		;to shift the cursor		
	
	
	
Acall OneSecondDelay

CJNE R6,#10,n1   ;"00:00:09"

mov A,R6		
add A,R5		;R5+R6 to decide if we will increment R4 or no

MOV R6,#0
INC R5			;"00:00:10"



CJNE A,#15,n1   ;"00:00:59"
MOV R5,#0
MOV R6,#0
MOV A,#0
INC R4

CJNE R4,#10,n1   ;"00:09:00"

mov A,R4		
add A,R3		;R3+R4 to decide if we will increment R2 or no

MOV R4,#0
INC R3



CJNE A,#15,n1   ;"00:59:00"
MOV R3,#0
MOV R4,#0
MOV A,#0
INC R2

CJNE R2,#10,n1   ;"09:00:00"
MOV R2,#0
INC R1
	
	
n1:
;SETB P2.3
;Acall OneSecondDelay	
;CLR P2.3
;Acall OneSecondDelay	

sjmp loop
	
OneSecondDelay:
	mov R0,#100 			; counter to make the timer loop for 100 times
	mov TMOD ,#01h			; mode 16 bit
Here:
	mov TL0 ,#0F0h			; the value in decimal is equal to 55536 to make 10 micro seconds 
	mov TH0 ,#0D8h			; the value in decimal is equal to 55536 to make 10 micro seconds
	SETB TR0
	Again: JNB TF0 ,Again	; wait till timer finish
	CLR TR0
	CLR TF0
	DJNZ R0,Here			; looping to make a total of 1 second
	INC R6					; Incrementing the seconds register
RET	



DataFunc:
		orl A,#30h
		MOV p1,A   		;To send the data
		SETB P2.0   		;Make Rs=1 to send DATA
		CLR P2.1   		;Make Rw=0 to write

		SETB P2.2		;To send High - Low signal
		Acall SmallDelay
		CLR P2.2
RET
		
DoubleDotFunc:
		MOV p1,A   		;To send the data
		SETB P2.0   		;Make Rs=1 to send DATA
		CLR P2.1   		;Make Rw=0 to write

		SETB P2.2		;To send High - Low signal
		Acall SmallDelay
		CLR P2.2
RET		
		
	
CommFunc:
		MOV p1,A   		;To choose the command
		CLR P2.0   		;Make Rs=0 to send command
		CLR P2.1   		;Make Rw=0 to write
	
		SETB P2.2		;To send High - Low signal
		Acall SmallDelay
		CLR P2.2
RET
		
		
		
		
		
MoveTheCursor:
		MOV p1,#06h  	;To shift the cursor to the right
		CLR P2.0   		;Make Rs=0 to send command
		CLR P2.1   		;Make Rw=0 to write
	
		SETB P2.2		;To send High - Low signal
		Acall SmallDelay
		CLR P2.2
RET


SmallDelay:
	    MOV R7 ,#255
	n7: DJNZ R7,n7
RET

END