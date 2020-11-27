 #include<p18F4550.inc>
  
loop_cnt1 equ 0x00
loop_cnt2 equ 0x01
controllcd equ PORTC
RS equ RC4
RW equ RC5
EN equ RC6

          org 0x00
          goto start
          org 0x08
          retfie
          org 0x18
          retfie
          
dup_nop   macro kk
          variable i

i=0
          while i<kk
          nop

i+=1
          endw
          endm

delay     movlw d'4'
           movwf loop_cnt2, A
again1     movlw d'250'
           movwf loop_cnt1, A
again2     dup_nop    d'17'
           decfsz     loop_cnt1, F, A
           bra        again2
           decfsz     loop_cnt2, F, A
           bra        again1
           nop
           return

;subroutine to configure lcd************

cnfglcd		bcf	controllcd, RS, A ;RS=0
			bcf	controllcd, RW, A ; RW=0
			bsf controllcd, EN, A ;EN=1
			call delay
			bcf controllcd, EN, A ;EN=0
			return

;subroutine to send data to lcd**********

sendatalcd	bsf	controllcd, RS, A ;RS=1
			bcf	controllcd, RW, A ;RW=0
			bsf controllcd, EN, A ;EN=1
			call delay
			bcf controllcd, EN, A ;RN=0
			return
;*************************************************
;subroutine for cnfg 2 lines and 5x7 matrix

cnfg2lines	movlw	0x38
			movwf	PORTD, A
			call	cnfglcd
			return

;subroutine for display to blink(cursor)

disblink	movlw	0x0F
			movwf	PORTD, A
			call 	cnfglcd
			return

;subroutine for clear display

cleardis	movlw	0x01
			movwf	PORTD, A
			call	cnfglcd
			return

;subroutine for second line
secline		movlw	0xC0
			movwf	PORTD, A
			call	cnfglcd
			return

;subroutine for Muhd Haziq

nameM	movlw	D'77'
		movwf	PORTD, A
		call sendatalcd
		return

nameu	movlw	D'117'
		movwf	PORTD, A
		call sendatalcd
		return

nameh	movlw	D'104'
		movwf	PORTD, A
		call sendatalcd
		return

namea	movlw	D'97'
		movwf	PORTD, A
		call sendatalcd
		return

namem	movlw	D'109'
		movwf	PORTD, A
		call sendatalcd
		return

named	movlw	D'100'
		movwf	PORTD, A
		call sendatalcd
		return

nameH	movlw	D'72'
		movwf	PORTD, A
		call sendatalcd
		return

namez	movlw	D'122'
		movwf	PORTD, A
		call sendatalcd
		return

namei	movlw	D'105'
		movwf	PORTD, A
		call sendatalcd
		return

nameq	movlw	D'113'
		movwf	PORTD, A
		call sendatalcd
		return

namespace	movlw	D'32'
			movwf	PORTD, A
			call sendatalcd
			return

;subroutine for ID

idD	movlw	D'68'
	movwf	PORTD, A
	call sendatalcd
	return

idE	movlw	D'69'
	movwf	PORTD, A
	call sendatalcd
	return

id9	movlw	D'57'
	movwf	PORTD, A
	call sendatalcd
	return

id7	movlw	D'55'
	movwf	PORTD, A
	call sendatalcd
	return

id2	movlw	D'50'
	movwf	PORTD, A
	call sendatalcd
	return

id0	movlw	D'48'
	movwf	PORTD, A
	call sendatalcd
	return

;subroutine for number

num0	movlw	D'48'
		movwf	PORTD, A
		call sendatalcd
		return

num1	movlw	D'49'
		movwf	PORTD, A
		call sendatalcd
		return

num2	movlw	D'50'
		movwf	PORTD, A
		call sendatalcd
		return

num3	movlw	D'51'
		movwf	PORTD, A
		call sendatalcd
		return

num4	movlw	D'52'
		movwf	PORTD, A
		call sendatalcd
		return

num5	movlw	D'53'
		movwf	PORTD, A
		call sendatalcd
		return

num6	movlw	D'54'
		movwf	PORTD, A
		call sendatalcd
		return

num7	movlw	D'55'
		movwf	PORTD, A
		call sendatalcd
		return

