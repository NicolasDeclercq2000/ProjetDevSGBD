# 🐉 Wiki Monster Hunter - Desktop Application

Bienvenue sur le **Wiki Monster Hunter**, une application de bureau performante conçue pour gérer et consulter une encyclopédie de monstres.

Ce projet a été développé dans le cadre d'un cours de développement Desktop. Il démontre l'utilisation d'une architecture moderne séparant le processus principal (Main) du rendu visuel (Renderer), le tout typé strictement et persistant les données localement.

---

## 🛠️ Stack Technique & Architecture

Ce projet repose sur une stack robuste et typée :

* **[Electron](https://www.electronjs.org/)** : Framework permettant de créer des applications Desktop avec des technologies Web.
* **[Vue.js 3](https://vuejs.org/) (via Vite)** : Framework Frontend pour une interface réactive et rapide.
* **[TypeScript](https://www.typescriptlang.org/)** : Utilisé sur toute la stack (Main & Renderer) pour garantir la robustesse du code et l'autocomplétion.
* **[Prisma](https://www.prisma.io/)** : ORM (Object-Relational Mapping) moderne. Il sert d'interface entre le code TypeScript et la base de données, gérant les schémas et les types automatiquement.
* **SQLite** : Base de données relationnelle légère stockée dans un fichier local (`dev.db`). Aucune installation de serveur (WAMP/MAMP) n'est requise.

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

1.  **Node.js** (Version 16 LTS ou supérieure recommandée) - [Télécharger ici](https://nodejs.org/)
2.  **Git** - [Télécharger ici](https://git-scm.com/)

### Étape 1 : Récupération du projet
Ouvrez votre terminal et clonez le dépôt :

```bash
git clone [https://github.com/NicolasDeclercq2000/MonsterHunterWiki.git](https://github.com/NicolasDeclercq2000/MonsterHunterWiki.git)
cd MonsterHunterWiki
Étape 2 : Installation des dépendances

Installez les librairies nécessaires au fonctionnement d'Electron, Vue et Prisma. Cela peut prendre une minute.

Bash
npm install
🗄️ Configuration de la Base de Données
Ce projet utilise Prisma avec SQLite. Vous devez initialiser le fichier de base de données local avant de lancer l'application.

1. Création des tables (Migration)

Cette commande va lire le fichier schema.prisma et créer le fichier prisma/dev.db avec la structure correcte (Tables Monstres, Habitats, etc.).

Bash
npx prisma migrate dev --name init
2. Remplissage des données (Seeding)

Pour ne pas démarrer avec une application vide, nous injectons des données de test (Rathalos, Teostra, Habitats, Types...).

Bash
npx prisma db seed
Note : Si vous voyez le message "Seeding terminé avec succès", tout est prêt !

▶️ Lancement de l'Application
Mode Développement

C'est le mode recommandé pour tester et modifier le code. Il permet le rechargement à chaud (Hot Reload).

Bash
npm start
Une fenêtre d'application devrait s'ouvrir après quelques secondes.

Création de l'Exécutable (Build)

Pour générer un installateur ou un fichier exécutable autonome (.exe sur Windows, .app sur Mac) :

Bash
npm run make
Les fichiers générés se trouveront dans le dossier out/make/.

🆘 Dépannage (Troubleshooting)
Voici les solutions aux problèmes courants :

Problème : L'application affiche un écran blanc au démarrage.

Solution : Vérifiez votre terminal. S'il y a des erreurs TypeScript rouge, l'application ne se lancera pas. Corrigez les erreurs de typage indiquées.

Problème : Erreur "Prisma Client could not be initialized".

Cause : Le client Prisma n'est pas synchronisé avec le schéma.

Solution : Lancez la commande npx prisma generate, puis redémarrez l'application.

Problème : La base de données semble corrompue ou les données sont incohérentes.

Solution : Vous pouvez remettre la base à zéro ("Factory Reset") avec ces commandes :

Supprimez le dossier prisma/migrations et le fichier prisma/dev.db.

Relancez npx prisma migrate dev --name init.

Relancez npx prisma db seed.

👤 Auteur
Nicolas Declercq Projet étudiant - Développement d'application Desktop riche.