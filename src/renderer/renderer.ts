import './index.css';
import { createApp } from 'vue';
import App from './App.vue';
import router from './router'; // <--- Importe le routeur qu'on a créé

const app = createApp(App);

app.use(router); // <--- Dis à Vue d'utiliser le routeur
app.mount('#app');

console.log('Renderer : Vue application mounted!');