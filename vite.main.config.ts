import { defineConfig } from 'vite';

// https://vitejs.dev/config
export default defineConfig({
  build: {
    rollupOptions: {
      // C'est ici qu'on dit à Vite : "Touche pas à ça, c'est du natif !"
      external: ['@prisma/client', '.prisma/client'],
    },
  },
});