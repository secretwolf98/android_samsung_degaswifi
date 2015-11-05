# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Platform
TARGET_BOARD_PLATFORM := mrvl

# CPU
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9

# Assert
TARGET_OTA_ASSERT_DEVICE := degas,degasue,degaswifi,degaswifiue

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := PXA1088
TARGET_NO_BOOTLOADER := true

# Include path
TARGET_SPECIFIC_HEADER_PATH := device/samsung/degaswifi/include

# Kernel
BOARD_KERNEL_BASE            := 0x10000000
BOARD_KERNEL_PAGESIZE        := 2048
BOARD_MKBOOTIMG_ARGS         := --dt device/samsung/degaswifi/rootdir/boot.img-dt --ramdisk_offset 0x01000000
BOARD_CUSTOM_BOOTIMG_MK      := device/samsung/degaswifi/degaswifi_mkbootimg.mk
TARGET_KERNEL_SOURCE         := kernel/samsung/degaswifi
TARGET_KERNEL_CONFIG         := cyanogenmod_seoffnomod_defconfig

# Audio
BOARD_USES_LEGACY_LIST := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/degaswifi/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MRVL := true
MRVL_WIRELESS_DAEMON_API := true

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Charger
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_CHARGER_SHOW_PERCENTAGE := true
CHARGING_ENABLED_PATH := "/sys/class/power_supply/battery/batt_lp_charging"

# CMHW
BOARD_HARDWARE_CLASS += hardware/samsung/cmhw

# Display
USE_OPENGL_RENDERER := true
COMMON_GLOBAL_FLAGS += -DSK_SUPPORT_LEGACY_SETCONFIG

# Malloc
MALLOC_IMPL := dlmalloc

# MRVL
BOARD_USES_MARVELL_HWC_ENHANCEMENT := true
COMMON_GLOBAL_CFLAGS += -DMARVELL_HWC_ENHANCEMENT

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 12582912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1507852288
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5775556608
BOARD_FLASH_BLOCK_SIZE := 4096

# Pre-L Compatibility
BOARD_USES_LEGACY_MMAP := true
COMMON_GLOBAL_CFLAGS += -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL

# Recovery
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
TARGET_RECOVERY_DEVICE_DIRS += device/samsung/degaswifi
TARGET_RECOVERY_FSTAB := device/samsung/degaswifi/rootdir/etc/fstab.pxa1088
TARGET_RECOVERY_INITRC := device/samsung/degaswifi/recovery/init.rc
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
TARGET_USERIMAGES_USE_EXT4 := true

# Wifi
BOARD_WLAN_DEVICE                := mrvl
BOARD_HAVE_MARVELL_WIFI          := true
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mrvl
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_mrvl
WIFI_DRIVER_FW_PATH_PARAM        := "/proc/mwlan/config"
WIFI_DRIVER_FW_PATH_STA          := "/system/etc/firmware/mrvl/sd8887_uapsta.bin"
WIFI_DRIVER_FW_PATH_AP           := "/system/etc/firmware/mrvl/sd8887_uapsta.bin"

# TWRP
TW_THEME := portrait_hdpi
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TW_NO_USB_STORAGE := true
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true

# Kernel
TARGET_ARCH := arm
TARGET_KERNEL_SOURCE := kernel/samsung/degaswifi
TARGET_KERNEL_CONFIG := cyanogenmod_seoffnomod_defconfig
BOARD_KERNEL_BASE := 0x10000000
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/degaswifi/degaswifi_mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --dt device/samsung/degaswifi/rootdir/boot.img-dt --ramdisk_offset 0x01000000
BOARD_KERNEL_PAGESIZE := 2048
