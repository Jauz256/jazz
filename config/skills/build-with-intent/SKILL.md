---
name: build-with-intent
description: MANDATORY skill before building ANY UI, prototype, app, or interactive artifact. Forces exhaustive user journey mapping - every click, every state, every edge case. Use when creating websites, apps, dashboards, visualizations, or any interactive interface. Triggers automatically on "build", "create UI", "design", "make a page", "prototype". Also use when user asks to "review", "audit", or "check" an existing build for UX issues.
---

# Build With Intent

**STOP. Before writing ANY UI code, complete this entire process.**

You are not allowed to write code until you have answered every question and gotten user approval.

---

## PHASE 1: Ask First (NEVER Skip)

Before designing anything, ASK the user:

```
1. DATA SCALE
   - How many items/nodes/rows will you typically have?
   - What's the maximum? (10? 100? 1000?)
   - How deep is the hierarchy? (2 levels? 5 levels?)

2. PRIMARY ACTIONS
   - What's the #1 thing you want to DO with this?
   - What should happen in 1 click vs 2 clicks?
   - Single-click or double-click to activate?

3. ENVIRONMENT
   - Screen size? (laptop, phone, large monitor)
   - Touch or mouse?
   - Quick glance or deep exploration?
```

**DO NOT ASSUME. ASK.**

---

## PHASE 2: Intent Declaration

Before ANY code:

```
INTENT DECLARATION:
1. Core Purpose: What is this solving for the user?
2. User Journey: ALL steps from start to finish
3. Screens/States: Every screen or state user will see
4. Promises: Specific features or capabilities mentioned
5. Navigation Map: How user moves between screens
6. Edge Cases: Empty states, errors, max data, completion states
```

---

## PHASE 3: Interaction Matrix

Map EVERY interactive element:

```
ELEMENT: [Button/Slider/Node Name]
├── PURPOSE: Why does this exist?
├── SINGLE CLICK → [Exact result]
├── DOUBLE CLICK → [Result or "same as single"]
├── RIGHT CLICK → [Result or "nothing"]
├── SHIFT+CLICK → [Result or "nothing"]
├── HOVER → [Visual feedback]
├── ACTIVE STATE → [How it looks when "on"]
├── DISABLED STATE → [When disabled? How it looks?]
├── LOADING STATE → [During async operations?]
└── ERROR STATE → [If action fails?]
```

### Control Verification Checklist

**Buttons:**
```
□ Click works (TESTED, not assumed)
□ Visual feedback on hover
□ Visual feedback on active/pressed
□ Disabled state exists and is clear
□ Double-click handled (no duplicate actions)
```

**Sliders/Range:**
```
□ Min value works
□ Max value works
□ Updates in real-time while dragging
□ Value displayed to user
□ Works for ALL views/modes (not just one)
```

**Toggle/Switch:**
```
□ On state clearly different from Off
□ Current state always visible
□ Click toggles reliably
```

---

## PHASE 4: Data Scale Testing (Mental)

Before coding, mentally test:

```
MINIMUM DATA:
□ 1 item → Does it look broken/empty?
□ 0 items → What does user see? (empty state)

TYPICAL DATA:
□ [User's expected amount] → Does spacing work?
□ Does it remain readable?

MAXIMUM DATA:
□ 100+ items → Overflow? Scroll? Performance?
□ 10 levels deep → Still navigable?

EDGE DATA:
□ Very long names → Truncate? Wrap? Overflow?
□ Special characters → Break anything?
□ Missing fields → Show "undefined"? Hide?
```

---

## PHASE 5: Journey Mapping

```
START: User opens the app
│
├── FIRST THING THEY SEE
│   └── Is it clear what to do?
│
├── PRIMARY TASK
│   ├── Step 1: [Action] → [Result]
│   ├── Step 2: [Action] → [Result]
│   └── Complete → [SUCCESS STATE]
│
├── EXPLORATION (user clicks randomly)
│   ├── Click any element → What happens?
│   ├── Click same thing twice → What happens?
│   └── Click while loading → What happens?
│
├── RECOVERY
│   ├── User gets lost → How to get back?
│   ├── User made mistake → How to undo?
│   └── User wants to reset → Clear path?
│
└── EXIT
    └── User is done → Clear completion state?
```

---

## PHASE 6: State Checklist

Every screen/view MUST have:

```
□ EMPTY STATE - What shows when no data?
□ LOADING STATE - What shows while fetching?
□ ERROR STATE - What shows when something fails?
□ PARTIAL STATE - What shows with incomplete data?
□ CROWDED STATE - What shows with lots of data?
□ SUCCESS STATE - What shows after completing action?
```

---

## PHASE 7: Pre-Build Verification

Before writing code, verify:

```
□ I ASKED about data scale (not assumed)
□ I mapped EVERY clickable element
□ I defined what EVERY click does
□ I tested with min/typical/max data (mentally)
□ I planned empty, loading, error states
□ I have a way back from every screen
□ ALL controls work for ALL modes/views
□ I will TEST every button after coding
```

---

## PHASE 8: Present Plan to User

Show this before coding:

```
## Build Plan for [Project Name]

### Your Data
- Scale: [X items, Y levels deep]
- Primary action: [What you mainly do]

### Interactive Elements
| Element | Click | Shift+Click | Result |
|---------|-------|-------------|--------|
| [Name]  | [Do]  | [Do]        | [What] |

### User Journey
1. Open → See [X] → Click [Y] → Result [Z]
2. To go back: [How]
3. To reset: [How]

### Edge Cases
- Empty: [Shows X]
- Crowded: [Handles by Y]
- Error: [Shows Z]

Ready to build? [WAIT FOR APPROVAL]
```

---

## PHASE 9: Post-Build Audit

After coding, BEFORE saying "done":

```
COHERENCE AUDIT:
□ Clicked every button myself
□ Tested every slider/control
□ Tested in ALL modes/views (tree AND radial, etc.)
□ Tested with minimum data
□ Tested with crowded data
□ Every promised feature actually works
□ No dead ends or broken states
```

---

## Common Failures This Prevents

| Failure | Prevention |
|---------|------------|
| Buttons don't work | Must TEST every button, not assume |
| Works in demo, breaks with real data | Must ASK about data scale first |
| Slider works in one view, not another | Must test ALL modes/views |
| No way to undo/go back | Must define recovery path |
| Looks good but unusable | Must map actual user journey |
| "Done" but user finds bugs | Must do post-build audit |

---

## The Rule

**Looking good ≠ Working well**

A beautiful button that does nothing is worse than an ugly button that works.

**ASK → PLAN → MAP → TEST → AUDIT → DONE**
