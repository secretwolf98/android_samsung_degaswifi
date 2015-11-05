# Inherit device configuration
$(call inherit-product, device/samsung/degaswifi/full_degaswifi.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME := degaswifi \
    TARGET_DEVICE=degaswifi \
    BUILD_FINGERPRINT="samsung/degaswifi/degaswifi:4.4.2/KOT49H/T230RUEU0CNI1:user/release-keys" \
    PRIVATE_BUILD_DESC="degaswifiue-user 4.4.2 KOT49H T230RUEU0CNI1 release-keys"

PRODUCT_NAME := cm_degaswifi
