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

# Shared Android userspace policy. Host backends inherit this file; this file
# must not inherit a VM, kernel, graphics transport, or desktop frontend.
# core_64_bit_only.mk must precede the chain that reaches core_minimal.mk.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

# Missing modules are product-definition errors, not optional output. The
# platform base product currently names the optional Ranging Mainline module,
# which is absent from this source manifest/release configuration.
$(call enforce-product-packages-exist,com.android.ranging)

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := true
PRODUCT_RESTRICT_VENDOR_FILES := all

PRODUCT_BRAND := CroissAndro
PRODUCT_MANUFACTURER := CroissAndro
