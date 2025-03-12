                                     
Doc realisé par :  **Ali FAWAZ, Romain HOCQUET, Alexandre MOUA, Brice VITTET**

# Documentation pour le développement du plugin Moodle "Foetapp360"

---

## Vue Statistiques (`stats.php`)

Cette page affiche les statistiques globales et détaillées des performances des étudiants sur les exercices réalisés dans le plugin.

**Contenu principal :**

- Nombre total d’étudiants ayant participé.  
- Taux de réussite moyen global.  
- Graphiques de performances par type d'inclinaison ("Bien Fléchi", "Mal Fléchi", "Peu Fléchi") pour les modes facile et difficile.  
- Tableau récapitulatif comparatif des taux de réussite par position et par mode de difficulté (facile/difficile).

**Structure des données utilisées :**

- Sessions (`foetapp360_session`)  
- Tentatives (`foetapp360_attempt`)  
- Datasets (`foetapp360_datasets`)

**Méthodes principales utilisées (`stats_manager.php`):**

- `get_global_stats($foetapp360id)`  
- `get_dataset_stats_by_difficulty($foetapp360id, $difficulty)`

---

## Page "Mes Statistiques" (`mystats.php`)

Permet à un étudiant spécifique de consulter ses statistiques personnelles.

**Contenu principal :**

- Taux de réussite global par étudiant.  
- Temps total passé par l'étudiant sur les exercices.  
- Nombre de sessions réalisées par difficulté (facile/difficile).  
- Graphiques représentant les performances de l'étudiant par type d'entrée et par représentation visuelle (correcte, acceptable, mauvaise).

**Méthodes principales utilisées (`stats_manager.php`):**

- `get_student_time_passed()`  
- `get_student_difficulties_amount()`  
- `get_student_success_rate()`  
- `get_success_rate_by_input()`  
- `get_success_rate_by_representation()`

---

## Page "Mes Statistiques" (`mystats.php`)

Cette page permet à un étudiant spécifique de visualiser ses propres statistiques individuelles.

**Contenu principal :**

- Taux de réussite individuel par niveau de difficulté (facile/difficile).  
- Statistiques par type d’entrée (par exemple, réponses données).  
- Historique des tentatives réalisées par l'étudiant.

**Méthodes principales utilisées (`stats_manager.php`):**

- `get_student_stats()`  
- `get_student_success_rate()`  
- `get_success_rate_by_input()`  
- `get_student_time_passed()`

---

## Page de consultation (`view.php`)

Cette page affiche le contenu principal d'une instance du plugin Foetapp360. Elle permet au profs de gérer la BD et de regarder les stats des étudiants, ainsi qu'elle permet au étudiants de faire des exos et regarder leurs stats.

---

## Formulaire d'ajout/modification (`db_form_submission.php`)

Cette page gère l'ajout et la modification des entrées (datasets) dans la base de données, incluant les images associées.

**Fonctionnalités :**

- Ajout de nouveaux jeux de données.  
- Modification des jeux de données existants.  
- Gestion des fichiers images (`vue antérieure`, `vue latérale`).

**Contrôles effectués :**

- Vérification des entrées obligatoires (nom, sigle, rotation, inclinaison).  
- Validation du format des données (rotation entre 0 et 360, inclinaison entre \-1 et 1).

**Classes utilisées :**

- `manage_datasets_form` (gestion du formulaire)  
- `image_manager` (gestion des images : upload, suppression, modification)

---

## Librairie (`lib.php` ou `lib essential`)

Fichier regroupant des fonctions essentielles du plugin.

**Fonctions implémentées :**

- `get_correct_rotation(int $input_rotation)` : Détermine la rotation correcte à partir d’une entrée utilisateur.  
- `get_correct_inclinaison(int $input_inclinaison)` : Détermine le type d'inclinaison (bien fléchie, mal fléchie, peu fléchie) à partir d’une entrée utilisateur.  
- `get_dataset_from_inclinaison_rotation(...)` : Récupère le dataset correspondant à l’inclinaison et la rotation spécifiées.  
- `format_answer_string(string $input_answer)` : Formate une chaîne entrée par l'utilisateur (suppression des accents, espaces inutiles, etc.) pour comparaison des réponses.

---

## Fonctions essentielles implémentées dans `lib.php`

- `foetapp360_add_instance`  
- `foetapp360_update_instance`  
- `foetapp360_delete_instance`

