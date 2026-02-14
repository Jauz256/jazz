# Pricing Power Master

## Description
S-tier skill for determining optimal pricing strategies based on market structure, elasticity, and customer segmentation. Covers all pricing approaches from uniform pricing to advanced price discrimination, two-part tariffs, and bundling strategies.

## Trigger Phrases
Use this skill when user asks:
- "How should I price?"
- "What pricing strategy?"
- "Price discrimination"
- "Should I bundle?"
- "Two-part pricing"
- "Raise or lower price?"
- "Elasticity pricing"
- "Different prices for different customers"
- "Membership pricing"
- "Volume discounts"
- "Student/senior discounts"

---

## PRICING STRATEGY DECISION TREE

```
START: What pricing strategy should I use?
│
├─→ Q1: Do you have market power? (Can you set price?)
│   ├─→ NO → PRICE TAKER (accept market price, produce where P = MC)
│   └─→ YES → Continue to Q2
│
├─→ Q2: Can you identify different customer segments?
│   ├─→ NO → UNIFORM PRICING (single price for all)
│   └─→ YES → Continue to Q3
│
├─→ Q3: Can you prevent resale/arbitrage?
│   ├─→ NO → UNIFORM PRICING (can't discriminate)
│   └─→ YES → Continue to Q4
│
├─→ Q4: What information do you have about customers?
│   ├─→ Know each customer's max WTP → 1ST DEGREE (Perfect)
│   ├─→ Know distribution, not individuals → 2ND DEGREE (Self-selection)
│   └─→ Observable signal (age, status) → 3RD DEGREE (Segmented)
│
└─→ Q5: Do customers make repeat purchases?
    ├─→ YES → Consider TWO-PART TARIFF
    └─→ Have complementary products? → Consider BUNDLING
```

---

## 1. UNIFORM PRICING (Single Price)

### When to Use
- Cannot identify customer segments
- Cannot prevent resale
- Simple product, simple market

### The Rule
```
Step 1: Find quantity where MR = MC (and MC is rising)
Step 2: Find price from demand curve at that quantity
```

### Graphical Method
```
        Price
          │
          │
        P*├────────●  ← Price from demand curve
          │        │
          │        │
       MC │........●  ← MR = MC intersection
          │        │
          └────────┴──────── Quantity
                  Q*
```

### Profit Calculation
```
Total Profit = (P - ATC) × Q

Where:
- P = Price (from demand curve at Q*)
- ATC = Average Total Cost at Q*
- Q* = Quantity where MR = MC
```

### Example
```
Demand: P = 100 - 2Q
MR: MR = 100 - 4Q
MC: MC = 20

Step 1: MR = MC
100 - 4Q = 20
Q* = 20 units

Step 2: P from demand
P* = 100 - 2(20) = 60

Profit = (60 - ATC) × 20
```

---

## 2. PRICE DISCRIMINATION

### Three Conditions Required

| Condition | Description | Example of Failure |
|-----------|-------------|-------------------|
| **Market Power** | Downward sloping demand | Commodity farmer can't discriminate |
| **Market Segregation** | Can identify buyer groups | Anonymous online buyers |
| **No Resale** | Buyers can't arbitrage | Students reselling to adults |

### Three Types of Price Discrimination

| Type | Name | Information Needed | How It Works |
|------|------|-------------------|--------------|
| **1st Degree** | Perfect | Each buyer's max WTP | Charge max each will pay |
| **2nd Degree** | Self-Selection | Distribution of WTP | Menu of options, buyers self-select |
| **3rd Degree** | Segmented | Observable signal | Different prices by group identity |

---

### 2A. FIRST DEGREE (Perfect Price Discrimination)

**Goal:** Charge each customer their maximum willingness to pay

**Result:**
- Captures ALL consumer surplus as profit
- Quantity = Competitive quantity (P = MC)
- Profit > Any other pricing strategy

**Practical Methods:**
| Method | Example |
|--------|---------|
| Auctions | eBay, art auctions |
| Negotiation | Car dealerships, B2B sales |
| Personalized pricing | Airline dynamic pricing |

**Profit Calculation:**
```
Profit = Total area under demand curve above MC
       = Consumer Surplus + Normal Monopoly Profit
```

---

### 2B. SECOND DEGREE (Self-Selection)

**Goal:** Design menu so customers reveal their type through choices

**Common Mechanisms:**

| Mechanism | How It Works | Example |
|-----------|--------------|---------|
| **Volume Discounts** | Lower price per unit for bulk | Costco bulk packs |
| **Versioning** | Different quality levels | Economy vs Business class |
| **Time-based** | Different prices by timing | Happy hour, matinee movies |
| **Coupons** | Price-sensitive customers clip coupons | Grocery store coupons |

