#!/bin/bash

container_name="portfolio-server"

script_to_run="npm run-script admin:user:show"

if [ "$(docker ps -q -f name=$container_name)" ]; then
    echo "Le conteneur $container_name est en cours d'exécution."
else
    echo "Erreur : le conteneur $container_name n'est pas en cours d'exécution."
    exit 1
fi

docker exec -it $container_name $script_to_run