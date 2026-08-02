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

TARGET_BOARD_PLATFORM := vsoc_x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_ABI := x86_64

# Enable native bridge to translate and run 64-bit ARM apps on this x86_64 device
TARGET_NATIVE_BRIDGE_ARCH := arm64
TARGET_NATIVE_BRIDGE_ARCH_VARIANT := armv8-a
TARGET_NATIVE_BRIDGE_CPU_VARIANT := generic
TARGET_NATIVE_BRIDGE_ABI := arm64-v8a

# Targets only the primary system architecture (ARM64) for both libraries and the daemon
AUDIOSERVER_MULTILIB := first

-include device/croissandro/shared/BoardConfig.mk