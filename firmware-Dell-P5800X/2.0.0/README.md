# Dell P5800x: Express-Flash-PCIe-SSD_Firmware_F63J5_LN64_2.0.0_A01.BIN

Specifically for Dell P5800X Optane drives. Unlike other Optane
.BIN files, this one is actually an x86-64 ELF. So there are
some caveats and different instructions depending on your system


## On Linux (Debian / Debian Live, probably others ...)

Simply run the .BIN file as an executable and it will perform the upgrade.
You can also use `--extract <dir>` to extract the contents of the upgrade,
including the raw firmware blob (which will be in `<dir>/payload`)

## Windows

If on Windows, use the file `Intel_P5800X_2.0.0.bin` as the firmware file and use
the standard firmware upgrade command for `intelmas`. This file was acquired using
`./Express-Flash-PCIe-SSD_Firmware_F63J5_LN64_2.0.0_A01.BIN --extract outdir` on
Debian

## Notes

You can run this on any modern x86-64 Linux system or Live CD. Debian 12 and Debian
13 work fine. You will get errors as it tries to open the IPMI that Dell systems
have, but you can ignore them. The update will apply successfully
