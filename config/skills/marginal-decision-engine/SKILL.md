# Marginal Decision Engine

## Description
S-tier skill for making quick, rigorous business and personal decisions using marginal analysis. Applies MB vs MC framework, identifies sunk costs, calculates opportunity costs, and provides clear yes/no recommendations with reasoning.

## Trigger Phrases
Use this skill when user asks:
- "Should I...?"
- "Is it worth it?"
- "Should I continue?"
- "Should I invest?"
- "Should I shut down?"
- "Is this a sunk cost?"
- "What's the opportunity cost?"
- "One more unit?"
- "Keep going or stop?"
- "Break-even analysis"
- "NPV calculation"
- "ROI analysis"
- "Continue or exit?"

---

## THE CORE FRAMEWORK

### The Marginal Decision Rule

```
┌─────────────────────────────────────────┐
│                                         │
│   MB ≥ MC  →  DO IT                    │
│                                         │
│   MB < MC  →  DON'T DO IT              │
│                                         │
└─────────────────────────────────────────┘

Where:
- MB = Marginal Benefit (additional benefit from action)
- MC = Marginal Cost (additional cost from action)
```

### Key Principles

| Principle | Meaning |
|-----------|---------|
| **Think at the margin** | Only consider what changes from this point forward |
| **Ignore sunk costs** | Past costs that cannot be recovered are irrelevant |
| **Include opportunity costs** | What you give up by choosing this option |
| **Consider both explicit and implicit** | Out-of-pocket AND forgone alternatives |

---

## DECISION TYPE 1: SHOULD I DO X?

### Framework

```
Step 1: Identify the Marginal Benefit (MB)
        → What do I gain from doing X?
        → Include all benefits (revenue, utility, satisfaction)

Step 2: Identify the Marginal Cost (MC)
        → What additional costs will I incur?
        → EXCLUDE sunk costs (already spent, can't recover)
        → INCLUDE opportunity costs (what I give up)

Step 3: Compare
        → MB ≥ MC? → YES, do it
        → MB < MC? → NO, don't do it
```

### Example: Should I Attend a Concert?

```
GIVEN:
- Ticket already bought for 2,000 THB (non-refundable)
- Concert is tonight
- Friend offers 1,500 THB to help them move instead

ANALYSIS:
- Sunk cost: 2,000 THB ticket (IGNORE - can't get it back)
- MB of concert: Enjoyment value (say, 2,500 THB worth)
- MC of concert: 1,500 THB (opportunity cost of friend's offer)

DECISION:
MB (2,500) > MC (1,500) → GO TO CONCERT

Note: The 2,000 THB ticket price is IRRELEVANT to this decision!
```

---

## DECISION TYPE 2: SHOULD I CONTINUE OR STOP?

### The Shutdown Decision Rule

```
┌─────────────────────────────────────────┐
│                                         │
│   P > AVC  →  CONTINUE OPERATING       │
│                                         │
│   P < AVC  →  SHUT DOWN                │
│                                         │
└─────────────────────────────────────────┘

Why? If P > AVC, you're covering variable costs AND
     contributing something toward fixed costs.
     If P < AVC, you lose more by operating than by stopping.
```

### Full Decision Matrix

| Condition | Economic Profit | Decision | Reasoning |
|-----------|-----------------|----------|-----------|
| P > ATC | Positive | Continue | Making profit |
| P = ATC | Zero | Continue | Breaking even |
| ATC > P > AVC | Negative | Continue (short-run) | Covering some fixed costs |
| P = AVC | Negative | Indifferent | Same loss either way |
| P < AVC | Negative | Shut down | Losing more by operating |

### Example: Coffee Shop During COVID

