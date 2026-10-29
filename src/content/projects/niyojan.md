---
order: 1
title: Niyojan
kicker: Business operations platform
summary: A web platform that brings a small business's purchasing, stock, production, sales, and billing into one place, with approvals and access controls for each team.
year: 2026
role: Sole product engineer — frontend and backend
stack: Ruby on Rails, GraphQL, React, TypeScript, PostgreSQL, Redis
kind: niyojan
card:
  stack: Rails · GraphQL · React · PostgreSQL
  summary: One system for purchasing, stock, production, sales, and billing, instead of separate, disconnected tools.
  highlights:
    - Purchase request to payment in one flow
    - Approvals and role-based access
    - Designed and built by me, frontend and backend
---

## What it is

Niyojan is a web application for running the day-to-day operations of a small business. It connects purchasing, inventory, production, sales, and billing, so each step feeds the next. It is multi-tenant: many businesses can use it, and each one's data stays separate.

## The problem it solves

Small businesses often run buying, stock, production, and accounts in separate tools. Information has to be passed between them by hand, it is hard to see the full picture, and it is hard to control who can approve or spend what.

Niyojan keeps one connected record from the original purchase request through to the final payment.

## Who it's for

Owners and teams of small manufacturing and service businesses who want purchasing, stock, and billing in one place, with different access for managers, approvers, and staff.

## What it does

- **Purchasing and approvals.** Raise purchase requests against budgets and cost centers. Configurable approval levels decide who signs off on each line.
- **Quotations and purchase orders.** Approved needs go out for vendor quotations or straight to a purchase order.
- **Stock control.** Goods receipts update inventory automatically, and stock ledgers and counts keep a clear trail.
- **Production.** Record production batches and the materials each one used.
- **Sales and billing.** Handle customer sales, invoices, payments, and vendor dues, with India-aware billing details.
- **People and permissions.** Set up offices, users, roles, and feature permissions to control who can see or change what.
- **Subscriptions.** Switch modules on or off for each organization, separately from what individual users are allowed to do.

## How a purchase flows

1. Someone raises a purchase request.
2. The right people approve it.
3. It becomes a quotation or a purchase order.
4. The goods arrive, stock updates, and the vendor's balance is recorded.
5. Invoices and payments link back to the original purchase.

## Built with

A Ruby on Rails API (GraphQL) and a React and TypeScript frontend, backed by PostgreSQL and Redis. Every record belongs to an organization, and business rules live in clearly separated services so the system stays easy to change.

## Good to know

- I designed and built all of it, frontend and backend. The source code is private.
- The demo uses sample data for several small Indian businesses across manufacturing and services. No real business data is involved.
- A public live demo is being prepared.
