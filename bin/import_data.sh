#!/bin/bash

# Nom par défaut du conteneur Docker
DOCKER_CONTAINER_NAME="portfolio-server"

# Fonction pour afficher l'usage et quitter
usage() {
    echo "Usage: $0 -f <file_name> or $0 --file <file_name>"
    exit 1
}

# Lecture des options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--file)
            if [ -n "$2" ] && [[ "$2" != -* ]]; then
                FILE_NAME="$2"
                shift
            else
                echo "Erreur : l'option $1 nécessite un argument."
                usage
            fi
            ;;
        *)
            echo "Option invalide : $1"
            usage
            ;;
    esac
    shift
done

# Vérification si le nom du fichier est défini
if [ -z "$FILE_NAME" ]; then
    echo "Erreur : le nom du fichier doit être spécifié."
    usage
fi

echo "Starting data import..."

echo "Docker container: $DOCKER_CONTAINER_NAME"
echo "Data file: $FILE_NAME"

echo "Running 'npm run data:import' command inside the Docker container..."
docker exec -it $DOCKER_CONTAINER_NAME npm run data:import $FILE_NAME
