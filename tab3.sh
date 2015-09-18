#!/bin/bash

# Grab patches for Tab 3

# BUILD
cd build

# Allow custom recovery init.rc
git fetch https://github.com/Tab3/android_build.git cm-12.1
git cherry-pick 9b235288c8324bb5247721867135cc51ac5e1db1
cd -

# FRAMEWORK
cd frameworks/av

# av: add support for Marvell hardware (1/6)
git fetch https://github.com/Tab3/android_frameworks_av.git cm-12.1
git cherry-pick 57601bc0956edbc9ed831ce477fb0f1fc06796cf
cd -

cd frameworks/native

# native: add support for Marvell hardware (2/6)
git fetch https://github.com/Tab3/android_frameworks_native cm-12.1
git cherry-pick ebd14439d0d28d860beb4a7549b310b1171328d4

# native: add support for BGRA_8888 format
git cherry-pick 123271c2288c5013f3fb6eb3f6135f15de1b6a44
cd -

# HARDWARE
cd hardware/libhardware

# libhardware: add support for Marvell hardware (3/6)
git fetch https://github.com/Tab3/android_hardware_libhardware cm-12.1
git cherry-pick c36f26f35c453441055643ef7edcece6fd3141d8
cd -

cd hardware/libhardware_legacy

# wifi: add support for Marvell hardware (6/6)
git fetch https://github.com/Tab3/android_hardware_libhardware_legacy cm-12.1
git cherry-pick 99fdc2d2a5e02ec48ce0c7b8fb58283c96b6f5da
cd -

# CORE
cd system/core

# core: add support for Marvell hardware (4/6)
git fetch https://github.com/Tab3/android_system_core cm-12.1
git cherry-pick 333bf12a2eaee6a7cdf5711163a7f7036c8a8c4f
cd -

# WPA_SUPPLICANT_8
cd external/wpa_supplicant_8

# n180211: add support for Marvell hardware (5/6)
git fetch https://github.com/Tab3/android_external_wpa_supplicant_8 cm-12.1
git cherry-pick a0fb3ddc02a1ab2819a2c3c5e503555af3ca8e6f
cd -
