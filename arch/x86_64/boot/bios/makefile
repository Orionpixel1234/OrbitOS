.DEFAULT_GOAL := all

BIOS_DIR  := arch/x86_64/boot/bios
ELF_DIR   := $(BUILD_ARCH_DIR)/elf

CC        := gcc
AS        := ./tools/proton
LD        := ld
OBJCOPY   := objcopy

CFLAGS    := -ffreestanding -fno-builtin -fno-stack-protector -fno-pie \
             -fno-omit-frame-pointer -fno-asynchronous-unwind-tables \
             -fno-exceptions -m32 -march=i386 -mtune=i386 \
             -Wall -Wextra -O0 -g

A20_SRC   := $(BIOS_DIR)/a20.asm
GDT_SRC   := $(BIOS_DIR)/gdt.asm
PM_SRC    := $(BIOS_DIR)/pm.asm
BOOTC_SRC := $(BIOS_DIR)/boot.c
BOOT2_LD  := $(BIOS_DIR)/linker.ld

BOOT2_O   := $(BUILD_ARCH_DIR)/boot2.o
A20_O     := $(BUILD_ARCH_DIR)/a20.o
GDT_O     := $(BUILD_ARCH_DIR)/gdt.o
PM_O      := $(BUILD_ARCH_DIR)/pm.o
BOOTC_O   := $(BUILD_ARCH_DIR)/bootc.o
BOOT2_ELF := $(ELF_DIR)/boot2.elf

$(STAGE1_BIN): $(STAGE1_SRC) | $(BUILD_ARCH_DIR)
	./tools/proton -f bin -o $@ $<

$(BOOT2_O): $(STAGE2_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f elf32 -o $@ $<

$(A20_O): $(A20_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f elf32 -o $@ $<

$(GDT_O): $(GDT_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f elf32 -o $@ $<

$(PM_O): $(PM_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f elf32 -o $@ $<

$(BOOTC_O): $(BOOTC_SRC) | $(BUILD_ARCH_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BOOT2_ELF): $(BOOT2_O) $(A20_O) $(GDT_O) $(PM_O) $(BOOTC_O)
	mkdir -p $(ELF_DIR)
	$(LD) -m elf_i386 -T $(BOOT2_LD) $(BOOT2_O) $(A20_O) $(GDT_O) $(PM_O) $(BOOTC_O) -o $@

$(STAGE2_BIN): $(BOOT2_ELF)
	$(OBJCOPY) -O binary $< $@
	truncate -s 2048 $@
