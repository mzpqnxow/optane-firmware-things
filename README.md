# optane-firmware-things

Things for working Optane disks. So you don't need to read help output, or go searching forums
or regional Dell or Intel sites to find the firmware for your drive.

This repo is probably most useful for Dell OEM P4800X and P5800X, since the upgrade process
is poorly documented and the relevant files are difficult to find. These drives are widely
available on eBay, but are EOL as far as Intel and Dell are concerned

## Firmware Upgrades

The firmwares here are up2date as of 11/2025. **NONE OF THESE FILES HAVE BEEN MODIFIED, THEY RETAIN THE COPYRIGHT OF THEIR RESPECTIVE OWNER(S), DELL OR INTEL**

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
