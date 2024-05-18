#!/bin/bash

echo "Restarting Docker containers..."
docker-compose stop && docker-compose up -d

if [ $? -eq 0 ]; then
    echo "The Docker containers have been successfully restarted."
else
    echo "An error occurred while restarting the Docker containers."
    exit 1
fi

echo "To check the logs, use the command: docker-compose logs -f."