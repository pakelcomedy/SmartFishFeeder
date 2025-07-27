; button.asm — simple debounced input on PD2

.include "registers.inc"
.include "macros.inc"

.global button_init
.global button_pressed

button_init:
    sbi DDRD, BUTTON_PIN   ; set as input: clear DDRD bit
    cbi DDRD, BUTTON_PIN
    sbi PORTD, BUTTON_PIN  ; enable pull‑up
    ret

; returns in Z flag (set=pressed)
button_pressed:
    lds r16, PIND
    sbic PIND, BUTTON_PIN  ; skip if bit cleared (active low)
    rjmp .pressed
    ; not pressed
    clc
    ret
.pressed:
    ; debounce
    delay_loop 1000
    sbic PIND, BUTTON_PIN
    rjmp .no
    sec
    ret
.no:
    clc
    ret
