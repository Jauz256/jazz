---
name: task-memory-tracker
description: Use this skill for ANY multi-step task or long conversation. Prevents losing track of requirements when conversation is long, compacted, or interrupted by questions. Forces explicit tracking of what was requested vs what was delivered. Triggers on complex tasks, multi-file changes, or when user says "build", "create", "fix", "implement", or gives a list of requirements.
---

# Task Memory Tracker

**Problem this solves:**
- Long conversations get compacted → context lost
- User asks clarifying questions → AI gets distracted from main task
- AI says "done" but missed parts
- AI doesn't realize it missed things

---

## PHASE 1: Capture Original Request

At the START of any task, write this down explicitly:

```
## TASK CAPTURE
Original Request: [Copy user's exact words]
Date Started: [Now]

Requirements Extracted:
□ 1. [First thing user wants]
□ 2. [Second thing user wants]
□ 3. [Third thing user wants]
...

Success Criteria:
- [ ] [How we know #1 is done]
- [ ] [How we know #2 is done]
- [ ] [How we know #3 is done]
```

**IMPORTANT:** Write this in a code block so it survives conversation compaction.

---

## PHASE 2: Track During Work

After EVERY significant action, update status:

```
## PROGRESS TRACKER
□ Requirement 1: [Status: NOT STARTED / IN PROGRESS / DONE / BLOCKED]
  - What was done: [Description]
  - What remains: [Description]

□ Requirement 2: [Status]
  - What was done: [Description]
  - What remains: [Description]

Current Focus: [What I'm working on now]
Parked Items: [Things I'll come back to]
```

---

## PHASE 3: Handle Interruptions

When user asks a question mid-task:

```
## INTERRUPTION LOGGED
User asked: [Question]
My answer: [Brief answer]

⚠️ RETURNING TO MAIN TASK:
- Was working on: [What]
- Next step: [What]
- Still remaining: [List uncompleted requirements]
```

**NEVER forget the main task when answering questions.**

---

## PHASE 4: Pre-Completion Checklist

BEFORE saying "done", run this checklist:

```
## COMPLETION VERIFICATION

Original Requirements vs Delivered:

| # | Requirement | Delivered? | Evidence |
|---|-------------|------------|----------|
| 1 | [What user asked] | ✓/✗ | [Where/how it's done] |
| 2 | [What user asked] | ✓/✗ | [Where/how it's done] |
| 3 | [What user asked] | ✓/✗ | [Where/how it's done] |

Questions user asked during task:
- Q: [Question] → Did this change requirements? [Yes/No]
- Q: [Question] → Did this change requirements? [Yes/No]

Files created/modified:
- [File 1]: [What was done]
- [File 2]: [What was done]

MISSING ITEMS: [List anything not delivered]

Ready to say "done"?
□ All original requirements have ✓
□ All user questions addressed
□ No MISSING ITEMS
□ Tested/verified the output
```

---

## PHASE 5: Final Summary

When truly complete, provide:

```
## TASK COMPLETE

### What You Asked For:
1. [Requirement 1]
2. [Requirement 2]

### What I Delivered:
1. ✓ [How #1 was fulfilled] - [File/location]
2. ✓ [How #2 was fulfilled] - [File/location]

### Changes Made During Task:
- [Any scope changes from your questions]

### Files:
- [File 1]: [Purpose]
- [File 2]: [Purpose]

### How to Use:
[Brief instructions]

### Not Done (if any):
- [Anything explicitly descoped or blocked]
```

---

## Memory Management Rules

### Rule 1: Write It Down
Don't keep requirements in "memory" - write them in a code block that survives compaction.

### Rule 2: Re-read Before "Done"
Before saying complete, scroll back (or re-read summary) to check original request.

### Rule 3: Track Scope Changes
If user's questions change the requirements, explicitly note:
```
SCOPE CHANGE: Originally [X], now [Y] because user said [Z]
```

### Rule 4: Admit Uncertainty
If conversation was compacted and you're unsure what was originally requested:
```
⚠️ CONTEXT CHECK
The conversation was long. Let me verify I haven't missed anything.
Original task was: [What I remember]
Is this correct? Did I miss anything?
```

### Rule 5: Count Deliverables
If user asked for 5 things, count that you delivered 5 things. Not 4. Not 3. All 5.

---

## When to Use This Skill

- Any task with 3+ requirements
- Any task that takes multiple messages to complete
- Any task where user asks questions mid-work
- After conversation compaction
- When you're unsure if you missed something

---

## Quick Version (Minimum)

For shorter tasks, at minimum do:

```
TASK: [What user wants]
DELIVERING:
□ [Item 1]
□ [Item 2]
□ [Item 3]

[... do the work ...]

DONE CHECK:
✓ [Item 1] - delivered in [location]
✓ [Item 2] - delivered in [location]
✓ [Item 3] - delivered in [location]
All items delivered? [YES/NO]
```

---

## Example

**User:** "Create a login page with email validation, password strength meter, and remember me checkbox"

**AI Response:**
```
## TASK CAPTURE
Original Request: "Create a login page with email validation, password strength meter, and remember me checkbox"

Requirements:
□ 1. Login page UI
□ 2. Email validation
□ 3. Password strength meter
□ 4. Remember me checkbox

Success Criteria:
- [ ] Page renders with all fields
- [ ] Invalid email shows error
- [ ] Password shows strength indicator
- [ ] Checkbox exists and works
```

[... work happens, user asks "what library for validation?" ...]

```
## INTERRUPTION LOGGED
User asked: What library for validation?
My answer: Using built-in HTML5 + custom regex

⚠️ RETURNING TO MAIN TASK:
- Was working on: Email validation
- Next step: Password strength meter
- Still remaining: Password meter, Remember me checkbox
```

[... more work ...]

```
## COMPLETION VERIFICATION

| # | Requirement | Delivered? | Evidence |
|---|-------------|------------|----------|
| 1 | Login page UI | ✓ | login.html created |
| 2 | Email validation | ✓ | Line 23-30, validates on blur |
| 3 | Password strength meter | ✓ | Line 45-60, shows weak/medium/strong |
| 4 | Remember me checkbox | ✓ | Line 72, saves to localStorage |

MISSING ITEMS: None

Ready to say "done"? ✓ All requirements delivered
```

---

## The Rule

**Don't trust your memory. Write it down. Check it twice.**
