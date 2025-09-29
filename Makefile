ASM = nasm
SRC_BOOT = boot/boot.asm
SRC_KERNEL = kernel/main.asm
BUILD_DIR = build

BOOT_BIN = $(BUILD_DIR)/boot.bin
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
IMG = $(BUILD_DIR)/os.img

all: $(IMG)

# Build the full OS image (boot + kernel)
$(IMG): $(BOOT_BIN) $(KERNEL_BIN) | $(BUILD_DIR)
	cat $(BOOT_BIN) $(KERNEL_BIN) > $(IMG)
	truncate -s 1440k $(IMG)

# Assemble bootloader
$(BOOT_BIN): $(SRC_BOOT) | $(BUILD_DIR)
	$(ASM) $(SRC_BOOT) -f bin -o $(BOOT_BIN)

# Assemble kernel
$(KERNEL_BIN): $(SRC_KERNEL) | $(BUILD_DIR)
	$(ASM) $(SRC_KERNEL) -f bin -o $(KERNEL_BIN)

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Run in QEMU
run: $(IMG)
	qemu-system-i386 -fda $(IMG)

clean:
	rm -rf $(BUILD_DIR)

