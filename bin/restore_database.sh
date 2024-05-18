#!/bin/bash

# Variables
container_name="portfolio-mongodb"

if [ -z "$1" ]; then
    echo "Please provide a backup file as an argument. Example: ./restore_database.sh <backup_file.gz>"
    exit 1
fi

backup_file="$1"

if [ ! -f "$backup_file" ]; then
    echo "Backup file not found: $backup_file"
    exit 1
fi

echo "Loading database from backup: $backup_file"
docker exec -i $container_name mongorestore --archive --gzip < "$backup_file"

if [ $? -eq 0 ]; then
    echo "Database restored successfully from $backup_file"
else
    echo "An error occurred while restoring the database."
    exit 1
fi