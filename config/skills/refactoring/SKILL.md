---
name: refactoring
description: Safely improve existing code without changing behavior. Use when code is messy, hard to understand, duplicated, or needs restructuring. Triggers on "clean up this code", "refactor", "this code is messy", "improve this", or when you notice code smells while working.
---

# Refactoring

**Improve code structure without changing behavior. Make it cleaner, not different.**

---

## THE GOLDEN RULE

```
Refactoring changes HOW code works, not WHAT it does.

Before refactoring: Code does X
After refactoring: Code still does X, but is cleaner
```

---

## BEFORE YOU START

```
PRE-REFACTOR CHECKLIST:
□ Do I understand what this code currently does?
□ Is there a way to verify it still works after? (tests, manual check)
□ Am I refactoring, or am I adding features? (don't mix!)
□ Is this the right time? (don't refactor during urgent bug fix)
```

---

## STEP 1: Identify Code Smells

What makes code need refactoring:

```
CODE SMELLS:

□ Duplicate code (same logic in multiple places)
□ Long function (does too many things)
□ Long parameter list (function takes 5+ params)
□ Magic numbers (hardcoded values without explanation)
□ Deep nesting (if inside if inside if...)
□ Dead code (unused functions/variables)
□ Unclear names (what does 'x' or 'temp' mean?)
□ God object (one class/file does everything)
□ Feature envy (function uses another object's data more than its own)
□ Comments explaining bad code (fix the code, not add comments)
```

---

## STEP 2: Choose Refactoring Pattern

| Smell | Refactoring |
|-------|-------------|
| Duplicate code | Extract function/method |
| Long function | Extract smaller functions |
| Long parameter list | Introduce parameter object |
| Magic numbers | Extract constant with name |
| Deep nesting | Early return, extract conditions |
| Unclear names | Rename to describe purpose |
| God object | Split into focused classes/modules |
| Dead code | Delete it |

---

## STEP 3: Refactor in Small Steps

**One change at a time. Verify after each.**

```
REFACTORING LOOP:
1. Make ONE small change
2. Verify code still works
3. Commit (or note the change)
4. Repeat

DON'T: Change 10 things, then test
DO: Change 1 thing, test, change 1 thing, test...
```

---

## COMMON REFACTORINGS

### 1. Extract Function
**Before:**
```javascript
function processOrder(order) {
  // validate
  if (!order.items) throw new Error('No items');
  if (!order.customer) throw new Error('No customer');
  if (order.total < 0) throw new Error('Invalid total');

  // calculate
  let subtotal = order.items.reduce((sum, i) => sum + i.price, 0);
  let tax = subtotal * 0.1;
  let total = subtotal + tax;

  // save
  database.save(order);
}
```

**After:**
```javascript
function processOrder(order) {
  validateOrder(order);
  const total = calculateTotal(order);
  saveOrder(order);
}

function validateOrder(order) {
  if (!order.items) throw new Error('No items');
  if (!order.customer) throw new Error('No customer');
  if (order.total < 0) throw new Error('Invalid total');
}

function calculateTotal(order) {
  const subtotal = order.items.reduce((sum, i) => sum + i.price, 0);
  const tax = subtotal * 0.1;
  return subtotal + tax;
}

function saveOrder(order) {
  database.save(order);
}
```

### 2. Extract Constant
**Before:**
```javascript
if (password.length < 8) { ... }
setTimeout(fetch, 30000);
if (items.length > 100) { ... }
```

**After:**
```javascript
const MIN_PASSWORD_LENGTH = 8;
const FETCH_TIMEOUT_MS = 30000;
const MAX_ITEMS_PER_PAGE = 100;

if (password.length < MIN_PASSWORD_LENGTH) { ... }
setTimeout(fetch, FETCH_TIMEOUT_MS);
if (items.length > MAX_ITEMS_PER_PAGE) { ... }
```

### 3. Early Return (Reduce Nesting)
**Before:**
```javascript
function getDiscount(user) {
  if (user) {
    if (user.isPremium) {
      if (user.yearsActive > 5) {
        return 0.3;
      } else {
        return 0.2;
      }
    } else {
      return 0.1;
    }
  } else {
    return 0;
  }
}
```

**After:**
```javascript
function getDiscount(user) {
  if (!user) return 0;
  if (!user.isPremium) return 0.1;
  if (user.yearsActive > 5) return 0.3;
  return 0.2;
}
```

### 4. Rename for Clarity
**Before:**
```javascript
const d = new Date();
const t = d.getTime();
const x = users.filter(u => u.a > 5);
```

**After:**
```javascript
const currentDate = new Date();
const timestamp = currentDate.getTime();
const activeUsers = users.filter(user => user.accountAge > 5);
```

### 5. Remove Duplication
**Before:**
```javascript
function saveUser(user) {
  const data = JSON.stringify(user);
  localStorage.setItem('user', data);
  console.log('Saved user');
}

function saveSettings(settings) {
  const data = JSON.stringify(settings);
  localStorage.setItem('settings', data);
  console.log('Saved settings');
}
```

**After:**
```javascript
function saveToStorage(key, value) {
  const data = JSON.stringify(value);
  localStorage.setItem(key, data);
  console.log(`Saved ${key}`);
}

function saveUser(user) {
  saveToStorage('user', user);
}

function saveSettings(settings) {
  saveToStorage('settings', settings);
}
```

---

## REFACTORING SAFETY

```
SAFETY CHECKLIST:

□ Have tests? Run them after each change
□ No tests? Manually verify the main flow works
□ Using version control? Commit before refactoring
□ Unsure about change? Make it on a branch first
□ Big refactor? Do it in multiple small PRs, not one giant one
```

---

## WHEN NOT TO REFACTOR

```
DON'T REFACTOR WHEN:
- Fixing urgent production bug (fix first, refactor later)
- You don't understand the code yet (understand first)
- Code will be deleted soon anyway
- It works and no one needs to change it
- You're mixing refactoring with feature work
```

---

## OUTPUT FORMAT

When refactoring, report:

```
## Refactoring: [Area/File]

### Code Smells Found
- [Smell 1]: [Where]
- [Smell 2]: [Where]

### Changes Made
1. [Change 1] - [Why]
2. [Change 2] - [Why]
3. [Change 3] - [Why]

### Verification
- [How I verified it still works]

### Before/After
[Show key improvement]
```

---

## The Rule

**Refactoring is about making code easier to understand and change, not about making it "clever".**

Simple > Clever
Clear > Short
Working > Perfect
