; delay.asm — simple busy delay

.include "registers.inc"

.global delay_ms
; r24 = ms count
delay_ms:
    ldi r18, 250
    mul r24, r18
    movw r18, r0           ; total loops in r19:r18
    clr r20
1:  nop
    sbiw r18, 1
    brne 1b
    ret
