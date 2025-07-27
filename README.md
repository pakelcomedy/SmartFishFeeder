```
SmartFishFeeder/
├── src/
│   ├── main.asm          ; Entry point + logic utama
│   ├── rtc.asm           ; Read DS3231 via I2C (TWI)
│   ├── servo.asm         ; Servo PWM (Timer1)
│   ├── button.asm        ; Tombol override
│   ├── delay.asm         ; Delay dan debounce
│   └── i2c.asm           ; I2C (hardware TWI)
├── include/
│   ├── macros.inc        ; Macro & util umum
│   └── registers.inc     ; Definisi register & pin
├── Makefile              ; Untuk compile via avr-as + avr-ld
└── README.md
```
