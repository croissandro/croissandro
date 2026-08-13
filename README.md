# CroissAndro

CroissAndro is intended to become a Hyper-V-native Android virtual device.
This tree currently implements **PI-0: Reproducible build product**.

PI-0 deliberately produces only a generic Android `system.img`. It does not
select a kernel, bootloader, ramdisk, device tree, storage layout, vendor HAL,
or virtual-machine implementation. Those contracts start in PI-1 and PI-2.

## PI-0 contract

- x86-64 Android userspace only; no secondary ABI or native bridge
- generic AOSP system components
- strict rejection of nonexistent `PRODUCT_PACKAGES`
- no Cuttlefish, Goldfish, Ranchu, crosvm, QEMU, or Hyper-V implementation
- no claim that the resulting image is bootable

## Build

From the AOSP root:

```sh
source build/envsetup.sh
lunch croissandro_hyperv_x86_64-trunk_staging-userdebug
m
```

The expected product artifact is:

```text
out/target/product/croissandro_hyperv_x86_64/system.img
```

Validate the product definition before a build:

```sh
device/croissandro/tools/validate-pi0.sh
```

Validate both the definition and built artifacts after `m`:

```sh
device/croissandro/tools/validate-pi0.sh --artifacts
```

PI-1 will introduce a separately versioned Android common kernel and a minimal
diagnostic initramfs for Hyper-V. It should not add vendor Android userspace or
pretend that a complete Android device boots yet.

## Reuse model

The device tree separates concerns so future hosts do not inherit Hyper-V:

```text
shared/product.mk                    common Android userspace policy
shared/board/x86_64.mk               reusable x86-64-only ABI policy
products/hyperv_x86_64.mk            Hyper-V product identity and PI state
croissandro_hyperv_x86_64/           Hyper-V x86-64 board contract
```

A future ARM64 target should add `shared/board/arm64.mk` and its own product and
board directory. Linux and macOS backends should likewise have thin product and
board layers over `shared/`; they must not inherit the Hyper-V layer.

GTK and KDE are host UI implementations, not Android hardware products. They
should consume a shared Linux host-service API and select different host build
packages, while using the same Linux Android guest product.
