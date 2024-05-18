#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide a service name as an argument. Example: bin/show_logs.sh <service name>
Accessible containers:
    - server
    - admin
    - portfolio-mongodb
    - portfolio-nginx
    "
    exit 1
fi

echo "Showing logs of container $1..."
docker-compose logs $1 -f

if [ $? -eq 0 ]; then
    echo "Logs displayed successfully."
else
    echo "An error occurred while displaying the logs."
    exit 1
fi
