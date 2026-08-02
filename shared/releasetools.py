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

import os

from common import BlockDifference, EmptyImage, GetUserImage


# The joint list of user image partitions of source and target builds.
# Keep removed partitions here so incremental OTAs can delete their images.
USERIMAGE_PARTITIONS = [
    "odm",
    "product",
    "system_ext",
]


def GetUserImages(input_tmp, input_zip):
  return {
      partition: GetUserImage(partition, input_tmp, input_zip)
      for partition in USERIMAGE_PARTITIONS
      if os.path.exists(os.path.join(input_tmp, "IMAGES", partition + ".img"))
  }


def FullOTA_GetBlockDifferences(info):
  images = GetUserImages(info.input_tmp, info.input_zip)
  return [
      BlockDifference(partition, image)
      for partition, image in images.items()
  ]


def IncrementalOTA_GetBlockDifferences(info):
  source_images = GetUserImages(info.source_tmp, info.source_zip)
  target_images = GetUserImages(info.target_tmp, info.target_zip)

  # Use EmptyImage() as a placeholder for partitions that will be deleted.
  for partition in source_images:
    target_images.setdefault(partition, EmptyImage())

  # New partitions are intentionally absent from source_images.
  return [
      BlockDifference(partition, target_image, source_images.get(partition))
      for partition, target_image in target_images.items()
  ]
