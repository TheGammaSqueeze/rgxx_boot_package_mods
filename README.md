# rgxx_boot_package_mods

Big thank you for acmeplus in help steering me in the right direction on boot_package signing.
To update your disk image with this mod, overwrite the disk image from 0x1004000 with the contents of boot_package.fex (119.947Hz or 60.006Hz mod).

stock_boot_package.fex included in case you want to revert any changes.

------
# 119.947Hz mod works best with these settings:

**BFI (turn screen off for 30 seconds after the device boots, before using BFI):**
![image](https://github.com/user-attachments/assets/ba50afef-5217-4ed5-a906-10bf240b6877)
![image](https://github.com/user-attachments/assets/3ab3ca08-138e-4362-8310-26bc1cdf4f3d)

**Normal (option 1) (would prefer VSync Swap Interval = 2, but this is broken on Anbernic stock build) (Enable Shaders, use the misc/image-adjustment shader):**
![image](https://github.com/user-attachments/assets/4c097a34-93dd-492d-8c74-50d6d761c2e8)
![image](https://github.com/user-attachments/assets/fd71fb52-c5c5-479f-b4d4-e318a2d034aa)

**Normal (option 2) (no shader needed, set Sync to Exact Content Framerate to ON)**
![image](https://github.com/user-attachments/assets/53d7f613-1552-4448-8c6d-8e31cc438558)

-------

# Timings

60.006Hz:
```
lcd_dclk_freq = <54>;
lcd_ht = <1679>;
lcd_vt = <536>;
```

119.947Hz:
```
lcd_dclk_freq = <54>;
lcd_ht = <840>;
lcd_vt = <536>;
```

Stock:
```
lcd_dclk_freq = <26>;
lcd_ht = <820>;
lcd_vt = <536>;
```

My personal finding is that the kernel is actually ignoring the stock 26Mhz clock and falls back to a higher clock anyway. 
54Mhz seems to be inline with accurate timing calculations, anything lower than this and the timing calculation and actual refresh rate don't match.

------

# Image retention

When using Black Frame Insertion (BFI) on 120Hz LCD/IPS screens, you may occasionally encounter image retention. This phenomenon is not the same as burn-in typically associated with OLED displays. Instead, it is a temporary effect where faint remnants of static images appear to linger on the screen even after the content changes.

**What Causes Image Retention with BFI?**
Image retention occurs because BFI enhances motion clarity by inserting black frames between regular frames, effectively reducing motion blur. However, the repeated flashing of high-contrast or static elements, such as UI elements, text, or logos, can leave an impression on the screen. The screen's pixels temporarily "hold onto" these images due to the rapid switching and contrast.

**How to Address Image Retention**
- Allow Recovery Time: Image retention typically fades on its own after displaying dynamic or neutral content for a short time. Simply turn off BFI and play your games as normal
- Screen Conditioning: If you have a more persistent case of Image Retention, you can force a refresh by doing the following:
  - Download the stuck_pixels.mb.gba GBA rom from this repo and store on your RG34XX.
  - Run this GBA ROM, and follow the on screen instructions, the screen will start flashing different colors.
  - Open the RetroArch menu, enable the LCD3x shader, then turn BFI off, Sync to Exact Content Framerate to off and Audio Sync off.
  - Leave for 30 minutes.
  - The screen will now be cleared up. You can close the ROM and revert your settings back to normal.

By taking these steps, you can enjoy the benefits of BFI on 120Hz screens without worrying about prolonged image retention.
