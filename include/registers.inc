; registers.inc — pin & register definitions
.equ  F_CPU       = 16000000       ; 16 MHz clock
.equ  SDA_PIN     = PC4            ; TWI SDA (PC4)
.equ  SCL_PIN     = PC5            ; TWI SCL (PC5)
.equ  SERVO_PIN   = PB1            ; OC1A (PB1) for Timer1 PWM
.equ  BUTTON_PIN  = PD2            ; digital input
.equ  LED_PIN     = PD3            ; status LED
.equ  DS3231_ADDR = 0x68           ; I²C address
