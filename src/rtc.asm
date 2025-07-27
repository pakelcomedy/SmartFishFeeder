; rtc.asm — read hour & minute from DS3231

.include "registers.inc"
.extern i2c_init, i2c_start, i2c_write, i2c_read_ack, i2c_read_nack, i2c_stop

.global rtc_get_time
; returns BCD hour in r22, BCD minute in r23
rtc_get_time:
    ; initialize I2C
    rcall i2c_init

    ; START + address write
    rcall i2c_start
    ldi r20, (DS3231_ADDR<<1)  ; write mode
    rcall i2c_write

    ; send register pointer = 0x00 (seconds)
    ldi r20, 0x00
    rcall i2c_write

    ; repeated START for read
    rcall i2c_start
    ldi r20, (DS3231_ADDR<<1)|1 ; read mode
    rcall i2c_write

    ; read seconds (ignore)
    rcall i2c_read_ack
    ; read minutes → r23
    rcall i2c_read_ack
    mov r23, r20
    ; read hours → r22
    rcall i2c_read_nack
    mov r22, r20

    rcall i2c_stop
    ret
