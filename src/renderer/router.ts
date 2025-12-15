import { createRouter, createWebHashHistory } from 'vue-router';

// 👇 CORRECTION ICI : Utilise "./" au lieu de "../"
import Home from './pages/Home.vue';
import MonsterDetail from './pages/MonsterDetail.vue';
import AddMonster from './pages/AddMonster.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/monster/:id', component: MonsterDetail },
  { path: '/add', component: AddMonster },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;