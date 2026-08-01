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

include build/make/target/board/BoardConfigMainlineCommon.mk
include build/make/target/board/BoardConfigPixelCommon.mk

# Include settings for 16k page size kernel if enabled.
ifneq ($(wildcard $(TARGET_KERNEL_DIR)/16kb/),)
include device/croissandro/vsoc/BoardConfig-16k-common.mk
endif

TARGET_SOC := croissandro
TARGET_SOC_NAME := croissandro
