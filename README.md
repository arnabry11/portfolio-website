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

## Deploy to the homeserver

Run this from your Mac after committing your changes:

```sh
./scripts/deploy.sh
```

The script uses your existing `ssh homeserver` connection and deploys to
`/home/arnab/dev/portfolio-website`. It transfers the committed checkout, builds
on the server, and starts the portfolio on `127.0.0.1:8083`. No GitHub credentials
are needed on the server, and no SSH keys are copied. Uncommitted changes cause
the script to stop so the deployed version is always identifiable by its commit.

Requirements: Git, SSH, and SCP on your Mac; Docker Compose with `--wait`, Bash,
`flock`, `tar`, and `curl` on the homeserver. The SSH connection must work without
an interactive password prompt (an unlocked SSH agent is supported).

Each release is stored under `releases/<commit>`, with `current` and `previous`
files recording successful deployments. The old container stays running during
the build; replacing it causes a brief interruption. Failed startup or HTTP
checks trigger an automatic attempt to restore the previous release. A failed
first deployment has no earlier release to restore. After a successful deployment,
the script keeps only the current and previous releases (the rollback target) and
removes every older release directory and `portfolio-website` image. It does not
modify other applications.

To restore the previous successful deployment:

```sh
./scripts/deploy.sh --rollback
```

Configure this route once in the existing Cloudflare tunnel:

| Setting | Value |
| --- | --- |
| Public hostname | `portfolio.arnabroy.co.in` |
| Path | Leave blank |
| Service | `http://127.0.0.1:8083` |

The script checks the local service. It does not change Cloudflare settings or
claim that the public URL is reachable before the tunnel route is configured.

## Content map

- `src/site.ts` — name, email, social links, and résumé path
- `src/pages/index.astro` — homepage copy and sections
- `src/content/projects/*.md` — project case studies; frontmatter also drives the homepage cards, next-project links, and sitemap (schema in `src/content.config.ts`)
- `src/components/ProjectVisual.astro` — representative interface visuals
- `src/styles/global.css` — visual system and responsive behavior
- `public/Arnab-Roy-Resume.pdf` — downloadable résumé

Only Ask the Docs currently has a verified live application link. EV Charging and Niyojan remain marked as deployment in progress until their homeserver Compose stacks, local ports, and public tunnels are verified.
