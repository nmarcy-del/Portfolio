#!/bin/bash

echo "Stopping running Docker containers..."
docker-compose down

echo "Installing local dependencies required for container building."

cd ./admin && npm install && cd ..
cd ./server && npm install && cd ..

echo "Building Docker images..."
docker-compose build

if [ $? -eq 0 ]; then
    echo "The Docker images have been successfully (re)built."

    echo "Starting Docker containers..."
    docker-compose up -d

    if [ $? -eq 0 ]; then
        echo "The Docker containers have been successfully started."

        echo "You can use the following URLs for your application:
  https://admin.myapp.local (administration interface)
  https://back.myapp.local (backend server)
  https://front.myapp.local (portfolio website)"
    else
        echo "An error occurred while starting the Docker containers."
        exit 1
    fi
else
    echo "An error occurred while building the Docker images."
    exit 1
fi

echo "To check the logs, use the command: docker-compose logs -f."