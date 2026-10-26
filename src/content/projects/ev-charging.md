---
order: 1
title: EV Charging
kicker: Real-time systems + money
summary: A small but complete EV charging backend where live device state and financial state have separate owners—and retries never create a second charge.
year: 2026
role: Product, architecture, and implementation
stack: Go, Ruby on Rails, OCPP 1.6J, PostgreSQL, Redis, Docker
kind: ev
sourceUrl: https://github.com/arnabry11/ev-charging
card:
  stack: Go · Rails · OCPP · PostgreSQL
  summary: An EV charging application with a live operations board. A Go gateway manages simulated chargers while Rails handles prepaid sessions, GST invoices, and refunds.
  highlights:
    - 10 concurrent simulated chargers
    - Idempotent commands and events
    - Meter-based settlement
---

## The problem

An EV charging platform has to reconcile two very different kinds of truth. A charger holds a long-lived socket and reports what is happening *now*. Billing has to remain correct days later, after retries, restarts, or an interrupted network.

I built a working portfolio slice around that boundary. A Go gateway speaks OCPP 1.6J to ten simulated chargers. A Rails platform takes a prepaid card payment, tells the gateway when to stop, and settles a GST invoice and refund from the final meter readings.

> The demo uses simulated chargers and an in-process payment provider. It does not connect to a real charging network, payment processor, or tax authority.

## A deliberate ownership split

The gateway owns live device state: connections, connector availability, OCPP transactions, meter readings, and enforcement of energy and duration limits. The Rails platform owns drivers, tariffs, payments, invoices, refunds, and durable session state.

That division keeps pricing out of the gateway and OCPP out of the billing platform. The services have separate PostgreSQL databases and communicate through a small signed HTTP contract.

### From prepayment to settlement

1. The platform charges a simulated card exactly once and snapshots the tariff.
2. It sends a signed start command with energy and time limits.
3. The gateway starts a charger and streams meter values back as ordered events.
4. When a limit is reached, the gateway stops the charger.
5. The platform calculates the final price from the start and stop meter readings, then writes one invoice and any refund.

## Reliability is part of the domain

Delivery is at least once, so duplicate commands and events are expected. Commands use a `command_id`; events use an `event_id` and per-session sequence number. Unique database constraints provide the final defense against duplicate work.

Gateway state changes and outgoing events are written in the same transaction through an outbox. A missing event sequence is rejected until the gap is filled, and a scheduled worker keeps retrying recoverable failures.

## What the demo makes visible

The live board streams server-rendered updates over SSE. It shows ten chargers operating at different power levels, the fleet’s power curve, delivered energy, running amounts, and progress toward each prepaid limit. When a session settles, its detail page connects device events to the charge, invoice, and refund.

The next step is packaging the existing services for the homeserver, verifying the root landing route, and exposing the confirmed local port at `ev-charging.arnabroy.co.in`.
