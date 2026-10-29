---
order: 2
title: Ask the Docs
kicker: AI documentation assistant
summary: A question-and-answer assistant for documentation. It finds the relevant pages, answers in plain language, and shows exactly which sources each answer came from.
year: 2026
role: Architecture and implementation
stack: Python, FastAPI, PostgreSQL, pgvector, Redis, FastEmbed, Docker
kind: docs
liveUrl: https://ask-the-docs.arnabroy.co.in/demo/
sourceUrl: https://github.com/arnabry11/ask-the-docs
card:
  stack: Python · FastAPI · pgvector · Redis
  summary: Ask a question and get an answer with its sources, so you can check it instead of just trusting it.
  highlights:
    - Every answer cites its sources
    - Says so when it doesn't have the evidence
    - Keeps AI usage costs under control
---

## What it is

Ask the Docs is a chat-style assistant that answers questions from a body of documentation. In the demo it is loaded with selected pages from the Rails Guides and the PostgreSQL 16 documentation. The same approach can be applied to a company's own manuals, policies, or help center.

## The problem it solves

People lose time hunting through long documentation. AI chatbots can answer quickly, but if they don't show where an answer came from, you can't tell whether to trust it.

Ask the Docs answers only from your documents and shows the passages behind each answer, so you can verify it. When it doesn't have enough evidence, it says so instead of guessing.

## Who it's for

Teams with a lot of documentation, such as support, onboarding, or engineering teams, who want fast answers they can check.

## What it does

- **Answers with citations.** Each answer points to numbered source passages.
- **Shows sources first.** The supporting passages appear before the answer finishes, so you can read along.
- **Declines when unsure.** If the search doesn't find enough evidence, no answer is generated.
- **Searches two ways at once.** It combines meaning-based search with keyword search, then re-ranks the results.
- **Lets you inspect the search.** A separate search-only endpoint returns just the passages, without an AI-written answer.
- **Controls cost.** Search and ranking run on the server itself. The external AI model is called only when needed, and answers are cached.

## How it works

1. Your question is searched two ways at the same time.
2. A local model re-ranks the best passages.
3. If the evidence is strong enough, the sources are sent to your screen right away.
4. The answer streams in and is marked provisional.
5. Every citation is checked against the sources. The interface accepts the answer only if the check passes.

## How well it works

I tested it on 50 questions that the documentation can answer and 10 that it can't, across 24 pages and 785 passages. For 48 of the 50 answerable questions, the right page was among the top five search results.

That measures search quality, not answer accuracy. The citation check confirms that references point to real source passages, but it cannot prove that every sentence is supported by what it cites.

## Built with

Python and FastAPI, with PostgreSQL (pgvector) for search, Redis for caching, FastEmbed for local embeddings, and Docker for deployment.

## Good to know

- The live demo is public, and the source code is on GitHub.
- Without an AI model configured, the search and source inspection still work.
