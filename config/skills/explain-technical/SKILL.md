---
name: explain-technical
description: Communicate complex technical concepts to non-technical people. Use when explaining code to stakeholders, writing documentation for end users, presenting technical decisions to business teams, or translating developer jargon. Triggers on "explain this to my boss", "how do I explain", "non-technical explanation", "ELI5", or any request to simplify technical content.
---

# Explain Technical

**Translate complex technical concepts into clear, accessible language without dumbing down.**

---

## THE CORE PRINCIPLE

```
Technical accuracy + Accessible language = Trust

Don't: Oversimplify to the point of being wrong
Don't: Use jargon that excludes
Do: Find the right analogy
Do: Build understanding layer by layer
```

---

## KNOW YOUR AUDIENCE

Before explaining, identify who you're talking to:

```
AUDIENCE ASSESSMENT:

□ Who is this person?
  - Executive (cares about: cost, risk, timeline)
  - Product manager (cares about: features, user impact)
  - Designer (cares about: UX implications)
  - Client (cares about: what they're paying for)
  - End user (cares about: how to use it)

□ What do they already know?
  - Zero tech background
  - Some tech exposure (uses software daily)
  - Adjacent technical (works with developers)
  - Technical but different domain

□ What do they need to decide or do with this info?
  - Approve budget/timeline
  - Understand a problem
  - Use a feature
  - Trust a solution
```

---

## THE EXPLANATION FRAMEWORK

### Step 1: Start with WHY They Care

Lead with the impact, not the technology.

```
BAD:  "We need to implement Redis caching"
GOOD: "We can make the app 10x faster for users"

BAD:  "There's a race condition in the async handler"
GOOD: "Sometimes two users editing at once can lose each other's changes"

BAD:  "We need to refactor the authentication module"
GOOD: "We need to fix a security vulnerability that could expose user data"
```

### Step 2: Use the Right Analogy

Match technical concepts to familiar experiences:

| Technical Concept | Analogy |
|-------------------|---------|
| API | A waiter taking your order to the kitchen |
| Database | A filing cabinet / spreadsheet |
| Cache | Keeping frequently used items on your desk |
| Server | A computer that's always on, serving requests |
| Bug | A typo that causes confusion |
| Encryption | A lock that only the right key can open |
| Load balancer | A traffic cop directing cars |
| Git/Version control | Track changes in Word, but for code |
| Microservices | Specialists vs one person doing everything |
| Technical debt | Deferred maintenance on a house |
| Refactoring | Reorganizing a messy closet |
| Authentication | Checking your ID at the door |
| Authorization | Checking if your ticket allows VIP access |
| Latency | The wait time between ordering and receiving |
| Bandwidth | How wide the highway is |
| CPU | The brain doing the thinking |
| Memory/RAM | The desk where you spread out your work |
| Storage | The filing cabinet for long-term keeping |
| Frontend | What customers see (the restaurant dining room) |
| Backend | What happens behind the scenes (the kitchen) |
| Deployment | Publishing a new edition of a book |
| Downtime | "Closed for renovation" |
| Scalability | Can you serve 10 customers or 10,000? |

### Step 3: Layer the Explanation

Build understanding progressively:

```
LAYER 1: One-sentence summary (what + why it matters)
"We're upgrading the login system to be more secure."

LAYER 2: Simple explanation (how it works conceptually)
"Right now, passwords are stored in a way that's becoming outdated.
We're switching to a newer method that's much harder to crack."

LAYER 3: More detail (if they want it)
"Specifically, we're moving from MD5 hashing to bcrypt.
Think of it like upgrading from a basic door lock to a bank vault."

LAYER 4: Technical detail (only if asked)
"bcrypt uses adaptive hashing with salt, making brute force
attacks computationally expensive..."
```

### Step 4: Anticipate Questions

Prepare for the questions they'll actually ask:

