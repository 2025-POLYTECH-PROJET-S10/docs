Doc realisé par :  **Ali FAWAZ, Romain HOCQUET, Alexandre MOUA, Brice VITTET**


# Documentation pour le développement du plugin Moodle "Foetapp360"


---

# Table des matières

- [Documentation pour le développement du plugin Moodle "Foetapp360"](#documentation-pour-le-développement-du-plugin-moodle-foetapp360)
  - [Introduction](#introduction)
    - [Liens utiles](#liens-utiles)
  - [Installation (pour utilisateurs)](#installation-pour-utilisateurs)
    - [Prérequis](#prérequis)
    - [Étapes d'installation](#étapes-dinstallation)
      - [1. Télécharger le plugin](#1-télécharger-le-plugin)
      - [2. Placer le plugin dans le bon dossier](#2-placer-le-plugin-dans-le-bon-dossier)
      - [3. Vérifier les permissions](#3-vérifier-les-permissions)
      - [4. Procéder à l'installation via l'administration Moodle](#4-procéder-à-linstallation-via-ladministration-moodle)
      - [5. Vérification](#5-vérification)
      - [6. Utilisation du plugin](#6-utilisation-du-plugin)
    - [Mise à jour du plugin](#mise-à-jour-du-plugin)
    - [Désinstallation](#désinstallation)
    - [Support](#support)
  - [Installation avec Docker (pour développeurs uniquement)](#installation-avec-docker-pour-développeurs-uniquement)
    - [Composants fournis](#composants-fournis)
    - [Structure du fichier `docker-compose.yml`](#structure-du-fichier-docker-composeyml)
    - [Fonctionnement du script `reset_docker.sh`](#fonctionnement-du-script-reset_dockersh)
    - [Instructions pour les développeurs](#instructions-pour-les-développeurs)
  - [Base de données (`db/install.xml`)](#base-de-données-dbinstallxml)
    - [Table: `foetapp360`](#table-foetapp360)
    - [Table: `foetapp360_datasets`](#table-foetapp360_datasets)
    - [Table: `foetapp360_session`](#table-foetapp360_session)
    - [Table: `foetapp360_attempt`](#table-foetapp360_attempt)
    - [Table: `foetapp360_feedback`](#table-foetapp360_feedback)
    - [Table: `foetapp360_feedback_data`](#table-foetapp360_feedback_data)
  - [Vue Statistiques (`stats.php`)](#vue-statistiques-statsphp)
  - [Page "Mes Statistiques" (`mystats.php`)](#page-mes-statistiques-mystatsphp)
  - [Page de consultation (`view.php`)](#page-de-consultation-viewphp)
  - [Formulaire d'ajout/modification (`db_form_submission.php`)](#formulaire-dajoutmodification-db_form_submissionphp)
  - [Librairie (`lib.php`)](#librairie-libphp)
  - [Fonctions essentielles implémentées dans `lib.php`](#fonctions-essentielles-implémentées-dans-libphp)
  - [Autres parties importantes à mentionner](#autres-parties-importantes-à-mentionner)
  - [Vue principale (`index.php`)](#vue-principale-indexphp)
  - [Image Manager `image_manager.php`](#image-manager-image_managerphp)
    - [Vue d’ensemble du stockage des données](#vue-densemble-du-stockage-des-données)
    - [Constructeur de la classe](#constructeur-de-la-classe)
    - [Résumé](#résumé)
  - [Fonctionnalités supplémentaires à développer](#fonctionnalités-supplémentaires-à-développer)
    - [I - Ajouter/Choisir une Présentation](#i-ajouterchoisir-une-présentation)
      - [Contexte](#contexte)
    - [II - Fonctionnalité de groupe de Dataset](#ii-fonctionnalité-de-groupe-de-dataset)
      - [Contexte](#contexte-1)
    - [III - Graphe qui montre le taux d’erreur en fonction de la représentation donnée](#iii-graphe-qui-montre-le-taux-derreur-en-fonction-de-la-représentation-donnée)
      - [Contexte](#contexte-2)
  - [Annexes et notes complémentaires](#annexes-et-notes-complémentaires)
- [Doc Moodle](#doc-moodle)
  - [Sources](#sources)
  - [Liens intéressants](#liens-intéressants)
  - [Ajouter module/plugin](#ajouter-moduleplugin)
  - [I - Plugin d’activité](#i-plugin-dactivité)
    - [I.1 - access.php](#i1-accessphp)
    - [I.2 - events.php](#i2-eventsphp)
    - [I.3 - install.xml](#i3-installxml)
    - [I.4 - upgrade.php](#i4-upgradephp)
    - [I.5 - mobile.php](#i5-mobilephp)
    - [I.6 - Language String Definition](#i6-language-string-definition)
    - [I.7 - lib.php](#i7-libphp)
    - [I.8 - mod_form - Création/Modification d’instance](#i8-mod_form-créationmodification-dinstance)
  - [II - Upgrade un plugin](#ii-upgrade-un-plugin)
    - [II.a - version.php](#iia-versionphp)
    - [II.b - install.xml](#iib-installxml)
    - [II.c - upgrade.php](#iic-upgradephp)
  - [Annexe - Code utile en PHP](#annexe-code-utile-en-php)

---


## Introduction: {#introduction}

Cette documentation comporte certaines informations pour vous permettre de comprendre l’environnement Moodle. Il est vrai que Moodle peut sembler compliqué au début. Il existe énormément de documentation en ligne, mais elle est plus ou moins efficace.

Ainsi, pour comprendre certaines parties de Moodle, il faut d’abord consulter la documentation officielle. Si vous ne trouvez pas la réponse que vous recherchez, vous pouvez ensuite explorer le code de Moodle. C’est d’ailleurs ce que j’ai souvent fait, par exemple, pour comprendre la classe *moodleform*.

On a galéré au début pour comprendre comment Moodle fonctionne. Mais une fois que vous comprenez comment ça marche et où chercher, cela devient beaucoup plus facile de développer et de résoudre les bugs, même si vous n’avez jamais travaillé en PHP auparavant (ce qui était le cas pour les ¾ de notre équipe).


### Liens utiles:

Lien Projet Github (Lien général): [https://github.com/orgs/2025-POLYTECH-PROJET-S10](https://github.com/orgs/2025-POLYTECH-PROJET-S10)

Lien Plugin Github (pour développement): [https://github.com/2025-POLYTECH-PROJET-S10/foetapp360](https://github.com/2025-POLYTECH-PROJET-S10/foetapp360)

Lien Plugin Github (documentation): [https://github.com/2025-POLYTECH-PROJET-S10/docs](https://github.com/2025-POLYTECH-PROJET-S10/docs)

Lien Plugin Github (fichier compressé): [https://github.com/2025-POLYTECH-PROJET-S10/foetapp360_zip](https://github.com/2025-POLYTECH-PROJET-S10/foetapp360_zip)


## Installation (pour utilisateurs): {#installation-pour-utilisateurs}


### Prérequis {#prérequis}

Avant de commencer, assurez-vous d’avoir :



* Une instance Moodle version **4.1 ou supérieure**.
* Un accès administrateur au serveur Moodle.
* Un accès aux fichiers du serveur (via FTP, SSH ou gestionnaire de fichiers).


---


### Étapes d'installation {#étapes-d'installation}


#### 1. Télécharger le plugin {#1-télécharger-le-plugin}

Téléchargez la dernière version de **foetapp360** depuis Github: [https://github.com/2025-POLYTECH-PROJET-S10/foetapp360_zip](#)

Le fichier sera au format **ZIP**.


---


#### 2. Placer le plugin dans le bon dossier {#2-placer-le-plugin-dans-le-bon-dossier}



1. Décompressez le fichier ZIP téléchargé.
2. Copiez le dossier **foetapp360** dans le répertoire suivant :

/moodle/mod/foetapp360

**Important :** Le dossier doit obligatoirement porter le nom exact `foetapp360`.


---


### 3. Vérifier les permissions {#3-vérifier-les-permissions}

Attribuez les bonnes permissions pour éviter les problèmes :

*chmod -R 755 /chemin/vers/moodle/mod/foetapp360*

*chown -R www-data:www-data /chemin/vers/moodle/mod/foetapp360*

*(Remplacez <code>www-data</code> par l’utilisateur utilisé par votre serveur.)*


---


#### 4. Procéder à l'installation via l'administration Moodle {#4-procéder-à-l'installation-via-l'administration-moodle}



1. Connectez-vous en tant qu’administrateur.
2. Allez dans :

Administration du site -> Notifications

Moodle détectera automatiquement le plugin **foetapp360**.



3. Cliquez sur **Continuer** et suivez les étapes pour finaliser l'installation.


---


#### 5. Vérification {#5-vérification}

Vérifiez que le plugin est bien installé :



1. Accédez à :

Administration du site -> Plugins -> Activités -> Gérer les activités



2. Le plugin **foetapp360** doit apparaître dans la liste.


---


#### 6. Utilisation du plugin {#6-utilisation-du-plugin}

Pour ajouter l’activité **foetapp360** dans un cours :



1. Accédez au cours souhaité.
2. Activez le mode édition.
3. Cliquez sur **Ajouter une activité ou une ressource**.
4. Sélectionnez **foetapp360** dans la liste.

Configurez les paramètres selon vos besoins puis sauvegardez.


---


### Mise à jour du plugin {#mise-à-jour-du-plugin}

Pour mettre à jour le plugin :



1. Téléchargez la dernière version.
2. Remplacez le dossier existant :

/moodle/mod/foetapp360



3. Connectez-vous à Moodle, puis allez dans :

Administration du site -> Notifications

Suivez les instructions pour terminer la mise à jour.


---


### Désinstallation {#désinstallation}

Pour désinstaller **foetapp360** :



1. Allez dans :

Administration du site -> Plugins -> Activités -> Gérer les activités



2. Trouvez **foetapp360** et cliquez sur **Désinstaller**.


---


### Support {#support}

**Si vous rencontrez des problèmes liés à notre implémentation de Moodle (nous avons travaillé sur ce plugin jusqu’au 03/2025), n’hésitez pas à nous contacter par mail :**

📧 Emails : [ali.fawaz.dev@outlook.com](mailto:ali.fawaz.dev@outlook.com) (Ali FAWAZ), [alexmoua.hmong@gmail.com](mailto:alexmoua.hmong@gmail.com) (Alexandre MOUA), [brice4.vittet4@gmail.com](mailto:brice4.vittet4@gmail.com) (Brice VITTET), [romain.hocquet1@gmail.com](mailto:romain.hocquet1@gmail.com) (Romain HOCQUET)

**Bon usage du plugin foetapp360 !**


## Installation avec Docker (pour développeurs uniquement): {#installation-avec-docker-pour-développeurs-uniquement}

Afin de faciliter le processus de développement, nous proposons une solution clé en main pour exécuter Moodle et le plugin **foetapp360** à l'aide de conteneurs Docker.


### Composants fournis {#composants-fournis}



* **<code>docker-compose.yml</code>** : Fichier de configuration Docker orchestrant les services Moodle, MySQL et phpMyAdmin.
* **<code>reset_docker.sh</code>** : Script shell automatisant la réinitialisation de l'environnement pour forcer la détection du plugin.


---


### Structure du fichier `docker-compose.yml` {#structure-du-fichier-docker-compose-yml}

Ce fichier définit trois services principaux :



1. **moodle** : Conteneur basé sur l'image Bitnami Moodle (version 4.5), exposé sur le port 8080. Le plugin **foetapp360 **y est monté dynamiquement via un volume local.
2. **db** : Service de base de données MySQL 8.0, configuré avec des identifiants par défaut adaptés à Moodle.
3. **phpmyadmin** : Interface web de gestion de base de données, accessible sur le port 8081, pour faciliter l'inspection et l'administration de MySQL.

Des volumes persistent les données pour Moodle, MoodleData et MySQL, et tous les services sont connectés via un réseau Docker commun `moodle-net`.


---


### Fonctionnement du script `reset_docker.sh` {#fonctionnement-du-script-reset_docker-sh}

Le script assure une réinitialisation complète et propre de l'environnement Docker en suivant les étapes suivantes :



1. **Arrêt et suppression des conteneurs existants ainsi que des volumes associés**.
2. **Commentaire temporaire de la ligne de montage du plugin dans le fichier <code>docker-compose.yml</code>** afin de purger l'environnement sans le plugin.
3. **Démarrage des conteneurs sans le plugin pour initialiser Moodle proprement**.
4. **Pause de 65 secondes** pour garantir l'initialisation complète, vous pouver changer cette durée selon la puissance de votre ordinateur.
5. **Arrêt des conteneurs**.
6. **Réactivation du montage du plugin** en décommentant la ligne.
7. **Redémarrage final des conteneurs avec le plugin correctement monté**.

Cette séquence permet d'assurer la détection et l'installation automatique du plugin par Moodle lors du redémarrage.

**Note: le script à été exécuté sur macOS, il faut changer la commande *<span style="text-decoration:underline;">sed</span>* afin qu’il soit compatible avec linux (il faut enlever le premier argument du texte vide).**


---


### Instructions pour les développeurs {#instructions-pour-les-développeurs}



1. Clonez le dépôt contenant les fichiers `docker-compose.yml`, `reset_docker.sh` et le dossier du plugin **foetapp360**.
2. Rendez le script exécutable :

*chmod +x reset_docker.sh*



1. Exécutez le script :

*./reset_docker.sh*



1. Accédez à l'interface Moodle depuis votre navigateur :

*http://localhost:8080*

Utilisez les identifiants suivants pour vous connecter :



* **Nom d'utilisateur :** admin
* **Mot de passe :** 12345
1. Pour administrer la base de données, connectez-vous à phpMyAdmin :

*http://localhost:8081*


---


## Base de données (`db/install.xml`): {#base-de-données-db-install-xml}


### Table: `foetapp360` {#table-foetapp360}

Stocke les instances du module d'activité **foetapp360**.

Ceci est nécessaire pour modeler, vous avez le droit d’ajouter des champs, mais cette structure est la minimum et vous pouvez pas enlever des champs.


<table>
  <tr>
   <td><strong>Champ</strong>
   </td>
   <td><strong>Type</strong>
   </td>
   <td><strong>Longueur</strong>
   </td>
   <td><strong>Null</strong>
   </td>
   <td><strong>Défaut</strong>
   </td>
   <td><strong>Commentaire</strong>
   </td>
  </tr>
  <tr>
   <td>id
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Identifiant unique (clé primaire, auto-incrémenté)
   </td>
  </tr>
  <tr>
   <td>course
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>ID du cours contenant l'activité
   </td>
  </tr>
  <tr>
   <td>name
   </td>
   <td>char
   </td>
   <td>255
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Nom de l'activité
   </td>
  </tr>
  <tr>
   <td>timecreated
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Timestamp de création
   </td>
  </tr>
  <tr>
   <td>timemodified
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Timestamp de modification
   </td>
  </tr>
  <tr>
   <td>intro
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Description de l'activité
   </td>
  </tr>
  <tr>
   <td>introformat
   </td>
   <td>int
   </td>
   <td>4
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Format de la description
   </td>
  </tr>
</table>


**Clés:**



* Clé primaire: `id`
* Clé étrangère: `course` → `course(id)`


---


### Table: `foetapp360_datasets` {#table-foetapp360_datasets}

Stocke les ensembles de données pour l'exercice.


<table>
  <tr>
   <td><strong>Champ</strong>
   </td>
   <td><strong>Type</strong>
   </td>
   <td><strong>Longueur</strong>
   </td>
   <td><strong>Null</strong>
   </td>
   <td><strong>Commentaire</strong>
   </td>
  </tr>
  <tr>
   <td>id
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>Identifiant unique (clé primaire, auto-incrémenté)
   </td>
  </tr>
  <tr>
   <td>name
   </td>
   <td>char
   </td>
   <td>255
   </td>
   <td>Non
   </td>
   <td>Nom de la position
   </td>
  </tr>
  <tr>
   <td>sigle
   </td>
   <td>char
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>Sigle de la position
   </td>
  </tr>
  <tr>
   <td>rotation
   </td>
   <td>int
   </td>
   <td>3
   </td>
   <td>Non
   </td>
   <td>Angle de rotation en degrés
   </td>
  </tr>
  <tr>
   <td>inclinaison
   </td>
   <td>int
   </td>
   <td>1
   </td>
   <td>Non
   </td>
   <td>Inclinaison (1 = bien fléchi, -1 = mal fléchi)
   </td>
  </tr>
  <tr>
   <td>vue_anterieure
   </td>
   <td>char
   </td>
   <td>255
   </td>
   <td>Non
   </td>
   <td>Image de la vue antérieure
   </td>
  </tr>
  <tr>
   <td>vue_laterale
   </td>
   <td>char
   </td>
   <td>255
   </td>
   <td>Non
   </td>
   <td>Image de la vue latérale
   </td>
  </tr>
</table>


**Clés:**



* Clé primaire: `id`
* Unique: `vue_anterieure`
* Unique: `vue_laterale`


---


### Table: `foetapp360_session` {#table-foetapp360_session}

Stocke les sessions utilisateur.


<table>
  <tr>
   <td><strong>Champ</strong>
   </td>
   <td><strong>Type</strong>
   </td>
   <td><strong>Longueur</strong>
   </td>
   <td><strong>Null</strong>
   </td>
   <td><strong>Défaut</strong>
   </td>
   <td><strong>Commentaire</strong>
   </td>
  </tr>
  <tr>
   <td>id
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Numéro de session (clé primaire)
   </td>
  </tr>
  <tr>
   <td>id_foetapp360
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>ID de l'instance foetapp360
   </td>
  </tr>
  <tr>
   <td>userid
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Référence utilisateur
   </td>
  </tr>
  <tr>
   <td>timestart
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Début de session
   </td>
  </tr>
  <tr>
   <td>timefinish
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Fin de session (0 = pas encore terminé)
   </td>
  </tr>
  <tr>
   <td>sumgrades
   </td>
   <td>number
   </td>
   <td>10
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Total des notes
   </td>
  </tr>
  <tr>
   <td>questionsdone
   </td>
   <td>number
   </td>
   <td>10
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Total des questions répondues
   </td>
  </tr>
  <tr>
   <td>difficulty
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Difficulté (Easy ou Hard)
   </td>
  </tr>
</table>


**Clés:**



* Clé primaire: `id, id_foetapp360, userid`
* Clé étrangère: `id_foetapp360` → `foetapp360(id)`
* Clé étrangère: `userid` → `user(id)`


---


### Table: `foetapp360_attempt` {#table-foetapp360_attempt}

Stocke les réponses et statistiques des tentatives des étudiants.


<table>
  <tr>
   <td><strong>Champ</strong>
   </td>
   <td><strong>Type</strong>
   </td>
   <td><strong>Longueur</strong>
   </td>
   <td><strong>Null</strong>
   </td>
   <td><strong>Défaut</strong>
   </td>
   <td><strong>Commentaire</strong>
   </td>
  </tr>
  <tr>
   <td>id
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Identifiant (clé primaire)
   </td>
  </tr>
  <tr>
   <td>id_session
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>ID session foetapp360
   </td>
  </tr>
  <tr>
   <td>id_dataset
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>ID dataset foetapp360
   </td>
  </tr>
  <tr>
   <td>attempt_number
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Numéro de tentative
   </td>
  </tr>
  <tr>
   <td>name
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Nom du dataset entré par l'étudiant
   </td>
  </tr>
  <tr>
   <td>sigle
   </td>
   <td>char
   </td>
   <td>255
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Sigle de la position
   </td>
  </tr>
  <tr>
   <td>partogram
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Réponse inclinaison/rotation partogramme
   </td>
  </tr>
  <tr>
   <td>schema_simplifie
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>
   </td>
   <td>Réponse inclinaison/rotation schéma simplifié
   </td>
  </tr>
  <tr>
   <td>vue_anterieure
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Fichier image vue antérieure
   </td>
  </tr>
  <tr>
   <td>vue_laterale
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Fichier image vue latérale
   </td>
  </tr>
  <tr>
   <td>given_input
   </td>
   <td>char
   </td>
   <td>255
   </td>
   <td>Non
   </td>
   <td>
   </td>
   <td>Inputs donnés (name/sigle/partogram/etc.)
   </td>
  </tr>
  <tr>
   <td>is_correct
   </td>
   <td>int
   </td>
   <td>1
   </td>
   <td>Non
   </td>
   <td>0
   </td>
   <td>Correct ou non (0 = non, 1 = oui)
   </td>
  </tr>
</table>


**Clés:**



* Clé primaire: `id, id_session`
* Clé étrangère: `id_session` → `foetapp360_session(id)`
* Clé étrangère: `id_dataset` → `foetapp360_datasets(id)`


---


### Table: `foetapp360_feedback` {#table-foetapp360_feedback}

Stocke les feedbacks en fonction des réponses.


<table>
  <tr>
   <td><strong>Champ</strong>
   </td>
   <td><strong>Type</strong>
   </td>
   <td><strong>Longueur</strong>
   </td>
   <td><strong>Null</strong>
   </td>
   <td><strong>Commentaire</strong>
   </td>
  </tr>
  <tr>
   <td>id
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>Identifiant (clé primaire)
   </td>
  </tr>
  <tr>
   <td>input_dataset
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>Nom dataset entré par l'étudiant
   </td>
  </tr>
  <tr>
   <td>expected_dataset
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>Dataset attendu
   </td>
  </tr>
  <tr>
   <td>input_inclinaison
   </td>
   <td>int
   </td>
   <td>2
   </td>
   <td>Non
   </td>
   <td>Inclinaison donnée (-1, 0, 1)
   </td>
  </tr>
  <tr>
   <td>expected_inclinaison
   </td>
   <td>int
   </td>
   <td>2
   </td>
   <td>Non
   </td>
   <td>Inclinaison attendue (-1, 0, 1)
   </td>
  </tr>
  <tr>
   <td>id_feedback
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>ID du feedback correspondant
   </td>
  </tr>
</table>


**Clés:**



* Clé primaire: `id`
* Clé étrangère: `id_feedback` → `foetapp360_feedback_data(id)`


---


### Table: `foetapp360_feedback_data` {#table-foetapp360_feedback_data}

Stocke les textes de feedback à afficher.


<table>
  <tr>
   <td><strong>Champ</strong>
   </td>
   <td><strong>Type</strong>
   </td>
   <td><strong>Longueur</strong>
   </td>
   <td><strong>Null</strong>
   </td>
   <td><strong>Commentaire</strong>
   </td>
  </tr>
  <tr>
   <td>id
   </td>
   <td>int
   </td>
   <td>10
   </td>
   <td>Non
   </td>
   <td>Identifiant (clé primaire)
   </td>
  </tr>
  <tr>
   <td>feedback
   </td>
   <td>text
   </td>
   <td>
   </td>
   <td>Oui
   </td>
   <td>Texte du feedback
   </td>
  </tr>
</table>


**Clés:**



* Clé primaire: `id`


## Vue Statistiques (`stats.php`) {#vue-statistiques-stats-php}

Cette page affiche les statistiques globales et détaillées des performances des étudiants sur les exercices réalisés dans le plugin.

**Contenu principal :**



* Nombre total d’étudiants ayant participé.
* Taux de réussite moyen global.
* Graphiques de performances par type d'inclinaison ("Bien Fléchi", "Mal Fléchi", "Peu Fléchi") pour les modes facile et difficile.
* Tableau récapitulatif comparatif des taux de réussite par position et par mode de difficulté (facile/difficile).

**Structure des données utilisées :**



* Sessions (`foetapp360_session`)
* Tentatives (`foetapp360_attempt`)
* Datasets (`foetapp360_datasets`)

**Méthodes principales utilisées (<code>stats_manager.php</code>):**



* `get_global_stats($foetapp360id)`
* `get_dataset_stats_by_difficulty($foetapp360id, $difficulty)`


---


## Page "Mes Statistiques" (`mystats.php`) {#page-"mes-statistiques"-mystats-php}

Permet à un étudiant spécifique de consulter ses statistiques personnelles.

**Contenu principal :**



* Taux de réussite global par étudiant.
* Temps total passé par l'étudiant sur les exercices.
* Nombre de sessions réalisées par difficulté (facile/difficile).
* Graphiques représentant les performances de l'étudiant par type d'entrée et par représentation visuelle (correcte, acceptable, mauvaise).

**Méthodes principales utilisées (<code>stats_manager.php</code>):**



* `get_student_time_passed()`
* `get_student_difficulties_amount()`
* `get_student_success_rate()`
* `get_success_rate_by_input()`
* `get_success_rate_by_representation()`


---


## Page "Mes Statistiques" (`mystats.php`) {#page-"mes-statistiques"-mystats-php}

Cette page permet à un étudiant spécifique de visualiser ses propres statistiques individuelles.

**Contenu principal :**



* Taux de réussite individuel par niveau de difficulté (facile/difficile).
* Statistiques par type d’entrée (par exemple, réponses données).
* Historique des tentatives réalisées par l'étudiant.

**Méthodes principales utilisées (<code>stats_manager.php</code>):**



* `get_student_stats()`
* `get_student_success_rate()`
* `get_success_rate_by_input()`
* `get_student_time_passed()`


---


## Page de consultation (`view.php`) {#page-de-consultation-view-php}

Cette page affiche le contenu principal d'une instance du plugin Foetapp360. Les détails doivent être complétés selon l’implémentation spécifique réalisée.

**Contenu principal :** *(À compléter selon l'implémentation)*


---


## Formulaire d'ajout/modification (`db_form_submission.php`) {#formulaire-d'ajout-modification-db_form_submission-php}

Cette page gère l'ajout et la modification des entrées (datasets) dans la base de données, incluant les images associées.

**Fonctionnalités :**



* Ajout de nouveaux jeux de données.
* Modification des jeux de données existants.
* Gestion des fichiers images (`vue antérieure`, `vue latérale`).

**Contrôles effectués :**



* Vérification des entrées obligatoires (nom, sigle, rotation, inclinaison).
* Validation du format des données (rotation entre 0 et 360, inclinaison entre -1 et 1).

**Classes utilisées :**



* `manage_datasets_form` (gestion du formulaire)
* `image_manager` (gestion des images : upload, suppression, modification)


---


## Librairie (`lib.php`) {#librairie-lib-php}

Fichier regroupant des fonctions essentielles du plugin.

**Fonctions implémentées :**



* `get_correct_rotation(int $input_rotation)` : Détermine la rotation correcte à partir d’une entrée utilisateur.
* `get_correct_inclinaison(int $input_inclinaison)` : Détermine le type d'inclinaison (bien fléchie, mal fléchie, peu fléchie) à partir d’une entrée utilisateur.
* `get_dataset_from_inclinaison_rotation(...)` : Récupère le dataset correspondant à l’inclinaison et la rotation spécifiées.
* `format_answer_string(string $input_answer)` : Formate une chaîne entrée par l'utilisateur (suppression des accents, espaces inutiles, etc.) pour comparaison des réponses.


---


## Fonctions essentielles implémentées dans `lib.php` {#fonctions-essentielles-implémentées-dans-lib-php}


```
foetapp360_add_instance:
```


C’est la fonction requise par moodle qui permet de créer une nouvelle instance du plugin et qui permet d'exécuter des scripts souhaités (additionnel à ceux sur moodle) lors du l’ajout d’une nouvelle instance.` `


```
foetapp360_update_instance:
```


C’est le script qui sera exécuté lorsque le build version du plugin change.


```
foetapp360_delete_instance:
```


Comme le nom indique, c’est la fonction à exécuter lors de la délétion d’une instance, dans notre cas, on nettoie de la base de données toutes les entrées et données relatives à cette instance dans la base de données.


```
mod_foetapp360_pluginfile:
```


Cette fonction est demandée par le [File API](https://moodledev.io/docs/4.5/apis/subsystems/files) de Moodle afin de traiter les images que nous avons stockées dans Moodle. Par exemple, les images non statiques, qui peuvent être modifiées depuis la page de gestion de la base de données implémentée dans notre plugin, ne sont pas stockées directement dans la base de données. En effet, l'accès à ces images serait coûteux. À la place, nous stockons uniquement le nom de l’image, et je vous conseille vivement de ne stocker aucune image dans la base de données.

Moodle fournit un moyen alternatif pour stocker ces images via le File API, où elles seront stockées dans un espace de fichiers géré par Moodle (regardez le fichier ***image_manager.php*** pour voir comment les images sont stockées).

Afin de servir les images au client, Moodle demande d’implémenter cette fonction. C’est ici que nous traitons le lien généré par Moodle pour récupérer l’image depuis l’espace de fichiers et l’envoyer aux utilisateurs.

**Note :** il existe une partie qui vérifie le rôle de l’utilisateur avant de lui permettre d’accéder à l’image. Cette partie a été commentée, car il y avait un problème d’accès pour les professeurs et les étudiants. Nous n’avons pas réussi à identifier le bug. Cela n’est pas dangereux en soi, mais il est préférable d’ajouter les rôles (qui sont gérés dans *access.php*) afin de garantir le respect du RGPD.


```
foetapp360_start_new_session:
```


Cette fonction n’est pas requise par moodle, on l’a ajouté afin de créer une nouvelle session lorsqu’un utilisateur lance un quiz.

Ces fonctions gèrent le cycle de vie d’une instance du plugin au sein d'un cours Moodle (création, mise à jour, suppression).


---


## Autres parties importantes à mentionner {#autres-parties-importantes-à-mentionner}



* La classe `image_manager` utilisée pour gérer les fichiers images (ajout, suppression, mise à jour), vous pouvez voir ce classe afin de comprendre comment les images sont stockées dans l’espace fichiers du moodle.
* La classe `single_student` qui permet de gérer les données d'un étudiant individuel (sessions, tentatives, taux de réussite), **ce classe n’est pas utilisée et peut être supprimer.**


---


## Vue principale (`index.php`) {#vue-principale-index-php}

Cette page liste toutes les instances du plugin disponibles au sein d’un cours.

**Contenu principal :**



* Liste des activités Foetapp360 présentes dans le cours, avec liens vers chacune.


## Image Manager `image_manager.php`: {#image-manager-image_manager-php}

La classe `image_manager` est responsable de la gestion du stockage des fichiers image dans un plugin Moodle (`mod_foetapp360`). Elle fournit des méthodes pour téléverser, récupérer, mettre à jour et supprimer des fichiers image dans le système de fichiers de Moodle. La classe interagit avec l'API de stockage de fichiers de Moodle et avec une table spécifique de la base de données `foetapp360_datasets` pour gérer ces images.


#### Vue d’ensemble du stockage des données {#vue-d’ensemble-du-stockage-des-données}



* **Context ID :** L’identifiant de contexte global du système est utilisé, obtenu via `context_system::instance()`.
* **Component :** Toujours défini à `mod_foetapp360` (le nom du plugin).
* **File Area :** Transmis dynamiquement au constructeur (`vue_anterieure`, `vue_laterale`, etc.).
* **Item ID :** Correspond au champ `id` dans la table `foetapp360_datasets`, identifiant l'enregistrement du dataset.
* **File Path & Filename :** Les fichiers sont stockés dans le répertoire `/` avec leurs noms de fichier respectifs.


---


#### Constructeur de la classe {#constructeur-de-la-classe}

```php
public function __construct($filearea)
```


* Initialise les propriétés `contextid`, `component` et `filearea`.
* Prépare la classe à interagir avec le stockage de fichiers de Moodle pour une zone de fichier spécifique.


---


```php
upload_pix_image($itemid, $filename)
```



* Téléverse un fichier image depuis le dossier `/pix` du plugin vers le stockage de fichiers de Moodle.
* **Cas d’utilisation :** Ajouter des images statiques fournies avec le plugin.


---


```php
updateImageFromContent($itemid, $elem, $mform)
```



* Supprime l’image existante (via `deleteImage()`).
* Ajoute une nouvelle image depuis le contenu du formulaire (via `addImageFromForm()`).

**Note: fonction non utilisée.**


---


```php
getImageUrl($itemid, $filename)
```



* Retourne l'URL accessible d'un fichier image, formatée pour le système de fichiers des plugins Moodle.


---


```php
getImageFile($itemid, $filename)
```



* Retourne l’objet fichier correspondant au `itemid` et au `filename` donnés, s’il existe.


---


```php
addImageFromContent($itemid, $filename, $filecontent)
```



* Sauvegarde un fichier depuis un contenu sous forme de chaîne (données binaires) vers le stockage de fichiers de Moodle.

**Note: fonction non utilisée.**


---


```php
addImageFromForm($itemid, $mform, $elem)
```



* Sauvegarde un fichier téléversé via un formulaire Moodle.
* Lance une exception `moodle_exception` si l’enregistrement du fichier échoue.


---


```php
delete_image($itemid, $filename)
```



* Supprime un fichier spécifique par `itemid` et `filename`.
* Retourne `true` si le fichier n’existe pas ou a été supprimé avec succès.


---


```php
updateImageFromForm($itemid, $mform, $elem)
```



* Supprime l’image actuelle (en utilisant `_delete_image_with_id`).
* Téléverse un nouveau fichier image depuis une soumission de formulaire Moodle.


---


```php
getImageUrlByName($filename)
```



* Recherche dans la base de données le `itemid` correspondant en fonction du nom de fichier et du `filearea` actuel.
* Retourne l’URL de l’image.
* Lève des exceptions si le nom de fichier n’est pas trouvé ou si le `filearea` est invalide.


---


#### Résumé {#résumé}

La classe `image_manager` abstrait et simplifie la gestion des fichiers image dans le système de fichiers de Moodle. Elle est étroitement intégrée avec la table `foetapp360_datasets` et offre une approche structurée pour stocker, récupérer, mettre à jour et supprimer les fichiers image associés aux enregistrements de datasets dans le plugin.


## <span style="text-decoration:underline;">Fonctionnalités supplémentaire à développer :</span> {#fonctionnalités-supplémentaire-à-développer}


### I - Ajouter/Choisir une Présentation {#i-ajouter-choisir-une-présentation}


#### Contexte :  {#contexte}

L’objectif est de pouvoir choisir parmi plusieurs présentations autres que le sommet qu’on a fait par défaut pour le partogramme et le schéma simplifié (Siège et Face manquant), qui se traduit par des images complètement différentes. De ce fait, il faudrait que l'enseignant, quand il ajoute une représentation puisse choisir le style de présentation et que ces dernières apparaissent dans la vue exercice.

**Ajouter un nouveau partogramme**



* Ajouter un champ “présentation” dans le formulaire “Gérer les ensembles” lors de l’ajout d’un dataset qui permettrait de choisir entre Siège, Face et Sommet.
* Modifier le fichier “db_form_submission” en conséquence.

**Gérer l’affichage des différentes Présentations.**

Il faut créer une table Présentation dans la base de donnée avec:



* Id
* Nom (facultatif)
* Nom de l’image

Modifier la table dataset:



* Ajouter un champ Présentation qui contient l’id de la table Présentation précédemment créer.

Dans attempt.php :



* Créer un objet “image_manager”
* Faire une requête SQL pour récupérer le nom de l’image de la présentation correspondant au dataset.
* Récupérer l’adresse de l’image avec “image_manager.getImageUrlByName(nom_image)”
* Modifier les deux lignes contenant “$interior_image” pour intégrer l’URL précédemment récupéré en variable.


### II - Fonctionnalité de groupe de Dataset {#ii-fonctionnalité-de-groupe-de-dataset}


#### Contexte :  {#contexte}

Nous avons discuté avec Lionel de la possibilité d’introduire un système de classement des représentations par groupe à l’aide d’un identifiant unique. Par exemple, les représentations actuellement définies par défaut seraient associées au groupe 0.

L’objectif serait de permettre aux enseignants de sélectionner les groupes de représentations à utiliser pour chaque instance du plugin. Ainsi, les étudiants ne recevraient que des questions basées sur les représentations appartenant aux groupes spécifiés par l’enseignant. Cette fonctionnalité offrirait une meilleure personnalisation des exercices, en permettant aux enseignants de structurer les représentations disponibles en fonction des besoins pédagogiques spécifiques de leurs cours.

**Intégrer les groupes de Dataset au projet**

Il faut modifier la table “foetapp360_datasets” dans la base de données (install.xml) en y ajoutant le champ “groupe (un entier/int)”.

Modifier la ligne où “$random_dataset” est instancié. Il faut modifier la requête SQL pour qu’elle ne renvoie que les datasets du groupe sélectionné.

**Mettre en place le choix du Dataset**

Il faut enfin ajouter dans la table “foetapp360” un champ “selected_dataset_group”. Faire en sorte que ce champ ait une valeur par défaut. Ensuite dans la page “Gérer les ensembles” ajouter un champ dans le formulaire pour modifier cette valeur.


### III - Graphe qui montre le taux d’erreur en fonction de la représentation donnée {#iii-graphe-qui-montre-le-taux-d’erreur-en-fonction-de-la-représentation-donnée}


#### Contexte :  {#contexte}

Un dernier **graphe intéressant**, qui n’a pas encore été ajouté, serait celui permettant d’**afficher le taux d’erreur des étudiants en fonction de la représentation et de l’attribut donné**.

Actuellement, nous disposons :



* d’un **graphe affichant le taux d’erreur en fonction de l’attribut donné** (par exemple, sigle, partogramme, etc.).
* d’un **graphe affichant le taux d’erreur en fonction de la représentation à trouver**.

Ce **nouveau graphique** serait une combinaison des deux, permettant d’**identifier précisément les exercices les plus difficiles**. Il offrirait une vision plus fine des points de blocage des étudiants, en montrant **quelles représentations posent problème selon l’attribut testé**.

**Ajout de la fonction dans classes/stats_manager.php**

Dans le fichier classes/stats_manager.php, il est nécessaire d'ajouter une fonction permettant d'exécuter la requête SQL afin de récupérer les données souhaitées. Une fonction existante, comme get_student_time_passed, peut servir d'exemple pour sa structure.

**Données à récupérer**

Les informations sont stockées dans la table mdl_foetapp360_attempt :

 -given_input : représente la représentation fournie par l’étudiant.

 -is_correct : indique si la réponse est correcte (1) ou incorrecte (0).

Conditions à respecter dans la requête SQL :

 -id_session dans mdl_foetapp360_attempt doit correspondre à l’id d’une session dans mdl_foetapp360_session.

 -Cette session doit appartenir à l’étudiant concerné (userid).

**Intégration dans mystats.php**

Une fois la fonction ajoutée, elle pourra être utilisée dans mystats.php via la variable $stats_manager.

**Affichage sous forme de graphique**

Les données pourront être affichées sous forme de diagramme en barres grâce à l’API de Moodle. Voici les étapes principales :

-Récupérer les données via la fonction du stats_manager.

-Créer un graphique avec $chart = new \core\chart_bar();.

-Ajouter les séries de données au graphique.

-Afficher le graphique avec $OUTPUT->render($chart);.

**Documentation utile** :[ Moodle Charts API](https://docs.moodle.org/dev/Charts_API)


## Annexes et notes complémentaires {#annexes-et-notes-complémentaires}

*(Espace réservé pour tout autre élément jugé pertinent à documenter ultérieurement.)*


# Doc Moodle: {#doc-moodle}

Ci-dessous, vous trouverez les liens qui nous semblent les plus utiles, ainsi que quelques astuces sur Moodle et certains fichiers spécifiques exigés par la plateforme.


## Sources:

[https://moodledev.io/docs/5.0/apis/plugintypes](https://moodledev.io/docs/5.0/apis/plugintypes)


## Liens intéressants:

[http://localhost/admin/purgecaches.php](http://localhost/admin/purgecaches.php)


## Ajouter module/plugin:

*server\moodle\mod\nom_module*


## I - Plugin d’activité: {#i-plugin-d’activité}

[https://moodledev.io/docs/5.0/apis/plugintypes/mod](https://moodledev.io/docs/5.0/apis/plugintypes/mod)


### I.1 - access.php {#i-1-access-php}


## Path: mod/*db/access.php*

Gère les permissions des utilisateurs sur le plugin.


```
'mod/folder:addinstance'
```


Contrôle qui peut créer une instance de l’activité.


```
'mod/folder:view'
```


Contrôle qui peut voir une instance de l’activité


```
'mod/folder:addinstance' => array(
        'riskbitmask' => RISK_XSS,

        'captype' => 'write',
        'contextlevel' => CONTEXT_COURSE,
        'archetypes' => array(
            'editingteacher' => CAP_ALLOW,
            'manager' => CAP_ALLOW
        ),
        'clonepermissionsfrom' => 'moodle/course:manageactivities'
    ),
```


Dans ‘archetypes’, on définit qui à accès à la règle.

On dit qu’il a accès avec la constante: “CAP_ALLOW”.


### I.2 - events.php  {#i-2-events-php}


## Path: mod/*db/events.php*

Permet d’effectuer de réagir à des évènements.

Le fichier permet d'abonner le plugin à des évènements. Cela permet d’observer des évènements générer autre part que sur Moodle.

$observers = [

   [

       'eventname' => '\core\event\course_module_created',

       'callback'  => '\plugintype_pluginname\event\observer\course_module_created::store',

       'priority'  => 1000,

   ],

];


### I.3 - install.xml {#i-3-install-xml}


## Path: mod/*db/install.xml*

Définit les bases de données, clés etc… qui seront créés pour le plugin à l’installation initiale.

**<span style="text-decoration:underline;">Attention: </span>**Utiliser [XMLDB](https://docs.moodle.org/dev/XMLDB_Documentation?_gl=1*121o8rm*_ga*NDkwMzk4Mjk4LjE3MzgxNDM2NTE.*_ga_QWYJYEY9P5*MTczODE1NjAwNS4zLjEuMTczODE1NjAyMS4wLjAuMA..) built-in dans Moodle editor lorsqu’on créer ou on modifie install.xml

Il faut une table dont le nom **correspond exactement** au nom du plugin.

À chaque fois que vous modifiez la base de données définie dans le plugin, vous devez changer la version (build number) du plugin afin que la modification de la base de données soit prise en compte lors de la mise à jour du plugin.


### I.4 - upgrade.php {#i-4-upgrade-php}


## Path: mod/*db/upgrade.php*

Contient les étapes des changements comme le changement de la database, config.

**<span style="text-decoration:underline;">Attention:</span>** Utilisez XMLDB editor. XMLDB peut générer les upgrades steps php.

Le fichier install.xml doit **impérativement toujours correspondre** au schéma généré.


### I.5 - mobile.php {#i-5-mobile-php}


## Path: mod/*db/mobile.php*

On n’a pas utiliser ce fichiers, mais plutôt c’est le fichier qui permet d’ajouter le support mobile, pour plus d’information visitez : 

[https://moodledev.io/general/app/development/plugins-development-guide](https://moodledev.io/general/app/development/plugins-development-guide)


### I.6 - Language String Definition {#i-6-language-string-definition}


## Path: mod/*lang/en/[modname].php*

Ce sont les fichiers responsables de l’internationalisation. Normalement, comme ce plugin est et sera toujours en français, vous n’êtes pas obligé de les remplir. Cependant, au moins une langue doit être définie, car c’est requis par Moodle. Cela ressemble au package i18n d’Angular et React.

Chaque plugin doit définir son nom (“pluginname”).

On utilise la fonction “get_string()” pour récupérer la valeur.


```
get_string('pluginname', '[plugintype]_[pluginname]');
```


 \
Exemple:


```
<?php

$string['pluginname'] = 'The name of your activity';
```



### I.7 - lib.php {#i-7-lib-php}


## Path: mod/lib.php

C’est un fichier qui fait le lien entre le “Moodle core” et le plugin. \
**<span style="text-decoration:underline;">Règle: </span>**Chaque fonction dans ce fichier doit suivre les règles suivantes: [Coding Style](https://moodledev.io/general/development/policies/codingstyle#functions-and-methods).

On doit définir les 3 fonctions suivantes pour un plugin:


```
function [modname]_add_instance($instancedata, $mform = null): int;
function [modname]_update_instance($instancedata, $mform): bool;
function [modname]_delete_instance($id): bool;
```



### I.8 - mod_form - Creation/Modification d’instance {#i-8-mod_form-creation-modification-d’instance}


## Path: mod/mod_form.php


## II - Upgrade un plugin {#ii-upgrade-un-plugin}

[https://moodledev.io/docs/5.0/guides/upgrade](https://moodledev.io/docs/5.0/guides/upgrade)


### II.a - version.php {#ii-a-version-php}

**<span style="text-decoration:underline;">Règle:</span>** Le fichier *version.php* doit être incrémenter après chaque changement dans le dossier *db/*, d’un code JavaScript, dans le pack de langue et ajout de nouvelle “auto-loaded class”.

<span style="text-decoration:underline;">Un incrément de version déclenche la procédure d’upgrade et reset tous les caches.</span>


### II.b - install.xml {#ii-b-install-xml}

Seulement utiliser pendant l’installation initiale du plugin.

Ce fichier contient une fonction 

Doit être créé et maintenu avec XMLDB Editor.


### II.c - upgrade.php {#ii-c-upgrade-php}

Décrit les étapes pour migrer d’une version vers une nouvelle. Moodle supporte uniquement les upgrade et les plugins ne peuvent pas être downgrade.

Doit être créé et maintenu avec XMLDB Editor.

**<span style="text-decoration:underline;">Exemple:</span>**


```
<?php

function xmldb_[plugintype]_[pluginname]_upgrade($oldversion): bool {
    global $CFG, $DB;

    $dbman = $DB->get_manager(); // Loads ddl manager and xmldb classes.

    if ($oldversion < 2019031200) {
        // Perform the upgrade from version 2019031200 to the next version.
        // Add new fields to certificate table.
        $table = new xmldb_table('certificate');
        $field = new xmldb_field('showcode');
        $field->set_attributes(XMLDB_TYPE_INTEGER, '1', XMLDB_UNSIGNED, XMLDB_NOTNULL, null, '0', 'savecert');
        if (!$dbman->field_exists($table, $field)) {
            $dbman->add_field($table, $field);
        }
        // Add new fields to certificate_issues table.
        $table = new xmldb_table('certificate_issues');
        $field = new xmldb_field('code');
        $field->set_attributes(XMLDB_TYPE_CHAR, '50', null, null, null, null, 'certificateid');
        if (!$dbman->field_exists($table, $field)) {
            $dbman->add_field($table, $field);
        }

        // Certificate savepoint reached.
        upgrade_mod_savepoint(true, 2012091800, 'certificate');
    }

    if ($oldversion < 2019031201) {
        // Perform the upgrade from version 2019031201 to the next version.
    }

    // Everything has succeeded to here. Return true.
    return true;
}
```


                                                                                                                                                                 


## Annexe - Code utile en PHP {#annexe-code-utile-en-php}


```
// Prevent access to this code from URL
defined('MOODLE_INTERNAL') || die();
