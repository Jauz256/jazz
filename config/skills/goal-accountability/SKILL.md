---
name: goal-accountability
description: Accountability system for goal completion with explicit skip acknowledgment. Use when user sets a new goal, wants to track progress, or needs a weekly check-in. Triggers on "I want to...", "my goal is...", "weekly check-in", "what should I focus on", "help me stay accountable", or when user mentions skipping steps or getting distracted.
---

# Goal Accountability System

Forces visibility on skipped steps. You CAN skip—but you must acknowledge what you're accepting.

## Two Modes

| Mode | Trigger | Purpose |
|------|---------|---------|
| **Goal Setup** | "I want to [X]", new project/goal | Define steps, make skipping painful |
| **Weekly Check-in** | "Weekly check-in", every Monday | Review progress, surface skipped steps |

## Core Mechanism: Acknowledged Skip

Every step has three states:

[ ] NOT STARTED
[✓] COMPLETED — Date: ___
[⚠️ SKIPPED] — I accept: "[consequence]"
              Reason: "[why I'm skipping]"
              Date skipped: ___

**The rule:** No invisible skipping. If you skip, you write down what you're accepting.

## Your Patterns (Be Honest)

This skill is designed for someone who:
- 🦋 **Shiny object** — Gets distracted by new ideas
- 😰 **Perfectionism avoidance** — Skips steps where you might fail
- 🧠 **"I know better"** — Convinces yourself steps don't apply
- 👻 **No visibility** — Forgets steps that aren't written down

The system counters these by making ALL skips explicit and permanent.

## Anti-Pattern Interventions

**When user shows shiny object behavior:**
> "You started [original goal] on [date]. You've now mentioned [new thing]. 
> Before switching: What's the status of [original goal]? 
> Are you abandoning it? If yes, write: 'I'm abandoning [goal] because [reason]'"

**When user shows perfectionism avoidance:**
> "You've skipped [step] for [X days]. This step involves [uncomfortable thing].
> Is this perfectionism avoidance? If you're scared of failing at this step, say so."

**When user shows "I know better":**
> "You said this step doesn't apply to you. 
> Write one sentence: 'I'm skipping [step] because my situation is different: [how]'
> Then: 'If I'm wrong, the consequence is: [what happens]'"
