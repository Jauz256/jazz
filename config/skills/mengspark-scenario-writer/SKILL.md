---
name: mengspark-scenario-writer
description: Generate multi-step business simulation scenarios for MengSpark app. Use when creating realistic entrepreneur decision-making scenarios with branching paths, consequences (Cash/Reputation/Morale), and real-world insights. Triggers on requests like "create a scenario about...", "write a business simulation for...", "generate MengSpark content for [business type]".
---

# MengSpark Scenario Writer

Generate realistic, multi-step business simulation scenarios that let users experience entrepreneurship before risking real money.

## Quick Start

1. Get business context from user: business type, location, budget, specific challenge
2. Select primary module
3. Write scenario with branching paths
4. Ensure consequences use specific numbers (e.g., "Cash -15,000 THB")
5. Add real-world insight (revealed AFTER player decides)

## Core Principles

**Tradeoffs, not right answers.** Every option has costs. Show what experienced founders typically choose and why.

**Specificity over vagueness.** Use exact numbers, real Thai business context, named characters.

**Consequences chain.** Decisions ripple—today's shortcut becomes next month's crisis.

## Scenario Requirements

| Element | Required |
|---------|----------|
| Multi-step (2-5 decisions) | ✅ |
| Branching paths based on choices | ✅ |
| Specific consequences (Cash/Reputation/Morale) | ✅ |
| Real-world insight (post-decision reveal) | ✅ |
| Death conditions | ✅ |

## Interaction Mechanics

| Mechanic | Best For |
|----------|----------|
| Swipe | Urgent binary pressure |
| Multiple Choice | Strategic tradeoffs |
| Slider | Negotiation, pricing |
| Dialogue | People/relationship moments |
| Open-Ended | Complex thinking |

## Checklist Before Finalizing

- [ ] Every choice has specific Cash/Reputation/Morale impact
- [ ] At least one path leads to potential business death
- [ ] Real-world insight cites source
- [ ] Dialogue feels natural to Thai business context
