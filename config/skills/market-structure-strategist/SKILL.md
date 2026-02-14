# Market Structure Strategist

## Description
S-tier skill for identifying market structures and determining optimal competitive strategies using the Structure-Conduct-Performance (SCP) framework. Analyzes any industry or business situation to determine market type, recommended conduct, and expected performance.

## Trigger Phrases
Use this skill when user asks:
- "What market structure is this?"
- "How many competitors?"
- "Is this oligopoly or monopolistic competition?"
- "What's the industry structure?"
- "Calculate C4/HHI"
- "Analyze this industry"
- "What type of market?"
- "Competition analysis"
- "Is this a monopoly?"
- "Market concentration"

---

## THE SCP FRAMEWORK

**Structure → Conduct → Performance**

Market structure determines what strategies are available, which determines profitability.

---

## STEP 1: IDENTIFY MARKET STRUCTURE

### Quick Classification Questions

```
Q1: How many firms in the market?
├── One → MONOPOLY
├── Few (2-10 dominant) → OLIGOPOLY
├── Many → Go to Q2
└── Very many (hundreds+) → Go to Q2

Q2: Are products differentiated?
├── Yes (brands matter) → MONOPOLISTIC COMPETITION
└── No (identical/commodity) → PERFECT COMPETITION
```

### The Four Market Structures

| Characteristic | Perfect Competition | Monopolistic Competition | Oligopoly | Monopoly |
|---------------|---------------------|-------------------------|-----------|----------|
| **Number of Firms** | Very large | Many | Few | One |
| **Product Type** | Standardized | Differentiated | Either | Unique, no substitutes |
| **Entry Barriers** | None | Low | High | Blocked |
| **Price Control** | None (price taker) | Some (narrow limits) | Limited/Collusive | Considerable |
| **Non-price Competition** | None | Heavy (ads, branding) | Heavy | PR only |
| **Examples** | Agriculture, eggs | Retail clothing, restaurants | Telecom, gasoline, cars | Utilities, licensed firms |

### Thailand Market Examples

| Industry | Structure | Key Players |
|----------|-----------|-------------|
| Eggs/Rice farming | Perfect Competition | Many farmers |
| Retail clothing | Monopolistic Competition | Zara, Uniqlo, H&M |
| Gasoline | Oligopoly | PTT, Shell, Bangchak |
| Telecom | Oligopoly | AIS, DTAC, TRUE |
| Duty-free | Monopoly | King Power |
| Convenience stores | Near Monopoly | CP All (7-Eleven) |

---

## STEP 2: MEASURE CONCENTRATION (Oligopoly Check)

### Concentration Ratio (C4)

```
C4 = Market share of top 4 firms combined

Rule of Thumb:
- C4 < 40% → Likely Monopolistic Competition
- C4 ≥ 40% → Likely Oligopoly
- C4 = 100% with 1 firm → Monopoly
```

### Herfindahl-Hirschman Index (HHI)

```
HHI = (S₁)² + (S₂)² + (S₃)² + ... + (Sₙ)²

Where S = Market share as percentage

Interpretation:
- HHI < 1,500 → Unconcentrated (competitive)
- HHI 1,500-2,500 → Moderately concentrated
- HHI > 2,500 → Highly concentrated (oligopoly/monopoly)
```

**Example Calculation:**
```
Four firms with shares: 40%, 30%, 20%, 10%

C4 = 40 + 30 + 20 + 10 = 100%

HHI = 40² + 30² + 20² + 10²
    = 1600 + 900 + 400 + 100
    = 3,000 (Highly concentrated → Oligopoly)
```

### Why HHI is Better Than C4

| Scenario | C4 | HHI | Reality |
|----------|-----|-----|---------|
| One firm: 100% | 100% | 10,000 | Monopoly |
| Four firms: 25% each | 100% | 2,500 | Oligopoly |
| 100 firms: 1% each | 4% | 100 | Perfect Competition |

C4 misses the distribution; HHI captures dominance.

---

## STEP 3: CHECK CONTESTABILITY

### The Contestable Market Principle

**What matters is barriers to entry, NOT number of firms!**

Even a single firm may behave competitively if:
- Entry is easy (low barriers)
- Exit is easy (no sunk costs)
- Potential competitors can enter quickly

### Contestability Check

| Question | If YES | If NO |
|----------|--------|-------|
| Can new firms enter easily? | More competitive behavior | Less competitive |
| Are there significant sunk costs? | Less contestable | More contestable |
| Can incumbents respond before entry? | Less contestable | More contestable |

**Example: Podunk Dentist**
- One dentist in isolated town (looks like monopoly)
- But any other dentist can move there (contestable)
- Result: May charge competitive prices despite being "monopolist"

---

## STEP 4: DETERMINE OPTIMAL CONDUCT

### Conduct by Market Structure

#### Perfect Competition
```
CONDUCT:
- Accept market price (price taker)
- Produce where P = MC
- Focus on cost reduction
- No advertising needed
- Entry/exit based on profit signals

PRICING RULE: P = MR = MC
```

#### Monopolistic Competition
```
CONDUCT:
- Set price from demand curve (some power)
- Produce where MR = MC
- Heavy product differentiation
- Advertising and branding essential
- Use STP: Segmentation, Targeting, Positioning

PRICING RULE: MR = MC, then P from demand curve
```