Ces fonctions gèrent le cycle de vie d’une instance du plugin au sein d'un cours Moodle (création, mise à jour, suppression).

---

## Autres parties importantes à mentionner

- La classe `image_manager` utilisée pour gérer les fichiers images (ajout, suppression, mise à jour).  
- La classe `single_student` qui permet de gérer les données d'un étudiant individuel (sessions, tentatives, taux de réussite).

---

## Vue principale (`index.php`)

Cette page liste toutes les instances du plugin disponibles au sein d’un cours.

**Contenu principal :**

- Liste des activités Foetapp360 présentes dans le cours, avec liens vers chacune.

---

## Autres parties importantes à compléter dans la documentation :

- Définition des rôles et capacités spécifiques au plugin (`access.php`)  
- Description détaillée de la structure de la base de données (`db/install.xml`)  
- Explication détaillée du gestionnaire d'images (`image_manager.php`)  
- Détails sur les événements enregistrés (`events.php`)

---

## Fonctionnalités supplémentaire à développer :

### I \- Ajouter/Choisir une Présentation

#### Contexte : 

L’objectif est de pouvoir choisir parmi plusieurs présentations autres que le sommet qu’on a fait par défaut pour le partogramme et le schéma simplifié (Siège et Face manquant), qui se traduit par des images complètement différentes. De ce fait, il faudrait que l'enseignant, quand il ajoute une représentation puisse choisir le style de présentation et que ces dernières apparaissent dans la vue exercice.

**Ajouter un nouveau partogramme**

- Ajouter un champ “présentation” dans le formulaire “Gérer les ensembles” lors de l’ajout d’un dataset qui permettrait de choisir entre Siège, Face et Sommet.  
- Modifier le fichier “db\_form\_submission” en conséquence.

**Gérer l’affichage des différentes Présentations.**  
Il faut créer une table Présentation dans la base de donnée avec:

- Id  
- Nom (facultatif)  
- Nom de l’image

Modifier la table dataset:

- Ajouter un champ Présentation qui contient l’id de la table Présentation précédemment créer.

Dans attempt.php :

- Créer un objet “image\_manager”  
- Faire une requête SQL pour récupérer le nom de l’image de la présentation correspondant au dataset.  
- Récupérer l’adresse de l’image avec “image\_manager.getImageUrlByName(nom\_image)”  
- Modifier les deux lignes contenant “$interior\_image” pour intégrer l’URL précédemment récupéré en variable.

### II \- Fonctionnalité de groupe de Dataset

#### Contexte : 

Nous avons discuté avec Lionel de la possibilité d’introduire un système de classement des représentations par groupe à l’aide d’un identifiant unique. Par exemple, les représentations actuellement définies par défaut seraient associées au groupe 0\.

L’objectif serait de permettre aux enseignants de sélectionner les groupes de représentations à utiliser pour chaque instance du plugin. Ainsi, les étudiants ne recevraient que des questions basées sur les représentations appartenant aux groupes spécifiés par l’enseignant. Cette fonctionnalité offrirait une meilleure personnalisation des exercices, en permettant aux enseignants de structurer les représentations disponibles en fonction des besoins pédagogiques spécifiques de leurs cours.

**Intégrer les groupes de Dataset au projet**  
Il faut modifier la table “foetapp360\_datasets” dans la base de données (install.xml) en y ajoutant le champ “groupe (un entier/int)”.

Modifier la ligne où “$random\_dataset” est instancié. Il faut modifier la requête SQL pour qu’elle ne renvoie que les datasets du groupe sélectionné.

**Mettre en place le choix du Dataset**  
Il faut enfin ajouter dans la table “foetapp360” un champ “selected\_dataset\_group”. Faire en sorte que ce champ ait une valeur par défaut. Ensuite dans la page “Gérer les ensembles” ajouter un champ dans le formulaire pour modifier cette valeur.

### III \- Graphe qui montre le taux d’erreur en fonction de la représentation donnée

#### Contexte : 

Un dernier **graphe intéressant**, qui n’a pas encore été ajouté, serait celui permettant d’**afficher le taux d’erreur des étudiants en fonction de la représentation et de l’attribut donné**.

Actuellement, nous disposons :

