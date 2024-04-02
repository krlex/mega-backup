#!/bin/bash

# Set your Mega credentials
MEGA_USERNAME="your_mega_username"
MEGA_PASSWORD="your_mega_password"

# Set the directory to backup
BACKUP_DIR="/path/to/backup/dir"

# Set the remote directory in Mega
MEGA_REMOTE_DIR="/Remote/Directory"

# Archive filename
BACKUP_FILENAME="backup_$(date +%Y-%m-%d_%H-%M-%S)"

# Compression format menu
select COMPRESSION_FORMAT in "tar.gz" "tar.bz2" "zip" "rar"; do
    case $COMPRESSION_FORMAT in
        "tar.gz")
            BACKUP_FILENAME="$BACKUP_FILENAME.tar.gz"
            tar_cmd="tar -zcvf"
            break
            ;;
        "tar.bz2")
            BACKUP_FILENAME="$BACKUP_FILENAME.tar.bz2"
            tar_cmd="tar -jcvf"
            break
            ;;
        "zip")
            BACKUP_FILENAME="$BACKUP_FILENAME.zip"
            tar_cmd="zip -r"
            break
            ;;
        "rar")
            BACKUP_FILENAME="$BACKUP_FILENAME.rar"
            tar_cmd="rar a"
            break
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done

# Archive the directory
echo "Creating backup archive..."
$tar_cmd "$BACKUP_FILENAME" "$BACKUP_DIR"

# Upload to Mega
echo "Uploading backup to Mega..."
megaput --username="$MEGA_USERNAME" --password="$MEGA_PASSWORD" --path="$MEGA_REMOTE_DIR" "$BACKUP_FILENAME"

# Clean up
echo "Cleaning up..."
rm "$BACKUP_FILENAME"

echo "Backup completed successfully."
