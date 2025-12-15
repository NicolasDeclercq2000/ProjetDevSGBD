🐉 Wiki Monster Hunter - Desktop App

Une application de bureau moderne pour gérer une encyclopédie de l'univers Monster Hunter.

Développée avec Electron, Vue.js 3, TypeScript et Prisma.

📋 Fonctionnalités

Consultation : Liste des monstres avec filtrage en temps réel (barre de recherche).

Détails : Page dédiée pour chaque monstre avec ses faiblesses et butins.

Gestion (CRUD) :

Ajout de nouveaux monstres via un formulaire.

Modification rapide via une fenêtre modale (sans rechargement).

Suppression de monstres.

Base de Données : Persistance des données locale via SQLite/MySQL gérée par Prisma.

🛠️ Stack Technique

Ce projet utilise une architecture Main / Renderer sécurisée :

Core : Electron (Chromium + Node.js)

Frontend : Vue.js 3 + Vite

Langage : TypeScript (Typage strict)

Backend / ORM : Prisma

Base de données : SQLite (par défaut) ou MySQL.

🚀 Installation et Lancement

Suivez ces étapes pour lancer le projet sur votre machine.

1. Prérequis

Assurez-vous d'avoir Node.js (version 16 ou supérieure) installé.

node -v


2. Installation des dépendances

À la racine du projet, lancez :

npm install


3. Configuration de la Base de Données (Prisma)

Avant de lancer l'application, il faut créer la base de données locale et la remplir avec les données initiales.

Générer la base de données (Migration) :

npx prisma migrate dev --name init


Remplir la base avec des données de test (Seeding) :
Cette commande va créer les Types, Habitats et quelques Monstres de base (Rathalos, Teostra...).

npx prisma db seed


(Note : Un fichier script.sql est également disponible à la racine pour une importation manuelle si nécessaire).

4. Lancer l'application (Mode Développement)

npm start


Une fenêtre Electron devrait s'ouvrir.

📦 Compilation (Build)

Pour générer un exécutable distribuable (.exe sur Windows, .app sur Mac, ou .deb/.rpm sur Linux) :

npm run make


Les fichiers générés se trouveront dans le dossier out/.

📂 Structure du Projet

MonsterHunterWiki/
├── prisma/
│   ├── schema.prisma        # Modèle de données
│   ├── seed.ts              # Script de remplissage initial
│   └── dev.db               # Fichier de BDD (si SQLite)
├── src/
│   ├── main/                # PROCESSUS PRINCIPAL (Backend Node.js)
│   │   ├── main.ts          # Point d'entrée, gestion des fenêtres
│   │   ├── db.ts            # Singleton Prisma
│   │   ├── handlers/        # Gestionnaires d'événements IPC
│   │   └── repositories/    # Logique d'accès à la BDD
│   ├── preload.ts           # PONT DE SÉCURITÉ (Main <-> Renderer)
│   ├── renderer/            # PROCESSUS DE RENDU (Frontend Vue.js)
│   │   ├── components/      # Composants réutilisables (Navbar, Cards...)
│   │   ├── pages/           # Pages complètes (Home, Add, Detail)
│   │   └── App.vue          # Racine de l'interface
│   └── shared/              # Interfaces TypeScript partagées
└── package.json


🐛 Dépannage (Troubleshooting)

Erreur : "Prisma Client could not be initialized"

Assurez-vous d'avoir lancé npx prisma generate après chaque modification du schema.prisma.

Si vous venez de cloner le projet, lancez npx prisma migrate dev.

Erreur : "Foreign key constraint failed"

Cela arrive si vous essayez de créer un monstre avec un ID de Type ou d'Habitat qui n'existe pas. Utilisez le script de seed pour avoir des IDs valides.

Écran blanc au lancement

Vérifiez la console du terminal pour voir s'il y a des erreurs de compilation TypeScript.

👤 Auteur

Projet réalisé dans le cadre du cours de développement Desktop.
Nicolas Declercq