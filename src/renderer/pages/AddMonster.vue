<template>
  <div class="container">
    <button @click="goBack" class="back-btn">⬅ Annuler</button>
    <h1>Ajouter un Monstre</h1>

    <form @submit.prevent="submitForm" class="form-card">
      
      <div class="form-group">
        <label>Nom du Monstre :</label>
        <input v-model="form.nom_monstre" type="text" required placeholder="Ex: Tigrex" />
      </div>

      <div class="form-group">
        <label>Description :</label>
        <textarea v-model="form.description" required placeholder="Description du monstre..."></textarea>
      </div>

      <div class="row">
        <div class="form-group">
          <label>ID Type (ex: 1, 2...) :</label>
          <input v-model.number="form.id_type" type="number" placeholder="0" />
        </div>

        <div class="form-group">
          <label>ID Habitat (ex: 1, 2...) :</label>
          <input v-model.number="form.id_habitat" type="number" placeholder="0" />
        </div>
      </div>

      <button type="submit" class="save-btn">💾 Sauvegarder</button>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import type { IMonsterCreate } from '../../shared/interfaces/IMonsterCreate';

const router = useRouter();

// Les données du formulaire
const form = ref<IMonsterCreate>({
  nom_monstre: '',
  description: '',
  id_type: null,
  id_habitat: null,
});

const goBack = () => router.push('/');

const submitForm = async () => {
  console.log("Envoi du formulaire...", form.value);
  
  // On envoie les données au Main Process
  const created = await window.monsterAPI.createMonster({ ...form.value });
  
  if (created) {
    alert('Monstre ajouté avec succès !');
    router.push('/'); // Retour à l'accueil pour voir le nouveau monstre
  } else {
    alert('Erreur lors de la création (Vérifiez les IDs).');
  }
};
</script>

<style scoped>
.container { max-width: 600px; margin: 0 auto; padding: 20px; font-family: sans-serif; }
.back-btn { background: none; border: 2px solid #ddd; padding: 5px 15px; border-radius: 15px; cursor: pointer; margin-bottom: 20px; }
.form-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
.form-group { margin-bottom: 20px; display: flex; flex-direction: column; }
.row { display: flex; gap: 20px; }
label { font-weight: bold; margin-bottom: 8px; color: #34495e; }
input, textarea { padding: 10px; border: 2px solid #eee; border-radius: 8px; font-size: 1rem; }
input:focus, textarea:focus { border-color: #3498db; outline: none; }
.save-btn { width: 100%; padding: 15px; background: #27ae60; color: white; border: none; border-radius: 8px; font-size: 1.1rem; cursor: pointer; transition: background 0.2s; }
.save-btn:hover { background: #219150; }
</style>