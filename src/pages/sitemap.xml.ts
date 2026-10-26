import type { APIRoute } from 'astro';
import { getProjects, projectPath } from '@/lib/projects';

export const GET: APIRoute = async ({ site }) => {
  const pages = ['/', ...(await getProjects()).map(projectPath)];
  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${pages.map((page) => `  <url><loc>${new URL(page, site).href}</loc></url>`).join('\n')}
</urlset>`;
  return new Response(body, { headers: { 'Content-Type': 'application/xml' } });
};
