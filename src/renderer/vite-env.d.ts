/// <reference types="vite/client" />

import { IMonster } from './shared/interfaces/IMonster';
import { IMonsterCreate } from './shared/interfaces/IMonsterCreate';
import { IMonsterUpdate } from './shared/interfaces/IMonsterUpdate';

// Définition de la forme exacte de ton API
interface IMonsterAPI {
  getMonsters: () => Promise<IMonster[]>;
  getMonsterDetails: (id: number) => Promise<IMonster | null>;
  createMonster: (payload: IMonsterCreate) => Promise<IMonster | null>;
  updateMonster: (payload: IMonsterUpdate) => Promise<IMonster | null>;
  deleteMonster: (id: number) => Promise<boolean>;
}

// On injecte cette interface dans l'objet global Window
declare global {
  interface Window {
    monsterAPI: IMonsterAPI;
  }
}