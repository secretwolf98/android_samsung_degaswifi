From 112f48e0ba1e31f71b853589f2f65090678c86d1 Mon Sep 17 00:00:00 2001
From: NV-Dev <you@example.com>
Date: Thu, 13 Aug 2015 19:29:12 -0430
Subject: [PATCH] Marvell support

---
 include/binder/MemoryHeapBase.h                    |   2 +
 libs/binder/Android.mk                             |   8 +
 libs/binder/MemoryHeapBase.cpp                     | 186 ++++++++++++++++++---
 opengl/include/EGL/eglext.h                        |  12 ++
 opengl/libagl/egl.cpp                              |  42 +++++
 opengl/libs/EGL/eglApi.cpp                         |  26 +++
 services/surfaceflinger/DisplayDevice.cpp          |  18 ++
 .../surfaceflinger/DisplayHardware/HWComposer.h    |   3 +
 8 files changed, 273 insertions(+), 24 deletions(-)

diff --git a/include/binder/MemoryHeapBase.h b/include/binder/MemoryHeapBase.h
index ea9b66c..2e3c5f9 100644
--- a/include/binder/MemoryHeapBase.h
+++ b/include/binder/MemoryHeapBase.h
@@ -87,6 +87,7 @@ class MemoryHeapBase : public virtual BnMemoryHeap
 
 private:
     status_t mapfd(int fd, size_t size, uint32_t offset = 0);
+    status_t mapion(int fd, size_t size, uint32_t offset = 0);
 
     int         mFD;
     size_t      mSize;
@@ -95,6 +96,7 @@ class MemoryHeapBase : public virtual BnMemoryHeap
     const char* mDevice;
     bool        mNeedUnmap;
     uint32_t    mOffset;
+    int         mDevFd;
 };
 
 // ---------------------------------------------------------------------------
diff --git a/libs/binder/Android.mk b/libs/binder/Android.mk
index 7861fef..67f296f 100644
--- a/libs/binder/Android.mk
+++ b/libs/binder/Android.mk
@@ -60,6 +60,10 @@ endif
 LOCAL_C_INCLUDES += hardware/samsung_slsi/$(PLATFORM_DIR)/include
 endif
 
+ifeq ($(strip $(MRVL_ION)), true)
+    LOCAL_CFLAGS += -DUSE_ION
+endif
+
 LOCAL_LDLIBS += -lpthread
 LOCAL_MODULE := libbinder
 LOCAL_SHARED_LIBRARIES += liblog libcutils libutils
@@ -80,6 +84,10 @@ endif
 LOCAL_C_INCLUDES += hardware/samsung_slsi/$(PLATFORM_DIR)/include
 endif
 
+ifeq ($(strip $(MRVL_ION)), true)
+    LOCAL_CFLAGS += -DUSE_ION
+endif
+
 LOCAL_LDLIBS += -lpthread
 LOCAL_MODULE := libbinder
 LOCAL_STATIC_LIBRARIES += libutils
diff --git a/libs/binder/MemoryHeapBase.cpp b/libs/binder/MemoryHeapBase.cpp
index d1cbf1c..794d615 100644
--- a/libs/binder/MemoryHeapBase.cpp
+++ b/libs/binder/MemoryHeapBase.cpp
@@ -31,24 +31,31 @@
 
 #include <binder/MemoryHeapBase.h>
 
+#ifdef USE_ION
+#include <linux/ion.h>
+#include <linux/pxa_ion.h>
+#endif /* USE_ION */
+
 #ifdef HAVE_ANDROID_OS
 #include <linux/android_pmem.h>
 #endif
 
 
+
+
 namespace android {
 
 // ---------------------------------------------------------------------------
 
 MemoryHeapBase::MemoryHeapBase()
     : mFD(-1), mSize(0), mBase(MAP_FAILED),
-      mDevice(NULL), mNeedUnmap(false), mOffset(0)
+      mDevice(NULL), mNeedUnmap(false), mOffset(0), mDevFd(-1)
 {
 }
 
 MemoryHeapBase::MemoryHeapBase(size_t size, uint32_t flags, char const * name)
     : mFD(-1), mSize(0), mBase(MAP_FAILED), mFlags(flags),
-      mDevice(0), mNeedUnmap(false), mOffset(0)
+      mDevice(0), mNeedUnmap(false), mOffset(0), mDevFd(-1)
 {
     const size_t pagesize = getpagesize();
     size = ((size + pagesize-1) & ~(pagesize-1));
@@ -62,7 +69,137 @@ MemoryHeapBase::MemoryHeapBase(size_t size, uint32_t flags, char const * name)
         }
     }
 }
