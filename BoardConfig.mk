# Target info
USE_CAMERA_STUB := true

# MRVL hardware
BOARD_USES_MRVL_HARDWARE := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOARD_PLATFORM := mrvl
TARGET_BOOTLOADER_BOARD_NAME := PXA1088
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := cortex-a7
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Assert
# TARGET_OTA_ASSERT_DEVICE := degas,degasue,degaswifi,degaswifiue

# Charging mode
BOARD_CHARGING_MODE_BOOTING_LPM := true

# Flags
COMMON_GLOBAL_CFLAGS += -DMRVL_HARDWARE
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

# Graphics
BOARD_USES_MRVL_HARDWARE := true
BOARD_HAVE_PIXEL_FORMAT_INFO := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_OPENGL_RENDERER := true

# Kernel
TARGET_PREBUILT_KERNEL := device/samsung/degaswifi/kernel
TARGET_KERNEL_SOURCE := kernel/samsung/degaswifi
TARGET_KERNEL_CONFIG := carmilla-pxa1088_defconfig
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
#BOARD_KERNEL_SEPARATED_DT := true
BOARD_CUSTOM_MKBOOTIMG := device/samsung/degaswifi/degas-mkbootimg
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/degaswifi/degaswifi-mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000
    
# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 12582912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2224029696
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5230297088
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_UMS_LUNFILE := "/sys/class/android_usb/f_mass_storage/lun0/file"

# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/degaswifi/recovery/twrp.fstab
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USES_MMCUTILS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"

# Vold
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/f_mass_storage/lun%d/file"

# TWRP
DEVICE_RESOLUTION := 800x1280
RECOVERY_SDCARD_ON_DATA := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_NO_USB_STORAGE := true
TW_FLASH_FROM_STORAGE := true

# MultiROM config. MultiROM also uses parts of TWRP config
MR_INPUT_TYPE := type_b
MR_INIT_DEVICES := device/samsung/degaswifi/multirom/mr_init_devices.c
MR_DPI := hdpi
MR_MUL := 1.5
MR_FSTAB := device/samsung/degaswifi/multirom/multirom.fstab
MR_USE_MROM_FSTAB := true
# MR_DEVICE_VARIANTS := degas degasue degaswifi degaswifiue
#                    0x885fffff
#MR_KEXEC_MEM_MIN := 0x85000000
#                   0x07dfffff
MR_KEXEC_MEM_MIN := 0x078fffff
