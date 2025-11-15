# Dell P4800X: Express-Flash-PCIe-SSD_Firmware_RRR52_LN64_E201DP37_A05_01.BIN

Firmware upgrade for Dell version of P4800X

## Files

You can choose from one of two methods - either run the `.BIN` file on a Linux system, or use `intelmas` to
flash the raw firmware image

- `E201DP38_non_uefi_EB3B0448_DP38_LS_WFEM01S2_signed.bin`: Raw firmware image, use with `intelmas` on Linux or Windows
- `Express-Flash-PCIe-SSD_Firmware_HMRK7_LN64_E201DP38_A07_01.BIN`: Self-extracting shell script, to upgrade, run as root on Linux

## Linux / Linux Live

Use any modern Linux system or Live CD, run this as root, and the update will be applied.
Ignore any errors about failing to interact with IPMI. This is because Dell expects this
update to run on Dell hardware. It's not necessary for the upgrade to work.

## Windows

The file `E201DP38_non_uefi_EB3B0448_DP38_LS_WFEM01S2_signed.bin` has been unpacked for you
from the `Express-Flash-PCIe-SSD_Firmware_HMRK7_LN64_E201DP38_A07_01.BIN` file. It can be used
with `intelmas` to upgrade from Windows
