#!/bin/bash

echo "Stopping Docker containers..."
docker-compose down

if [ $? -eq 0 ]; then
    echo "The Docker containers have been successfully stopped."
else
    echo "An error occurred while stopping the Docker containers."
    exit 1
fi