; main.asm — entry point and feeding logic

.include "registers.inc"
.include "macros.inc"

.extern rtc_get_time
.extern servo_init, servo_sweep
.extern button_init, button_pressed
.extern delay_ms

; Hardcoded feed times (BCD)
.equ FEED1_H = 0x08
.equ FEED1_M = 0x00
.equ FEED2_H = 0x18
.equ FEED2_M = 0x00

.global  main
main:
    ; stack init
    ldi r16, low(RAMEND)
    out SPL, r16
    ldi r16, high(RAMEND)
    out SPH, r16

    ; init modules
    rcall servo_init
    rcall i2c_init
    rcall button_init
    sbi DDRD, LED_PIN       ; LED output
    cbi PORTD, LED_PIN

main_loop:
    ; read time
    rcall rtc_get_time     ; returns BCD H→r22, M→r23

    ; check if match FEED1
    cpi r22, FEED1_H
    brne check_feed2
    cpi r23, FEED1_M
    brne check_feed2
    rcall do_feed
    rjmp after_feed

check_feed2:
    cpi r22, FEED2_H
    brne check_button
    cpi r23, FEED2_M
    brne check_button
    rcall do_feed

check_button:
    rcall button_pressed
    brcc main_continue
    rcall do_feed

main_continue:
    rjmp main_loop

after_feed:
    ; wait one minute to avoid retrigger
    ldi r24, 60
wait_min:
    rcall delay_ms
    dec r24
    brne wait_min
    rjmp main_loop

; do_feed: rotate servo + LED indicator
do_feed:
    sbi PORTD, LED_PIN
    ; open door: pulse servo to 200/255
    ldi r24, 200
    rcall servo_sweep
    rcall delay_ms        ; ~1 ms
    ; close door: back to neutral 150
    ldi r24, 150
    rcall servo_sweep
    rcall delay_ms
    cbi PORTD, LED_PIN
    ret