+#ifdef USE_ION
+MemoryHeapBase::MemoryHeapBase(const char* device, size_t size, uint32_t flags)
+    : mFD(-1), mSize(0), mBase(MAP_FAILED), mFlags(flags),
+      mDevice(0), mNeedUnmap(false), mOffset(0), mDevFd(-1)
+{
+    int open_flags = O_RDWR;
+    if (flags & NO_CACHING)
+        open_flags |= O_SYNC;
+
+    int dev_fd = open(device, open_flags);
+    ALOGE_IF(dev_fd<0, "error opening %s: %s", device, strerror(errno));
+    if (dev_fd >= 0) {
+        const size_t pagesize = getpagesize();
+        size = ((size + pagesize-1) & ~(pagesize-1));
+        status_t mapret = mapion(dev_fd, size);
+        if (mapret == NO_ERROR) {
+            mDevice = device;
+        } else {
+            ALOGE("mapion failed : %d", mapret);
+        }
+    }
+}
+
+MemoryHeapBase::MemoryHeapBase(int fd, size_t size, uint32_t flags, uint32_t offset)
+    : mFD(-1), mSize(0), mBase(MAP_FAILED), mFlags(flags),
+      mDevice(0), mNeedUnmap(false), mOffset(0), mDevFd(-1)
+{
+    const size_t pagesize = getpagesize();
+    size = ((size + pagesize-1) & ~(pagesize-1));
+    mapion(dup(fd), size, offset);
+}
+
+status_t MemoryHeapBase::mapion(int dev_fd, size_t size, uint32_t offset)
+{
+    struct ion_allocation_data req_alloc;
+    struct ion_fd_data req_fd;
+    int ret;
+
+    if (size == 0) {
+        ALOGE("mapion size = 0");
+        return BAD_VALUE;
+    }
+
+    if ((mFlags & DONT_MAP_LOCALLY) == 0) {
+        memset(&req_alloc, 0, sizeof(struct ion_allocation_data));
+        req_alloc.len = size;
+        req_alloc.align = PAGE_SIZE;
+        if((mFlags & NO_CACHING) == 0){
+            req_alloc.flags = ION_FLAG_CACHED | ION_FLAG_CACHED_NEEDS_SYNC;
+        }
+        // req_alloc.heap_id_mask = ION_HEAP_TYPE_DMA_MASK;
+        req_alloc.heap_id_mask = ION_HEAP_CARVEOUT_MASK;
+        ret = ioctl(dev_fd, ION_IOC_ALLOC, &req_alloc);
+        if (ret < 0) {
+            ALOGE("ION_IOC_ALLOC failed ret = %d : reason : %s", ret, strerror(errno));
+            goto out;
+        }
+        memset(&req_fd, 0, sizeof(struct ion_fd_data));
+        req_fd.handle = req_alloc.handle;
+        ret = ioctl(dev_fd, ION_IOC_SHARE, &req_fd);
+        if (ret < 0) {
+            ALOGE("ION_IOC_SHARE failed = %d", ret);
+            goto out;
+        }
+
+        void *base = (uint8_t*)mmap(0, size, PROT_READ|PROT_WRITE,
+                                    MAP_SHARED, req_fd.fd, offset);
+        if (base == MAP_FAILED) {
+            ALOGE("mmap(fd=%d, size=%u) failed (%s)",
+                 dev_fd, uint32_t(size), strerror(errno));
+            goto out;
+        }
+        mBase = base;
+        mNeedUnmap = true;
+    } else {
+        mBase = 0;
+        mNeedUnmap = false;
+    }
+    /* buf fd is stored in mFD, node fd is stored in mDevFd */
+    mFD = req_fd.fd;
+    mDevFd = dev_fd;
+    mSize = size;
+    mOffset = offset;
+
+    return NO_ERROR;
+out:
+    close(dev_fd);
+    return -errno;
+}
 
