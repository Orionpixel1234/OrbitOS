BOOT_DIR := arch/x86_64/boot/bios
BUILD_DIR := build
BIN_DIR := $(BUILD_DIR)/bin
ARCH := x86_64
BUILD_ARCH_DIR := $(BUILD_DIR)/$(ARCH)
ARCH_DIR := arch/$(ARCH)

STAGE1_SRC := $(BOOT_DIR)/boot.asm
STAGE2_SRC := $(BOOT_DIR)/boot2.asm
STAGE1_BIN := $(BUILD_ARCH_DIR)/stage1.bin
STAGE2_BIN := $(BUILD_ARCH_DIR)/stage2.bin
DISK_IMG   := $(BUILD_ARCH_DIR)/boot.img

include libs/libk/makefile
include arch/makefile

.PHONY: all clean run

all: $(DISK_IMG) $(LIBK)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR): | $(BUILD_DIR)
	mkdir -p $(BIN_DIR)

$(BUILD_ARCH_DIR): | $(BUILD_DIR)
	mkdir -p $(BUILD_ARCH_DIR)

$(DISK_IMG): $(STAGE1_BIN) $(STAGE2_BIN)
	cat $(STAGE1_BIN) $(STAGE2_BIN) > $@

run: $(DISK_IMG)
	qemu-system-x86_64 -drive file=$(DISK_IMG),format=raw

clean:
	rm -rf $(BUILD_DIR)
