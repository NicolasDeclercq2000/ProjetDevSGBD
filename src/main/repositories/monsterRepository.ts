import prisma from '../db';
import { IMonster } from '../../shared/interfaces/IMonster';
import { IMonsterCreate } from '../../shared/interfaces/IMonsterCreate';
import { IMonsterUpdate } from '../../shared/interfaces/IMonsterUpdate';

export const monsterRepository = {
  getAll: async (): Promise<IMonster[]> => {
    const monstres = await prisma.monstres.findMany({
      orderBy: {
        nom_monstre: 'asc',
      },
      include: {
        Types_Monstres: true, 
        Habitats: true,       
      },
    });
    return monstres as unknown as IMonster[];
  },

  getById: async (id: number): Promise<IMonster | null> => {
    const monstre = await prisma.monstres.findUnique({
      where: { id_monstre: id },
      include: {
        Types_Monstres: true,
        Habitats: true,
        Butins: true,
        Faiblesses: {
          include: {
            Elements: true,
          },
        },
      },
    });
    return monstre as unknown as IMonster;
  },

  create: async (payload: IMonsterCreate): Promise<IMonster> => {
    const newMonster = await prisma.monstres.create({
      data: {
        nom_monstre: payload.nom_monstre,
        description: payload.description,
        id_type: payload.id_type,
        id_habitat: payload.id_habitat,
      },
      include: {
        Types_Monstres: true,
        Habitats: true,
        Faiblesses: { include: { Elements: true } },
        Butins: true
      }
    });
    return newMonster as unknown as IMonster;
  },

  delete: async (id: number): Promise<boolean> => {
    try {
      // 1. Suppression des dépendances (Nettoyage)
      await prisma.faiblesses.deleteMany({ where: { id_monstre: id } });
      await prisma.butins.deleteMany({ where: { id_monstre: id } });
      
      // 2. Suppression du monstre
      await prisma.monstres.delete({
        where: { id_monstre: id },
      });
      
      return true;
    } catch (error) {
      console.error(`Erreur lors de la suppression du monstre ${id} :`, error);
      return false;
    }
  },

  update: async (payload: IMonsterUpdate): Promise<IMonster | null> => {
    try {
      if (!payload.id_monstre) {
        throw new Error("L'ID du monstre est manquant dans le payload de mise à jour.");
      }

      const updatedMonster = await prisma.monstres.update({
        where: { id_monstre: payload.id_monstre },
        data: {
          nom_monstre: payload.nom_monstre,
          description: payload.description,
          id_type: payload.id_type,
          id_habitat: payload.id_habitat,
        },
        include: {
          Types_Monstres: true,
          Habitats: true,
          Faiblesses: { include: { Elements: true } },
          Butins: true
        }
      });
      return updatedMonster as unknown as IMonster;
    } catch (error) {
      console.error(`Erreur update monstre ${payload.id_monstre} :`, error);
      return null;
    }
  },
};