* d’un **graphe affichant le taux d’erreur en fonction de l’attribut donné** (par exemple, sigle, partogramme, etc.).  
* d’un **graphe affichant le taux d’erreur en fonction de la représentation à trouver**.

Ce **nouveau graphique** serait une combinaison des deux, permettant d’**identifier précisément les exercices les plus difficiles**. Il offrirait une vision plus fine des points de blocage des étudiants, en montrant **quelles représentations posent problème selon l’attribut testé**.

**Ajout de la fonction dans classes/stats\_manager.php**  
Dans le fichier classes/stats\_manager.php, il est nécessaire d'ajouter une fonction permettant d'exécuter la requête SQL afin de récupérer les données souhaitées. Une fonction existante, comme get\_student\_time\_passed, peut servir d'exemple pour sa structure.

**Données à récupérer**  
Les informations sont stockées dans la table mdl\_foetapp360\_attempt :  
 \-given\_input : représente la représentation fournie par l’étudiant.  
 \-is\_correct : indique si la réponse est correcte (1) ou incorrecte (0).  
Conditions à respecter dans la requête SQL :  
 \-id\_session dans mdl\_foetapp360\_attempt doit correspondre à l’id d’une session dans mdl\_foetapp360\_session.  
 \-Cette session doit appartenir à l’étudiant concerné (userid).

**Intégration dans mystats.php**  
Une fois la fonction ajoutée, elle pourra être utilisée dans mystats.php via la variable $stats\_manager.

**Affichage sous forme de graphique**  
Les données pourront être affichées sous forme de diagramme en barres grâce à l’API de Moodle. Voici les étapes principales :  
\-Récupérer les données via la fonction du stats\_manager.  
\-Créer un graphique avec $chart \= new \\core\\chart\_bar();.  
\-Ajouter les séries de données au graphique.  
\-Afficher le graphique avec $OUTPUT-\>render($chart);.