+void MemoryHeapBase::dispose()
+{
+    int fd = android_atomic_or(-1, &mFD);
+    if (fd >= 0) {
+        if (mBase) {
+            if (mNeedUnmap) {
+                munmap(mBase, mSize);
+            }
+
+            if ((mDevFd > 0) && (fd > 0)) {
+                /* using ION memory */
+                struct ion_fd_data req_fd;
+                struct ion_handle_data req;
+                int ret;
+
+                memset(&req_fd, 0, sizeof(struct ion_fd_data));
+                req_fd.fd = fd; /* get buffer fd */
+                ret = ioctl(mDevFd, ION_IOC_IMPORT, &req_fd);
+                if (ret < 0) {
+                    ALOGE("Failed to import ION buffer with buffer fd:%d, ret:%d",
+                         fd, ret);
+                    goto out;
+                }
+                memset(&req, 0, sizeof(struct ion_handle_data));
+                req.handle = req_fd.handle;
+                ret = ioctl(mDevFd, ION_IOC_FREE, &req);
+                if (ret < 0) {
+                    ALOGE("Failed to free ION buffer, ret:%d", ret);
+                }
+out:
+                close(mDevFd);
+            }
+            mBase = 0;
+            mSize = 0;
+            close(fd);
+            mFD = -1;
+            mDevFd = -1;
+        }
+    }
+}
+#else
 MemoryHeapBase::MemoryHeapBase(const char* device, size_t size, uint32_t flags)
     : mFD(-1), mSize(0), mBase(MAP_FAILED), mFlags(flags),
       mDevice(0), mNeedUnmap(false), mOffset(0)
@@ -91,18 +228,20 @@ MemoryHeapBase::MemoryHeapBase(int fd, size_t size, uint32_t flags, uint32_t off
     mapfd(dup(fd), size, offset);
 }
 
