import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://portfolio.arnabroy.co.in',
  trailingSlash: 'always',
  build: { format: 'directory' },
});
