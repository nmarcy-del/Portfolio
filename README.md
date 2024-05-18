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

  1. ```bash
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