LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.pxa1088
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/fstab.pxa1088
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.pxa1088.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.pxa1088.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.pxa1088.tel.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.pxa1088.tel.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.pxa1088.usb.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.pxa1088.usb.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.wifi.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.wifi.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := ueventd.pxa1088.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/ueventd.pxa1088.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)
