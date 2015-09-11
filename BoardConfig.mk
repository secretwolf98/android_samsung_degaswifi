# Assert
# TARGET_OTA_ASSERT_DEVICE := degaswifi

BOARD_VENDOR := samsung

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOARD_PLATFORM := mrvl
TARGET_BOOTLOADER_BOARD_NAME := PXA1088
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := cortex-a9
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Flags
COMMON_GLOBAL_CFLAGS += -DMRVL_HARDWARE
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

BOARD_HARDWARE_CLASS += hardware/samsung/cmhw
TARGET_RECOVERY_DEVICE_DIRS += device/samsung/degaswifi

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Graphics
USE_OPENGL_RENDERER := true
BOARD_USE_BGRA_8888 := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Charging mode
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_BATTERY_DEVICE_NAME := "battery"

# Override healthd HAL
BOARD_HAL_STATIC_LIBRARIES := libhealthd.mrvl

# Target info
USE_CAMERA_STUB := true

# MRVL hardware
BOARD_USES_MRVL_HARDWARE := true

# Audio
BOARD_USES_ALSA_AUDIO := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/degaswifi/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MRVL := true

# Graphics
BOARD_USES_MRVL_HARDWARE := true
BOARD_HAVE_PIXEL_FORMAT_INFO := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/samsung/degaswifi/configs/egl.cfg
ENABLE_HWC_GC_PATH := true

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/degaswifi
TARGET_KERNEL_CONFIG := pxa1088_degaswifi_eur_defconfig
BOARD_KERNEL_BASE := 0x10000000
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/degaswifi/degaswifi_mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --dt device/samsung/degaswifi/rootdir/boot.img-dt --ramdisk_offset 0x01000000
BOARD_KERNEL_CMDLINE := initrd=0x01100000,1m rw androidboot.console=ttyS1 console=ttyS1,115200 panic_debug
BOARD_KERNEL_PAGESIZE := 2048
TARGET_SPECIFIC_HEADER_PATH := device/samsung/degaswifi/include
    
# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 12582912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2224029696
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5230297088
BOARD_FLASH_BLOCK_SIZE := 4096
BLOCK_BASED_OTA := false

# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/degaswifi/twrp.fstab
BOARD_SUPPRESS_EMMC_WIPE := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
BOARD_SUPPRESS_SECURE_ERASE := true

#TWRP
RECOVERY_VARIANT := twrp
TW_THEME := portrait_hdpi
TW_DEFAULT_EXTERNAL_STORAGE := true
#TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TW_HAS_DOWNLOAD_MODE := true
TW_NO_REBOOT_BOOTLOADER := true
#TW_NEW_ION_HEAP := true
TW_SCREEN_BLANK_ON_BOOT := true


# Vold
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/f_mass_storage/lun%d/file"
BOARD_UMS_LUNFILE := "/sys/class/android_usb/f_mass_storage/lun0/file"

# WiFi
BOARD_WLAN_VENDOR := MRVL
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/sd8xxx.ko"
WIFI_DRIVER_MODULE_NAME	:= "sd8xxx"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/firmware/mrvl/sd8777_uapsta.bin cfg80211_wext=12 sta_name=wlan uap_name=wlan wfd_name=p2p fw_name=mrvl/sd8777_uapsta.bin"
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/sd8xxx/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/firmware/mrvl/sd8777_uapsta.bin"
WIFI_DRIVER_FW_PATH_AP := "/system/etc/firmware/mrvl/sd8777_uapsta.bin"
WIFI_DRIVER_FW_PATH_P2P := "/system/etc/firmware/mrvl/sd8777_uapsta.bin"
WIFI_SDIO_IF_DRIVER_MODULE_PATH := "/system/lib/modules/mlan.ko"
WIFI_SDIO_IF_DRIVER_MODULE_NAME := "mlan"
WIFI_SDIO_IF_DRIVER_MODULE_ARG := ""
MRVL_WIRELESS_DAEMON_API := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/degaswifi
