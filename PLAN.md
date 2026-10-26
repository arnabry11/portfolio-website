# Arnab Roy — Portfolio implementation plan

Status: portfolio implementation in progress. Application deployment follows the completed portfolio build.

Implementation checkpoint (2026-10-26): the first complete local portfolio version is built and browser-verified at desktop and mobile breakpoints. Steps 1–4 are materially complete; content and visual feedback can still be incorporated before homeserver deployment. Step 5 has not started.

## 1. Agreed direction

- **Homepage headline:** “From your idea to working software.” Supporting copy covers web applications, internal tools, and automated workflows, with responsibility from planning through deployment.
- **Audience:** clients, hiring managers, and engineering leads. The homepage should establish confidence that Arnab can turn an idea into a production application, carrying it through technical planning, frontend and backend implementation, and deployment. Skills and project evidence support that outcome.
- **Positioning:** software engineer with deep backend expertise and the ability to build and deploy complete applications. Rails and PostgreSQL remain the strongest foundation. Earlier React experience supports current AI-assisted frontend implementation with explicit code conventions and review; visual design is assisted. AWS infrastructure experience includes EC2, ECS, Route 53, and load balancing.
- **Design:** light editorial style; warm white, charcoal text, a restrained blue accent, strong typography, generous spacing, and large application previews.
- **Content:** a homepage, three project case studies, résumé, and direct contact links.
- **Projects:** EV Charging, Ask the Docs, and Niyojan. Initial order is EV Charging, Ask the Docs, then Niyojan; revisit after selecting screenshots and clarifying Niyojan's story.
- **Technology:** Astro, TypeScript, plain CSS, and Markdown case studies; static output served by Nginx in Docker Compose.
- **Hosting:** the existing homeserver and Cloudflare Tunnel, administered over Tailscale.
- **Primary URL:** `https://portfolio.arnabroy.co.in/`. No portfolio `/demo/` route or redirect is planned.
- **Project destinations:** Ask the Docs links to `https://ask-the-docs.arnabroy.co.in/demo/`; EV Charging links to `https://ev-charging.arnabroy.co.in/`; Niyojan links to `https://niyojan.arnabroy.co.in/`. Only Ask the Docs uses `/demo/`. These are the agreed destinations; deployment verification remains a separate step.
- **Niyojan authorship:** Arnab built the entire project, including both frontend and backend. Present it as an end-to-end application built by him.
- **Public content constraint:** use only approved professional details. Niyojan source remains private.

## 2. First-release boundaries

### Included

- Responsive homepage and three case-study pages.
- Real application screenshots, with descriptive alternative text.
- Small architecture diagrams that explain meaningful system boundaries.
- Project demo links and public source links where available.
- Selected career achievements and a concise experience timeline.
- Short personal introduction, email, LinkedIn, GitHub, and downloadable résumé.
- Search metadata, canonical URLs, sitemap, robots file, social sharing image, favicon, and a useful 404 page.
- Accessible navigation, visible keyboard focus, and reduced-motion support.
- Repeatable build/deployment instructions and a rollback procedure.

### Deferred

- Blog, CMS, contact-form backend, visitor accounts, analytics, and live service-status widgets.
- Elaborate animations, 3D scenes, theme switching, or a portfolio chatbot.
- Broad redesigns or feature development in the three applications. Only separately scoped work needed for usable demonstrations belongs in the demo preparation work below.

## 3. Evidence already gathered

- The supplied CV describes production backend work, team leadership, integrations, performance improvements, and mentoring.
- Local documentation describes Ask the Docs as a RAG service with hybrid retrieval, reranking, cited streaming answers, and evaluation.
- Local documentation describes EV Charging as a Go/Rails simulation with OCPP devices, prepaid sessions, invoices, refunds, and retry-safe event handling.
- Niyojan documentation and source structure show a Rails/GraphQL and React application covering business workflows. Arnab confirmed that he built the entire frontend and backend. Its demonstration and public story remain to be selected.
- A read-only homeserver inspection confirmed Docker workloads, an active `cloudflared` service, and an Ask the Docs deployment. Its public demo returned HTTP 200.
- EV Charging and Niyojan are not yet deployed on the homeserver. Their portfolio links remain visibly marked as deployment in progress until their Compose stacks and ports are verified.

## 4. Step-by-step execution

### Step 1 — Finalize the content brief

**Work**

