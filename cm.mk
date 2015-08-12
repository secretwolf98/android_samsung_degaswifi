$(call inherit-product, device/samsung/lt02wifiue/full_lt02wifiue.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=lt02wifiue \
    TARGET_DEVICE=lt02wifi \
    BUILD_FINGERPRINT="samsung/lt02wifiue/lt02wifi:4.4.2/KOT49H/T210RUEU0CNI1:user/release-keys" \
    PRIVATE_BUILD_DESC="lt02wifiue-user 4.4.2 KOT49H T210RUEU0CNI1 release-keys"

PRODUCT_NAME := cm_lt02wifiue
