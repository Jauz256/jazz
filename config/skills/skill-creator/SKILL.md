---
name: skill-creator
description: Guide for creating effective skills. This skill should be used when users want to create a new skill (or update an existing skill) that extends Claude's capabilities with specialized knowledge, workflows, or tool integrations.
---

# Skill Creator

Create effective skills that extend Claude's capabilities.

## Core Principles

### Concise is Key
Context window is shared. Only add what Claude doesn't already have. Challenge each piece: "Does Claude really need this?"

### Degrees of Freedom
- **High freedom**: Multiple approaches valid, use text instructions
- **Medium freedom**: Preferred pattern exists, use pseudocode
- **Low freedom**: Operations fragile, use specific scripts

## Skill Anatomy

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/     - Executable code
    ├── references/  - Documentation
    └── assets/      - Templates, icons, fonts
```

## Creation Process

### Step 1: Understand with Examples
- "What functionality should the skill support?"
- "Can you give examples of how this would be used?"

### Step 2: Plan Contents
Analyze each example:
1. How to execute from scratch
2. What scripts/references/assets would help

### Step 3: Initialize
```bash
scripts/init_skill.py <skill-name> --path <output-directory>
```

### Step 4: Edit the Skill
Include information beneficial and non-obvious to Claude.

**Frontmatter:**
- `name`: Skill name
- `description`: What it does AND when to use it (triggers)

### Step 5: Package
```bash
scripts/package_skill.py <path/to/skill-folder>
```

### Step 6: Iterate
Use skill → Notice struggles → Update → Test again