-status_t MemoryHeapBase::init(int fd, void *base, int size, int flags, const char* device)
+void MemoryHeapBase::dispose()
 {
-    if (mFD != -1) {
-        return INVALID_OPERATION;
+    int fd = android_atomic_or(-1, &mFD);
+    if (fd >= 0) {
+        if (mNeedUnmap) {
+            //ALOGD("munmap(fd=%d, base=%p, size=%lu)", fd, mBase, mSize);
+            munmap(mBase, mSize);
+        }
+        mBase = 0;
+        mSize = 0;
+        close(fd);
     }
-    mFD = fd;
-    mBase = base;
-    mSize = size;
-    mFlags = flags;
-    mDevice = device;
-    return NO_ERROR;
 }
+#endif
 
 status_t MemoryHeapBase::mapfd(int fd, size_t size, uint32_t offset)
 {
@@ -145,23 +284,22 @@ status_t MemoryHeapBase::mapfd(int fd, size_t size, uint32_t offset)
     return NO_ERROR;
 }
 
-MemoryHeapBase::~MemoryHeapBase()
+status_t MemoryHeapBase::init(int fd, void *base, int size, int flags, const char* device)
 {
-    dispose();
+    if (mFD != -1) {
+        return INVALID_OPERATION;
+    }
+    mFD = fd;
+    mBase = base;
+    mSize = size;
+    mFlags = flags;
+    mDevice = device;
+    return NO_ERROR;
 }
 
-void MemoryHeapBase::dispose()
+MemoryHeapBase::~MemoryHeapBase()
 {
-    int fd = android_atomic_or(-1, &mFD);
-    if (fd >= 0) {
-        if (mNeedUnmap) {
-            //ALOGD("munmap(fd=%d, base=%p, size=%lu)", fd, mBase, mSize);
-            munmap(mBase, mSize);
-        }
-        mBase = 0;
-        mSize = 0;
-        close(fd);
-    }
+dispose();
 }
 
 int MemoryHeapBase::getHeapID() const {
diff --git a/opengl/include/EGL/eglext.h b/opengl/include/EGL/eglext.h
index 3b2984a..16b9cd7 100644
--- a/opengl/include/EGL/eglext.h
+++ b/opengl/include/EGL/eglext.h
@@ -535,6 +535,18 @@ typedef EGLint (EGLAPIENTRYP PFNEGLDUPNATIVEFENCEFDANDROIDPROC)(EGLDisplay dpy,
 #define EGL_RECORDABLE_ANDROID			0x3142
 #endif
 
+/* EGL_EXT_get_render_buffer_android
+*/
+#ifdef MRVL_HARDWARE
+#ifndef EGL_ANDROID_get_render_buffer
+#define EGL_ANDROID_get_render_buffer 1
+#ifdef EGL_EGLEXT_PROTOTYPES
+EGLAPI EGLClientBuffer EGLAPIENTRY eglGetRenderBufferANDROID(EGLDisplay dpy, EGLSurface draw);
+#endif
+typedef EGLClientBuffer (EGLAPIENTRYP PFNEGLGETRENDERBUFFERANDROIDPROC) (EGLDisplay dpy, EGLSurface draw);
+#endif
+#endif
+
 #ifndef EGL_EXT_buffer_age
 #define EGL_EXT_buffer_age 1
 #define EGL_BUFFER_AGE_EXT			0x313D
diff --git a/opengl/libagl/egl.cpp b/opengl/libagl/egl.cpp
index bbbda76..be3bdcd 100644
--- a/opengl/libagl/egl.cpp
+++ b/opengl/libagl/egl.cpp
@@ -167,6 +167,9 @@ struct egl_surface_t
     virtual     EGLint      getSwapBehavior() const;
     virtual     EGLBoolean  swapBuffers();
     virtual     EGLBoolean  setSwapRectangle(EGLint l, EGLint t, EGLint w, EGLint h);
+#ifdef MRVL_HARDWARE
+    virtual     EGLClientBuffer getRenderBuffer() const;
+#endif
 protected:
     GGLSurface              depth;
 };
@@ -193,6 +196,11 @@ bool egl_surface_t::isValid() const {
 EGLBoolean egl_surface_t::swapBuffers() {
     return EGL_FALSE;
 }
+#ifdef MRVL_HARDWARE
+EGLClientBuffer egl_surface_t::getRenderBuffer() const {
+    return 0;
+}
+#endif
 EGLint egl_surface_t::getHorizontalResolution() const {
     return (0 * EGL_DISPLAY_SCALING) * (1.0f / 25.4f);
 }
@@ -235,6 +243,9 @@ struct egl_window_surface_v2_t : public egl_surface_t
     virtual     EGLint      getRefreshRate() const;
     virtual     EGLint      getSwapBehavior() const;
     virtual     EGLBoolean  setSwapRectangle(EGLint l, EGLint t, EGLint w, EGLint h);
+#ifdef MRVL_HARDWARE
+    virtual     EGLClientBuffer getRenderBuffer() const;
+#endif
     
 private:
     status_t lock(ANativeWindowBuffer* buf, int usage, void** vaddr);
@@ -574,6 +585,13 @@ EGLBoolean egl_window_surface_v2_t::swapBuffers()
     return EGL_TRUE;
 }
 
+#ifdef MRVL_HARDWARE
+EGLClientBuffer egl_window_surface_v2_t::getRenderBuffer() const
+{
+    return buffer;
+}
+#endif
+
 EGLBoolean egl_window_surface_v2_t::setSwapRectangle(
         EGLint l, EGLint t, EGLint w, EGLint h)
 {
@@ -811,6 +829,9 @@ static char const * const gExtensionsString =
         // "KHR_image_pixmap "
         "EGL_ANDROID_image_native_buffer "
         "EGL_ANDROID_swap_rectangle "
+#ifdef MRVL_HARDWARE
+        "EGL_ANDROID_get_render_buffer "
+#endif
         ;
 
 // ----------------------------------------------------------------------------
@@ -871,6 +892,10 @@ static const extention_map_t gExtentionMap[] = {
             (__eglMustCastToProperFunctionPointerType)&eglGetSyncAttribKHR },
     { "eglSetSwapRectangleANDROID", 
             (__eglMustCastToProperFunctionPointerType)&eglSetSwapRectangleANDROID }, 
+#ifdef MRVL_HARDWARE
+    { "eglGetRenderBufferANDROID",
+            (__eglMustCastToProperFunctionPointerType)&eglGetRenderBufferANDROID },
+#endif
 };
 
 /*
@@ -2168,3 +2193,20 @@ EGLBoolean eglSetSwapRectangleANDROID(EGLDisplay dpy, EGLSurface draw,
 
     return EGL_TRUE;
 }
+
+#ifdef MRVL_HARDWARE
+EGLClientBuffer eglGetRenderBufferANDROID(EGLDisplay dpy, EGLSurface draw)
+{
+    if (egl_display_t::is_valid(dpy) == EGL_FALSE)
+        return setError(EGL_BAD_DISPLAY, (EGLClientBuffer)0);
+
+    egl_surface_t* d = static_cast<egl_surface_t*>(draw);
+    if (!d->isValid())
+        return setError(EGL_BAD_SURFACE, (EGLClientBuffer)0);
+    if (d->dpy != dpy)
+        return setError(EGL_BAD_DISPLAY, (EGLClientBuffer)0);
+
+    // post the surface
+    return d->getRenderBuffer();
+}
+#endif
diff --git a/opengl/libs/EGL/eglApi.cpp b/opengl/libs/EGL/eglApi.cpp
index a9dc7b3..5b9c4ef 100644
--- a/opengl/libs/EGL/eglApi.cpp
+++ b/opengl/libs/EGL/eglApi.cpp
@@ -97,6 +97,9 @@ extern char const * const gExtensionString  =
         "EGL_KHR_create_context "
         "EGL_EXT_create_context_robustness "
         "EGL_NV_system_time "
+#ifdef MRVL_HARDWARE
+        "EGL_ANDROID_get_render_buffer "
+#endif
         "EGL_ANDROID_image_native_buffer "      // mandatory
         "EGL_KHR_wait_sync "                    // strongly recommended
         "EGL_ANDROID_recordable "               // mandatory
@@ -144,6 +147,10 @@ static const extention_map_t sExtensionMap[] = {
             (__eglMustCastToProperFunctionPointerType)&eglGetSystemTimeFrequencyNV },
     { "eglGetSystemTimeNV",
             (__eglMustCastToProperFunctionPointerType)&eglGetSystemTimeNV },
+#ifdef MRVL_HARDWARE
+    { "eglGetRenderBufferANDROID",
+            (__eglMustCastToProperFunctionPointerType)&eglGetRenderBufferANDROID },
+#endif
 
     // EGL_KHR_wait_sync
     { "eglWaitSyncKHR",
@@ -1519,7 +1526,26 @@ EGLint eglWaitSyncKHR(EGLDisplay dpy, EGLSyncKHR sync, EGLint flags) {
 // ----------------------------------------------------------------------------
 // ANDROID extensions
 // ----------------------------------------------------------------------------
+# ifdef MRVL_HARDWARE
+EGLClientBuffer eglGetRenderBufferANDROID(EGLDisplay dpy, EGLSurface draw)
+{
+    clearError();
+
+    const egl_display_ptr dp = validate_display(dpy);
+    if (!dp) return EGL_FALSE;
 
+    SurfaceRef _s(dp.get(), draw);
+    if (!_s.get())
+        return setError(EGL_BAD_SURFACE, (EGLClientBuffer*)0);
+
+    egl_surface_t const * const s = get_surface(draw);
+    if (s->cnx->egl.eglGetRenderBufferANDROID) {
+        return s->cnx->egl.eglGetRenderBufferANDROID(
+                dp->disp.dpy, s->surface);
+    }
+    return setError(EGL_BAD_DISPLAY, (EGLClientBuffer*)0);
+}
+#endif
 EGLint eglDupNativeFenceFDANDROID(EGLDisplay dpy, EGLSyncKHR sync)
 {
     clearError();
diff --git a/services/surfaceflinger/DisplayDevice.cpp b/services/surfaceflinger/DisplayDevice.cpp
index 5f765bd..3e07d8d 100755
--- a/services/surfaceflinger/DisplayDevice.cpp
+++ b/services/surfaceflinger/DisplayDevice.cpp
@@ -246,9 +246,27 @@ void DisplayDevice::swapBuffers(HWComposer& hwc) const {
     //    (a) we have framebuffer target support (not present on legacy
     //        devices, where HWComposer::commit() handles things); or
     //    (b) this is a virtual display
+
+    // when (cur== end) we may have to consider wether we need call eglSwapBuffers
+    // caution: this change is to deal with the issue that SurfaceFlinger
+    //  called drawWormHoles() but not call eglSwapBuffers here.
+    //  however, there may have potential risk in case SurfaceFlinger
+    //  didn't call drawWormHoles(). if so, SurfaceFlinger may
+    //  wrongly call eglSwapBuffers one more time.
+
+#ifdef MRVL_HARDWARE
+    const int32_t id = getHwcDisplayId();
+    HWComposer::LayerListIterator cur = hwc.begin(id);
+    const HWComposer::LayerListIterator end = hwc.end(id);
+#endif
     if (hwc.initCheck() != NO_ERROR ||
+#ifdef MVL_HARDWARE
+            ((hwc.supportsFramebufferTarget() || mType >= DISPLAY_VIRTUAL) &&
+            (hwc.hasGlesComposition(mHwcDisplayId) || (cur==end)))){
+#else
             (hwc.hasGlesComposition(mHwcDisplayId) &&
              (hwc.supportsFramebufferTarget() || mType >= DISPLAY_VIRTUAL))) {
+#endif
         EGLBoolean success = eglSwapBuffers(mDisplay, mSurface);
         if (!success) {
             EGLint error = eglGetError();
diff --git a/services/surfaceflinger/DisplayHardware/HWComposer.h b/services/surfaceflinger/DisplayHardware/HWComposer.h
index 2632323..0d842b3 100644
--- a/services/surfaceflinger/DisplayHardware/HWComposer.h
+++ b/services/surfaceflinger/DisplayHardware/HWComposer.h
@@ -338,6 +338,9 @@ class HWComposer
 #ifdef QCOM_BSP
         bool hasBlitComp;
 #endif
+#ifdef MRVL_HARDWARE
+        uint32_t format;
+#endif
         size_t capacity;
         hwc_display_contents_1* list;
         hwc_layer_1* framebufferTarget;
