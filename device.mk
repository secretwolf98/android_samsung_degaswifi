LOCAL_PATH := device/samsung/degaswifi

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/dt.img:dt.img \
    $(LOCAL_PATH)/kernel:kernel


PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/sbin/healthd:root/sbin/healthd \
    $(LOCAL_PATH)/rootdir/fstab.pxa1088:root/fstab.pxa1088

$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := degaswifi
