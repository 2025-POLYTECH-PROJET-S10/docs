### **Rapport RGPD \- FOETAPP360**

**Projet S10 \- Développement d’un plugin Moodle**  
 **Ali FAWAZ, Romain HOCQUET, Alexandre MOUA, Brice VITTET**

---

## 1\. Introduction

Dans ce rapport, nous détaillons les mesures mises en place au cours de notre projet pour respecter les règles du RGPD (« Règlement Général sur la Protection des Données »). En tant que projet étudiant, nous avons essayé de respecter un maximum de dispositions RGPD dans la limite de nos compétences et des moyens disponibles, sans viser un respect exhaustif de toutes les exigences. 

---

## 2\. Données collectées et leur finalité

FOETAPP360 ne stocke que les informations strictement nécessaires pour offrir une expérience pédagogique efficace :

**Données des étudiants :**

* **Identifiant Moodle (ID utilisateur)** → Permet de lier les sessions aux utilisateurs et d’afficher leurs statistiques personnelles.  
* **Réponses aux exercices** → Permet de générer un feedback personnalisé et d’améliorer la progression de l’étudiant.  
* **Sessions d'entraînement** → Enregistre le temps passé sur les exercices et les niveaux de difficulté choisis pour offrir un suivi des performances.

**Données des enseignants :**

* **Gestion des ensembles de représentations** → Permet d’ajouter ou modifier les représentations disponibles dans les exercices.

**Données non stockées** : FOETAPP360 ne collecte aucune donnée personnelle sensible (nom, adresse, e-mail, historique de navigation, etc.) autre que ceux collectés déjà par moodle.

---

## 3\. Bases légales du traitement des données

Les données traitées dans FOETAPP360 s’inscrivent dans le cadre de **l’intérêt légitime de la formation** et de l’apprentissage en ligne :

* **Usage pédagogique** : Les données des étudiants sont utilisées uniquement pour améliorer leur apprentissage et proposer un suivi personnalisé.  
* **Absence de notation** : Le plugin n’attribue aucune note et ne participe pas à une évaluation formelle des étudiants.  
* **Contrôle total des enseignants et administrateurs Moodle** : Ils peuvent gérer les représentations et suivre les tendances des exercices.

---

## 4\. Sécurité et Protection des Données

Des mesures spécifiques ont été mises en place pour garantir la sécurité des données collectées :

**Stockage sécurisé**

* Les informations sont stockées dans la **base de données de Moodle**, qui applique déjà des standards de protection conformes.  
* L’accès aux données est restreint aux enseignants et administrateurs via le système de permissions Moodle (ex: les rôles tel que manager, teacher)

**Contrôle des accès et gestion des droits**

* Chaque **étudiant** ne peut consulter que ses propres résultats.  
* Les **enseignants** voient uniquement les tendances globales, sans accès aux données individuelles des étudiants. Ils ne peuvent voir que les données correspondant à ses cours.  
* Les **administrateurs** Moodle peuvent supprimer les données si nécessaire.

**Validation des entrées**

* Toutes les réponses saisies sont **normalisées** et **vérifiées** pour éviter les erreurs et protéger la base de données contre d’éventuelles injections SQL.

**Gestion des fichiers**

* Les images utilisées pour les exercices sont **vérifiées** pour éviter l’importation de fichiers malveillants.

---

## 5\. Durée de conservation des données

Les données stockées sont maintenues uniquement pour la durée nécessaire à l’apprentissage :

* **Données des sessions et réponses des étudiants** : Stockées tant que l’instance du plugin est activé sur Moodle et sont supprimables au travers d’une demande auprès d’un administrateur.  
* **Représentations ajoutées par les enseignants** : Conservées jusqu’à la suppression manuelle par un enseignant ou un administrateur.

---

## 6\. Droits des utilisateurs

Conformément au RGPD, les utilisateurs conservent un contrôle total sur leurs données :

**Droits des étudiants**

* Accès à leurs propres statistiques et résultats.  
* Demande de suppression de leurs données via l’administration Moodle.

**Droits des enseignants et administrateurs**

* Modification ou suppression des représentations ajoutées.  
* Suppression d’une instance si nécessaire.

---

## 7\. Améliorations possibles pour renforcer la conformité

Bien que le plugin soit déjà conforme au RGPD dans sa version actuelle, plusieurs évolutions peuvent être envisagées :

* **Option de suppression automatique des anciennes sessions**, après un certain délai.  
* **Ajout d’une page dédiée aux mentions légales et RGPD**, expliquant clairement aux utilisateurs le traitement de leurs données.

## Conclusion

Notre projet intègre plusieurs dispositions visant à respecter les principes fondamentaux du RGPD. Bien que des améliorations soient encore possibles, les outils et procédures mis en place montrent notre engagement à protéger les données des utilisateurs et à respecter leurs droits. 

