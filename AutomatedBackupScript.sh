#!/bin/bash

# Backup Configuration
BACKUP_DIR="/backup"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
WEB_DIR="/var/www/html"
DB_USER="root"
DB_PASSWORD="your_password"
DB_NAME="your_database"
RETENTION_DAYS=7

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

echo "🔹 Starting Backup Process..."

# 1️⃣ Backup Website Files
echo "📁 Backing up website files..."
tar -czf $BACKUP_DIR/web_backup_$TIMESTAMP.tar.gz $WEB_DIR

# 2️⃣ Backup MySQL Database
echo "🛢️ Backing up MySQL database..."
mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/db_backup_$TIMESTAMP.sql
gzip $BACKUP_DIR/db_backup_$TIMESTAMP.sql  # Compress SQL file

# 3️⃣ Delete Old Backups
echo "🗑️ Removing backups older than $RETENTION_DAYS days..."
find $BACKUP_DIR -type f -mtime +$RETENTION_DAYS -exec rm {} \;

echo "✅ Backup Completed Successfully!"
