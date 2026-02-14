---
name: fibercoder-mindmap
description: Simple tech tree/mind map visualizations using circle nodes. Use for codebase architecture, project structure, or system dependency diagrams. Triggers on "tech tree", "mind map", "codebase map", "project structure". For full 7-lens visualization (Canvas, Timeline, Flow, Journey, etc.), use project-prism instead.
---

# Fibercoder Mind Map

Create interactive tech tree visualizations for codebases and projects using circle nodes in a mind-map style.

## When to Use

- Visualize project architecture
- Create tech stack mind maps
- Map codebase structure
- Show system dependencies
- Generate architecture diagrams

## Template Location

Use `tech-tree-template.html` as the base template.

## Data Structure

```javascript
const techTreeData = {
  name: "Root Node",
  type: "core",           // core | frontend | backend | data | infra | flow
  icon: "layers",         // Lucide icon name
  color: "#8b5cf6",       // Node color (hex)
  tech: ["Tech1", "Tech2"], // Shows as satellites when expanded
  badges: ["Tag1", "Tag2"], // Optional tags
  description: "What this node represents",
  children: [...]         // Nested children (recursive)
};
```

## Node Types & Colors

| Type | Color | Use For |
|------|-------|---------|
| core | #8b5cf6 (purple) | Root/main system |
| frontend | #3b82f6 (blue) | UI, client apps |
| backend | #22c55e (green) | APIs, services |
| data | #f97316 (orange) | Databases, storage |
| infra | #8b5cf6 (purple) | External services, cloud |
| flow | #06b6d4 (cyan) | Processes, workflows |

## Layout Options

- **Vertical**: Top-down tree
- **Horizontal**: Left-to-right tree (default)
- **Radial**: Circular/radial layout

## Features

- Click nodes to expand/collapse
- Tech satellites orbit expanded nodes
- Detail panel shows full info
- Zoom and pan controls
- Expand All / Collapse All buttons

## Workflow

1. Analyze the codebase/project
2. Create hierarchical data structure
3. Copy template and customize:
   - Update `techTreeData` with project info
   - Adjust title and branding colors
4. Save as `[project]-tech-tree.html`
5. Open in browser

## Example Usage

```
User: "Create a tech tree for my project"

1. Explore the codebase structure
2. Identify main components (frontend, backend, services, data)
3. Map technologies used in each component
4. Generate techTreeData structure
5. Create HTML file from template
```
