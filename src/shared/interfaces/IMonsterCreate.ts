export interface IMonsterCreate {
  // Pas d'ID ici, c'est la base de données qui le génère
  nom_monstre: string;
  description: string;
  
  // On envoie juste les IDs pour faire le lien
  id_type: number | null;
  id_habitat: number | null;
}