---
name: project-breakdown
description: Use when user has a big, vague, or complex project request. Breaks it into phases, milestones, dependencies, and actionable tasks. Triggers on "build me a...", "create a system for...", "I want to make...", or any large project request that needs planning before coding.
---

# Project Breakdown

**Turn big vague requests into clear, actionable plans.**

---

## WHEN TO USE

- User says "build me a [big thing]"
- Project has multiple features/components
- You're not sure where to start
- Project will take multiple sessions
- Multiple files/systems involved

---

## PHASE 1: Understand Scope

Ask these questions FIRST:

```
SCOPE QUESTIONS:
1. What's the ONE most important thing this should do?
2. Who uses this? (you, team, public)
3. What exists already? (starting from scratch or adding to existing?)
4. What's the deadline pressure? (prototype vs production)
5. What's out of scope? (what should it NOT do)
```

---

## PHASE 2: Break Into Components

Identify all the pieces:

```
PROJECT: [Name]

COMPONENTS:
├── [Component 1]
│   ├── Subpart A
│   └── Subpart B
├── [Component 2]
│   ├── Subpart A
│   └── Subpart B
└── [Component 3]
    └── Subpart A

EXTERNAL DEPENDENCIES:
- [API/Service 1]
- [Library 1]

DATA:
- [What data is stored/processed]
- [Where it comes from]
- [Where it goes]
```

---

## PHASE 3: Define Phases

Break into deliverable phases:

```
## Phase 1: Foundation (Must Have)
Goal: [What this achieves]
Delivers: [What user can see/use]
Tasks:
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

## Phase 2: Core Features
Goal: [What this achieves]
Depends on: Phase 1
Tasks:
- [ ] Task 1
- [ ] Task 2

## Phase 3: Polish
Goal: [What this achieves]
Depends on: Phase 2
Tasks:
- [ ] Task 1
- [ ] Task 2

## Phase 4: Nice-to-Have (Optional)
Goal: [What this achieves]
Tasks:
- [ ] Task 1
```

---

## PHASE 4: Identify Dependencies

What blocks what:

```
DEPENDENCY MAP:

[Task A] ──blocks──> [Task B] ──blocks──> [Task C]
                          │
                          └──blocks──> [Task D]

CRITICAL PATH (must do in order):
1. [Task A] - can't start anything without this
2. [Task B] - unlocks C and D
3. [Task C] or [Task D] - can parallelize

CAN PARALLELIZE:
- [Task X] and [Task Y] have no dependencies
```

---

## PHASE 5: Risk Identification

What could go wrong:

```
RISKS:

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [How to prevent/handle] |
| [Risk 2] | High/Med/Low | High/Med/Low | [How to prevent/handle] |

UNKNOWNS:
- [Thing we don't know yet that could change the plan]
- [Need to research/prototype first]
```

---

## PHASE 6: Create Task List

Actionable, specific tasks:

```
## Task List

### Phase 1: Foundation
- [ ] 1.1 [Specific action] - [output/deliverable]
- [ ] 1.2 [Specific action] - [output/deliverable]
- [ ] 1.3 [Specific action] - [output/deliverable]

### Phase 2: Core
- [ ] 2.1 [Specific action] - [output/deliverable]
- [ ] 2.2 [Specific action] - [output/deliverable]

TOTAL: [X] tasks across [Y] phases
```

---

## OUTPUT FORMAT

Present to user:

```
# Project Plan: [Name]

## Overview
[1-2 sentence summary]

## Components
[Bulleted list of major pieces]

## Phases
### Phase 1: [Name] - Foundation
- [Task list]
- Delivers: [What user gets]

### Phase 2: [Name] - Core
- [Task list]
- Delivers: [What user gets]

### Phase 3: [Name] - Polish
- [Task list]
- Delivers: [What user gets]

## Dependencies
[What must happen before what]

## Risks
[What could go wrong]

## Recommended Starting Point
[Where to begin]

---
Approve this plan? Then I'll start with Phase 1.
```

---

## TASK SIZING GUIDE

Good task size:
- Can be completed in one focused session
- Has clear "done" criteria
- Produces something testable

Too big:
- "Build the backend" → Break into: Setup DB, Create models, Build API endpoints, Add auth...

Too small:
- "Create variable x" → Combine with related work

---

## EXAMPLE

**User:** "Build me a habit tracking app"

**Breakdown:**

```
# Project Plan: Habit Tracker

## Components
- UI (screens)
- Data storage (habits, completions)
- Logic (streaks, reminders)
- Notifications

## Phases

### Phase 1: Foundation
- [ ] Data model for habits (name, frequency, created date)
- [ ] Data model for completions (habit_id, date, completed)
- [ ] Basic storage (localStorage or DB)
- Delivers: Can save and retrieve habits

### Phase 2: Core UI
- [ ] Habit list screen
- [ ] Add habit form
- [ ] Mark complete toggle
- [ ] Today view
- Delivers: Usable app for tracking

### Phase 3: Insights
- [ ] Streak calculation
- [ ] Completion history view
- [ ] Stats (% completed this week)
- Delivers: Motivation features

### Phase 4: Polish (Optional)
- [ ] Notifications/reminders
- [ ] Themes
- [ ] Export data

## Start With
Phase 1, Task 1: Define habit data model
```

---

## The Rule

**Big projects fail when you try to do everything at once.**

Break it down. Deliver in phases. Get feedback early.
