export interface IMonster {
  // Champs de base de la table Monstres
  id_monstre: number;
  nom_monstre: string;
  description: string | null;
  id_type: number | null;
  id_habitat: number | null;

  // Relation : Type (ex: Wyverne)
  Types_Monstres: {
    nom_type: string;
  } | null;

  // Relation : Habitat (ex: Forêt)
  Habitats: {
    nom_habitat: string;
    region: string | null;
  } | null;

  // Relation : Faiblesses (Table de liaison)
  Faiblesses: {
    niveau: number | null; // ex: 3 étoiles
    Elements: {
      nom_element: string; // ex: Feu, Eau
      icone: string | null;
    } | null;
  }[];

  // Relation : Butins (Loot)
  Butins: {
    nom: string;
    rarete: number | string;
    description: string | null;
  }[];
}