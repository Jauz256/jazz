---
name: debugging
description: Systematic approach to finding and fixing bugs. Use when something isn't working, user reports an error, code behaves unexpectedly, or you need to find root cause of a problem. Triggers on "why isn't this working", "there's a bug", "this is broken", "error", or any troubleshooting request.
---

# Debugging

**Systematic approach to finding and fixing bugs. Don't guess randomly.**

---

## THE DEBUGGING PROCESS

```
REPRODUCE → ISOLATE → HYPOTHESIZE → TEST → FIX → VERIFY
```

---

## STEP 1: Reproduce

Before fixing, confirm you can see the bug:

```
REPRODUCTION:
□ Can I make the bug happen consistently?
□ What exact steps trigger it?
□ What input causes it?
□ What's the expected behavior?
□ What's the actual behavior?

Steps to reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]
→ Bug appears: [Description]
```

**If you can't reproduce it, you can't fix it reliably.**

---

## STEP 2: Isolate

Narrow down where the bug lives:

```
ISOLATION QUESTIONS:
□ When did it last work? What changed?
□ Does it fail with ALL input or just SOME?
□ Does it fail every time or sometimes?
□ Does it fail in all environments or just one?
□ What's the smallest input that causes failure?

BINARY SEARCH:
- Works with input A, fails with input B
- Try input halfway between A and B
- Keep narrowing until you find the boundary
```

---

## STEP 3: Gather Information

Collect clues:

```
ERROR MESSAGES:
- Exact error text: [Copy paste]
- Stack trace: [What functions involved]
- Line number: [Where it points]

LOGGING:
- Add console.log/print at key points
- Log inputs and outputs of suspect functions
- Log "reached here" at checkpoints

STATE:
- What are variable values at failure point?
- What's in the database/storage?
- What did the API return?
```

---

## STEP 4: Form Hypotheses

Based on evidence, guess what's wrong:

```
HYPOTHESES (ranked by likelihood):

1. [Most likely cause]
   Evidence for: [Why I think this]
   Evidence against: [Why it might not be this]
   How to test: [Quick check]

2. [Second most likely]
   Evidence for: [Why]
   How to test: [Quick check]

3. [Third possibility]
   Evidence for: [Why]
   How to test: [Quick check]
```

---

## STEP 5: Test Hypotheses

Test ONE thing at a time:

```
TESTING HYPOTHESIS 1:
Action: [What I'll change/check]
Expected result if hypothesis correct: [What should happen]
Actual result: [What happened]
Conclusion: [Confirmed/Ruled out]

→ If ruled out, move to Hypothesis 2
→ If confirmed, proceed to fix
```

**Don't change multiple things at once. You won't know what fixed it.**

---

## STEP 6: Fix

Apply the minimal fix:

```
FIX:
Root cause: [What was actually wrong]
Fix applied: [What I changed]
Why this fixes it: [Explanation]
```

---

## STEP 7: Verify

Confirm the fix works:

```
VERIFICATION:
□ Original bug no longer occurs
□ Steps to reproduce now work correctly
□ No new bugs introduced
□ Edge cases still work
□ Other features still work (regression)
```

---

## COMMON BUG PATTERNS

| Symptom | Likely Cause |
|---------|--------------|
| Works sometimes, fails sometimes | Race condition, timing, uninitialized state |
| Works locally, fails in production | Environment difference, config, missing dependency |
| Works first time, fails after | State not reset, memory leak, cache |
| Works with small data, fails with large | Performance, timeout, buffer overflow |
| Silent failure (no error) | Swallowed exception, wrong condition, early return |
| Wrong output | Logic error, off-by-one, type coercion |
| "undefined" or "null" error | Accessing property of non-existent object |
| "not a function" error | Wrong import, typo, scope issue |

---

## DEBUGGING TECHNIQUES

### 1. Print/Log Debugging
```javascript
console.log("=== DEBUG ===");
console.log("input:", input);
console.log("result:", result);
console.log("=============");
```

### 2. Rubber Duck Debugging
Explain the code line by line out loud. Often you'll spot the bug while explaining.

### 3. Binary Search
Comment out half the code. Does it still fail?
- Yes → Bug is in remaining half
- No → Bug is in commented half
Repeat until found.

### 4. Minimal Reproduction
Strip away everything until you have the smallest code that still shows the bug.

### 5. Check Assumptions
```
I assumed X was [type/value].
Let me verify: console.log(typeof X, X)
```

### 6. Read the Error Message
Actually read it. The line number and message often tell you exactly what's wrong.

### 7. Check Recent Changes
```
git diff HEAD~5
```
What changed recently? Bug is likely in recent changes.

---

## DEBUGGING OUTPUT FORMAT

When reporting debugging results:

```
## Bug Report

### Symptom
[What user sees / what's broken]

### Reproduction
1. [Steps]
2. [Steps]
3. [Bug occurs]

### Root Cause
[What was actually wrong]

### Fix
[What was changed]
[File:line]

### Verification
[How I confirmed it's fixed]
```

---

## DEBUGGING MINDSET

```
1. Don't panic
2. Don't guess randomly
3. Follow the evidence
4. Test one thing at a time
5. The computer is doing exactly what you told it
6. The bug is in YOUR code (not the framework) 99% of the time
7. If stuck for 30 min, take a break or ask for help
```

---

## The Rule

**Bugs are puzzles with solutions. Approach systematically, not randomly.**

REPRODUCE → ISOLATE → HYPOTHESIZE → TEST → FIX → VERIFY
