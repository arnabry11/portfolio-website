const pages = [
  '/',
  '/projects/ev-charging/',
  '/projects/ask-the-docs/',
  '/projects/niyojan/',
];

export function GET({ site }: { site: URL }) {
  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${pages.map((page) => `  <url><loc>${new URL(page, site).href}</loc></url>`).join('\n')}
</urlset>`;
  return new Response(body, { headers: { 'Content-Type': 'application/xml' } });
}
