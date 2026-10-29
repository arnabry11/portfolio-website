---
order: 3
title: EV Charging
kicker: Charging and billing platform
summary: A small, working EV charging backend built as a portfolio project. Drivers prepay, chargers start and stop automatically, and the final invoice and refund are calculated from the energy actually delivered.
year: 2026
role: Product, architecture, and implementation
stack: Go, Ruby on Rails, OCPP 1.6J, PostgreSQL, Redis, Docker
kind: ev
sourceUrl: https://github.com/arnabry11/ev-charging
card:
  stack: Go · Rails · OCPP · PostgreSQL
  summary: Prepay, charge, and get an exact invoice and refund, with a live board showing ten simulated chargers at work.
  highlights:
    - Live operations board
    - Retries never charge a driver twice
    - Invoice and refund from meter readings
---

## What it is

A small, working slice of an EV charging backend, built as a portfolio project. A Go service talks to ten simulated chargers using OCPP 1.6J, a widely used protocol for communicating with chargers. A Ruby on Rails application handles drivers, payments, pricing, invoices, and refunds. A live board shows everything happening in real time and refreshes every second.

## The problem it solves

A charger reports what is happening right now. Billing has to stay correct days later, even after retries, restarts, or a dropped network connection. The risk is mistakes with money: charging a driver twice after a retry, or billing for the wrong amount of energy.

This platform keeps live charger activity and billing separate, and it is built so a retry can never create a second charge.

## Who it's for

It is built to show how a charging network operator's backend can be structured. Drivers benefit indirectly: they pay once and are billed for what they actually used.

## What it does

- **Prepaid sessions.** A driver pays up front by card. The amount sets how much energy the session can deliver, and a maximum duration (90 minutes by default) also applies.
- **Automatic stop.** When a limit is reached, the charger is stopped without anyone stepping in.
- **Exact settlement.** The final price comes from the charger's start and stop meter readings. The demo tariff is ₹18 per kWh plus a ₹10 session fee, both including GST. The platform issues one GST invoice and refunds any unused balance.
- **No double charging.** Duplicate or repeated requests are recognized and ignored, so a retry never charges a driver again.
- **Live operations board.** See all ten chargers, their power levels, the fleet's power curve, energy delivered, running amounts, and progress toward each prepaid limit. The running amount is an estimate; the real invoice is written when the session ends.
- **Session detail.** Each session has a page linking the payment, the charger's events, the invoice, and the refund.

## How a session flows

1. The driver prepays. The card is charged once and the tariff is locked in.
2. The platform sends a signed start command with energy and time limits.
3. The charger delivers energy and sends meter readings back, in order.
4. At the limit, the charger is stopped.
5. The platform works out the final price from the meter readings and issues one invoice and any refund.

## How it stays reliable

- **Separate responsibilities.** The Go service owns live charger state. The Rails application owns money. They use separate databases and a small signed API between them.
- **Safe retries.** Every command and event carries a unique ID, and the database rejects duplicates as a final safeguard.
- **Nothing gets lost.** Events are saved together with the state change that caused them and delivered in order. An out-of-order event is refused until the missing one arrives. If the platform is down, delivery is retried with growing delays. If the platform refuses the same event repeatedly, it is set aside rather than deleted, so it can be requeued once the cause is fixed.

## Built with

Go for the charger gateway and the charger simulator, Ruby on Rails 8 with Sidekiq for drivers, payments, invoicing, and the live board, two separate PostgreSQL databases, Redis for the job queue, and Docker Compose to run it all.

## Good to know

- The demo uses simulated chargers and an in-process card payment. It does not connect to a real charging network, payment processor, or tax authority. GST is calculated for in-state sales only, as a simulation rather than tax advice.
- It is a single-tenant demo with no login, and the admin pages are open. It leaves out logins and roles, load testing, and newer OCPP versions on purpose.
- The source code is on GitHub. A public live demo is being prepared.
