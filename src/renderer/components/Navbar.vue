<script setup lang="ts">
import { useRouter } from 'vue-router';

const router = useRouter();
</script>

<template>
  <nav class="navbar">
    <div class="brand" @click="router.push('/')">
      <span class="logo">🐉</span>
      <span class="title">Wiki Monster Hunter</span>
    </div>

    <div class="nav-links">
      <button @click="router.push('/')" class="nav-btn">
        🏠 Accueil
      </button>
      
      <button @click="router.push('/add')" class="nav-btn add-btn">
        ➕ Nouveau Monstre
      </button>
    </div>
  </nav>
</template>

<style scoped>
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #2c3e50;
  padding: 15px 30px;
  color: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.2);
  position: sticky;
  top: 0;
  z-index: 100;
}

.brand {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  transition: opacity 0.2s;
}
.brand:hover {
  opacity: 0.8;
}

.logo {
  font-size: 1.8rem;
}

.title {
  font-size: 1.4rem;
  font-weight: bold;
  letter-spacing: 1px;
}

.nav-links {
  display: flex;
  gap: 15px;
}

.nav-btn {
  background: transparent;
  border: 1px solid transparent;
  color: #ecf0f1;
  padding: 8px 15px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 1rem;
  transition: all 0.2s;
  font-weight: 500;
}

.nav-btn:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.add-btn {
  background-color: #27ae60;
  color: white;
  border: none;
  font-weight: bold;
}

.add-btn:hover {
  background-color: #2ecc71;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}
</style>