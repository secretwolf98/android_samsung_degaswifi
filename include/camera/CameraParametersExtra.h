/*
 * Copyright (C) 2015 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define CAMERA_PARAMETERS_EXTRA_C \
const char CameraParameters::PIXEL_FORMAT_YUV420P_I420[] = "yuv420p-i420"; \
const char CameraParameters::PIXEL_FORMAT_YUV420SP_NV12[] = "yuv420sp-nv12"; \
const char CameraParameters::PIXEL_FORMAT_YUV422I_UYVY[] = "yuv422i-uyvy"; \
const char CameraParameters::PIXEL_FORMAT_YUV422P[] = "yuv422p"; \
const char CameraParameters::KEY_SUPPORTED_ISO_MODES[] = "iso-values"; \
const char CameraParameters::KEY_MAX_CONTRAST[] = "max-contrast"; \
const char CameraParameters::KEY_MIN_CONTRAST[] = "min-contrast"; \
const char CameraParameters::KEY_CONTRAST[] = "contrast"; \
const char CameraParameters::KEY_METERING[] = "metering"; \
const char CameraParameters::KEY_MAX_SATURATION[] = "max-saturation"; \
const char CameraParameters::KEY_MIN_SATURATION[] = "min-saturation"; \
const char CameraParameters::KEY_SATURATION[] = "saturation"; \
const char CameraParameters::BURST_CAPTURE_MODE_OFF[] = "off-burst";\
const char CameraParameters::BURST_CAPTURE_MODE_INFINITE[] = "infinite-burst"; \
const char CameraParameters::BURST_CAPTURE_MODE_FAST[] = "fast-burst"; \
const char CameraParameters::KEY_MAX_BURST_CAPTURE_NUM[] = "burst-capture-number"; \
const char CameraParameters::KEY_SUPPORTED_BURST_CAPTURE_MODES[] = "burst-capture-mode"; \
const char CameraParameters::HDR_MODE_OFF[] = "off"; \
const char CameraParameters::HDR_MODE_ON[] = "on"; \
const char CameraParameters::KEY_SUPPORTED_HDR_MODES[] = "hdr-mode-values"; \
const char CameraParameters::ISO_MODE_AUTO[] = "auto"; \
const char CameraParameters::ISO_MODE_50[] = "50"; \
const char CameraParameters::ISO_MODE_100[] = "100"; \
const char CameraParameters::ISO_MODE_200[] = "200"; \
const char CameraParameters::ISO_MODE_400[] = "400"; \
const char CameraParameters::ISO_MODE_800[] = "800"; \
const char CameraParameters::ISO_MODE_1600[] = "1600"; \
const char CameraParameters::ISO_MODE_3200[] = "3200"; \

#define CAMERA_PARAMETERS_EXTRA_H \
 static const char PIXEL_FORMAT_YUV420P_I420[]; \
 static const char PIXEL_FORMAT_YUV420SP_NV12[]; \
 static const char PIXEL_FORMAT_YUV422I_UYVY[]; \
 static const char PIXEL_FORMAT_YUV422P[]; \
 static const char KEY_SUPPORTED_ISO_MODES[]; \
 static const char KEY_MAX_CONTRAST[]; \
 static const char KEY_MIN_CONTRAST[]; \
 static const char KEY_CONTRAST[]; \
 static const char KEY_METERING[]; \
 static const char KEY_MAX_SATURATION[]; \
 static const char KEY_MIN_SATURATION[]; \
 static const char KEY_SATURATION[]; \
 static const char BURST_CAPTURE_MODE_OFF[]; \
 static const char BURST_CAPTURE_MODE_INFINITE[]; \
 static const char BURST_CAPTURE_MODE_FAST[]; \
 static const char KEY_MAX_BURST_CAPTURE_NUM[]; \
 static const char KEY_SUPPORTED_BURST_CAPTURE_MODES[]; \
 static const char HDR_MODE_OFF[]; \
 static const char HDR_MODE_ON[]; \
 static const char KEY_SUPPORTED_HDR_MODES[]; \
 static const char ISO_MODE_AUTO[]; \
 static const char ISO_MODE_50[]; \
 static const char ISO_MODE_100[]; \
 static const char ISO_MODE_200[]; \
 static const char ISO_MODE_400[]; \
 static const char ISO_MODE_800[]; \
 static const char ISO_MODE_1600[]; \
 static const char ISO_MODE_3200[]; \

