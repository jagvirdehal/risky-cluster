PREFIX:=riscv64-unknown-elf
CC:=$(PREFIX)-gcc

TARGET:=blink.elf
CFLAGS:=-ggdb -pipe -static -ffreestanding -march=rv32ec -mabi=ilp32e -nostdlib
LDFLAGS:=-Wl,-nmagic -Wl,-Tlinker.ld -Wl,--no-warn-rwx-segments -nostartfiles

# Source files and include dirs
SOURCES:=$(shell find src/ -type f -name '*.c') $(shell find src/ -type f -name '*.S')
# Create .o and .d files for every .c and .S (hand-written assembly) file
OBJECTS:=$(patsubst src/%, build/%, $(patsubst %.c, %.o, $(patsubst %.S, %.o, $(SOURCES))))
DEPENDS:=$(patsubst src/%, build/%, $(patsubst %.c, %.d, $(patsubst %.S, %.d, $(SOURCES))))


# Build rules

all: $(TARGET)

$(TARGET): $(OBJECTS) linker.ld
	$(CC) $(CFLAGS) $(filter-out %.ld, $^) -o $@ $(LDFLAGS)

$(OBJECTS): $(SOURCES) Makefile
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $(filter-out Makefile, $^) -o $@

-include $(DEPENDS)

.PHONY: clean
clean:
	rm -f minichlink $(OBJECTS) $(TARGET) || true

# Utilities

# Flashing tool
minichlink:
	make -C ch32fun/minichlink
	cp ch32fun/minichlink/minichlink .

.PHONY: poweroff
poweroff: minichlink
	./minichlink -t

.PHONY: poweron
poweron: minichlink
	./minichlink -3
