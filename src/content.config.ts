import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const projects = defineCollection({
  loader: glob({ pattern: '*.md', base: './src/content/projects' }),
  schema: ({ image }) => z.object({
    order: z.number().int().positive(),
    title: z.string(),
    kicker: z.string(),
    summary: z.string(),
    year: z.number().int(),
    role: z.string(),
    stack: z.string(),
    kind: z.enum(['ev', 'docs', 'niyojan']),
    liveUrl: z.url().optional(),
    sourceUrl: z.url().optional(),
    deploymentStatus: z.string().default('Deployment in progress'),
    galleryIntro: z.string().optional(),
    gallery: z
      .array(z.object({ src: image(), alt: z.string(), caption: z.string() }))
      .optional(),
    card: z.object({
      stack: z.string(),
      summary: z.string(),
      highlights: z.array(z.string()).min(1),
    }),
  }),
});

export const collections = { projects };
