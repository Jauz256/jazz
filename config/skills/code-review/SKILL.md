---
name: code-review
description: Use before delivering ANY code to catch bugs, security issues, and performance problems. Triggers on "review this code", "check my code", "is this code good", or automatically before saying code is "done". Also use when user reports a bug to find root cause.
---

# Code Review

**Run this checklist BEFORE delivering code. Catch problems before the user does.**

---

## QUICK REVIEW (Always Do This)

```
□ Does it actually work? (Did I test it?)
□ Does it handle edge cases? (null, empty, max values)
□ Does it handle errors? (try/catch, error states)
□ Will it break with more data? (scale)
□ Is there any hardcoded value that should be configurable?
```

---

## FULL REVIEW CHECKLIST

### 1. Functionality
```
□ Does it do what was requested?
□ Does it work for the happy path?
□ Does it work for edge cases?
  - Empty input
  - Null/undefined
  - Very large input
  - Very small input
  - Special characters
  - Negative numbers (if applicable)
□ Does it work for error cases?
□ Did I actually RUN it, not just read it?
```

### 2. Bugs & Logic
```
□ Off-by-one errors? (< vs <=, array bounds)
□ Null pointer risks? (accessing .property of undefined)
□ Race conditions? (async operations)
□ Infinite loops possible?
□ Memory leaks? (event listeners not removed, intervals not cleared)
□ Type mismatches? (string vs number, comparing objects)
```

### 3. Security (If User-Facing)
```
□ SQL injection possible? (use parameterized queries)
□ XSS possible? (escape user input in HTML)
□ Sensitive data exposed? (passwords, API keys in code)
□ CORS properly configured?
□ Input validated on server, not just client?
□ Authentication checked on protected routes?
```

### 4. Performance
```
□ N+1 query problem? (fetching in loops)
□ Unnecessary re-renders? (React)
□ Large data loaded when only small needed?
□ Missing pagination for large lists?
□ Heavy computation in render/main thread?
□ Assets optimized? (images, fonts)
```

### 5. Scale
```
□ Works with 10 items. Works with 10,000?
□ Hardcoded limits that will break?
□ Database queries indexed?
□ Caching where needed?
```

### 6. Code Quality
```
□ Variable names make sense?
□ No magic numbers? (use constants)
□ No duplicate code? (DRY)
□ Functions do one thing?
□ Comments where logic is complex?
□ No dead code left behind?
```

---

## LANGUAGE-SPECIFIC CHECKS

### JavaScript/TypeScript
```
□ Using === not ==
□ Handling Promise rejections
□ No var (use const/let)
□ Array methods return new array (map, filter) vs mutate (sort, reverse)
□ Async/await errors caught
□ Event listeners cleaned up
```

### Python
```
□ Using `is` for None, `==` for values
□ Mutable default arguments avoided (def foo(x=[]))
□ File handles closed (use `with`)
□ Exceptions specific, not bare `except:`
□ f-strings for formatting
```

### React
```
□ Keys on list items (not index)
□ useEffect dependencies correct
□ State not mutated directly
□ Expensive calculations memoized
□ Event handlers not recreated each render
□ Cleanup in useEffect return
```

### SQL
```
□ Parameterized queries (no string concat)
□ Indexes on WHERE/JOIN columns
□ SELECT only needed columns (not *)
□ LIMIT on large queries
□ Transactions where needed
```

---

## REVIEW OUTPUT FORMAT

After reviewing, report:

```
## Code Review Results

### ✓ Passed
- [What's good about the code]

### ⚠️ Warnings
- [Things that might cause issues]

### ✗ Must Fix
- [Critical issues that will break]

### Suggestions
- [Nice-to-have improvements]
```

---

## COMMON BUGS I SHOULD CATCH

| Bug Pattern | How to Spot |
|-------------|-------------|
| Forgot to await async | Look for Promises used without await |
| Array index out of bounds | Check loops with length-1 |
| Null reference | Check if object exists before .property |
| Wrong comparison | == vs === vs is |
| Forgot error handling | API calls without try/catch |
| State mutation | Array.push instead of [...arr, new] |
| Missing return | Function should return but doesn't |
| Scope issues | Variable defined in wrong scope |
| Event listener leak | Added but never removed |
| Hardcoded values | URLs, IDs, sizes that should be config |

---

## SELF-CHECK BEFORE "DONE"

```
Before saying the code is complete:

□ I actually ran/tested the code
□ I tested with normal input
□ I tested with edge input (empty, large)
□ I checked for the common bugs above
□ I didn't just assume it works because it looks right
```

---

## The Rule

**Code that looks right isn't the same as code that works right.**

Test it. Review it. Then deliver it.
