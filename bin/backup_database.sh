#!/bin/bash

# Variables
backup_folder="./database_backups"
backup_file="db_backup_$(date +%Y-%m-%d_%H-%M-%S).gz"
container_name="portfolio-mongodb"

mkdir -p "$backup_folder"
docker exec $container_name mongodump --archive --gzip > "$backup_folder/$backup_file"

echo "Database backup completed and saved in the folder. $backup_folder/$backup_file"
