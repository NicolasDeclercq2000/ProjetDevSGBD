import { contextBridge, ipcRenderer } from 'electron';

// 👇 Attention aux chemins : on utilise "./" car preload.ts est à la racine de "src"
import { IMonster } from './shared/interfaces/IMonster';
import { IMonsterCreate } from './shared/interfaces/IMonsterCreate';
import { IMonsterUpdate } from './shared/interfaces/IMonsterUpdate';

contextBridge.exposeInMainWorld('monsterAPI', {
  
  // --- LECTURE (READ) ---
  
  // Récupérer tous les monstres
  getMonsters: (): Promise<IMonster[]> => {
    return ipcRenderer.invoke('get-monsters');
  },

  // Récupérer un seul monstre par son ID
  getMonsterDetails: (id: number): Promise<IMonster | null> => {
    return ipcRenderer.invoke('get-monster-details', id);
  },

  // --- ÉCRITURE (WRITE) ---

  // Créer un monstre
  createMonster: (payload: IMonsterCreate): Promise<IMonster | null> => {
    return ipcRenderer.invoke('create-monster', payload);
  },

  // Mettre à jour un monstre (La fonction que tu as ajoutée)
  updateMonster: (payload: IMonsterUpdate): Promise<IMonster | null> => {
    return ipcRenderer.invoke('update-monster', payload);
  },

  // Supprimer un monstre
  deleteMonster: (id: number): Promise<boolean> => {
    return ipcRenderer.invoke('delete-monster', id);
  },
});