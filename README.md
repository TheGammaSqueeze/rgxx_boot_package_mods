# rgxx_boot_package_mods - RG CubeXX

Big thank you for acmeplus in help steering me in the right direction on boot_package signing.
To update your disk image with this mod, overwrite the disk image from 0x1004000 with the contents of boot_package.fex (59.978Hz mod).

stock_boot_package.fex included in case you want to revert any changes.


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