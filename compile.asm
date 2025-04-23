;
; Project.asm
;
; Created: 10/07/2022 12:32:11 AM
; Author : Sonam
;


.include "m32def.inc"

; Define registers for temporary storage and timekeeping
.def temp = r16
.def seg = r17
.def digit = r18
.def hours = r19
.def minutes = r20
.def loopcnt = r21

; Segment lookup table for digits 0–9 (common anode configuration)
.org 0x00
rjmp start

.org 0x50
seg_table:
.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F

start:
    ; Initialize PORTD and PORTB as output ports
    ldi temp, 0xFF
    out DDRD, temp
    out DDRB, temp

    ; Clear hours and minutes registers
    clr hours
    clr minutes

main_loop:
    ; Display the current time for a visible period
    ldi loopcnt, 100

    ; Loop to repeatedly display the time
    display_loop:
        rcall display_time
        dec loopcnt
        brne display_loop

    ; Increment the time
    inc minutes
    cpi minutes, 60
    brlt skip_hour_inc
    clr minutes
    inc hours
    cpi hours, 24
    brlt skip_hour_inc
    clr hours

skip_hour_inc:
    rjmp main_loop

; Subroutine to display the current time using multiplexing
display_time:
    ; Display each digit of the time
    mov temp, hours
    ldi digit, 0x01
    rcall show_digit

    mov temp, hours
    ldi digit, 0x02
    rcall show_digit

    mov temp, minutes
    ldi digit, 0x04
    rcall show_digit

    mov temp, minutes
    ldi digit, 0x08
    rcall show_digit

    ret

; Subroutine to display a single digit on the 7-segment display
show_digit:
    push r30
    push r31

    ; Extract the correct digit based on the input
    cpi digit, 0x01
    breq hour_tens
    cpi digit, 0x02
    breq hour_units
    cpi digit, 0x04
    breq minute_tens

    ; Default to minute units
    mov temp, minutes
    andi temp, 0x0F
    rjmp encode

hour_tens:
    mov temp, hours
    lsr temp
    lsr temp
    lsr temp
    lsr temp
    rjmp encode

hour_units:
    mov temp, hours
    andi temp, 0x0F
    rjmp encode

minute_tens:
    mov temp, minutes
    lsr temp
    lsr temp
    lsr temp
    lsr temp

encode:
    ; Encode the digit using the segment lookup table
    ldi ZH, high(seg_table << 1)
    ldi ZL, low(seg_table << 1)
    add ZL, temp
    ldi temp, 0x00
    adc ZH, temp
    lpm seg, Z

    ; Output the encoded digit to the 7-segment display
    com seg
    out PORTD, seg
    out PORTB, digit
    rcall delay_small

    pop r31
    pop r30
    ret

; Small delay subroutine for multiplexing
delay_small:
    ldi temp, 5
dloop1:
    ldi loopcnt, 100
dloop2:
    nop
    dec loopcnt
    brne dloop2
    dec temp
    brne dloop1
    ret
