---
order: 3
title: Niyojan
kicker: End-to-end product engineering
summary: A multi-tenant operations platform I designed and built across the frontend and backend, covering procurement, stock, production, billing, and the permissions connecting them.
year: 2026
role: Sole product engineer — frontend and backend
stack: Ruby on Rails, GraphQL, React, TypeScript, PostgreSQL, Redis
kind: niyojan
card:
  stack: Rails · GraphQL · React · PostgreSQL
  summary: A multi-tenant operations platform I built end to end, joining procurement, inventory, production, billing, permissions, and approval workflows into one coherent system.
  highlights:
    - Frontend and backend built by me
    - Role and feature permissions
    - India-aware billing workflows
---

## The problem

Small manufacturing businesses often operate purchasing, inventory, production, and finance as separate islands. Niyojan explores how those workflows can share one reliable operational model without becoming one tangled set of screens and tables.

I built the whole application: a Rails GraphQL backend and a React/TypeScript frontend. The repository is private, so this case study focuses on product scope, architecture, and the decisions visible in the running demo.

## One workflow, several responsibilities

The system follows work from an internal need through approval, purchase, receipt, stock, production, invoice, and payment. Organizations configure offices, users, roles, cost centers, units, item catalogues, vendors, budgets, and approval levels.

The application also covers stock ledgers and counts, production batches and material usage, customer sales, organization subscriptions, and India-aware billing details.

### A representative procurement path

1. A user raises a purchase request against items, cost centers, and budget categories.
2. Configured approval levels determine who can approve each line.
3. Approved requirements move through quotations or directly to a purchase order.
4. A goods receipt updates inventory and establishes vendor dues.
5. Invoices and payments preserve the financial trail back to the original purchase.

## Architecture around tenant boundaries

The Rails API exposes GraphQL and keeps write behavior in explicit domain services. Organization-owned records carry their tenant identity, while role, feature, and permission data control what each user can read or change.

The React frontend uses generated GraphQL types, TanStack Query, route-level modules, and consistent data-table and form patterns. Billing entitlements can enable modules independently from user permissions, keeping commercial access and authorization as different concerns.

## Designed for a credible demonstration

The seed data models several small Indian businesses across manufacturing and services, with sample users, catalogues, approval rules, budgets, and historical purchase-to-payment flows. That gives the public demo realistic workflows without using real business data.

The next step is to create the homeserver Compose deployment, define a safe shared demo login and reset policy, verify the local port, and then expose the root application at `niyojan.arnabroy.co.in`.
