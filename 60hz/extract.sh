#!/bin/bash

UBOOT_OFFSET="0x800"
MONITOR_OFFSET="0x101000"
P1_OFFSET="0x11b400"
SUNXI_OFFSET="0x11c000"

echo "Extracting stock_boot_package contents..."
dd if=stock_boot_package.fex of=u-boot.fex skip=$(($UBOOT_OFFSET)) count=$(($MONITOR_OFFSET)) bs=1
dd if=stock_boot_package.fex of=monitor.fex skip=$(($MONITOR_OFFSET)) count=$(($P1_OFFSET-$MONITOR_OFFSET)) bs=1
dd if=stock_boot_package.fex of=p1.dtbo skip=$(($P1_OFFSET)) count=$(($SUNXI_OFFSET-$P1_OFFSET)) bs=1
dd if=stock_boot_package.fex of=sunxi.fex skip=$(($SUNXI_OFFSET)) bs=1

echo "Done"