**Documentation utile** : [Moodle Charts API](https://docs.moodle.org/dev/Charts_API)

# Doc Moodle

## Sources:

[https://moodledev.io/docs/5.0/apis/plugintypes](https://moodledev.io/docs/5.0/apis/plugintypes)

## Liens intéressants:

[http://localhost/admin/purgecaches.php](http://localhost/admin/purgecaches.php)

## Ajouter module/plugin:

*server\\moodle\\mod\\nom\_module*

## I \- Plugin d’activité:

[https://moodledev.io/docs/5.0/apis/plugintypes/mod](https://moodledev.io/docs/5.0/apis/plugintypes/mod)

### I.1 \- access.php

## Path: mod/*db/access.php*

Gère les permissions des utilisateurs sur le plugin.  
'mod/folder:addinstance'  
Contrôle qui peut créer une instance de l’activité.

'mod/folder:view'  
Contrôle qui peut voir une instance de l’activité

'mod/folder:addinstance' \=\> array(  
        'riskbitmask' \=\> RISK\_XSS,

        'captype' \=\> 'write',  
        'contextlevel' \=\> CONTEXT\_COURSE,  
        'archetypes' \=\> array(  
            'editingteacher' \=\> CAP\_ALLOW,  
            'manager' \=\> CAP\_ALLOW  
        ),  
        'clonepermissionsfrom' \=\> 'moodle/course:manageactivities'  
    ),

Dans ‘archetypes’, on définit qui à accès à la règle.  
On dit qu’il a accès avec la constante: “CAP\_ALLOW”.

### I.2 \- events.php 

## Path: mod/*db/events.php*

Permet d’effectuer de réagir à des évènements.  
Le fichier permet d'abonner le plugin à des évènements. Cela permet d’observer des évènements générer autre part que sur Moodle.

$observers \= \[  
   \[  
       'eventname' \=\> '\\core\\event\\course\_module\_created',  
       'callback'  \=\> '\\plugintype\_pluginname\\event\\observer\\course\_module\_created::store',  
       'priority'  \=\> 1000,  
   \],  
\];

### I.3 \- install.xml

## Path: mod/*db/install.xml*

Définit les bases de données, clés etc… qui seront créés pour le plugin à l’installation initiale.  
**Attention:** Utiliser [XMLDB](https://docs.moodle.org/dev/XMLDB_Documentation?_gl=1*121o8rm*_ga*NDkwMzk4Mjk4LjE3MzgxNDM2NTE.*_ga_QWYJYEY9P5*MTczODE1NjAwNS4zLjEuMTczODE1NjAyMS4wLjAuMA..) built-in dans Moodle editor lorsqu’on créer ou on modifie install.xml

Il faut une table dont le nom **correspond exactement** au nom du plugin.

### I.4 \- upgrade.php

## Path: mod/*db/upgrade.php*

Contient les étapes des changements comme le changement de la database, config.  
**Attention:** Utilisez XMLDB editor. XMLDB peut générer les upgrades steps php.  
Le fichier install.xml doit **impérativement toujours correspondre** au schéma généré.

### I.5 \- mobile.php

## Path: mod/*db/mobile.php*

### I.6 \- Language String Definition

## Path: mod/*lang/en/\[modname\].php*

Chaque plugin doit définir son nom (“pluginname”).  
On utilise la fonction “get\_string()” pour récupérer la valeur.  
get\_string('pluginname', '\[plugintype\]\_\[pluginname\]');

Exemple:  
\<?php

$string\['pluginname'\] \= 'The name of your activity';

### I.7 \- lib.php

## Path: mod/lib.php

C’est un fichier qui fait le lien entre le “Moodle core” et le plugin.  
**Règle:** Chaque fonction dans ce fichier doit suivre les règles suivantes: [Coding Style](https://moodledev.io/general/development/policies/codingstyle#functions-and-methods).

On doit définir les 3 fonctions suivantes pour un plugin:  
function \[modname\]\_add\_instance($instancedata, $mform \= null): int;  
function \[modname\]\_update\_instance($instancedata, $mform): bool;  
function \[modname\]\_delete\_instance($id): bool;

### I.8 \- mod\_form \- Creation/Modification d’instance

## Path: mod/mod\_form.php

## II \- Upgrade un plugin

[https://moodledev.io/docs/5.0/guides/upgrade](https://moodledev.io/docs/5.0/guides/upgrade)

### II.a \- version.php

**Règle:** Le fichier *version.php* doit être incrémenter après chaque changement dans le dossier *db/*, d’un code JavaScript, dans le pack de langue et ajout de nouvelle “auto-loaded class”.  
Un incrément de version déclenche la procédure d’upgrade et reset tous les caches.

### II.b \- install.xml

Seulement utiliser pendant l’installation initiale du plugin.

Ce fichier contient une fonction   
Doit être créé et maintenu avec XMLDB Editor.

### II.c \- upgrade.php

Décrit les étapes pour migrer d’une version vers une nouvelle. Moodle supporte uniquement les upgrade et les plugins ne peuvent pas être downgrade.  
Doit être créé et maintenu avec XMLDB Editor.

**Exemple:**  
\<?php

function xmldb\_\[plugintype\]\_\[pluginname\]\_upgrade($oldversion): bool {  
    global $CFG, $DB;

    $dbman \= $DB\-\>get\_manager(); // Loads ddl manager and xmldb classes.

    if ($oldversion \< 2019031200) {  
        // Perform the upgrade from version 2019031200 to the next version.  
        // Add new fields to certificate table.  
        $table \= new xmldb\_table('certificate');  
        $field \= new xmldb\_field('showcode');  
        $field\-\>set\_attributes(XMLDB\_TYPE\_INTEGER, '1', XMLDB\_UNSIGNED, XMLDB\_NOTNULL, null, '0', 'savecert');  
        if (\!$dbman\-\>field\_exists($table, $field)) {  
            $dbman\-\>add\_field($table, $field);  
        }  
        // Add new fields to certificate\_issues table.  
        $table \= new xmldb\_table('certificate\_issues');  
        $field \= new xmldb\_field('code');  
        $field\-\>set\_attributes(XMLDB\_TYPE\_CHAR, '50', null, null, null, null, 'certificateid');  
        if (\!$dbman\-\>field\_exists($table, $field)) {  
            $dbman\-\>add\_field($table, $field);  
        }

        // Certificate savepoint reached.  
        upgrade\_mod\_savepoint(true, 2012091800, 'certificate');  
    }

    if ($oldversion \< 2019031201) {  
        // Perform the upgrade from version 2019031201 to the next version.  
    }

    // Everything has succeeded to here. Return true.  
    return true;  
}

                                                                                                                                                                 

## Annexe \- Code utile en PHP

// Prevent access to this code from URL  
defined('MOODLE\_INTERNAL') || die();  
