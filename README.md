# rgxx_boot_package_mods

Big thank you for acmeplus in help steering me in the right direction on boot_package signing.
To update your disk image with this mod, overwrite the disk image from 0x1004000 with the contents of boot_package.fex (119.947Hz mod).

stock_boot_package.fex included in case you want to revert any changes.

119.947Hz mod works best with these settings:

# BFI (turn screen off for 30 seconds after the device boots, before using BFI):
![image](https://github.com/user-attachments/assets/ba50afef-5217-4ed5-a906-10bf240b6877)
![image](https://github.com/user-attachments/assets/3ab3ca08-138e-4362-8310-26bc1cdf4f3d)

# Normal (would prefer VSync Swap Interval = 2, but this is broken on Anbernic stock build) (Enable Shaders, use the misc/image-adjustment shader):
![image](https://github.com/user-attachments/assets/4c097a34-93dd-492d-8c74-50d6d761c2e8)
![image](https://github.com/user-attachments/assets/fd71fb52-c5c5-479f-b4d4-e318a2d034aa)
