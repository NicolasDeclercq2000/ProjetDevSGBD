<script setup lang="ts">
import { ref, watch } from 'vue';
import type { IMonster } from '../../shared/interfaces/IMonster';
import type { IMonsterUpdate } from '../../shared/interfaces/IMonsterUpdate';

const props = defineProps<{
  isOpen: boolean;
  monster: IMonster | null;
}>();

const emit = defineEmits(['close', 'refresh']);

const formData = ref<IMonsterUpdate>({
  id_monstre: 0,
  nom_monstre: '',
  description: '',
  id_type: null,
  id_habitat: null
});

watch(() => props.monster, (newVal) => {
  if (newVal) {
    formData.value = {
      id_monstre: newVal.id_monstre,
      nom_monstre: newVal.nom_monstre,
      description: newVal.description || '',
      id_type: newVal.id_type,
      id_habitat: newVal.id_habitat
    };
  }
});

const handleSave = async () => {
  if (!formData.value.id_monstre) return;

  try {
    const cleanPayload = JSON.parse(JSON.stringify(formData.value));

    cleanPayload.id_type = cleanPayload.id_type ? Number(cleanPayload.id_type) : null;
    cleanPayload.id_habitat = cleanPayload.id_habitat ? Number(cleanPayload.id_habitat) : null;

    console.log("Envoi de la mise à jour...", cleanPayload);
    
    const result = await window.monsterAPI.updateMonster(cleanPayload);
    
    if (result) {
      alert('Monstre mis à jour avec succès ! ✅');
      emit('refresh');
      emit('close');
    } else {
      alert("Erreur : La mise à jour a échoué.");
    }
  } catch (error) {
    console.error("Erreur technique :", error);
    alert("Une erreur est survenue.");
  }
};
</script>

<template>
  <div v-if="isOpen" class="modal-backdrop" @click="$emit('close')">
    <div class="modal-content" @click.stop>
      <div class="modal-header">
        <h2>Modifier</h2>
        <button class="close-btn" @click="$emit('close')">×</button>
      </div>
      
      <form @submit.prevent="handleSave">
        <div class="form-group">
          <label>Nom :</label>
          <input v-model="formData.nom_monstre" type="text" required />
        </div>

        <div class="form-group">
          <label>Description :</label>
          <textarea v-model="formData.description" rows="5"></textarea>
        </div>

        <div class="form-row">
          <div class="form-group half">
            <label>ID Type :</label>
            <input v-model.number="formData.id_type" type="number" />
          </div>
          <div class="form-group half">
            <label>ID Habitat :</label>
            <input v-model.number="formData.id_habitat" type="number" />
          </div>
        </div>

        <div class="actions">
          <button type="button" @click="$emit('close')" class="btn-cancel">Annuler</button>
          <button type="submit" class="btn-save">Sauvegarder</button>
        </div>
      </form>
    </div>
  </div>
</template>

<style scoped>
.modal-backdrop {
  position: fixed; top: 0; left: 0; width: 100%; height: 100%;
  background: rgba(0,0,0,0.6); display: flex; justify-content: center; align-items: center; z-index: 999;
}
.modal-content {
  background: white; padding: 25px; border-radius: 10px; width: 450px;
}
.modal-header { display: flex; justify-content: space-between; margin-bottom: 20px; }
.close-btn { background: none; border: none; font-size: 2rem; cursor: pointer; }
.form-group { margin-bottom: 15px; }
.form-row { display: flex; gap: 15px; }
.half { flex: 1; }
input, textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
.actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
.btn-save { background: #2ecc71; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
.btn-cancel { background: #e74c3c; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
</style>