<script setup lang="ts">
// On importe le composant qu'on vient de créer
import Navbar from './components/Navbar.vue';
</script>

<template>
  <div class="app-container">
    <!-- 1. La Barre de Navigation (Toujours visible) -->
    <Navbar />

    <!-- 2. Le contenu de la page actuelle (Home, Detail, Add...) -->
    <main class="content">
      <router-view></router-view>
    </main>
  </div>
</template>

<style>
/* Reset global simple */
body {
  margin: 0;
  padding: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: #f4f6f8; /* Fond gris très clair pour l'app */
  color: #333;
}

/* Mise en page */
.app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.content {
  flex: 1; /* Prend toute la place restante */
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto; /* Centre le contenu */
  width: 100%;
  box-sizing: border-box;
}
</style>