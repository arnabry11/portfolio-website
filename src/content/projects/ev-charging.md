---
order: 3
title: EV Charging
kicker: Charging and billing platform
summary: A working EV charging platform. Drivers prepay, chargers start and stop automatically, and the final invoice and refund are calculated from the energy actually delivered.
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

A demonstration EV charging platform with two parts. A Go service talks to ten simulated chargers using OCPP 1.6J, the standard protocol chargers use. A Ruby on Rails application handles drivers, payments, pricing, invoices, and refunds. A live board shows everything happening in real time.

## The problem it solves

A charger reports what is happening right now. Billing has to stay correct days later, even after retries, restarts, or a dropped network connection. The risk is mistakes with money: charging a driver twice after a retry, or billing for the wrong amount of energy.

This platform keeps live charger activity and billing separate, and it is built so a retry can never create a second charge.

## Who it's for

Charging network operators and the teams building their software. Drivers benefit indirectly: they pay once and are billed for what they actually used.

## What it does

- **Prepaid sessions.** A driver pays up front, and each session runs within energy and time limits.
- **Automatic stop.** When a limit is reached, the charger is stopped without anyone stepping in.
- **Exact settlement.** The final price comes from the charger's start and stop meter readings. The platform issues one GST invoice and refunds any unused balance.
- **No double charging.** Duplicate or repeated messages are recognized and ignored, so a retry never charges a driver again.
- **Live operations board.** See all ten chargers, their power levels, the fleet's power curve, energy delivered, running amounts, and progress toward each prepaid limit.
- **Session detail.** Each finished session links charger events to the charge, invoice, and refund.

## How a session flows

1. The driver prepays. The card is charged once and the tariff is locked in.
2. The platform sends a signed start command with energy and time limits.
3. The charger delivers energy and sends meter readings back, in order.
4. At the limit, the charger is stopped.
5. The platform works out the final price from the meter readings and issues one invoice and any refund.

## How it stays reliable

- **Separate responsibilities.** The Go service owns live charger state. The Rails application owns money. They use separate databases and a small signed API between them.
- **Safe retries.** Every command and event carries a unique ID, and the database rejects duplicates as a final safeguard.
- **Nothing gets lost.** Events are saved together with the state change that caused them, out-of-order events are held back until the gap is filled, and a scheduled worker keeps retrying failures that can be recovered.

## Built with

Go for the charger gateway, Ruby on Rails for drivers, payments, and invoicing, PostgreSQL and Redis for data, and Docker for deployment.

## Good to know

- The demo uses simulated chargers and an in-process payment provider. It does not connect to a real charging network, payment processor, or tax authority.
- The source code is on GitHub. A public live demo is being prepared.
