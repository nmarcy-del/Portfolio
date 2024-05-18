#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide a service name as an argument. Example: ./exec_shell.sh <service name>
Accessible containers:
    - server
    - admin
    - portfolio-mongodb
    - portfolio-nginx
    "
    exit 1
fi

echo "Running an interactive shell in container $1..."
docker-compose exec $1 sh

if [ $? -eq 0 ]; then
    echo "Interactive shell terminated successfully."
else
    echo "An error occurred while running the interactive shell."
    exit 1
fi
