;
; lab6.asm
;
; Created: 9/19/2022 2:42:21 PM
; Author : Sonam
;


.INCLUDE "M328PDEF.INC"
.list

; Define constants for LCD control pins
.EQU LCD_DPRT = PORTD
.EQU LCD_DDDR = DDRD
.EQU LCD_DPIN = PIND

.EQU LCD_BPRT = PORTB
.EQU LCD_BDDR = DDRB
.EQU LCD_BPIN = PINB

.EQU LCD_RS = 4
.EQU LCD_RW = 3
.EQU LCD_EN = 2
.EQU LCD_BL = 5

.ORG 0x000

Init_LCD4D:
    ; Initialize the LCD in 4-bit mode
    LDI R16,50
InitLoopI1:
    CALL Delay_1ms
    DEC R16
    BRNE InitLoopI1

    LDI R16,0x30
    CALL CMNDWRT41
    LDI R16,41

InitLoopI2:
    CALL Delay_100us
    DEC R16
    BRNE InitLoopI2

    LDI R16, 0x30
    CALL CMNDWRT41
    CALL Delay_100us
    LDI R16,0x30
    CALL CMNDWRT41
    CALL Delay_100us
    LDI R16,0x20
    CALL CMNDWRT41
    CALL Delay_100us
    LDI R16,0x28
    CALL CMNDWRT42
    LDI R16,0x0C
    CALL CMNDWRT42
    CALL LCD_CLS
    LDI R16, 0x06
    CALL CMNDWRT42

    RET

rjmp Main

MSG: .DB " Hello Thailand!",0
MSG2:.DB "  ?????? ",0

Main:
    ; Initialize the stack pointer
    LDI R22,HIGH(RAMEND)
    OUT SPH,R22
    LDI R22,LOW(RAMEND)
    OUT SPL,R22

    ; Set LCD ports as output
    LDI R22,0xFF
    OUT LCD_DDDR, R22
    OUT LCD_BDDR, R22

    ; Initialize the LCD
    CALL Init_LCD4D
    SBI LCD_BPRT,LCD_BL

MainPrint:
    ; Display "Hi" on the LCD
    LDI R16, 'H'
    CALL DATAWRT42
    LDI R16, 'i'
    CALL DATAWRT42
    CALL DELAY_1s
    CALL LCD_CLS

    ; Display the first message
    LDI R31,HIGH(MSG<<1)
    LDI R30,LOW(MSG<<1)

MainLOOP1:
    LPM R16,Z+
    CPI R16,0
    BREQ NEXT1
    CALL DATAWRT42
    RJMP MainLOOP1

Next1:
    ; Move to the second line and display the second message
    LDI R16,0XC0
    CALL CMNDWRT42

    LDI R31,HIGH(MSG2<<1)
    LDI R30,LOW(MSG2<<1)

MainLOOP2:
    LPM R16,Z+
    CPI R16,0
    BREQ Next2
    CALL DATAWRT42
    RJMP MainLOOP2

Next2:
    CALL Delay_2s
    CALL LCD_CLS

    JMP MainPrint

; Subroutines for LCD commands and data writing
CMNDWRT41:
    ; Write a command to the LCD in 4-bit mode
    MOV R27, R16
    ANDI R27, 0XF0
    LSR R27
    LSR R27
    OUT LCD_DPRT, R27
    CBI LCD_BPRT, LCD_RS
    CBI LCD_BPRT, LCD_RW
    SBI LCD_BPRT, LCD_EN
    CALL Delay_1ms
    CBI LCD_BPRT, LCD_EN
    RET

CMNDWRT42:
    ; Write a command to the LCD in 4-bit mode (extended)
    MOV R27, R16
    ANDI R27, 0XF0
    LSR R27
    LSR R27
    OUT LCD_DPRT, R27
    CBI LCD_BPRT, LCD_RS
    CBI LCD_BPRT, LCD_RW
    SBI LCD_BPRT, LCD_EN
    CALL Delay_1us
    CBI LCD_BPRT, LCD_EN

    MOV R27, R16
    SWAP R27
    ANDI R27, 0XF0
    LSR R27
    LSR R27
    OUT LCD_DPRT, R27

    SBI LCD_BPRT, LCD_EN
    CALL Delay_1us
    CBI LCD_BPRT, LCD_EN
    CALL Delay_100us
    RET

DATAWRT42:
    ; Write data to the LCD in 4-bit mode
    MOV R27, R16
    ANDI R27, 0XF0
    LSR R27
    LSR R27
    OUT LCD_DPRT, R27
    CBI LCD_BPRT, LCD_RS
    CBI LCD_BPRT, LCD_RW
    SBI LCD_BPRT, LCD_EN
    CALL Delay_1us
    CBI LCD_BPRT, LCD_EN

    MOV R27, R16
    SWAP R27
    ANDI R27, 0XF0
    LSR R27
    LSR R27
    OUT LCD_DPRT, R27

    SBI LCD_BPRT, LCD_EN
    CALL Delay_1us
    CBI LCD_BPRT, LCD_EN
    CALL Delay_100us
    RET

; Delay subroutines for timing
Delay_1ms:
    ldi  r18, 11
    ldi  r19, 99
L1: dec  r19
    brne L1
    dec  r18
    brne L1
    ret

Delay_100ms:
    ldi  r18, 5
    ldi  r19, 15
    ldi  r20, 242
L2: dec  r20
    brne L2
    dec  r19
    brne L2
    dec  r18
    brne L2
    ret

Delay_100us:
    ldi  r18, 2
    ldi  r19, 9
L3: dec  r19
    brne L3
    dec  r18
    brne L3
    ret

Delay_1us:
    ldi  r25, 5
L4: dec  r25
    brne L4
    nop
    ret

Delay_1s:
    ldi  r18, 82
    ldi  r19, 43
    ldi  r20, 0
L5: dec  r20
    brne L5
    dec r19
    brne L5
    dec r18
    brne L5
    lpm
    nop
    ret

Delay_2s:
    ldi  r18, 163
    ldi  r19, 87
    ldi  r20, 3
L6: dec  r20
    brne L6
    dec r19
    brne L6
    dec r18
    brne L6
    nop
    ret

