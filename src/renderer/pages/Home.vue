<template>
  <div class="container">
    <!-- Barre de Recherche -->
    <div class="search-container">
      <input 
        type="text" 
        v-model="searchQuery" 
        placeholder="🔍 Rechercher un monstre (ex: Rathalos)..." 
        class="search-input"
      />
    </div>
    <div v-if="monsters.length === 0" class="loading">
      Chargement des monstres...
    </div>

    <!-- Pas de résultat -->
    <div v-else-if="filteredMonsters.length === 0" class="no-result">
      Aucun monstre ne correspond à "{{ searchQuery }}" 🦖
    </div>

    <!-- Grille des Monstres -->
    <div v-else class="grid">
      <div 
        v-for="monster in filteredMonsters" 
        :key="monster.id_monstre" 
        class="card"
        @click="goToDetail(monster.id_monstre)"
      >
        <button class="edit-btn-card" @click.stop="openEditModal(monster)">
          ✏️
        </button>

        <h2>{{ monster.nom_monstre }}</h2>
        <p class="description">
          {{ monster.description || "Pas de description disponible." }}
        </p>
        
        <div class="badges">
          <span v-if="monster.Types_Monstres" class="badge type-badge">
            {{ monster.Types_Monstres.nom_type }}
          </span>
          <span v-if="monster.Habitats" class="badge habitat-badge">
            📍 {{ monster.Habitats.nom_habitat }}
          </span>
        </div>
      </div>
    </div>

    
    <EditMonsterModal 
      :isOpen="isModalOpen"
      :monster="selectedMonster"
      @close="isModalOpen = false"
      @refresh="loadData"
    />

  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';
import type { IMonster } from '../../shared/interfaces/IMonster';
import EditMonsterModal from '../components/EditMonsterModal.vue';

const monsters = ref<IMonster[]>([]);
const searchQuery = ref('');
const router = useRouter();

const isModalOpen = ref(false);
const selectedMonster = ref<IMonster | null>(null);

const goToDetail = (id: number) => {
  router.push(`/monster/${id}`);
};

const filteredMonsters = computed(() => {
  if (searchQuery.value.trim() === '') {
    return monsters.value;
  }
  return monsters.value.filter((monster) => {
    return monster.nom_monstre.toLowerCase().includes(searchQuery.value.toLowerCase());
  });
});

const loadData = async () => {
  console.log("Home : Chargement des données...");
  try {
    const data = await window.monsterAPI.getMonsters();
    monsters.value = data;
  } catch (error) {
    console.error("Erreur :", error);
  }
};

const openEditModal = (monster: IMonster) => {
  selectedMonster.value = monster; // On dit quel monstre on modifie
  isModalOpen.value = true;        // On ouvre la fenêtre
};

onMounted(() => {
  loadData();
});
</script>

<style scoped>

.container {
  padding: 20px;
  font-family: sans-serif;
}

h1 {
  text-align: center;
  color: #2c3e50;
  margin-bottom: 20px;
}

.search-container {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}

.search-input {
  width: 100%;
  max-width: 500px;
  padding: 12px 20px;
  font-size: 1.1rem;
  border: 2px solid #ddd;
  border-radius: 25px;
  outline: none;
  transition: border-color 0.3s;
}

.search-input:focus {
  border-color: #3498db;
  box-shadow: 0 0 8px rgba(52, 152, 219, 0.3);
}

.no-result {
  text-align: center; color: #777; font-size: 1.2rem; margin-top: 40px;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}


.card {
  background: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: transform 0.2s;
  position: relative; 
}
.card:hover {
  transform: translateY(-5px);
}

.edit-btn-card {
  position: absolute;
  top: 10px;
  right: 10px;
  background: #ecf0f1;
  border: none;
  border-radius: 50%;
  width: 30px;
  height: 30px;
  cursor: pointer;
  font-size: 1.1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
}
.edit-btn-card:hover {
  background: #bdc3c7;
}

.description {
  color: #666;
  font-size: 0.9rem;
  max-height: 60px;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 10px;
  margin-right: 25px; 
}
.badges {
  display: flex; gap: 8px; margin-top: 10px; flex-wrap: wrap;
}
.badge {
  padding: 4px 10px; border-radius: 12px; font-size: 0.75rem; font-weight: 600; box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}
.type-badge { background-color: #3498db; color: white; }
.habitat-badge { background-color: #27ae60; color: white; }

.add-btn {
  background-color: #3498db; color: white; border: none; padding: 10px 20px; border-radius: 20px; cursor: pointer; font-weight: bold;
}
.add-btn:hover { background-color: #2980b9; }

.loading { text-align: center; font-size: 1.2rem; color: #666; }
</style>