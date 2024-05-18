#!/bin/bash

# Source files list
files=(
  "./specific/docker-compose.local"
  "./specific/nginx.conf.local"
  "server/specific/Dockerfile.local"
  "server/specific/.env.local"
  "admin/specific/.env.local"
  "admin/specific/Dockerfile.local"
  "frontend/specific/.env.local"
  "frontend/specific/Dockerfile.local"
)

# Copy each file without .local extension
for file in "${files[@]}"; do
  if [ -e "$file" ]; then
    parent_directory=$(dirname "$file")
    parent_of_parent_directory=$(dirname "$parent_directory")
    filename=$(basename "${file%.local}")
    destination="${parent_of_parent_directory}/${filename}"
    cp "$file" "$destination"
    echo "Copy of $file to $destination completed."
  else
    echo "Error: File $file not found."
  fi
done
