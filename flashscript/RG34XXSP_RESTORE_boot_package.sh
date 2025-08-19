#!/bin/bash

# Set locale to English
export LC_ALL=C

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Variables
DEVICE="/dev/mmcblk0"
OFFSET=0x1004000
BACKUP_FILE="$SCRIPT_DIR/flash/backup.bin"
BLOCK_SIZE=1
MAGIC_STRING="sunxi-package"
MAGIC_STRING_HEX=$(echo -n "$MAGIC_STRING" | xxd -p)
LOG_FILE="$SCRIPT_DIR/flash/restore.log"

# Ensure the flash folder exists
mkdir -p "$SCRIPT_DIR/flash"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting restore process."

# Check if the backup file exists
if [[ ! -f "$BACKUP_FILE" ]]; then
    log "Error: Backup file '$BACKUP_FILE' not found!"
    exit 1
fi

# Validate sunxi-package in the backup file
log "Validating backup file..."
BACKUP_MAGIC=$(dd if="$BACKUP_FILE" bs=$BLOCK_SIZE count=14 2>/dev/null | xxd -p -c 14 | tr -d '\n' | sed 's/00*$//')
if [[ "$BACKUP_MAGIC" != "$MAGIC_STRING_HEX" ]]; then
    log "Error: Backup file does not start with '$MAGIC_STRING'. Found (hex): $BACKUP_MAGIC"
    log "Expected (hex): $MAGIC_STRING_HEX"
    exit 1
fi
log "Backup file validation passed."

# Validate sunxi-package in the target device
log "Validating target device ($DEVICE)..."
DEVICE_MAGIC=$(dd if="$DEVICE" bs=$BLOCK_SIZE skip=$((OFFSET)) count=14 2>/dev/null | xxd -p -c 14 | tr -d '\n' | sed 's/00*$//')
if [[ "$DEVICE_MAGIC" != "$MAGIC_STRING_HEX" ]]; then
    log "Error: Target device does not start with '$MAGIC_STRING' at offset $OFFSET. Found (hex): $DEVICE_MAGIC"
    log "Expected (hex): $MAGIC_STRING_HEX"
    exit 1
fi
log "Target device validation passed."

# Restore data from the backup file
log "Restoring data from $BACKUP_FILE to $DEVICE at offset $OFFSET..."
if dd if="$BACKUP_FILE" of="$DEVICE" bs=$BLOCK_SIZE seek=$((OFFSET)) conv=notrunc 2>>"$LOG_FILE"; then
    log "Success: Data from '$BACKUP_FILE' restored to $DEVICE at offset $OFFSET."
    reboot
else
    log "Error: Failed to restore data to $DEVICE."
    exit 1
fi
