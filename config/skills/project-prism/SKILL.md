---
name: project-prism
description: CS student visualization toolkit with 9 lenses - Canvas (overview cards), Tech Tree (codebase), Flow (algorithms), Data Flow (pipelines), Sequence (interactions), Architecture (system design), Graph (dependencies), State (state machines), Timeline (roadmap). Triggers on "visualize", "diagram", "flowchart", "architecture", "state machine", or any visualization request.
---

# Project Prism

**9 lenses to visualize any CS concept.**

## All 9 Lenses

| # | Lens | Purpose | Example |
|---|------|---------|---------|
| 1 | **Canvas** | Cards grouped by layer | Feature overview |
| 2 | **Tech Tree** | Hierarchical circles | Codebase structure |
| 3 | **Flow** | Flowchart shapes | Algorithms, control flow |
| 4 | **Data Flow** | Data movement arrows | Request/response |
| 5 | **Sequence** | Time-based messages | API interactions |
| 6 | **Architecture** | Swim lane layers | System design |
| 7 | **Graph** | Force-directed network | Dependencies |
| 8 | **State** | State machine circles | UI states, protocols |
| 9 | **Timeline** | Phases + milestones | Project roadmap |

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `1-9` | Switch lens |
| `D` | Toggle dark/light theme |
| `F` | Fit to screen |
| `E` | Expand all (Tech Tree) |
| `C` | Collapse all (Tech Tree) |
| `V/H/R` | Layout (Tech Tree only) |
| `Esc` | Close detail panel |

## Data Structure

```javascript
const projectData = {
  meta: { name: "Project", description: "..." },

  // 1. Canvas
  canvas: {
    layers: [{ id: "core", name: "Core", color: "#8b5cf6" }],
    cards: [{ id: "auth", layer: "core", title: "Auth", icon: "lock", description: "...", tags: ["JWT"] }]
  },

  // 2. Tech Tree
  techTree: {
    name: "Root", type: "core", icon: "layers", color: "#8b5cf6",
    tech: ["Tech1"], description: "...",
    children: [...]
  },

  // 3. Flow
  flowChart: {
    nodes: [{ id: "start", type: "start|process|decision|io|error|end", label: "Start", x: 400, y: 50 }],
    connections: [{ from: "start", to: "process", label: "Yes" }]
  },

  // 4. Data Flow
  dataFlow: {
    nodes: [{ id: "client", label: "Client", icon: "monitor", x: 100, y: 200, type: "source|process|store" }],
    flows: [{ from: "client", to: "api", label: "Request" }]
  },

  // 5. Sequence
  sequence: {
    actors: [{ id: "user", label: "User", icon: "user" }],
    messages: [{ from: "user", to: "api", label: "Login", type: "sync|reply|async" }]
  },

  // 6. Architecture
  architecture: {
    zones: [{ id: "client", name: "Client Layer", y: 0, height: 120, color: "#3b82f620" }],
    nodes: [{ id: "web", zone: "client", label: "Web", icon: "globe", x: 150, tech: ["React"] }],
    connections: [{ from: "web", to: "api" }]
  },

  // 7. Graph (force-directed with icons, hover highlighting)
  graph: {
    nodes: [{ id: "react", label: "React", group: "frontend|backend|data", size: 30 }],
    links: [{ source: "react", target: "redux" }]
    // Features: curved gradient links, icons inside nodes, connected node highlighting on hover
  },

  // 8. State Machine (with icons, bidirectional transitions, self-loops)
  stateMachine: {
    states: [{ id: "idle", label: "Idle", type: "initial|normal|final|error", x: 100, y: 200 }],
    transitions: [{ from: "idle", to: "loading", label: "FETCH" }]
    // Features: state icons, curved transitions, bidirectional support, entry arrows for initial state
  },

  // 9. Timeline
  timeline: {
    phases: [{ id: "q1", name: "Q1", start: 0, duration: 3, color: "#3b82f6" }],
    milestones: [{ id: "m1", label: "MVP", month: 2, icon: "flag" }],
    tasks: [{ id: "t1", label: "Design", phase: "q1", row: 0 }]
  }
};
```

## Node Colors

| Type | Color | Hex |
|------|-------|-----|
| Core/Initial | Purple | #8b5cf6 |
| Frontend/Source | Blue | #3b82f6 |
| Backend/Process | Green | #22c55e |
| Data/Store | Orange | #f97316 |
| External | Cyan | #06b6d4 |
| Error | Red | #ef4444 |
| Success/Final | Emerald | #10b981 |

## Lens Features

### Graph Lens
- **Force-directed layout** with draggable nodes
- **Gradient curved links** between connected nodes
- **Icons inside nodes** based on group (monitor, server, database)
- **Hover highlighting** - connected nodes highlight, others dim
- **Node size** determines visual importance

### State Machine Lens
- **State icons** based on type (play, circle-dot, flag, alert-triangle)
- **Curved transitions** with smart bidirectional handling
- **Initial state entry arrow** (small circle → first state)
- **Double ring** for final states
- **Labels in boxes** for better readability
- **Click to see** incoming/outgoing transitions

## Usage

1. Copy `template.html`
2. Replace `projectData` with your data
3. Update title
4. Save as `[project]-prism.html`
5. Open in browser
