---
name: tech-research
description: Quickly evaluate and compare technologies, libraries, frameworks, or tools. Use when choosing between options, evaluating a new tool, or researching how to implement something. Triggers on "what library should I use", "compare X vs Y", "is X good", "how should I implement", "best way to do X".
---

# Tech Research

**Quickly evaluate technologies and make informed recommendations.**

---

## WHEN TO USE

- Choosing between libraries/frameworks
- Evaluating if a tool is right for the job
- Researching implementation approaches
- Checking if technology is mature/maintained
- Comparing trade-offs

---

## RESEARCH FRAMEWORK

### Step 1: Define Requirements

Before researching, clarify what you need:

```
REQUIREMENTS:
□ What problem am I solving?
□ What are the must-haves?
□ What are nice-to-haves?
□ What are deal-breakers?
□ What's the scale? (prototype vs production)
□ What's the team's experience?
□ What's already in the stack?
```

---

### Step 2: Identify Options

List candidates:

```
OPTIONS:
1. [Option A] - [One-line description]
2. [Option B] - [One-line description]
3. [Option C] - [One-line description]
4. Do it yourself / No library
```

---

### Step 3: Quick Filter

Eliminate obviously bad fits:

```
QUICK FILTER:

| Option | Active? | Size OK? | License OK? | Keep? |
|--------|---------|----------|-------------|-------|
| A | ✓/✗ | ✓/✗ | ✓/✗ | Y/N |
| B | ✓/✗ | ✓/✗ | ✓/✗ | Y/N |
| C | ✓/✗ | ✓/✗ | ✓/✗ | Y/N |

CHECK:
□ Last commit < 6 months ago? (actively maintained)
□ Bundle size acceptable?
□ License compatible? (MIT, Apache = usually fine)
□ Works with our stack?
```

---

### Step 4: Deep Comparison

For remaining options:

```
## Comparison: [Option A] vs [Option B]

### Overview
| Criteria | Option A | Option B |
|----------|----------|----------|
| GitHub Stars | X | Y |
| Weekly Downloads | X | Y |
| Bundle Size | X kb | Y kb |
| Last Updated | Date | Date |
| License | MIT | Apache |
| TypeScript Support | ✓/✗ | ✓/✗ |

### Pros & Cons

**Option A**
Pros:
- [Pro 1]
- [Pro 2]

Cons:
- [Con 1]
- [Con 2]

**Option B**
Pros:
- [Pro 1]
- [Pro 2]

Cons:
- [Con 1]
- [Con 2]

### When to Choose Each
- Choose A if: [Scenario]
- Choose B if: [Scenario]
```

---

### Step 5: Evaluate Health

Check if technology is healthy:

```
HEALTH CHECK:

□ Maintenance
  - Last commit: [Date]
  - Release frequency: [How often]
  - Open issues: [Count, are they addressed?]
  - Bus factor: [1 person or team?]

□ Community
  - GitHub stars: [Count]
  - npm downloads: [Weekly]
  - Stack Overflow questions: [Count]
  - Discord/Slack activity: [Active?]

□ Documentation
  - Getting started guide: [Exists? Quality?]
  - API docs: [Complete?]
  - Examples: [Sufficient?]

□ Maturity
  - Version: [1.x = stable, 0.x = unstable]
  - Breaking changes: [Frequent?]
  - Used by: [Big companies?]
```

---

### Step 6: Hands-On Test

If still unsure, prototype:

```
PROTOTYPE TEST:
□ Can I install it easily?
□ Can I do basic task in < 30 min?
□ Does it work with my existing code?
□ Are errors helpful or cryptic?
□ Is the API intuitive?
```

---

## EVALUATION CRITERIA BY USE CASE

### For Production App
```
Priority: Stability, maintenance, community
Weight: Maturity > Features > Popularity
```

### For Prototype/MVP
```
Priority: Speed to implement, simplicity
Weight: Ease of use > Maturity > Performance
```

### For Learning
```
Priority: Documentation, community
Weight: Learning resources > Popularity > Features
```

### For Performance-Critical
```
Priority: Benchmarks, efficiency
Weight: Performance > Ease of use > Features
```

---

## RED FLAGS

```
🚩 RED FLAGS - Avoid if:
- No commits in 12+ months
- Only 1 maintainer who's inactive
- Major version 0.x with no roadmap
- No documentation
- Lots of open issues with no responses
- License is GPL (if you need commercial use)
- Requires heavy vendor lock-in
- Only works with specific outdated versions
```

---

## OUTPUT FORMAT

```
## Tech Research: [Topic]

### Requirements
- Need: [What]
- Scale: [Prototype/Production]
- Constraints: [Any limitations]

### Options Evaluated
1. **[Winner]** ⭐ Recommended
2. [Runner-up]
3. [Also considered]

### Comparison
| Criteria | Option 1 | Option 2 |
|----------|----------|----------|
| [Key 1] | X | Y |
| [Key 2] | X | Y |

### Recommendation
**Use [Option]** because:
- [Reason 1]
- [Reason 2]

**Don't use** [Other option] because:
- [Reason]

### Getting Started
[Quick start instructions or link]
```

---

## COMMON COMPARISONS TEMPLATE

### Frontend Framework
```
Criteria: Performance, bundle size, learning curve, ecosystem, job market
```

### State Management
```
Criteria: Complexity, boilerplate, devtools, learning curve
```

### Database
```
Criteria: Scale, query complexity, hosting options, cost
```

### API Framework
```
Criteria: Performance, middleware ecosystem, TypeScript support
```

### CSS Solution
```
Criteria: Bundle size, runtime cost, DX, theming
```

---

## The Rule

**Don't pick technology because it's popular. Pick it because it fits YOUR needs.**

Requirements first. Then research. Then decide.
