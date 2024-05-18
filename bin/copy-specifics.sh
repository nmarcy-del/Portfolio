#!/bin/bash

# Définir le répertoire du script
script_dir=$(dirname "$(readlink -f "$0")")

# Définir le répertoire de destination (parent du script)
dest_dir="$script_dir/.."

# Définir les répertoires source
source_dirs=("$dest_dir/specific" "$dest_dir/server/specific" "$dest_dir/admin/specific" "$dest_dir/frontend/specific")

# Environnement par défaut
env="local"

# Activer dotglob pour inclure les fichiers cachés
shopt -s dotglob

# Fonction pour copier les fichiers
copy_files() {
    local source_dir="$1"
    local extension=".$env"

    for file in "$source_dir"/*"$extension"
    do
        if [ -f "$file" ]; then
            base_name="${file##*/}"
            base_name="${base_name%$extension}"

            # Définir le chemin complet du fichier source et destination
            full_path="$source_dir/$base_name$extension"
            dest_path="${source_dir%/specific}/$base_name"

            cp "$file" "$dest_path"
        fi

        echo "Ok"
    done
}

# Fonction pour valider l'environnement
is_valid_env() {
    local env_value="$1"
    case "$env_value" in
        local|staging|prod)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Lecture des options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -e|--env)
            if is_valid_env "$2"; then
                env="$2"
                shift
            else
                echo "Invalid environment: $2. Allowed values are 'local', 'staging' and 'prod'."
                exit 1
            fi
            ;;
        *)
            echo "Invalid option: $1" >&2
            exit 1
            ;;
    esac
    shift
done

# Parcourir les répertoires source et copier les fichiers
for source_dir in "${source_dirs[@]}"; do
    if [ -d "$source_dir" ]; then
        copy_files "$source_dir"
    else
        echo "The $source_dir folder does not exist."
    fi
done

# Désactiver dotglob après la copie
shopt -u dotglob
