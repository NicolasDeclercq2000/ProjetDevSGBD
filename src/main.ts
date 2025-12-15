import { app, BrowserWindow, ipcMain } from 'electron';
import path from 'path';
// On pointe vers le repository qu'on vient de corriger
import { monsterRepository } from './main/repositories/monsterRepository';

// Ces variables sont définies par le build system de Vite/Electron Forge
declare const MAIN_WINDOW_VITE_DEV_SERVER_URL: string;
declare const MAIN_WINDOW_VITE_NAME: string;

const createWindow = () => {
  // Création de la fenêtre du navigateur
  const mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
    },
  });

  // Chargement de l'URL (dev) ou du fichier html (prod)
  if (MAIN_WINDOW_VITE_DEV_SERVER_URL) {
    mainWindow.loadURL(MAIN_WINDOW_VITE_DEV_SERVER_URL);
  } else {
    mainWindow.loadFile(path.join(__dirname, `../renderer/${MAIN_WINDOW_VITE_NAME}/index.html`));
  }

  // Outils de dev
  // mainWindow.webContents.openDevTools(); // Décommente si besoin
};

// --- FIX MAC ---
app.disableHardwareAcceleration();

// Quand l'app est prête
app.on('ready', () => {
  
  // ---------------------------------------------------------
  // 1. LECTURE (READ)
  // ---------------------------------------------------------
  
  ipcMain.handle('get-monsters', async () => {
    console.log('Main [GET-ALL] : Demande de la liste...');
    try {
      return await monsterRepository.getAll();
    } catch (error) {
      console.error('Erreur get-monsters :', error);
      return [];
    }
  });

  ipcMain.handle('get-monster-details', async (_event, id) => {
    console.log(`Main [GET-ONE] : Détails pour ID ${id}`);
    try {
      return await monsterRepository.getById(Number(id));
    } catch (error) {
      console.error('Erreur get-monster-details :', error);
      return null;
    }
  });

  // ---------------------------------------------------------
  // 2. ÉCRITURE (CREATE / UPDATE / DELETE)
  // ---------------------------------------------------------

  ipcMain.handle('create-monster', async (_event, payload) => {
    console.log('Main [CREATE] : Nouveau monstre...', payload);
    try {
      return await monsterRepository.create(payload);
    } catch (error) {
      console.error('Erreur create-monster :', error);
      return null;
    }
  });

  // 👇 C'est ici qu'on ajoute la fonction UPDATE qui manquait
  ipcMain.handle('update-monster', async (_event, payload) => {
    console.log(`Main [UPDATE] : Mise à jour ID ${payload.id_monstre}...`);
    try {
      // Le payload doit correspondre à IMonsterUpdate (avec l'ID dedans)
      return await monsterRepository.update(payload);
    } catch (error) {
      console.error('Erreur update-monster :', error);
      return null;
    }
  });

  ipcMain.handle('delete-monster', async (_event, id) => {
    console.log(`Main [DELETE] : Suppression ID ${id}`);
    try {
      return await monsterRepository.delete(Number(id));
    } catch (error) {
      console.error('Erreur delete-monster :', error);
      return false;
    }
  });

  // ---------------------------------------------------------
  // 3. LANCEMENT FENÊTRE
  // ---------------------------------------------------------
  createWindow();
});

// Quitter quand toutes les fenêtres sont fermées (sauf sur Mac)
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});