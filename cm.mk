# Inherit device configuration
$(call inherit-product, device/samsung/degaswifi/full_degaswifi.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

PRODUCT_NAME := cm_degaswifi