```
BEFORE COVID:
- Revenue: 72,000 THB/month (30 cups × 80 THB × 30 days)
- Variable costs: 36,000 THB/month (materials)
- Fixed costs: 36,000 THB/month (rent + labor)
- Profit: 0 THB (breaking even)

DURING COVID (only 20 cups/day):
- Revenue: 48,000 THB/month
- Variable costs: 24,000 THB/month
- Fixed costs: 36,000 THB/month
- Loss: -12,000 THB/month

SHUTDOWN ANALYSIS:
- P per cup = 80 THB
- AVC per cup = 40 THB
- P (80) > AVC (40) → CONTINUE

But wait - is rent a sunk cost?

SCENARIO A: Rent is refundable/transferable
- Can exit lease → Rent is NOT sunk
- Total loss if continue: -12,000 THB
- Total loss if stop: 0 THB
- DECISION: SHUT DOWN

SCENARIO B: Rent is non-refundable (sunk cost)
- Can't exit lease → Rent IS sunk
- Loss if continue: -12,000 THB
- Loss if stop: -36,000 THB (still pay rent)
- DECISION: CONTINUE until lease expires
```

---

## DECISION TYPE 3: HOW MANY UNITS?

### Optimal Quantity Rule

```
Produce/consume until MB = MC

- If MB > MC for next unit → Produce/consume more
- If MB < MC for next unit → Produce/consume less
- At MB = MC → Optimal quantity reached
```

### Example: Hiring Workers

```
| Workers | Total Output | MP (Marginal Product) | Wage (MC) | Decision |
|---------|--------------|----------------------|-----------|----------|
| 1 | 10 | 10 | 500 | Hire if MP × Price > 500 |
| 2 | 22 | 12 | 500 | Hire if 12 × Price > 500 |
| 3 | 32 | 10 | 500 | Hire if 10 × Price > 500 |
| 4 | 40 | 8 | 500 | Hire if 8 × Price > 500 |
| 5 | 45 | 5 | 500 | Hire if 5 × Price > 500 |

If Price = 60 THB per unit:
- Worker 5: MB = 5 × 60 = 300, MC = 500 → DON'T HIRE
- Worker 4: MB = 8 × 60 = 480, MC = 500 → DON'T HIRE
- Worker 3: MB = 10 × 60 = 600, MC = 500 → HIRE

OPTIMAL: Hire 3 workers
```

---

## DECISION TYPE 4: SHOULD I INVEST?

### Three Methods

| Method | Rule | Best For |
|--------|------|----------|
| **NPV** | Accept if NPV > 0 | Comparing different-sized projects |
| **ROI** | Accept if ROI > Cost of Capital | Quick profitability check |
| **Payback** | Accept if Payback < Target | Risk assessment |

### NPV (Net Present Value)

```
NPV = Σ [CF_t / (1 + r)^t] - Initial Investment

Where:
- CF_t = Cash flow in year t
- r = Discount rate (cost of capital)
- t = Year number

DECISION:
- NPV > 0 → ACCEPT (creates value)
- NPV < 0 → REJECT (destroys value)
- NPV = 0 → Indifferent
```

**Simplified NPV (equal annual cash flows):**
```
NPV = (Annual CF × PV Factor) - Initial Investment

PV Factor for n years at rate r:
= [1 - (1 + r)^(-n)] / r
```

### ROI (Return on Investment)

```
ROI = (Net Profit / Investment) × 100%

DECISION:
- ROI > Cost of Capital → ACCEPT
- ROI < Cost of Capital → REJECT
```

### Payback Period

```
Payback = Initial Investment / Annual Cash Flow

DECISION:
- Payback < Target → ACCEPT (less risky)
- Payback > Target → REJECT (too risky)
```

### Example: New Equipment Investment

