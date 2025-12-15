<template>
  <div class="container">
    <!-- Bouton Retour -->
    <button @click="goBack" class="back-btn">⬅ Retour</button>

    <!-- Affichage conditionnel : on attend que les données arrivent -->
    <div v-if="monster">
      
      <!-- En-tête : Titre + Bouton Supprimer -->
      <div class="header-actions">
        <h1>{{ monster.nom_monstre }}</h1>
        <button @click="deleteMonster" class="delete-btn">🗑️ Supprimer</button>
      </div>
      
      <!-- Badges (Type et Habitat) -->
      <!-- Les classes .badges, .badge, etc. viennent de index.css -->
      <div class="badges">
        <span v-if="monster.Types_Monstres" class="badge type-badge">
          {{ monster.Types_Monstres.nom_type }}
        </span>
        <span v-if="monster.Habitats" class="badge habitat-badge">
          📍 {{ monster.Habitats.nom_habitat }}
        </span>
      </div>

      <!-- Description -->
      <p class="description">{{ monster.description }}</p>

      <!-- Les Panneaux d'informations -->
      <div class="panels">
        
        <!-- 1. Panneau Faiblesses -->
        <div class="panel">
          <h3>⚔️ Faiblesses</h3>
          <ul>
            <li v-for="(f, index) in monster.Faiblesses" :key="index" class="faiblesse-item">
              <!-- Nom de l'élément (via la relation Elements) -->
              <span v-if="f.Elements" class="element-name">
                {{ f.Elements.nom_element }}
              </span>
              <!-- Étoiles selon le niveau -->
              <span class="stars">
                {{ '⭐'.repeat(f.niveau || 0) }}
              </span>
            </li>
          </ul>
          <p v-if="monster.Faiblesses.length === 0" class="empty-msg">Aucune faiblesse connue.</p>
        </div>

        <!-- 2. Panneau Butins -->
        <div class="panel">
          <h3>💰 Butins (Loot)</h3>
          <ul>
            <li v-for="(b, index) in monster.Butins" :key="index">
              {{ b.nom }} <span class="rarete">(Rareté: {{ b.rarete }})</span>
            </li>
          </ul>
          <p v-if="monster.Butins.length === 0" class="empty-msg">Aucun butin enregistré.</p>
        </div>
        
      </div>
    </div>

    <!-- Chargement -->
    <div v-else class="loading">Chargement des données...</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import type { IMonster } from '../../shared/interfaces/IMonster';

const route = useRoute();
const router = useRouter();
const monster = ref<IMonster | null>(null);

// Retour à l'accueil
const goBack = () => {
  router.push('/');
};

// Fonction de suppression
const deleteMonster = async () => {
  if (!monster.value) return;

  const confirmDelete = confirm(`Veux-tu vraiment supprimer ${monster.value.nom_monstre} ? Cette action est irréversible !`);
  
  if (confirmDelete) {
    const success = await window.monsterAPI.deleteMonster(monster.value.id_monstre);
    if (success) {
      alert("Monstre supprimé !");
      router.push('/'); // On retourne à l'accueil
    } else {
      alert("Erreur lors de la suppression.");
    }
  }
};

// Au chargement de la page
onMounted(async () => {
  const id = Number(route.params.id);
  console.log("Page Détail : demande pour l'ID", id);
  try {
    const data = await window.monsterAPI.getMonsterDetails(id);
    monster.value = data;
  } catch (e) {
    console.error("Erreur chargement détail :", e);
  }
});
</script>

<style scoped>
.container { padding: 40px; max-width: 800px; margin: 0 auto; font-family: sans-serif; }

.back-btn { 
  background: none; border: 2px solid #ddd; padding: 8px 16px; 
  border-radius: 20px; cursor: pointer; font-weight: bold; margin-bottom: 20px;
  transition: all 0.2s;
}
.back-btn:hover { border-color: #3498db; color: #3498db; }

/* En-tête avec titre et bouton supprimer alignés */
.header-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

h1 { margin: 0; color: #2c3e50; }

.delete-btn {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 10px 15px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  transition: background 0.2s;
}
.delete-btn:hover { background-color: #c0392b; }

.description { font-size: 1.1rem; line-height: 1.6; color: #444; margin: 20px 0; }

.panels { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 30px; }
.panel { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }

h3 { margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 10px; color: #2c3e50; }

ul { padding-left: 20px; }
li { margin-bottom: 8px; }
.empty-msg { color: #888; font-style: italic; }

/* Styles spécifiques aux faiblesses */
.faiblesse-item { display: flex; justify-content: space-between; border-bottom: 1px solid #f9f9f9; padding: 4px 0; }
.element-name { font-weight: bold; color: #e74c3c; }
.rarete { color: #888; font-size: 0.9rem; }
</style>