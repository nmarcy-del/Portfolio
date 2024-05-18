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

  4. @todo récupération des dossiers admin, server et frontend depuis Git

  5. @todo copy des fichiers .local (env, dockerfile, docker-compose) sur l'ensemble des projets via script

## Générer un certificat SSL auto-signé pour une application locale (les commandes doivent être lancée depuis le dossier root de votre application)

  1. @todo script de generation de clé ssl

Vous devriez maintenant avoir deux fichiers: myapp.local.key (clé privée) et myapp.local.crt (certificat auto-signé).

## Créer les dockers

  1. @todo procédure création docker scripts

## Création d'un compte admin et importation de données samples

  1. @todo creation admin (script ?)
  2. @todo importation données de test via scripts

## Commandes utiles

  @todo description des scripts de développement local
  @todo lancement de commande de création d'admin depuis le container server
  @todo import des données depuis container server

## Problèmes connus

1. Le certificat autosigné est bloqué par le serveur : régler le soucis sur le navigateur utilisé

Exemple avec Firefox : https://support.mozilla.org/fr/kb/comment-regler-codes-erreur-securite-sur-sites-securises#w_certificats-auto-signes