1. Draft the headline and a short introduction that connects backend expertise to the three projects.
2. Select three career achievements from the CV, preserving the metric, context, and personal contribution.
3. Condense work history into a short timeline with emphasis on recent roles.
4. Shape Niyojan's story around Arnab's complete frontend and backend authorship; establish its current maturity and select the screens and workflow to showcase.
5. Select public contact details and prepare a résumé suitable for download. Default to email and professional profiles on the page; leave telephone and street/postal details off the homepage.
6. Use the agreed project destinations above and record public source URLs where available. Track whether each destination has been verified; keep Niyojan's source private.

**Deliverable:** homepage copy, project summaries, and a factual content checklist.

**Complete when:** the positioning is specific, all claims are supported, and the public description of Niyojan is settled.

### Step 2 — Prepare the three project stories and assets

**Work**

1. Inspect each application's actual user journey and choose one short demonstration.
2. Capture real screenshots using sample data; select one hero preview and a small number of supporting images per project.
3. Write each case study using the same structure: problem and status → role and scope → system overview → engineering decisions and tradeoffs → evidence and limitations → demo and source links.
4. Create concise architecture diagrams from verified behavior.
5. Keep screenshots and descriptions useful even when a live application is unavailable.

| Project | Demonstration | Engineering focus | Presentation requirement |
| --- | --- | --- | --- |
| EV Charging | Follow a simulated charging session through settlement | Device state versus billing ownership; event delivery; idempotency; meter-based settlement | Clearly identify simulated devices and payments |
| Ask the Docs | Ask a documentation question and inspect its sources | Hybrid search; reranking; streaming; caching; evaluation | Distinguish retrieval metrics from answer correctness |
| Niyojan | Follow one representative procurement or inventory workflow | End-to-end frontend/backend development; domain modeling; permissions; tenant boundaries; workflow design | Credit Arnab with building the entire frontend and backend; use sample data; no private repository link |

**Deliverable:** three case-study drafts, a screenshot set, and architecture diagrams.

**Complete when:** each project explains both what a visitor can try and why its engineering decisions matter.

### Step 3 — Design the homepage and case-study layout

**Work**

1. Establish colors, typography, spacing, content width, and reusable link/button styles.
2. Create desktop and mobile homepage mockups with the actual copy and screenshots.
3. Use this homepage sequence: introduction → selected projects → professional impact → experience → about → contact.
4. Design wide project sections with a screenshot beside the story; stack them vertically on small screens.
5. Create one case-study mockup to establish headings, diagrams, image treatment, and navigation.
6. Review readability, page length, contrast, and the prominence of project/demo links.

**Deliverable:** desktop and mobile homepage mockups, one case-study mockup, and a small visual style guide.

**Complete when:** the design direction is reviewed and settled before full website implementation.

### Step 4 — Build the static portfolio

**Work**

1. Initialize the project repository and Astro/TypeScript structure.
2. Add shared layout, navigation, footer, project presentation, and case-study components.
3. Store case studies in Markdown and maintain structured project metadata for titles, summaries, screenshots, and links.
4. Implement these routes:
   - `/`
   - `/projects/ev-charging/`
   - `/projects/ask-the-docs/`
   - `/projects/niyojan/`
5. Add the downloadable résumé and professional contact links.
6. Optimize images and fonts; keep client-side JavaScript limited to necessary interactions.
7. Add page metadata, sitemap, social preview assets, favicon, and 404 handling.
8. Link directly to each project's agreed destination: `/demo/` for Ask the Docs and `/` for EV Charging and Niyojan. Serve the portfolio at `/` without a `/demo/` alias.

**Deliverable:** a complete local website preview and a reproducible production build.

**Complete when:** all planned pages render with final content, working internal navigation, and no placeholder assets or copy.

### Step 5 — Prepare the public application demos

This work begins after the portfolio website is built and reviewed. It is tracked separately so deployment issues do not obscure website progress.

**Work**