```
EXECUTIVE QUESTIONS:
- How much will this cost?
- How long will it take?
- What's the risk if we don't do it?
- What's the risk if we do?
- Can we do it later?

PRODUCT QUESTIONS:
- How will users experience this?
- Will it break anything existing?
- Can we ship other features during this?
- What's the minimum viable version?

CLIENT QUESTIONS:
- Why do I need this?
- Is this included in what I paid for?
- When will it be done?
- Will I notice any difference?
```

---

## COMMON SCENARIOS

### Explaining a Bug

```
TEMPLATE:
"[What went wrong in user terms]
Because [simple cause]
We're fixing it by [solution in simple terms]
This will be resolved by [timeline]"

EXAMPLE:
"Some users saw an error when trying to upload files.
This happened because our storage system got temporarily overloaded.
We're adding more capacity and a better queue system.
This will be fixed by end of day, and we're adding monitoring
to catch this earlier in the future."
```

### Explaining Technical Debt

```
TEMPLATE:
"Think of it like [home maintenance analogy].
When we [describe shortcut taken],
It worked fine then, but now [current problem].
If we don't address it, [future risk].
Fixing it will [benefit]."

EXAMPLE:
"Think of it like a house where we've been delaying maintenance.
When we first built the app, we took some shortcuts to ship faster.
Those shortcuts worked fine with 100 users, but now with 10,000
users, things are starting to strain.
If we don't address it, the app will get slower and buggier.
Fixing it will make the app faster and easier to add new features."
```

### Explaining a Delay

```
TEMPLATE:
"We discovered [problem in simple terms].
This is important because [why it matters to them].
We have two options: [ship with risk] or [delay to fix].
We recommend [choice] because [reason in their terms]."

EXAMPLE:
"We discovered a security issue in the payment flow.
This is important because it could expose customer credit card data.
We can ship now and patch later (risky) or delay 2 days to fix it properly.
We recommend the delay because the reputational damage from
a breach would be far worse than a 2-day delay."
```

### Explaining Why Something is Hard

```
TEMPLATE:
"This looks simple but [hidden complexity].
It's like [analogy showing why it's complex].
The careful work is [what takes time].
Rushing it would [consequence]."

EXAMPLE:
"Moving to a new database looks simple but requires migrating
10 years of data without losing anything.
It's like moving a hospital to a new building while keeping
all patients alive and all records intact.
The careful work is testing every possible data scenario.
Rushing it could mean losing customer data permanently."
```

---

## WORDS TO AVOID vs USE

| Avoid | Use Instead |
|-------|-------------|
| Refactor | Reorganize / Clean up |
| Deploy | Launch / Release / Publish |
| Bug | Issue / Problem / Error |
| API | Connection / Integration |
| Database | Data storage / Records |
| Server | System / Service |
| Latency | Delay / Wait time |
| Scalability | Capacity / Growth readiness |
| Technical debt | Maintenance backlog |
| Deprecate | Phase out / Retire |
| Regression | Something that used to work broke |
| Edge case | Unusual situation |
| Bandwidth | Capacity / Time available |
| Sprint | Development cycle / Week |
| Blockers | Issues preventing progress |

---

## OUTPUT FORMAT

When asked to explain something technical:

```
## [Topic] - Non-Technical Explanation

### The Quick Version
[One sentence: what it is + why it matters]

### How It Works
[2-3 sentences using analogy]

### Why We're Doing This / Why This Happened
[Impact in terms they care about]

### What This Means For You
[Direct implications for this audience]

### Questions You Might Have
- [Anticipated question 1]: [Answer]
- [Anticipated question 2]: [Answer]
```

---

## CHECKLIST BEFORE DELIVERING

```
□ Did I lead with impact, not technology?
□ Did I use an analogy that fits?
□ Could my grandmother understand the first sentence?
□ Did I avoid unnecessary jargon?
□ Did I anticipate their real questions?
□ Is my explanation technically accurate (not oversimplified to wrong)?
□ Did I give them what they need to make a decision/take action?
```

---

## THE RULE

**The goal is understanding, not impressiveness.**

If they walk away confused, you failed - no matter how accurate you were.
If they walk away understanding, you succeeded - no matter how simple you made it.