**Design Principle:**
```
High-value customers → Premium option (high price, high quality)
Low-value customers → Basic option (low price, basic features)

Key: Premium option must be attractive enough that high-value
     customers don't switch to basic option
```

**Examples:**
| Product | Basic Option | Premium Option |
|---------|--------------|----------------|
| Airline | Economy (cramped, no perks) | Business (space, lounge) |
| Software | Free version (limited) | Pro version (full features) |
| Stadium | Nosebleed seats | VIP box seats |
| Gas station | Self-service | Full-service |

---

### 2C. THIRD DEGREE (Segmented Markets)

**Goal:** Charge different prices to identifiable groups

**The Rule:**
```
More INELASTIC demand → HIGHER price
More ELASTIC demand → LOWER price
```

**Common Segmentation Variables:**

| Variable | Higher Price | Lower Price | Why |
|----------|-------------|-------------|-----|
| Age | Adults | Students/Seniors | Students more price sensitive |
| Location | Domestic | Tourist/"Farang" | Tourists less informed |
| Time | Peak hours | Off-peak | Peak demand less elastic |
| Membership | Non-members | Members | Members committed |
| Purchase timing | Last-minute | Early bird | Last-minute is desperate |

**Profit Maximization:**
```
For each segment:
1. Set MR₁ = MC in segment 1 → Find Q₁, P₁
2. Set MR₂ = MC in segment 2 → Find Q₂, P₂

Total Profit = (P₁ - ATC) × Q₁ + (P₂ - ATC) × Q₂
```

**Example: Movie Theater**
```
Adults: Demand is inelastic (will pay for entertainment)
→ Price: 300 THB

Students: Demand is elastic (limited budget, alternatives)
→ Price: 180 THB

Result: Higher total profit than single price
```

---

## 3. TWO-PART TARIFF

### When to Use
- Recurring purchases
- Can charge entry/membership fee
- Want to extract more consumer surplus

### Structure
```
Total Payment = Lump-sum Fee (T) + Per-unit Price (P) × Quantity
```

### Examples

| Business | Lump-sum (T) | Per-unit (P) |
|----------|--------------|--------------|
| Costco | Annual membership | Product prices |
| Gym | Monthly fee | Per-class fee |
| Phone plan | Monthly base | Per-minute/GB |
| Sizzler | Entry fee | Food prices |
| Amusement park | Gate admission | Ride tickets |

### Optimal Two-Part Tariff (Identical Consumers)

```
Step 1: Set per-unit price P = MC
Step 2: Set lump-sum T = All consumer surplus at that price
        (Area under demand curve above P)

Result: Extracts ALL consumer surplus = Perfect price discrimination profit
```

**Graphical:**
```
        Price
          │
          │\
          │ \
          │  \  ← Consumer surplus = Lump-sum fee (T)
          │   \
        MC├────\────  ← Per-unit price = MC
          │     \
          └──────\────── Quantity
```

### Two-Part Tariff with Different Customers (One Menu)

When you can't tell customer types apart:

**Option A:** High lump-sum, P = MC
- Only high-value customers buy
- Profit = T₁ × N₁ (number of high-value)

**Option B:** Low lump-sum, P = MC
- Both types buy
- Profit = T₂ × (N₁ + N₂)

**Choose option with higher total profit.**

### Two-Part Tariff with Two Menus

Design self-selection menus:

| Menu | Target | Lump-sum | Per-unit Price |
|------|--------|----------|----------------|
| Basic | Low-volume users | Lower T | Higher P |
| Premium | High-volume users | Higher T | Lower P (often = MC) |

**Key:** High-volume users save money with premium despite higher T.

---

## 4. BUNDLING (TIE-IN SALES)

### When to Use
- Have multiple related products
- Customers have different valuations across products
- Want to capture more surplus or extend market power

### Types of Bundling

| Type | Description | Example |
|------|-------------|---------|
| **Pure Bundling** | Only sold together | Cable TV packages |
| **Mixed Bundling** | Available separately or together | MS Office (suite or individual) |
| **Requirement Tie-in** | Must buy complement from same firm | Printer + ink cartridges |

### Why Bundling Works

**Scenario without bundling:**
```
Customer A: Values Word at 100, Excel at 50
Customer B: Values Word at 50, Excel at 100

Sell separately at 100 each:
- A buys Word only (100)
- B buys Excel only (100)
- Revenue = 200

Sell separately at 50 each:
- Both buy both
- Revenue = 200
```

**With bundling at 150:**
```
- A values bundle at 150, buys (150)
- B values bundle at 150, buys (150)
- Revenue = 300 ← Higher!
```

### Strategic Uses of Bundling

