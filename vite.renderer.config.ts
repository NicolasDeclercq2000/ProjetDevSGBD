import { defineConfig } from 'vite';

// https://vitejs.dev/config
export default defineConfig(async () => {
  // Importation dynamique pour contourner le problème de compatibilité CJS/ESM
  const { default: vue } = await import('@vitejs/plugin-vue');

  return {
    plugins: [vue()], // On active le plugin ici
  };
});