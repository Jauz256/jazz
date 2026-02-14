---
name: error-handling-patterns
description: Master error handling patterns across languages including exceptions, Result types, error propagation, and graceful degradation to build resilient applications. Use when implementing error handling, designing APIs, or improving application reliability.
---

# Error Handling Patterns

Build resilient applications with robust error handling strategies.

## When to Use This Skill

- Implementing error handling in new features
- Designing error-resilient APIs
- Debugging production issues
- Improving application reliability

## Error Handling Philosophies

**Exceptions vs Result Types:**
- **Exceptions**: Traditional try-catch, disrupts control flow
- **Result Types**: Explicit success/failure, functional approach

**When to Use Each:**
- Exceptions: Unexpected errors, exceptional conditions
- Result Types: Expected errors, validation failures
- Panics/Crashes: Unrecoverable errors, programming bugs

## Universal Patterns

### Pattern 1: Circuit Breaker
Prevent cascading failures in distributed systems.

### Pattern 2: Error Aggregation
Collect multiple errors instead of failing on first error.

### Pattern 3: Graceful Degradation
Provide fallback functionality when errors occur.

## Best Practices

1. **Fail Fast**: Validate input early, fail quickly
2. **Preserve Context**: Include stack traces, metadata, timestamps
3. **Meaningful Messages**: Explain what happened and how to fix it
4. **Log Appropriately**: Error = log, expected failure = don't spam logs
5. **Handle at Right Level**: Catch where you can meaningfully handle
6. **Clean Up Resources**: Use try-finally, context managers, defer
7. **Don't Swallow Errors**: Log or re-throw, don't silently ignore

## Common Pitfalls

- **Catching Too Broadly**: `except Exception` hides bugs
- **Empty Catch Blocks**: Silently swallowing errors
- **Poor Error Messages**: "Error occurred" is not helpful
