---
name: writing-skills
description: Use when creating, editing, or improving skills for AI agents. Applies TDD methodology to documentation—write test scenarios first, watch agents fail, then write the skill. Triggers on "create a skill", "write a skill", "improve this skill", or any skill authoring task.
---

# Writing Skills

Create effective skills using Test-Driven Development for documentation.

**Core principle:** If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing.

## What Skills Are

**Skills ARE:** Reusable techniques, patterns, tools, reference guides, concrete methods with steps to follow.

**Skills are NOT:** Narratives about how you solved a problem once.

## The RED-GREEN-REFACTOR Cycle

### RED Phase - Establish Baseline
1. Identify specific scenarios where agents struggle
2. Run scenarios WITHOUT skill
3. Document failures

### GREEN Phase - Write Minimal Skill
1. Create skill with proper structure
2. Address ONLY the specific baseline failures
3. Run scenarios WITH skill—verify compliance

### REFACTOR Phase - Close Loopholes
1. Identify NEW rationalizations from testing
2. Add explicit counters for each rationalization
3. Re-test until bulletproof

## Skill Structure

```
skills/
  skill-name/
    SKILL.md          # Main reference (required)
    supporting-file.* # Only if needed
```

### Frontmatter (YAML)

```yaml
---
name: skill-name-with-hyphens
description: Use when [specific triggering conditions and symptoms]
---
```

## Deployment Checklist

- [ ] RED: Ran baseline scenario, documented failures
- [ ] GREEN: Wrote minimal skill addressing failures
- [ ] REFACTOR: Closed loopholes found in testing
- [ ] Description starts with "Use when..."
- [ ] Tested with fresh agent/subagent
