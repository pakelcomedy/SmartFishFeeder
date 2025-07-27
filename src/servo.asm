; servo.asm — configure Timer1 PWM and drive servo

.include "registers.inc"

.global servo_init
.global servo_sweep

servo_init:
    ; configure PB1/OC1A as output
    sbi DDRB, SERVO_PIN
    ; Timer1, Fast PWM, 8‑bit (TOP=0x00FF), prescaler=8
    ldi r16, (1<<WGM10)|(1<<WGM12)
    sts TCCR1A, r16
    ldi r16, (1<<CS11)
    sts TCCR1B, r16
    ; initial duty = 1.5 ms → OCR1A = (1.5ms/(clk/8)) = 1.5e-3*2e6=3000→8bit≈150
    ldi r16, 150
    sts OCR1A, r16
    ret

; sweep servo: r24 = position 0–255
servo_sweep:
    sts OCR1A, r24
    ret