```
GIVEN:
- Investment: 1,000,000 THB
- Annual cash flow: 300,000 THB for 5 years
- Discount rate: 10%
- Target payback: 4 years

ANALYSIS:

NPV:
Year 1: 300,000 / 1.10 = 272,727
Year 2: 300,000 / 1.21 = 247,934
Year 3: 300,000 / 1.33 = 225,394
Year 4: 300,000 / 1.46 = 205,479
Year 5: 300,000 / 1.61 = 186,335
Total PV = 1,137,869
NPV = 1,137,869 - 1,000,000 = +137,869 ✓

ROI:
Total profit over 5 years = 1,500,000 - 1,000,000 = 500,000
Average annual profit = 100,000
ROI = 100,000 / 1,000,000 = 10% = Cost of capital (borderline)

Payback:
1,000,000 / 300,000 = 3.33 years < 4 years ✓

DECISION: ACCEPT (NPV positive, payback acceptable)
```

---

## DECISION TYPE 5: OPPORTUNITY COST ANALYSIS

### Definition

```
Opportunity Cost = Value of the NEXT BEST alternative forgone

NOT all alternatives - just the SECOND BEST option
```

### Types of Opportunity Costs

| Type | Description | Examples |
|------|-------------|----------|
| **Explicit** | Out-of-pocket payments | Rent, wages, materials |
| **Implicit** | Forgone alternatives | Salary you could earn elsewhere, rent you could charge |

### Economic vs Accounting Profit

```
Accounting Profit = Revenue - Explicit Costs

Economic Profit = Revenue - Explicit Costs - Implicit Costs
                = Accounting Profit - Opportunity Costs

A firm with positive accounting profit but negative economic profit
should exit - they could do better elsewhere!
```

### Example: Should I Quit My Job to Start a Business?

```
CURRENT JOB:
- Salary: 50,000 THB/month

BUSINESS PLAN:
- Expected revenue: 150,000 THB/month
- Explicit costs: 80,000 THB/month
- Accounting profit: 70,000 THB/month

OPPORTUNITY COST ANALYSIS:
- Implicit cost: 50,000 THB/month (forgone salary)
- Economic profit: 70,000 - 50,000 = 20,000 THB/month

DECISION: START BUSINESS (economic profit is positive)

COMPARISON:
- Stay at job: 50,000 THB/month
- Start business: 50,000 + 20,000 = 70,000 THB equivalent
```

---

## SUNK COST IDENTIFICATION

### The Sunk Cost Test

```
Ask: "Can I recover this cost if I change my decision?"

YES → NOT a sunk cost (include in analysis)
NO → SUNK COST (exclude from analysis)
```

### Common Sunk Costs

| Sunk Cost | Why It's Sunk |
|-----------|---------------|
| Non-refundable tickets | Can't get money back |
| R&D already spent | Money already gone |
| Training costs for employee who quit | Can't recover |
| Marketing campaign already run | Already spent |
| Equipment with no resale value | Can't sell |

### Common NOT Sunk Costs

| Not Sunk | Why It's Not Sunk |
|----------|-------------------|
| Refundable deposit | Can get money back |
| Inventory | Can sell or return |
| Transferable lease | Can exit |
| Equipment with resale value | Can sell |

### The Sunk Cost Fallacy

```
WRONG THINKING:
"I've already invested 1 million THB, so I must continue."

RIGHT THINKING:
"The 1 million is gone regardless. Should I invest MORE
 based on future MB vs future MC?"
```

### Example: Movie Theater Decision

```
SCENARIO:
- Paid 200 THB for movie ticket (non-refundable)
- 30 minutes into movie, it's terrible
- Should you stay or leave?

WRONG ANALYSIS:
"I paid 200 THB, I should stay to get my money's worth."

RIGHT ANALYSIS:
- Sunk cost: 200 THB (can't recover)
- MB of staying: Low (movie is bad)
- MC of staying: 90 minutes of boredom + opportunity cost
- MB of leaving: Better use of time
- MC of leaving: 0 THB (ticket already gone)

DECISION: LEAVE (MB of leaving > MB of staying)
```

---

## BREAK-EVEN ANALYSIS

### Formula

