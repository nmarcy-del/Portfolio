#!/bin/bash

# Variables
container_name="portfolio-mongodb"
database_name="portfolio"

echo "Starting data cleaning for database: $database_name"

# Récupérer les noms des collections
collections=$(docker exec $container_name mongosh --quiet --eval "db.getMongo().getDB('$database_name').getCollectionNames().join(' ')" | tr -d '\r')

# Nettoyer les données de chaque collection sans supprimer les collections
for collection in $collections; do
    docker exec $container_name mongosh --quiet --eval "db.getMongo().getDB('$database_name').$collection.deleteMany({})"
    echo "Cleaned data from collection: $collection"
done

echo "Data cleaning completed for all collections in the database: $database_name"
