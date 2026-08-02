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

TARGET_BOARD_PLATFORM := vsoc_arm64
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
# TODO: Do we need different CPU variants for different ARM processors?
# E.g.: Snapdragon X Elite relies on ARMv8.7-A specification
TARGET_CPU_VARIANT := cortex-a53

# Targets only the primary system architecture (ARM64) for both libraries and the daemon
AUDIOSERVER_MULTILIB := first

# Cross-build
# TODO: Do we need Windows and Darwin support?
HOST_CROSS_OS := linux_musl
HOST_CROSS_ARCH := arm64
HOST_CROSS_2ND_ARCH :=

-include device/croissandro/shared/BoardConfig.mk