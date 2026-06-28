# 🐉 Wiki Monster Hunter - Desktop Application

Bienvenue sur le **Wiki Monster Hunter**, une application de bureau performante conçue pour gérer et consulter une encyclopédie de monstres.

Ce projet a été développé dans le cadre d'un cours de développement Desktop. Il démontre l'utilisation d'une architecture moderne séparant le processus principal (Main) du rendu visuel (Renderer), le tout typé strictement et connectant les données à un SGBD local.

---

## 🛠️ Stack Technique & Architecture

Ce projet repose sur une stack robuste et typée :

* **[Electron](https://www.electronjs.org/)** : Framework permettant de créer des applications Desktop avec des technologies Web.
* **[Vue.js 3](https://vuejs.org/) (via Vite)** : Framework Frontend pour une interface réactive et rapide.
* **[TypeScript](https://www.typescriptlang.org/)** : Utilisé sur toute la stack (Main & Renderer) pour garantir la robustesse du code et l'autocomplétion.
* **[Prisma](https://www.prisma.io/)** : ORM (Object-Relational Mapping) moderne. Il sert d'interface entre le code TypeScript et la base de données, gérant les schémas et les types automatiquement.
* **MySQL** : Système de gestion de base de données relationnelle utilisé pour stocker et persister l'intégralité des données de l'encyclopédie.

### Structure du Projet
* `src/main` : **Backend local**. Contient la logique Node.js, la gestion des fenêtres et l'accès à la base de données via Prisma.
* `src/renderer` : **Frontend**. Contient les composants Vue.js et l'interface utilisateur.
* `src/preload.ts` : **Pont de sécurité**. Permet au Frontend de communiquer avec le Backend (IPC) sans exposer tout le système.
* `prisma/` : Contient la définition de la BDD (`schema.prisma`) et le script de remplissage (`seed.ts`).

---

## 📋 Fonctionnalités

### 1. Consultation (Lecture)
* Visualisation de tous les monstres sous forme de cartes.
* Barre de recherche en temps réel pour filtrer par nom.
* Page de détail complète affichant : Habitats, Type, Description, Faiblesses élémentaires et Butins.

### 2. Gestion (Écriture)
* **Ajout** : Formulaire complet pour insérer un nouveau monstre dans la base.
* **Modification** : Édition rapide des informations d'un monstre existant.
* **Suppression** : Retrait définitif d'un monstre de la base de données.

---

## ⚙️ Prérequis et Installation

Avant de commencer, assurez-vous d'avoir les outils suivants installés sur votre machine :

1. **Node.js** (Version 16 LTS ou supérieure recommandée) - [Télécharger ici](https://nodejs.org/)
2. **Git** - [Télécharger ici](https://git-scm.com/)
3. Un serveur MySQL local (via **WAMP, MAMP, XAMPP** ou une installation native)

### Étape 1 : Récupération du projet
Ouvrez votre terminal et clonez le dépôt :

```bash
git clone [https://github.com/NicolasDeclercq2000/ProjetDevSGBD.git](https://github.com/NicolasDeclercq2000/ProjetDevSGBD.git)
cd ProjetDevSGBD
```

### Étape 2 : Installation des dépendances
Installez les librairies nécessaires au fonctionnement d'Electron, Vue et Prisma :

```bash
npm install
```

---

## 🗄️ Configuration de la Base de Données

### 1. Préparation de la base de données
1. Lancez votre serveur MySQL local (WAMP, MAMP, etc.).
2. Créez une base de données vide nommée `monsterhunter_wiki`.

### 2. Variables d'environnement
À la racine du projet, créez un fichier nommé **`.env`** (ce fichier est ignoré par Git pour des raisons de sécurité). Ajoutez-y votre chaîne de connexion Prisma en l'adaptant si nécessaire à vos identifiants locaux :

```env
DATABASE_URL="mysql://root@localhost:3306/monsterhunter_wiki"
```
*(Si votre configuration requiert un mot de passe, utilisez la structure suivante : `mysql://root:VOTRE_MOT_DE_PASSE@localhost:3306/monsterhunter_wiki`)*

### 3. Création des tables (Migration)
Cette commande va lire le fichier `schema.prisma`, se connecter à votre instance MySQL locale et générer automatiquement la structure des tables (Monstres, Habitats, etc.).

```bash
npx prisma migrate dev --name init
```

### 4. Remplissage des données (Seeding)
Pour injecter les données de test initiales (Rathalos, Teostra, Habitats, Types...) afin de ne pas démarrer avec une application vide :

```bash
npx prisma db seed
```
> **Note :** Si vous voyez le message "Seeding terminé avec succès", la base de données est prête !

---

## ▶️ Lancement de l'Application

### Mode Développement
C'est le mode recommandé pour tester et modifier le code. Il permet le rechargement à chaud (Hot Reload).

```bash
npm start
```
Une fenêtre d'application s'ouvre automatiquement après quelques secondes.

### Création de l'Exécutable (Build)
Pour générer un installateur ou un fichier exécutable autonome (`.exe` sur Windows, `.app` sur Mac) :

```bash
npm run make
```
Les fichiers générés se trouveront dans le dossier `out/make/`.

---

## 🆘 Dépannage (Troubleshooting)

Voici les solutions aux problèmes courants :

* **L'application affiche un écran blanc au démarrage :** Vérifiez votre terminal. S'il y a des erreurs TypeScript en rouge, l'application ne se lancera pas. Corrigez les erreurs de typage indiquées.
* **Erreur "Prisma Client could not be initialized" :** Le client Prisma n'est pas synchronisé avec le schéma. Lancez la commande suivante pour le regénérer, puis redémarrez l'application :
  ```bash
  npx prisma generate
  ```
* **La base de données doit être remise à zéro ou synchronisée à nouveau :** Vous pouvez vider la base, réappliquer les migrations et relancer le seed proprement avec la commande dédiée de Prisma :
  ```bash
  npx prisma migrate reset
  ```

---

👤 **Auteur :** Nicolas Declercq  
*Projet étudiant - Développement d'application Desktop riche.*