---
order: 1
title: Niyojan
kicker: Procurement and production platform
summary: A cloud platform that lets small Indian businesses run purchasing, stock, production, sales, and costing in one place, with approvals, GST-ready documents, and a full audit trail.
year: 2026
role: Sole product engineer — frontend and backend
stack: Ruby on Rails 8, GraphQL, React 19, TypeScript, PostgreSQL, Redis, Sidekiq
kind: niyojan
deploymentStatus: Demo available on request
galleryIntro: These screens come from Batchline, an interactive demo workspace I built on sample data for a fictional moulded-bottle plant. They show the production, stock, and costing side of this kind of platform.
gallery:
  - src: ../../assets/niyojan/batch-board.png
    alt: The Batchline batch board with columns for Planned, Blocked, In production, Quality check, Completed, and Failed or cancelled, each holding batch cards with bottle counts and action buttons.
    caption: The batch board. Each production batch moves from Planned to Completed, and its materials leave stock only when it starts.
  - src: ../../assets/niyojan/plan-a-batch.png
    alt: The Plan a batch form with a recipe, shift, and planned output, a materials-needed table checked against stock, and an estimate of cost, list price, and expected margin.
    caption: Planning a batch. Required materials are checked against stock, with an estimated cost and margin before anything starts.
  - src: ../../assets/niyojan/variance.png
    alt: The Variance page, comparing expected and actual material use against tolerance for each material, and listing batches that went over tolerance.
    caption: Variance. Material use is compared with the recipe, and batches that went over tolerance are flagged.
  - src: ../../assets/niyojan/costing.png
    alt: The Costing and margin page, with a batch cost breakdown by resin, additives, cartons, labour, power, and overhead, and a margin-by-product table.
    caption: Costing and margin. What each batch cost, split by material, labour, power, and overhead, and what each product earns.
card:
  stack: Rails · GraphQL · React · PostgreSQL
  summary: One system for buying, stock, production, sales, and costing, built for small Indian businesses and GST-ready from the start.
  highlights:
    - Buying, stock, production, and sales in one system
    - Approvals, GST documents, and a full audit trail
    - Subscription billing and an admin portal included
---

## What it is

Niyojan is a multi-tenant web platform for small businesses in India that buy materials and make or sell goods. Each company gets its own private workspace. Inside it, the team handles buying, stock, production, sales, and costing, and every step feeds the next.

It is also a product with its own business model: companies subscribe to a Procurement plan, a Production plan, or both, and a separate admin portal lets the platform operator manage plans, coupons, and customers.

## The problem it solves

Small manufacturers and traders often run buying, stock, production, sales, and accounts in separate tools. That makes it hard to control who can approve spending, to know what one unit really costs, to see what customers still owe, and to trust the numbers at month-end.

Niyojan keeps one connected record, from the first purchase request to the final profit figure.

## Who it's for

Owners, plant managers, purchasing staff, store-keepers, and accounts teams at small businesses. The demo includes sample companies from nine kinds of business: auto components, bricks and blocks, food processing, furniture, hospitality, pharma, plastics, ready-mix concrete, and textiles.

## What it does

- **Purchasing.** Raise purchase requests, send them through multi-level approvals (with amount limits for purchase orders), request vendor quotations, issue purchase orders, receive goods, and track vendor invoices, payments, and dues. Budgets can be set by category.
- **Stock.** See live stock, run stock counts, set reorder levels with low-stock alerts, and adjust or issue stock. Stock is valued at what it really cost, with freight and other charges added to each item's unit cost.
- **Production.** Define recipes with versions, record each production run with materials used, good and rejected units, labour, and power, and see where actual use differs from the recipe.
- **Sales and money.** Create GST sales invoices, record customer receipts, watch overdue dues, and manage cash and bank accounts and expenses.
- **Costing.** Work out the cost of each unit made, margin by product, and profit and loss, with overhead rates shared across production.
- **Daily dashboard.** One screen for what was made, what is in stock, who owes money, what was spent, what a unit costs, and what needs attention.
- **Control.** Roles and permissions decide who can see or do what. Companies, offices, projects, and cost centers are set up inside each workspace.
- **Subscriptions and admin.** Plans with optional add-on modules, GST tax invoices, bank-transfer and UPI payment claims approved by an admin, coupons, and usage limits.

## From a purchase to a profit figure

1. Someone raises a purchase request, and the right approvers sign off.
2. It becomes a quotation or a purchase order.
3. Goods arrive. Stock goes up at their real landed cost, and the vendor's balance is recorded.
4. A production run uses those materials and makes finished goods.
5. The cost of that run is worked out per unit.
6. Finished goods are sold on a GST invoice, and the customer's payment is recorded.
7. Margin by product and profit and loss show what each sale actually earned.

## Why you can trust the numbers

- **Corrections are reversals, not edits.** A posted document is never changed. Reversing it puts stock and money back exactly as they were, and stock is never allowed to go negative.
- **Closed months stay closed.** A period lock freezes past dates. Reopening one needs an approved request.
- **Money is exact.** Amounts are stored in whole paise, so there are no rounding drifts.
- **Every change is recorded.** An audit trail shows who changed what and when.

## Built with

A Ruby on Rails 8 GraphQL API with PostgreSQL, and a React 19 and TypeScript web app. Background jobs on Sidekiq and Redis handle daily work such as overdue invoices, renewal reminders, and monthly costing. Automated tests cover both the API and the web app, and Docker is used for deployment.

## Good to know

- I designed and built all of it: the web app, the API, the billing system, and the admin portal. The source code is private.
- It runs on my own server. There is no public sign-up, so demo accounts are set up by an admin. Get in touch if you would like to see it.
- The demo uses sample data for fictional businesses. No real business data is involved.
