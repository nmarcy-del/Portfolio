(English version below)

# FR
## Pré-requis avant la création des containers locaux

  1. Avoir docker installé sur sa machine

  ```bash
  $ docker -v
  Docker version 20.10.22, build 3a2c30b
  ```

  2. Avoir openssl installé sur sa machine

  ```bash
  $ openssl version
  OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
  ```

  3. S'assurer que les lignes suivantes soient présente dans le host

  ```ini
  127.0.0.1 back.myapp.local
  127.0.0.1 admin.myapp.local
  127.0.0.1 front.myapp.local
  ```
  Le fichier se trouve sous
 
  ```bash
  /etc/hosts
  ```
  pour linux et macOS

  et dans 

  ```bash
  C:\Windows\System32\drivers\etc\hosts
  ```
  pour windows

  4. Récupérer l'ensemble des submodules nécessaire à l'exécution du projet (server, admin et frontend)

  ```bash
  git submodule update --init --recursive
  ```

  5. Copier les fichier nécessaires à la bonne exécution de votre env (il est possible de définir des environnements pour les futur deploiements)

  ```bash
  bin/copy-specifics.sh
  ```

## Générer un certificat SSL auto-signé pour une application locale (les commandes doivent être lancée depuis le dossier root de votre application)

Exécuter la commande (notez qu'il est possible de modifier la configuration en modifiant le script avant de l'exécuter)

  ```bash
  bin/generate_local_certificates.sh
  ```

  exemple de configuration : 

  ```bash
  [ subject ]
countryName                 = Country Name (2 letter code)
countryName_default         = CH
stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = Vaud
localityName                = Locality Name (eg, city)
localityName_default        = Lausanne
organizationName            = Organization Name (eg, company)
organizationName_default    = Portfolio
commonName                  = Common Name (e.g. server FQDN or YOUR name)
commonName_default          = *.myapp.local
commonName_max              = 64
  ``` 

Vous devriez maintenant avoir deux fichiers: myapp.local.key (clé privée) et myapp.local.crt (certificat auto-signé).

## Créer les dockers

  1. 
  
  ```bash
  bin/start_containers.sh
  ```

## Création d'un compte admin et importation de données samples

    1. Créer un nouvel admin :

  ```bash
  bin/create_admin.sh server
  ```

  2. Importer les samples data

  ```bash
  bin/import-data.sh -f sampleData.json
  ```

  (Ce script peut également servir à importer vos propre données, depuis un fichier json à placer dans server/data)

  ou 

  ```bash
  bin/restore_database.sh database_backups/sample_db_portfolio_project.gz
  ```

## Commandes utiles

  1. Faire un backup de la db

  ```bash
  bin/backup_database.sh
  ```

  Le backup est crée dans le dossier database_backups et peut être chargé via la commande : 

  ```bash
  bin/restore_database.sh database_backups/nomdufichier.gz
  ```

  (Ce script peut également servir à importer vos propre données, depuis un fichier json à placer dans server/data)

  2. Nettoyer la db (supprime toutes les données dans les collections)

  ```bash
  bin/clean_database.sh
  ```

  3. Rebuild les containers

  ```bash
  bin/build_containers.sh
  ```

  4. Demarrer les containers

  ```bash
  bin/start_containers.sh
  ```

  5. Stopper les containers

  ```bash
  bin/stop_containers.sh
  ```

  6. Supprimer les containers

  ```bash
  bin/remove_containers.sh
  ```

  7. Lister les user admins

  ```bash
  bin/list_admin.sh
  ```

## Problèmes connus

1. Le certificat autosigné est bloqué par le serveur : régler le soucis sur le navigateur utilisé

Exemple avec Firefox : https://support.mozilla.org/fr/kb/comment-regler-codes-erreur-securite-sur-sites-securises#w_certificats-auto-signes

# EN
## Prerequisites before creating local containers

  1. Have docker installed on your machine

  ```bash
  $ docker -v
  Docker version 20.10.22, build 3a2c30b
  ```

  2. Have openssl installed on your machine

  ```bash
  $ openssl version
  OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
  ```

  3. Make sure the following lines are present in the host

  ```ini
  127.0.0.1 back.myapp.local
  127.0.0.1 admin.myapp.local
  127.0.0.1 front.myapp.local
  ```
  The file is located under
 
  ```bash
  /etc/hosts
  ```
  for linux and macOS

  and in 

  ```bash
  C:\Windows\System32\drivers\etc\hosts
  ```

  for windows

  4. Retrieve all submodules needed to run the project (server, admin and frontend)

  ```bash
  git submodule update --init --recursive
  ```

  5. Copy the files you need to run your env (you can define environments for future deployments)

  ```bash
  bin/copy-specifics.sh
  ```

## Generate a self-signed SSL certificate for a local application (commands must be run from your application's root folder)

Execute the command (note that it is possible to modify the configuration by editing the script before executing it)

  ```bash
  bin/generate_local_certificates.sh
  ```

  configuration example : 

```bash
[ subject ]
countryName = Country Name (2 letter code)
countryName_default = CH
stateOrProvinceName = State or Province Name (full name)
stateOrProvinceName_default = Vaud
localityName = Locality Name (eg, city)
localityName_default = Lausanne
organizationName = Organization Name (eg, company)
organizationName_default = Portfolio
commonName = Common Name (e.g. server FQDN or YOUR name)
commonName_default = *.myapp.local
commonName_max = 64
``` 

You should now have two files: myapp.local.key (private key) and myapp.local.crt (self-signed certificate).

## Create the dockers

  1.
  ```bash
  bin/start_containers.sh
  ```

## Create admin account and import sample data

  1. Create a new admin :

  ```bash
  bin/create_admin.sh server
  ```

  2. Import sample data

  ```bash
  bin/import-data.sh -f sampleData.json
  ```

  (This script can also be used to import your own data, from a json file in server/data)

  or 

  ```bash
  bin/restore_database.sh database_backups/sample_db_portfolio_project.gz
  ```

## Useful commands

  1. Make a backup of the db

  ```bash
  bin/backup_database.sh
  ```

  The backup is created in the database_backups folder and can be loaded with the command : 

  ```bash
  bin/restore_database.sh database_backups/filename.gz
  ```

  (This script can also be used to import your own data, from a json file in server/data).

  2. Clean up db (deletes all data in collections)

  bash
  bin/clean_database.sh
  ```

  3. Rebuild containers

  ```bash
  bin/build_containers.sh
  ```

  4. Start containers

  ```bash
  bin/start_containers.sh
  ```

  5. Stop containers

  ```bash
  bin/stop_containers.sh
  ```

  6. Delete containers

  ```bash
  bin/remove_containers.sh
  ```

  7. List user admins

  ```bash
  bin/list_admin.sh
  ```

## Known problems

1. The self-signed certificate is blocked by the server: fix the problem in the browser used.

Firefox example: https://support.mozilla.org/fr/kb/comment-regler-codes-erreur-securite-sur-sites-securises#w_certificats-auto-signes