1. Verify Ask the Docs through the selected public user journey, including its configured answer-generation behavior and visitor limits.
2. Inspect the current deployment requirements for EV Charging and Niyojan and select service ports for their agreed public hostnames. Ensure each domain root provides a usable entry point, with an internal redirect to the application's landing or login screen only if needed.
3. Define a short deployment checklist for each missing demo: container/services, configuration, sample data, health checks, visitor access, and restart behavior.
4. Ensure EV Charging uses simulated payments and offers a useful session to observe without requiring a visitor's terminal.
5. Select an appropriate Niyojan demo-access flow with isolated sample data. Check that visitors cannot access real business data or platform administration.
6. Define how demo data is reset and how shared visitor activity is handled.
7. Create or complete the production Docker Compose setup for each application, deploy it under `/home/arnab/dev`, and record its verified local port.
8. Hand the verified ports to Arnab so he can add the Cloudflare Tunnel routes for `ev-charging.arnabroy.co.in` and `niyojan.arnabroy.co.in`.
9. After the tunnel routes exist, verify the public URLs and replace the portfolio's deployment-in-progress states with live demo links.
10. If a demo cannot be ready for launch, use an explicit screenshot walkthrough or honest availability label; never ship a broken or misleading demo button.

**Deliverable:** verified visitor journeys and final project destinations, or clearly documented launch limitations.

**Complete when:** every visible project action leads to a usable, accurately described experience. The full three-live-demo objective remains open if any demonstration is deferred.

### Step 6 — Verify the finished portfolio

**Work**

1. Test phone, tablet, and desktop widths, including long titles and image loading.
2. Check keyboard navigation, focus visibility, heading order, contrast, alternative text, and reduced-motion behavior.
3. Check all routes, demo/source links, contact actions, résumé download, redirects, and 404 responses.
4. Review wording for unsupported claims, stale details, accidental private information, and prohibited platform references.
5. Run the production build, type/content checks, and a focused browser smoke test.
6. Measure performance and address material image, font, or script costs. Aim for Lighthouse performance and accessibility scores of at least 95 in a recorded representative mobile run; scores are a target, not a substitute for manual checks.
7. Check titles, descriptions, canonicals, sitemap, and social previews.

**Deliverable:** a short verification report and resolved launch defects.

**Complete when:** there are no broken primary journeys, significant layout/accessibility problems, placeholder content, or unresolved factual errors.

### Step 7 — Deploy and verify the public site

**Work**

1. Inspect the existing tunnel's management method and select an unused local service port without disturbing other workloads.
2. Create `/home/arnab/dev/portfolio-website` and deploy a versioned static build in a small Nginx container using Docker Compose.
3. Configure the serving path, restart policy, and health check. Match network binding to how the existing tunnel reaches services.
4. Add the public hostname route for `portfolio.arnabroy.co.in` to the existing Cloudflare setup.
5. Configure asset caching and ensure updated HTML does not retain stale deployment references.
6. Verify HTTPS, the root homepage, direct case-study URLs, résumé download, 404 behavior, and project links through the public hostname. Confirm only the Ask the Docs link uses `/demo/`.
7. Retain the previous working image/build and document how to restore it.

**Deliverable:** the live portfolio at `https://portfolio.arnabroy.co.in/`.

**Complete when:** the public site passes the same primary navigation and content checks as the local preview.

### Step 8 — Document maintenance and close the release

**Work**

1. Document how to edit project copy, replace screenshots, update the résumé, build, deploy, and roll back.
2. Record where domain/tunnel configuration is managed without storing credentials in the repository.
3. Keep deployment simple and reproducible first; consider automated deployment later if useful.
4. Record any deferred demo work or optional enhancements separately from completed release work.

**Deliverable:** README/deployment notes and a concise release checklist.

**Complete when:** routine content updates and rollback can be performed from the documentation.

## 5. Order and review points

1. Content brief and case studies: Steps 1–2.
2. Visual review: Step 3, before committing to the full implementation.
3. Website build and review: Step 4.
4. Application Compose setup and homeserver deployment: Step 5, after the portfolio build.
5. Launch verification: Step 6, with demo destinations settled.
6. Portfolio deployment and handover: Steps 7–8.

The current request authorizes preparing this plan only. Implementation begins in a subsequent phase when requested. During implementation, ordinary reversible work should proceed within the agreed scope; review points are for substantive content/design decisions, not repeated permission requests for routine steps.

## 6. Remaining inputs

Resolve these during Step 1; they do not prevent agreeing on this plan:

- Niyojan's public-demo workflow and sample-data scope. Complete frontend and backend authorship is already confirmed.
- Which employer/project names and career metrics to include publicly.
- The final public résumé and preferred contact details.

A portrait is optional. The design should work well without one. No further stack or hosting decisions are needed before content planning begins.
