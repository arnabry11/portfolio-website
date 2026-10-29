---
order: 2
title: Ask the Docs
kicker: AI documentation assistant
summary: A question-and-answer assistant for documentation. It finds the relevant passages, writes a plain-language answer, and links the answer to the sources it used.
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
    - Answers link to the sources they used
    - Declines when the evidence is weak
    - Calls the AI model only when needed
---

## What it is

Ask the Docs is a chat-style assistant that answers questions from a body of documentation. The project is built around a catalog of 24 selected pages from the Rails Guides and the PostgreSQL 16 documentation. The same approach can be applied to a company's own manuals, policies, or help center.

## The problem it solves

People lose time hunting through long documentation. AI chatbots can answer quickly, but if they don't show where an answer came from, you can't tell whether to trust it.

Ask the Docs answers from your documents and shows the passages behind each answer, so you can verify it. When the search doesn't find strong enough evidence, it declines instead of guessing.

## Who it's for

Teams with a lot of documentation, such as support, onboarding, or engineering teams, who want fast answers they can check.

## What it does

- **Answers with citations.** Each answer points to numbered source passages, with links to the original pages.
- **Shows sources as it goes.** The supporting passages appear on screen while the answer is still being written, so you can read along.
- **Declines when evidence is weak.** If the best search results don't score high enough, no answer is written.
- **Searches two ways at once.** It combines meaning-based search with keyword search, then re-ranks the results.
- **Lets you inspect the search.** A separate search-only endpoint returns the passages, their scores, and the decision to answer or decline, without an AI-written answer.
- **Controls cost.** Embedding, search, and re-ranking run on the server itself. The external AI model is called only for a question that isn't already cached, and the amount of text sent and returned is capped.

## How it works

1. Your question is searched two ways at the same time.
2. A local model re-ranks the best passages.
3. If the top passages don't score high enough, the assistant declines. Otherwise it shows the sources and looks for a saved answer to the same question.
4. The answer streams in, marked provisional, or comes straight from the saved copy.
5. Every citation is checked against the sources. The demo accepts the answer only if the check passes.

## How well it works

I tested it on 50 questions that the documentation can answer and 10 that it can't, across 24 pages and 785 passages. For 48 of the 50 answerable questions, the right page was among the top five search results.

The decision to decline was less perfect: it declined 7 of the 10 questions the documentation can't answer, and wrongly declined 2 of the 50 it can. The threshold was tuned on this same small question set, so treat these numbers as a rough indication, not a reliability guarantee.

Those results measure search quality, not answer accuracy. The citation check confirms that each reference points to a real source passage, but it cannot prove that every sentence is supported by what it cites. In one offline check, an answer carried a valid citation but included a claim its source did not support.

## Built with

Python and FastAPI. PostgreSQL, with pgvector for meaning-based search and its built-in full-text search for keywords, stores the documents, embeddings, and saved answers. Redis and a background worker handle ingestion of the documentation. FastEmbed runs the embedding and re-ranking models locally. The answer-writing model is reached through OpenRouter, and only when it is switched on. Docker Compose runs the whole stack.

## Good to know

- The live demo is public, and the source code is on GitHub.
- The public demo currently has a single page loaded, PostgreSQL's introduction to indexes, so it can answer questions about that page only. Questions on other topics are declined. Try: "How does an index help PostgreSQL find rows?"
- Without an AI model configured, search and source inspection still work, and the assistant reports that answers aren't available.
- Each question is handled on its own. The demo doesn't remember earlier questions in a conversation.
- There is no spending cap or usage tracker. Limits on text size and the saved-answer cache keep cost down, but a production setup would add a budget.
