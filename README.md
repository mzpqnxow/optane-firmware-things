# optane-firmware-things

Things for working Optane disks. So you don't need to read help output, or go searching forums
or regional Dell or Intel sites to find the firmware for your drive.

This repo is probably most useful for Dell OEM P4800X and P5800X, since the upgrade process
is poorly documented and the relevant files are difficult to find. These drives are widely
available on eBay, but are EOL as far as Intel and Dell are concerned

## Firmware Upgrades

The firmwares here are up2date as of 11/2025.

**NONE OF THE APPLICATIONS OR FIMRWARE FILES IN THIS REPOSITORY HAVE BEEN MODIFIED, THEY ARE
COPIES OF FILES PUBLICLY AVAILABLE FOR DOWNLOAD FROM DELL OR INTEL. THEY RETAIN THE COPYRIGHT
OF THEIR RESPECTIVE OWNER(S)**

- Most of the time, you can use `intelmas -load -intelssd <drive-id>` and the firmware will
  be successfully upgraded to the latest, whether it's P4800X, P5800X, P5801X, etc. As long
  as it's a true Intel Optane and not OEM
- Optionally, you can use the SSDFUT tool (in `software/`) to make a bootable upgrader which
  is OS agnostic (it's a lightweight bootable Linux system that auto-runs the Intel tools)
- For OEM drives (e.g. Dell P5800x) this is not how it works
  - See the `firmware-Dell-<model>/` directories
- The `intelmas` and SSDFUT tools work by storing all of the firmwares in the data sections of
  ELF shared libraries. I have unpacked a few of them, but decided while interesting, it served
  no purpose.
  - If `intelmas` and SSDFUT are unable to detect the drive needs an upgrade, you can
    look into carving out the raw firmware from the ELF shared libraries in the Intel_MAS_CLT or the
    SSD_FUT archives in `software/`, then explicitly applying with `intelmas`. I'm not aware of this
    being necessary for any drives, though

## Scripts

Not complex, but helpful ...

- `optane-enumerate.sh`: Enumerate all Optane drives in the system
- `optane-firmware-update.sh`: Print the command needed to update a drive
- `optane-list-lbaf.sh`: List the supported LBAF for a drive
- `optane-set-lbaf.sh`: Set the LBAF on a drive

Remember that setting the LBAF will destroy data

## Extracting firmwares from SSD FUT and/or Intel MAS CLI

Some notes, but this ought not be necessary ...

- The SSDFUT and Intel MAS tools are auto-upgrade applications
- All of the latest firmwares for all supported models are embedded
  in ELF shared libraries, in the .data section
- If you're interested in extracting these:
  - Open the shared library
    - The libraries can be found in `/usr/lib/intelmas/FirmwareModules/`
    - They are named as `firmware_module_XX.so` (e.g. `firmware_module_nh.so`, `firmware_module_as.so`, etc.)
    - I don't know what the two letters mean, I only know different firmwares are in different libraries ...
  - Find the function named `GetTargetFirmwareBinary`
    - Find one of the first functions it calls with two arguments
    - Jump into the function, you will see one or more calls to string-compare-like function with a string
      argument like "U4110553_signed" (or similar)
      - A size and .data pointer are set for each of those names - you can carve them out from those
        locations in the ELF
      - radare2, headless IDA, etc. could do this most easily, probably ...
