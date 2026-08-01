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

$(call inherit-product, device/google/croissandro/aosp_common.mk)

PRODUCT_PROPERTY_OVERRIDES += service.adb.root=1 \
    ro.vendor.factory=1

# factory should always has SELinux permissive
BOARD_BOOTCONFIG += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Disable DebugFS restrictions in factory builds
PRODUCT_SET_DEBUGFS_RESTRICTIONS := false
