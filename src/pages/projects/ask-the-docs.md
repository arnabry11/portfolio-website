---
layout: ../../layouts/ProjectLayout.astro
title: Ask the Docs
kicker: Inspectable AI systems
summary: A retrieval-augmented generation service that shows its sources, exposes retrieval separately from generation, and treats every streamed token as provisional until its citations pass.
year: 2026
role: Architecture and implementation
stack: Python, FastAPI, PostgreSQL, pgvector, Redis, FastEmbed, Docker
kind: docs
liveUrl: https://ask-the-docs.arnabroy.co.in/demo/
sourceUrl: https://github.com/arnabry11/ask-the-docs
---

## The problem

Many RAG demos collapse search and generation into one opaque answer box. Ask the Docs keeps the steps separate so a visitor can inspect what was retrieved, see which passages support an answer, and understand when the system refuses to generate.

The corpus contains selected Rails Guides and PostgreSQL 16 documentation. Ingestion, embeddings, search, reranking, and evaluation run locally. Only an opted-in answer-cache miss calls an external model.

## The retrieval pipeline

Each question runs vector similarity and PostgreSQL full-text search in parallel. Reciprocal rank fusion combines the result lists, a local cross-encoder reranks the leading passages, and a score gate decides whether generation has enough evidence to continue.

The public `/query` endpoint stops at retrieval. The `/answer` endpoint adds cache lookup, provider generation, and citation validation, streaming progress and source events along the way.

### A source-first stream

1. Search and rank candidate passages.
2. Send the selected sources to the browser.
3. Stream provisional answer tokens.
4. Validate every numbered citation marker against the supplied passages.
5. Send one final event; the interface only accepts the final answer when validation succeeds.

This protects the interface from treating an interrupted or malformed stream as a completed answer. It cannot prove that every sentence is supported by its cited passage, and the case study says so explicitly.

## Evidence, with limits

The retrieval evaluation covers 50 answerable and 10 unanswerable questions over 24 selected pages and 785 chunks. Hybrid retrieval followed by reranking places a curated gold page in the first five chunks for 48 of the 50 answerable questions.

That is a retrieval metric, not an answer-accuracy score. The small refusal set and answer-support checks are useful regression evidence, but they are not presented as general reliability guarantees.

## Cost and operational boundaries

Embeddings and reranking run locally. Generation is gated, bounded, and cached. A question without enough retrieval evidence never calls the provider, and the service remains useful for inspecting sources even when generation is not configured.
