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
LENGTH=$((0x140000))  # 140,000 hex bytes
LOG_FILE="$SCRIPT_DIR/flash/backup.log"

# Ensure the flash folder exists
mkdir -p "$SCRIPT_DIR/flash"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting backup of $DEVICE at offset $OFFSET for $LENGTH bytes."

# Backup data
if dd if="$DEVICE" bs=$BLOCK_SIZE skip=$((OFFSET)) count=$LENGTH of="$BACKUP_FILE" 2>>"$LOG_FILE"; then
    log "Success: Backup saved to $BACKUP_FILE."
else
    log "Error: Failed to back up data from $DEVICE."
    exit 1
fi
