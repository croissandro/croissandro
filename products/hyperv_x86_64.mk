#
# Copyright (c) 2026 CroissAndro and Contributors
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
#

$(call inherit-product, device/croissandro/shared/product.mk)

# PI-0 emits only system.img. Boot and device partitions are introduced when
# their machine and runtime contracts exist.
PRODUCT_BUILD_BOOT_IMAGE := false
PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_INIT_BOOT_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_ODM_DLKM_IMAGE := false
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_RAMDISK_IMAGE := false
PRODUCT_BUILD_RECOVERY_IMAGE := false
PRODUCT_BUILD_SUPER_EMPTY_IMAGE := false
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_SYSTEM_DLKM_IMAGE := false
PRODUCT_BUILD_SYSTEM_EXT_IMAGE := false
PRODUCT_BUILD_SYSTEM_IMAGE := true
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_USERDATA_IMAGE := false
PRODUCT_BUILD_VBMETA_IMAGE := false
PRODUCT_BUILD_VENDOR_BOOT_IMAGE := false
PRODUCT_BUILD_VENDOR_DLKM_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := false

# CroissAndro is a new device launching on API 37. PI-0 is system-only, so it
# must retain the legacy framework-side HIDL services required when the image
# is checked against frozen, older vendor compatibility matrices. AOSP's GSI
# release product carries the same compatibility set explicitly.
PRODUCT_SHIPPING_API_LEVEL := 37

PRODUCT_PACKAGES += \
    hwservicemanager \
    android.hidl.allocator@1.0-service \
    android.hidl.memory@1.0-impl \
    system_ext_manifest.xml

# Keep generic_system.mk's artifact ownership check strict. These are the
# complete system_ext outputs of the compatibility packages above; do not use
# a system/system_ext/% wildcard here.
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/system_ext/bin/hw/android.hidl.allocator@1.0-service \
    system/system_ext/bin/hwservicemanager \
    system/system_ext/etc/init/android.hidl.allocator@1.0-service.rc \
    system/system_ext/etc/init/hwservicemanager.rc \
    system/system_ext/etc/vintf/manifest.xml \
    system/system_ext/etc/vintf/manifest/android.hidl.allocator@1.0-service.xml \
    system/system_ext/lib64/hw/android.hidl.memory@1.0-impl.so

PRODUCT_NAME := croissandro_hyperv_x86_64
PRODUCT_DEVICE := croissandro_hyperv_x86_64
PRODUCT_MODEL := CroissAndro Hyper-V x86_64 (PI-0)
