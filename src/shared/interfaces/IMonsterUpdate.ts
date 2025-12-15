export interface IMonsterUpdate { 
    // Obligatoire : On doit savoir quel monstre modifier
    id_monstre: number; 
    
    // Optionnels (?) : On ne met à jour que ce qui est présent
    nom_monstre?: string; 
    description?: string; 
    
    // On garde "| null" au cas où tu voudrais supprimer le lien vers un type/habitat
    id_type?: number | null; 
    id_habitat?: number | null; 
}