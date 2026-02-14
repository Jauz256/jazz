---
name: web-artifacts-builder
description: Suite of tools for creating elaborate, multi-component claude.ai HTML artifacts using modern frontend web technologies (React, Tailwind CSS, shadcn/ui). Use for complex artifacts requiring state management, routing, or shadcn/ui components - not for simple single-file HTML/JSX artifacts.
---

# Web Artifacts Builder

Build powerful frontend claude.ai artifacts.

## Steps
1. Initialize the frontend repo
2. Develop your artifact
3. Bundle into single HTML file
4. Display artifact to user

**Stack**: React 18 + TypeScript + Vite + Parcel + Tailwind CSS + shadcn/ui

## Design Guidelines

**AVOID "AI slop":**
- No excessive centered layouts
- No purple gradients
- No uniform rounded corners
- No Inter font everywhere

## Quick Start

### Step 1: Initialize
```bash
bash scripts/init-artifact.sh <project-name>
cd <project-name>
```

Creates:
- React + TypeScript (via Vite)
- Tailwind CSS 3.4.1 with shadcn/ui
- Path aliases (@/) configured
- 40+ shadcn/ui components
- Parcel for bundling

### Step 2: Develop
Edit the generated files.

### Step 3: Bundle
```bash
bash scripts/bundle-artifact.sh
```

Creates `bundle.html` - self-contained with all JS, CSS, dependencies inlined.

### Step 4: Share
Share the bundled HTML file as an artifact.

## Reference
- shadcn/ui components: https://ui.shadcn.com/docs/components
