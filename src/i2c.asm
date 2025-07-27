; i2c.asm — minimal hardware TWI routines

.include "registers.inc"

.global i2c_init
.global i2c_start
.global i2c_write
.global i2c_read_ack
.global i2c_read_nack
.global i2c_stop

i2c_init:
    ldi r16, (1<<TWEN)|(1<<TWSR0)   ; enable TWI, prescaler=1
    sts TWCR, r16
    ldi r16, ((F_CPU/100000)-16)/2  ; set SCL to 100kHz
    sts TWBR, r16
    ret

i2c_start:
    ldi r16, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
    sts TWCR, r16
1:  lds r16, TWCR
    sbrs r16, TWINT
    rjmp 1b
    ret

i2c_write:
    ; expects: r20 = data
    sts TWDR, r20
    ldi r16, (1<<TWINT)|(1<<TWEN)
    sts TWCR, r16
2:  lds r16, TWCR
    sbrs r16, TWINT
    rjmp 2b
    ret

i2c_read_ack:
    ldi r16, (1<<TWINT)|(1<<TWEN)|(1<<TWEA)
    sts TWCR, r16
3:  lds r16, TWCR
    sbrs r16, TWINT
    rjmp 3b
    lds r20, TWDR
    ret

i2c_read_nack:
    ldi r16, (1<<TWINT)|(1<<TWEN)
    sts TWCR, r16
4:  lds r16, TWCR
    sbrs r16, TWINT
    rjmp 4b
    lds r20, TWDR
    ret

i2c_stop:
    ldi r16, (1<<TWINT)|(1<<TWEN)|(1<<TWSTO)
    sts TWCR, r16
    ret
