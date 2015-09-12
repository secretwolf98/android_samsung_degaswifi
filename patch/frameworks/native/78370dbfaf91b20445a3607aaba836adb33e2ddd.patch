From 78370dbfaf91b20445a3607aaba836adb33e2ddd Mon Sep 17 00:00:00 2001
From: NV-Dev <you@example.com>
Date: Fri, 14 Aug 2015 10:26:11 -0430
Subject: [PATCH] Fix redeclaration of "uint32_t format;"

---
 services/surfaceflinger/DisplayHardware/HWComposer.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/services/surfaceflinger/DisplayHardware/HWComposer.h b/services/surfaceflinger/DisplayHardware/HWComposer.h
index 0d842b3..f09f0b4 100644
--- a/services/surfaceflinger/DisplayHardware/HWComposer.h
+++ b/services/surfaceflinger/DisplayHardware/HWComposer.h
@@ -328,7 +328,6 @@ class HWComposer
         ~DisplayData();
         uint32_t width;
         uint32_t height;
-        uint32_t format;    // pixel format from FB hal, for pre-hwc-1.1
         float xdpi;
         float ydpi;
         nsecs_t refresh;
