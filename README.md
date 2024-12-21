# rgxx_boot_package_mods - RG CubeXX

Big thank you for acmeplus in help steering me in the right direction on boot_package signing.
To update your disk image with this mod, overwrite the disk image from 0x1004000 with the contents of boot_package.fex (59.978Hz mod).

stock_boot_package.fex included in case you want to revert any changes.

------
# Flashing
I've now added a flashscript zip file to this repo to allow easy flashing of these mods.
I am not responsible for if this does not work on any CFW, these have been tested on Stock firmware. 

Extract the contents of the flashscript folder into your Ports folder, then execute the scripts directly from your ports menu.
Ensure you take a backup of your existing data, use the RG**XX_BACKUP_boot_package.sh script to do this. 

Then proceed to flash the fixed 60Hz patch, this will take up to 1 minute (will just show a loading screen during this time), your device will reboot automatically when this is done.

RG**XX_RESTORE_boot_package.sh will restore your initial backup and reboot.

------

# Timings

59.978Hz:
```
lcd_dclk_freq = <48>;
lcd_ht = <1060>;
lcd_vt = <755>;
```

Stock:
```
lcd_dclk_freq = <36>;
lcd_ht = <812>;
lcd_vt = <756>;
```