num8	movlw	D'56'
		movwf	PORTD, A
		call sendatalcd
		return

num9	movlw	D'57'
		movwf	PORTD, A
		call sendatalcd
		return
numsym1	movlw	D'42'
		movwf	PORTD, A
		call sendatalcd
		return

numsym2	movlw	D'35'
		movwf	PORTD, A
		call sendatalcd
		return



		
	

;***********************************************************



start	clrf TRISC, A
		clrf TRISD, A
		clrf TRISB, A
		clrf PORTD, A

	bsf TRISB, 2, A
	bsf TRISB, 3, A
	bsf TRISB, 4, A
	bcf	TRISA, 0, A
	bcf	TRISA, 1, A
	bcf	TRISA, 2, A
	bcf	TRISA, 3, A
	clrf PORTD, A

set1	btfsc PORTB, 0, A
		bra lcd1
set2	btfsc PORTB, 1, A
		bra lcd2
check1	bsf PORTA, 0, A
		btfss PORTB, 2, A
		bra check2
		call keypad1
check2	bsf PORTA, 0 , A
		btfss PORTB, 3, A
		bra check3
		call keypad2
check3	bsf PORTA, 0, A
		btfss PORTB, 4, A
		bra check4
		call keypad3
check4	bcf PORTA, 0, A
		bsf PORTA, 1, A
		btfss PORTB, 2, A
		bra check5
		call keypad4
check5	bcf	PORTA, 0, A
		bsf PORTA, 1, A
		btfss PORTB, 3, A
		bra check6
		call keypad5
check6	bcf	PORTA, 0, A
		bsf PORTA, 1, A
		btfss PORTB, 4, A
		bra check7
		call keypad6
check7	bcf	PORTA, 0, A
		bcf PORTA, 1, A
		bsf PORTA, 2, A
		btfss PORTB, 2, A
		bra check8
		call keypad7
check8	bcf	PORTA, 0, A
		bcf PORTA, 1, A
		bsf PORTA, 2, A
		btfss PORTB, 3, A
		bra check9
		call keypad8
check9	bcf	PORTA, 0, A
		bcf PORTA, 1, A
		bsf PORTA, 2, A
		btfss PORTB, 4, A
		bra checksym1
		call keypad9
		bra check1
checksym1	bcf	PORTA, 0, A
			bcf PORTA, 1, A
			bcf PORTA, 2, A
			bsf PORTA, 3, A
			btfss PORTB, 2, A
			bra check0
			call keypadsym1
check0	bcf	PORTA, 0, A
			bcf PORTA, 1, A
			bcf PORTA, 2, A
			bsf PORTA, 3, A
			btfss PORTB, 3, A
			bra checksym2
			call keypad0
checksym2	bcf	PORTA, 0, A
			bcf PORTA, 1, A
			bcf PORTA, 2, A
			bsf PORTA, 3, A
			btfss PORTB, 4, A
			bra set1
			call keypadsym2
			bra set1
		
;******name on lcd*******
	
lcd1	call cnfg2lines
		call disblink
		call cleardis
		call nameM
		call nameu
		call nameh
		call namea
		call namem
		call namem
		call namea
		call named
		call namespace
		call nameH
		call namea
		call namez
		call namei
		call nameq
		bra set2

lcd2	call cnfg2lines
		call disblink
		call cleardis
		call idD
		call idE
		call id9
		call id7
		call id2
		call id9
		call id0
		bra set1

;*******keypad on lcd************

keypad1	call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num1
		bra check2
		

keypad2 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num2
		bra check3

keypad3 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num3
		bra check4

keypad4 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num4
		bra check5

keypad5 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num5
		bra check6

keypad6 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num6
		bra check7

keypad7 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num7
		bra check8

keypad8 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num8
		bra check9

keypad9 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num9
		bra checksym1

keypadsym1 	call cnfg2lines
			call disblink
			call cleardis
			call secline
			call numsym1
			bra check0

keypad0 call cnfg2lines
		call disblink
		call cleardis
		call secline
		call num0
		bra checksym2

keypadsym2 	call cnfg2lines
			call disblink
			call cleardis
			call secline
			call numsym2
			bra check1


		


		end

