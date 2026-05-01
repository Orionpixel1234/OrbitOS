.DEFAULT_GOAL := all

BIOS_DIR  := arch/x86_64/boot/bios
ELF_DIR   := $(BUILD_ARCH_DIR)/elf

CC32      := ./tools/neutron -m32 -ffreestanding -O2 -nostdlib
AS        := ./tools/proton
LD        := ./tools/neutron-ld
OBJCOPY   := objcopy

PM_SRC    := $(BIOS_DIR)/pm.asm
BOOTC_SRC := $(BIOS_DIR)/boot.c
BOOT2_LD  := $(BIOS_DIR)/linker.ld

BOOT2_RAW := $(BUILD_ARCH_DIR)/boot2_raw.bin
PM_O      := $(BUILD_ARCH_DIR)/pm.o
BOOTC_O   := $(BUILD_ARCH_DIR)/bootc.o
BOOT2_ELF := $(ELF_DIR)/boot2.elf
PM_BIN    := $(BUILD_ARCH_DIR)/pm.bin

$(STAGE1_BIN): $(STAGE1_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f bin -o $@ $<

# boot2.asm is a self-contained flat binary (16-bit real mode + GDT, no ELF)
$(BOOT2_RAW): $(STAGE2_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f bin -o $@ $<

$(PM_O): $(PM_SRC) | $(BUILD_ARCH_DIR)
	$(AS) -f elf32 -o $@ $<

$(BOOTC_O): $(BOOTC_SRC) | $(BUILD_ARCH_DIR)
	$(CC32) -I$(LIBK_INC) -c -o $@ $<

# Only 32-bit code (pm + C) is linked via ELF, starting at 0x7F00
$(BOOT2_ELF): $(PM_O) $(BOOTC_O) $(LIBK_BUILD)/kprintv.o
	mkdir -p $(ELF_DIR)
	$(LD) -m elf_i386 -T $(BOOT2_LD) $(PM_O) $(BOOTC_O) $(LIBK_BUILD)/kprintv.o -o $@

$(STAGE2_BIN): $(BOOT2_RAW) $(BOOT2_ELF)
	dd if=$(BOOT2_ELF) of=$(PM_BIN) bs=4096 skip=1
	cat $(BOOT2_RAW) $(PM_BIN) > $@
	truncate -s 2048 $@
