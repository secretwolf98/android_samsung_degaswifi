# Copyright (C) 2014 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/degaswifi/degaswifi-vendor.mk)

PRODUCT_CHARACTERISTICS := tablet

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/degaswifi/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml	\
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml


# OMX
PRODUCT_PACKAGES += \
	lib_driver_cmd_mrvl \
    libion \
	libGLES_android 

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Set property overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.zygote.disable_gl_preload=true \
    ro.cm.hardware.cabc=/sys/class/mdnie/mdnie/cabc \
    ro.bq.gpu_to_cpu_unsupported=1 \
    wifi.interface=wlan0 \
    wifi.softap.interface=wlan0 \
    wifi.supplicant_scan_interval=30 \
    dalvik.vm.heapsize=128m \
    ro.carrier=wifi-only
	
DEFAULT_PROPERTY_OVERRIDES += \
    ro.secure=0 \
    ro.allow.mock.location=1 \
    ro.debuggable=1 \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mtp,adb \
    sys.disable_ext_animation=1


# Screen density
PRODUCT_AAPT_CONFIG := large
PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_LOCALES += mdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH  := 800

$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.r_submix.default

# Audio configuration
PRODUCT_COPY_FILES += \
    device/samsung/degaswifi/audio/audio_policy.conf:system/etc/audio_policy.conf \
    device/samsung/degaswifi/audio/audio_effects.conf:system/etc/audio_effects.conf

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# IR
PRODUCT_PACKAGES += \
    consumerir.mrvl

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

# Keylayouts
PRODUCT_COPY_FILES += \
    device/samsung/degaswifi/keylayout/88pm80x_on.kl:system/usr/keylayout/88pm80x_on.kl \
    device/samsung/degaswifi/keylayout/88pm800_hook_vol.kl:system/usr/keylayout/88pm800_hook_vol.kl \
    device/samsung/degaswifi/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/samsung/degaswifi/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl

# Media Config
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    device/samsung/degaswifi/media/media_codecs.xml:system/etc/media_codecs.xml \
    device/samsung/degaswifi/media/media_profiles.xml:system/etc/media_profiles.xml

# Power
PRODUCT_PACKAGES += \
    libxml2 \
    power.mrvl \
    powerhal.conf

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.pxa1088 \
    init.pxa1088.rc \
    init.pxa1088.tel.rc \
    init.pxa1088.usb.rc \
    init.wifi.rc \
    ueventd.pxa1088.rc

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Disable SELinux
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.selinux=disabled

# Wifi
PRODUCT_PACKAGES += \
    hostapd \
    MarvellWirelessDaemon \
    wpa_supplicant \
    wpa_supplicant.conf 

PRODUCT_COPY_FILES += \
    device/samsung/degaswifi/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    device/samsung/degaswifi/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf
