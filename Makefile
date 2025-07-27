MCU        = atmega328p
F_CPU      = 16000000UL
CC_ASM     = avr-as
CC_LD      = avr-ld
OBJCOPY    = avr-objcopy
CFLAGS     = -mmcu=$(MCU) -DF_CPU=$(F_CPU)
ASFLAGS    = $(CFLAGS)
LDFLAGS    = -m AVR5

SRC        = src/main.asm src/i2c.asm src/rtc.asm src/servo.asm src/button.asm src/delay.asm
OBJ        = $(SRC:.asm=.o)
ELF        = SmartFishFeeder.elf
HEX        = SmartFishFeeder.hex

all: $(HEX)

%.o: %.asm
	$(CC_ASM) $(ASFLAGS) -o $@ $<

$(ELF): $(OBJ)
	$(CC_LD) $(LDFLAGS) -o $@ $^
	$(OBJCOPY) -O ihex $(ELF) $(HEX)

flash: $(HEX)
	avrdude -p m328p -c arduino -P COM3 -b 115200 -U flash:w:$(HEX):i

clean:
	rm -f $(OBJ) $(ELF) $(HEX)
