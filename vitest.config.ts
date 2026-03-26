import { defineConfig } from 'vitest/config';
import path from 'path';

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    include: ['src/__tests__/**/*.test.ts'],
    coverage: {
      provider: 'v8',
      include: [
        'src/app/api/**/*.ts',
        'src/lib/sat-scoring.ts',
        'src/lib/fetch-with-retry.ts',
        'src/stores/useSATTestStore.ts',
        'src/stores/useGRETestStore.ts',
      ],
      thresholds: {
        lines: 60,
        functions: 60,
        branches: 50,
        statements: 60,
      },
    },
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
      '@/design-system': path.resolve(__dirname, 'design-system'),
    },
  },
});