| Purpose | How | Example |
|---------|-----|---------|
| **Extend market power** | Bundle monopoly product with competitive product | Windows + Internet Explorer |
| **Price discrimination** | Different bundle valuations | Cable packages |
| **Ensure quality** | Control complementary product quality | iPhone + App Store |
| **Increase switching costs** | Ecosystem lock-in | Apple products |

---

## 5. ELASTICITY-BASED PRICING

### The Core Principle

```
Price Elasticity of Demand (Ed) = % Change in Quantity / % Change in Price

Ed is ALWAYS NEGATIVE (law of demand)
Use absolute value |Ed| for decisions
```

### Pricing Direction Guide

| If Demand is... | |Ed| Value | Price Change | Revenue Effect |
|-----------------|-----------|--------------|----------------|
| **Elastic** | > 1 | LOWER price | Revenue INCREASES |
| **Inelastic** | < 1 | RAISE price | Revenue INCREASES |
| **Unit Elastic** | = 1 | Don't change | Revenue maximized |

### Factors Affecting Elasticity

| Factor | More Elastic | More Inelastic |
|--------|--------------|----------------|
| Substitutes | Many available | Few available |
| Necessity | Luxury | Necessity |
| Budget share | High % of income | Low % of income |
| Time horizon | Long run | Short run |
| Brand loyalty | Weak | Strong |

### Elasticity Applications

**Tax Policy:**
- Government taxes INELASTIC goods (cigarettes, alcohol, gasoline)
- Revenue is stable because demand doesn't drop much

**Price Discrimination:**
- Charge HIGHER prices to INELASTIC segment
- Charge LOWER prices to ELASTIC segment

**Competitive Strategy:**
- If your product is elastic → Compete on price
- If your product is inelastic → Compete on value/brand

---

## 6. COMPLETE PRICING ANALYSIS TEMPLATE

```
PRICING STRATEGY ANALYSIS

1. PRODUCT/SERVICE: _______________

2. MARKET POWER CHECK:
   □ Can set price above MC? Yes / No
   □ Downward sloping demand? Yes / No
   → Market Power: Yes / No

3. SEGMENTATION POSSIBILITIES:
   □ Can identify different customer groups? Yes / No
   □ Can prevent resale? Yes / No
   □ Observable signals available? _______________

4. ELASTICITY ASSESSMENT:
   □ Overall demand elasticity: Elastic / Inelastic / Unit
   □ Segment 1 elasticity: ___
   □ Segment 2 elasticity: ___

5. RECOMMENDED STRATEGY:
   □ Uniform Pricing
   □ 1st Degree (Perfect)
   □ 2nd Degree (Self-selection)
   □ 3rd Degree (Segmented)
   □ Two-Part Tariff
   □ Bundling

6. PRICING CALCULATIONS:
   - Optimal Q (from MR = MC): ___
   - Optimal P: ___
   - Expected profit: ___

7. IMPLEMENTATION:
   - How to segment: _______________
   - How to prevent arbitrage: _______________
   - Menu design: _______________
```

---

## QUICK REFERENCE: PRICING FORMULAS

```
UNIFORM PRICING:
MR = MC → Find Q* → Find P* from demand

PROFIT:
π = (P - ATC) × Q

BREAK-EVEN QUANTITY:
Q_BE = FC / (P - AVC)

TWO-PART TARIFF (Identical):
P = MC
T = Consumer Surplus at MC

PRICE DISCRIMINATION:
Inelastic segment → Higher P
Elastic segment → Lower P

ELASTICITY:
Ed = (%ΔQ) / (%ΔP)
|Ed| > 1 → Lower price to increase revenue
|Ed| < 1 → Raise price to increase revenue
```

---

## OUTPUT FORMAT

When recommending pricing strategy:

```
## Pricing Strategy Recommendation: [Product/Service]

### 1. MARKET ANALYSIS
- **Market Power:** [Yes/No - explanation]
- **Segmentation Possible:** [Yes/No - how]
- **Elasticity:** [Elastic/Inelastic - by segment]

### 2. RECOMMENDED STRATEGY
- **Primary Strategy:** [Uniform / Discrimination / Two-Part / Bundling]
- **Rationale:** [Why this strategy fits]

### 3. PRICING DETAILS
| Segment/Option | Price | Expected Quantity | Revenue |
|----------------|-------|-------------------|---------|
| | | | |

### 4. IMPLEMENTATION
- **Segmentation Method:** [How to identify/separate customers]
- **Arbitrage Prevention:** [How to prevent resale]
- **Communication:** [How to present to customers]

### 5. EXPECTED RESULTS
- **Total Revenue:** ___
- **Total Profit:** ___
- **vs. Uniform Pricing:** [% improvement]
```
