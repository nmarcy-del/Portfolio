#!/bin/bash

DOCKER_CONTAINER_NAME="portfolio-server"
FILE_NAME="sampleData.json"

echo "Starting data import..."

echo "Docker container: $DOCKER_CONTAINER_NAME"
echo "Data file: $FILE_NAME"

echo "Running 'npm run data:import' command inside the Docker container..."
docker exec -it $DOCKER_CONTAINER_NAME npm run data:import $FILE_NAME
