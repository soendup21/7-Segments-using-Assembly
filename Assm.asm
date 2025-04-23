;
; lab7.asm
;
; Created: 9/27/2022 4:45:02 PM
; Author : Sonam
;


rjmp start
start:
        ldi r16, 0xff
    out DDRD, r16
    out PORTD, r16
    ldi r16, 0x00

    ldi r17, 0xff
    out DDRB, r17
    out PORTB, r17
    ldi r17, 0x00

    ; Define constants for 7-segment patterns and digit control
    .set six = 0x7D
    .set seven = 0x7
    .set first = 0x2
    .set second = 0x4
    .set third = 0x8
    .set onetwo = 0x6
    .set all = 0xE

loop:
    ; Display the number 7 on the second digit
    ldi r16, seven
    com r16
    out PORTD, r16
    ldi r17, second
    out PORTB, r17
    call delay

S1:
    ; Display the number 6 on all digits
    ldi r16, six
    com r16
    out PORTD, r16
    ldi r17, all
    out PORTB, r17
    call delay
    call S1

delay:
    ; Delay subroutine to create a visible pause
    ldi R20, 15
L1: ldi R21, 50
L2: ldi R22, 150
L3: ;
        NOP
        NOP
        DEC R22
        BRNE L3

        DEC R21
        BRNE L2

        DEC R20
        BRNE L1
    RET
