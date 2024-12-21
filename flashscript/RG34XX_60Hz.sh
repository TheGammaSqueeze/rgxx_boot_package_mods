#!/bin/bash

# Set locale to English
export LC_ALL=C

# Variables
DEVICE="/dev/mmcblk0"
OFFSET=0x1004000
FOLDER="$(dirname "$0")/flash"
FILE="$FOLDER/RG34XX_60Hz_boot_package.fex"
MAGIC_STRING="sunxi-package"
BLOCK_SIZE=1
LOG_FILE="$FOLDER/flash_$(date '+%Y%m%d_%H%M%S').log"

# Ensure the flash folder exists
mkdir -p "$FOLDER"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Check if the file exists
if [[ ! -f "$FILE" ]]; then
    log "Error: File '$FILE' not found in folder '$FOLDER'."
    exit 1
fi

# Read the first 14 bytes from the offset
EXISTING_DATA=$(dd if="$DEVICE" bs=$BLOCK_SIZE skip=$((OFFSET)) count=14 2>/dev/null | xxd -p -c 14 | tr -d '\n' | sed 's/00*$//')

# Convert MAGIC_STRING to hex
MAGIC_STRING_HEX=$(echo -n "$MAGIC_STRING" | xxd -p)

# Compare the existing data to the magic string in hex
if [[ "$EXISTING_DATA" != "$MAGIC_STRING_HEX" ]]; then
    log "Error: Data at offset does not start with '$MAGIC_STRING'. Found (hex): $EXISTING_DATA"
    log "Expected (hex): $MAGIC_STRING_HEX"
    exit 1
fi

# Overwrite the data from the file
if dd if="$FILE" of="$DEVICE" bs=$BLOCK_SIZE seek=$((OFFSET)) conv=notrunc 2>>"$LOG_FILE"; then
    log "Success: Data from '$FILE' written to $DEVICE at offset $OFFSET."
	reboot
else
    log "Error: Failed to write data to $DEVICE."
    exit 1
fi
