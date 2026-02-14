---
name: algorithmic-art
description: Creating algorithmic art using p5.js with seeded randomness and interactive parameter exploration. Use this when users request creating art using code, generative art, algorithmic art, flow fields, or particle systems. Create original algorithmic art rather than copying existing artists' work to avoid copyright violations.
---

# Algorithmic Art

Create algorithmic philosophies expressed through code. Output .md files (philosophy), .html files (interactive viewer), and .js files (generative algorithms).

## Two Steps
1. Algorithmic Philosophy Creation (.md file)
2. Express by creating p5.js generative art (.html + .js files)

## Philosophy Creation

Create a VISUAL PHILOSOPHY interpreted through:
- Computational processes, emergent behavior, mathematical beauty
- Seeded randomness, noise fields, organic systems
- Particles, flows, fields, forces
- Parametric variation and controlled chaos

**Name the movement** (1-2 words): "Organic Turbulence" / "Quantum Harmonics"

**Articulate the philosophy** (4-6 paragraphs):
- Computational processes and mathematical relationships
- Noise functions and randomness patterns
- Particle behaviors and field dynamics
- Temporal evolution and system states

## P5.js Implementation

**Seeded Randomness:**
```javascript
let seed = 12345;
randomSeed(seed);
noiseSeed(seed);
```

**Required Features:**
1. Parameter Controls - Sliders for numeric parameters
2. Seed Navigation - Previous/Next/Random buttons
3. Single Artifact Structure - Self-contained HTML

**Technical Requirements:**
- Use p5.js from CDN: https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.7.0/p5.min.js
- All code inline in HTML
- Regenerate, Reset, Download buttons