```
Break-Even Quantity = Fixed Costs / (Price - Variable Cost per Unit)
                    = FC / (P - AVC)

Break-Even Revenue = Fixed Costs / Contribution Margin Ratio
Contribution Margin Ratio = (P - AVC) / P
```

### Example

```
GIVEN:
- Fixed costs: 100,000 THB/month
- Price: 500 THB/unit
- Variable cost: 300 THB/unit

BREAK-EVEN:
Q_BE = 100,000 / (500 - 300)
     = 100,000 / 200
     = 500 units

Must sell 500 units to cover all costs.
Below 500 → Loss
Above 500 → Profit
```

### Break-Even Chart

```
Revenue/Cost
      │
      │                    Revenue ↗
      │                  ↗
      │               ↗    Break-even point
      │            ↗  ●
      │         ↗  ╱
      │      ↗  ╱    Total Cost
      │   ↗  ╱
      │↗  ╱
   FC ├──╱─────────────────────
      │╱
      └────────────────────────── Quantity
                Q_BE
```

---

## QUICK DECISION TEMPLATES

### Template 1: Simple MB vs MC

```
DECISION: Should I [action]?

MARGINAL BENEFIT:
- Benefit 1: ___
- Benefit 2: ___
- Total MB: ___

MARGINAL COST:
- Cost 1: ___ (Is this sunk? Y/N)
- Cost 2: ___ (Is this sunk? Y/N)
- Opportunity cost: ___
- Total MC (excluding sunk): ___

COMPARISON:
MB ___ MC
[>/</=]

DECISION: [DO IT / DON'T DO IT]
```

### Template 2: Continue or Shutdown

```
DECISION: Should I continue operating?

CURRENT SITUATION:
- Price (P): ___
- Average Variable Cost (AVC): ___
- Average Total Cost (ATC): ___

ANALYSIS:
- P vs AVC: P [>/</=] AVC
- P vs ATC: P [>/</=] ATC

DECISION:
- P > AVC → CONTINUE (covering variable costs)
- P < AVC → SHUT DOWN (losing on every unit)
```

### Template 3: Investment Decision

```
DECISION: Should I invest in [project]?

INVESTMENT DETAILS:
- Initial investment: ___
- Annual cash flows: ___
- Time horizon: ___
- Discount rate: ___

CALCULATIONS:
- NPV: ___
- ROI: ___%
- Payback: ___ years

DECISION:
- NPV > 0? [Y/N]
- ROI > Cost of capital? [Y/N]
- Payback acceptable? [Y/N]

RECOMMENDATION: [INVEST / DON'T INVEST]
```

---

## OUTPUT FORMAT

When making a decision recommendation:

```
## Decision Analysis: [Question]

### 1. DECISION TYPE
[Simple MB/MC | Continue/Shutdown | Investment | Opportunity Cost]

### 2. KEY FACTORS

| Factor | Value | Sunk? | Include? |
|--------|-------|-------|----------|
| | | | |

### 3. ANALYSIS

**Marginal Benefit:** ___

**Marginal Cost:** ___

**Comparison:** MB [>/</=] MC

### 4. DECISION

**RECOMMENDATION:** [YES / NO]

**REASONING:** [1-2 sentence explanation]

### 5. SENSITIVITY CHECK
- What would change this decision?
- Key assumptions made
```

---

## COMMON DECISION SCENARIOS

| Scenario | Key Question | Framework |
|----------|--------------|-----------|
| "Should I finish this project?" | Are sunk costs clouding judgment? | Ignore sunk, compare future MB/MC |
| "Should I stay open during slow season?" | Is P > AVC? | Shutdown rule |
| "Should I accept this job offer?" | What's the opportunity cost? | Compare total compensation (explicit + implicit) |
| "Should I buy one more unit?" | Is MB of next unit > MC? | Marginal analysis |
| "Should I invest in this machine?" | Is NPV positive? | Investment analysis |
| "Should I drop this product line?" | Is it covering its variable costs? | Contribution analysis |
