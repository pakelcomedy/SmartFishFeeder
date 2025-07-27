; macros.inc — common utilities

.macro delay_loop count:req
    ldi r18, lo8(\count)
    ldi r19, hi8(\count)
1:  sbiw r18, 1
    brne 1b
.endm