#### Oligopoly
```
CONDUCT (depends on model):

1. Kinked Demand (no dominant firm, non-collusive):
   - Don't change price (rigidity)
   - Match price decreases, ignore increases
   - Compete on non-price factors

2. Collusion (similar firms, can limit entry):
   - Act as group monopoly
   - Joint profit maximization
   - Output quotas
   - Risk: Cheating incentives

3. Price Leadership (dominant firm exists):
   - Follow leader's price
   - Leader considers followers when pricing
   - Infrequent price changes

GENERAL OLIGOPOLY CONDUCT:
- Heavy R&D and innovation
- Significant advertising
- Consider mergers
- Strategic interdependence
```

#### Monopoly
```
CONDUCT:
- Full price control
- Produce where MR = MC
- Maintain barriers to entry
- Consider price discrimination
- PR advertising only

PRICING RULE: MR = MC, then P from demand curve
```

---

## STEP 5: PREDICT PERFORMANCE

### Long-Run Profit Expectations

| Structure | Long-Run Economic Profit | Why |
|-----------|-------------------------|-----|
| Perfect Competition | Zero | Free entry eliminates profit |
| Monopolistic Competition | Zero | Easy entry eliminates profit |
| Oligopoly | Possible (positive) | Barriers protect profits |
| Monopoly | Likely (positive) | Blocked entry protects profits |

### Price vs Marginal Cost

| Structure | P vs MC | Efficiency |
|-----------|---------|------------|
| Perfect Competition | P = MC | Allocatively efficient |
| Monopolistic Competition | P > MC | Some inefficiency, excess capacity |
| Oligopoly | P > MC | Inefficient |
| Monopoly | P > MC | Most inefficient |

---

## COMPLETE ANALYSIS TEMPLATE

```
MARKET STRUCTURE ANALYSIS

1. INDUSTRY: _______________

2. STRUCTURE IDENTIFICATION:
   - Number of firms: ___
   - Product type: Standardized / Differentiated
   - Entry barriers: None / Low / High / Blocked

   → MARKET STRUCTURE: _______________

3. CONCENTRATION (if applicable):
   - C4 = ___%
   - HHI = ___
   - Interpretation: _______________

4. CONTESTABILITY CHECK:
   - Entry ease: High / Medium / Low
   - Sunk costs: High / Medium / Low
   - Contestable: Yes / No

5. RECOMMENDED CONDUCT:
   - Pricing approach: _______________
   - Non-price competition: _______________
   - Key strategic focus: _______________

6. EXPECTED PERFORMANCE:
   - Long-run profit: Zero / Possible / Likely
   - Price efficiency: P = MC / P > MC
```

---

## BARRIERS TO ENTRY ANALYSIS

### Types of Barriers

| Barrier Type | Description | Strength |
|--------------|-------------|----------|
| **Economies of Scale** | Large scale needed for low cost | High |
| **Capital Requirements** | High investment to start | High |
| **Patents/Licenses** | Legal protection | Very High |
| **Resource Control** | Owning essential inputs | Very High |
| **Brand Loyalty** | Established customer base | Medium-High |
| **Switching Costs** | Costly to change suppliers | Medium |
| **Network Effects** | Value increases with users | High |
| **Government Regulation** | Legal restrictions | Very High |

### Barrier Assessment Template

```
ENTRY BARRIER ANALYSIS

| Barrier | Present? | Strength (1-5) |
|---------|----------|----------------|
| Economies of scale | | |
| Capital requirements | | |
| Patents/licenses | | |
| Resource control | | |
| Brand loyalty | | |
| Switching costs | | |
| Network effects | | |
| Government regulation | | |

TOTAL BARRIER SCORE: ___/40

Interpretation:
- 0-10: Very easy entry → Perfect/Monopolistic Competition
- 11-20: Moderate barriers → Monopolistic Competition
- 21-30: Significant barriers → Oligopoly
- 31-40: Blocked entry → Monopoly
```

---

## QUICK DECISION FLOWCHART

```
START: Analyze market for [Industry/Product]
│
├─→ Count competitors
│   ├─→ 1 firm → Check barriers
│   │   ├─→ Blocked entry → MONOPOLY
│   │   └─→ Entry possible → CONTESTABLE (acts competitive)
│   │
│   ├─→ 2-10 dominant → Calculate C4/HHI
│   │   ├─→ C4 ≥ 40% or HHI > 2500 → OLIGOPOLY
│   │   └─→ Lower concentration → MONOPOLISTIC COMPETITION
│   │
│   └─→ Many firms → Check product differentiation
│       ├─→ Differentiated → MONOPOLISTIC COMPETITION
│       └─→ Standardized → PERFECT COMPETITION
│
└─→ OUTPUT: Structure + Conduct + Performance prediction
```

---

## OUTPUT FORMAT

When analyzing a market, provide:

```
## Market Structure Analysis: [Industry Name]

### 1. STRUCTURE
- **Classification:** [Perfect Competition / Monopolistic Competition / Oligopoly / Monopoly]
- **Key Indicators:** [Number of firms, product type, barriers]
- **Concentration:** C4 = __%, HHI = __

### 2. RECOMMENDED CONDUCT
- **Pricing Strategy:** [Price taker / MR=MC / Follow leader / etc.]
- **Non-Price Competition:** [None / Differentiation / R&D / etc.]
- **Key Success Factors:** [What matters most in this structure]

### 3. EXPECTED PERFORMANCE
- **Long-Run Profit:** [Zero / Possible / Likely]
- **Price Efficiency:** [P = MC / P > MC]
- **Strategic Outlook:** [Key opportunities and threats]
```
