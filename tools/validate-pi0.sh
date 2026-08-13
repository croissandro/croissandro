#!/bin/bash

set -euo pipefail

product="croissandro_hyperv_x86_64"
lunch_target="${product}-trunk_staging-userdebug"
check_artifacts=false

if [[ ${1:-} == "--artifacts" ]]; then
  check_artifacts=true
elif [[ $# -ne 0 ]]; then
  echo "usage: $0 [--artifacts]" >&2
  exit 2
fi

if [[ ! -f build/envsetup.sh ]]; then
  echo "error: run this script from the AOSP source root" >&2
  exit 1
fi

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
device_dir=$(cd "${script_dir}/.." && pwd)

required_files=(
  "${device_dir}/Android.bp"
  "${device_dir}/AndroidProducts.mk"
  "${device_dir}/shared/product.mk"
  "${device_dir}/shared/board/x86_64.mk"
  "${device_dir}/products/hyperv_x86_64.mk"
  "${device_dir}/croissandro_hyperv_x86_64/BoardConfig.mk"
)

for file in "${required_files[@]}"; do
  if [[ ! -f ${file} ]]; then
    echo "error: missing ${file}" >&2
    exit 1
  fi
done

if grep -Eiq \
  'device/(google/cuttlefish|generic/goldfish)|inherit-product[^#]*(cuttlefish|goldfish)|TARGET_BOARD_PLATFORM[[:space:]]*:=[[:space:]]*vsoc|PRODUCT_SOONG_NAMESPACES[^#]*(cuttlefish|goldfish)' \
  "${device_dir}/AndroidProducts.mk" \
  "${device_dir}/shared/product.mk" \
  "${device_dir}/shared/board/x86_64.mk" \
  "${device_dir}/products/hyperv_x86_64.mk" \
  "${device_dir}/croissandro_hyperv_x86_64/BoardConfig.mk"; then
  echo "error: PI-0 imports a virtual-device implementation" >&2
  exit 1
fi

if ! grep -Fq '$(call enforce-product-packages-exist,com.android.ranging)' \
  "${device_dir}/shared/product.mk"; then
  echo "error: strict product package validation is not enabled" >&2
  exit 1
fi

# envsetup contains functions that are not compatible with nounset.
set +u
source build/envsetup.sh >/dev/null
lunch "${lunch_target}" >/dev/null
set -u

dumpvar() {
  build/soong/soong_ui.bash --dumpvar-mode "$1"
}

[[ $(dumpvar TARGET_PRODUCT) == "${product}" ]] || {
  echo "error: unexpected TARGET_PRODUCT" >&2
  exit 1
}
[[ $(dumpvar TARGET_DEVICE) == "${product}" ]] || {
  echo "error: unexpected TARGET_DEVICE" >&2
  exit 1
}
[[ $(dumpvar TARGET_ARCH) == "x86_64" ]] || {
  echo "error: unexpected TARGET_ARCH" >&2
  exit 1
}
[[ -z $(dumpvar TARGET_2ND_ARCH) ]] || {
  echo "error: PI-0 unexpectedly defines a secondary architecture" >&2
  exit 1
}
[[ $(dumpvar TARGET_NO_KERNEL) == "true" ]] || {
  echo "error: PI-0 unexpectedly selects a kernel" >&2
  exit 1
}

if ${check_artifacts}; then
  product_out="out/target/product/${product}"
  [[ -f ${product_out}/system.img ]] || {
    echo "error: missing ${product_out}/system.img; run m first" >&2
    exit 1
  }

  unexpected_images=(
    boot.img
    init_boot.img
    vendor_boot.img
    recovery.img
    super.img
    userdata.img
    vendor.img
    odm.img
  )
  for image in "${unexpected_images[@]}"; do
    if [[ -e ${product_out}/${image} ]]; then
      echo "error: PI-0 unexpectedly emitted ${product_out}/${image}" >&2
      exit 1
    fi
  done
fi

echo "PI-0 validation passed for ${lunch_target}"
