#!/bin/bash

# Configuration
LOG_DIR="/var/log"
BACKUP_DIR="/backup/logs"
DAYS_TO_COMPRESS=7   # Compress logs older than 7 days
DAYS_TO_DELETE=30    # Delete logs older than 30 days

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Ask about the number of days
read -p "Enter number of days that logs older than (default => 30) : " DAYS_TO_DELETE

echo "🔹 Starting Log Rotation..."

# 1️⃣ Compress Old Logs (Older than 7 days)
echo "📦 Compressing logs older than $DAYS_TO_COMPRESS days..."
find $LOG_DIR -type f -name "*.log" -mtime +$DAYS_TO_COMPRESS -exec gzip {} \;

# 2️⃣ Move Compressed Logs to Backup
echo "📤 Moving compressed logs to backup..."
find $LOG_DIR -type f -name "*.gz" -mtime +$DAYS_TO_COMPRESS -exec mv {} $BACKUP_DIR \;

# 3️⃣ Delete Very Old Logs (Older than 30 days)
echo "🗑️ Deleting logs older than $DAYS_TO_DELETE days..."
find $BACKUP_DIR -type f -name "*.gz" -mtime +$DAYS_TO_DELETE -exec rm {} \;

echo "✅ Log Rotation Completed!"
