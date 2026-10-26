# Arnab Roy — portfolio

A static editorial portfolio for a software engineer with backend depth, AI-assisted frontend development, and AWS deployment experience, built with Astro and served by Nginx. It contains a homepage, three detailed project case studies, a downloadable résumé, social metadata, a sitemap, and a custom 404 page.

## Local development

```sh
npm install
npm run dev
```

The development server uses `http://localhost:4321` by default.

## Verify and build

```sh
npm run build
npm run preview
```

The static production output is written to `dist/`.

## Container

```sh
docker compose up -d --build
curl --fail http://127.0.0.1:8083/health
```

The default host port is `8083`. Override it without editing the Compose file:

```sh
PORTFOLIO_PORT=8090 docker compose up -d --build
```

The service binds to loopback because the homeserver's `cloudflared` process runs on the host. The planned public hostname is `portfolio.arnabroy.co.in`.

## Content map

- `src/pages/index.astro` — homepage copy and sections
- `src/pages/projects/*.md` — project case studies
- `src/components/ProjectVisual.astro` — representative interface visuals
- `src/styles/global.css` — visual system and responsive behavior
- `public/Arnab-Roy-Resume.pdf` — downloadable résumé

Only Ask the Docs currently has a verified live application link. EV Charging and Niyojan remain marked as deployment in progress until their homeserver Compose stacks, local ports, and public tunnels are verified.
