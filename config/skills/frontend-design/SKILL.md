---
name: frontend-design
description: "PROACTIVE SKILL - Auto-invoke for ANY visual/UI work. Use when: designing screens, creating UI, building websites, making landing pages, dashboards, React components, HTML files, mobile app screens, posters, mockups, prototypes, or modifying any visual interface. Triggers on: 'design', 'create screen', 'build UI', 'make a page', 'draw', 'style', 'layout', 'prototype', 'mockup', 'HTML', 'CSS', 'interface', 'visual', 'app screen'. CRITICAL: Never use emoji as icons - always use Lucide icons."
---

# Frontend Design

**IMPORTANT: This skill should be invoked AUTOMATICALLY whenever the user asks to design, create, build, or modify any visual interface - including mobile app screens, HTML files, prototypes, or mockups.**

Create distinctive, production-grade frontend interfaces. Implement real working code with exceptional attention to aesthetic details and creative choices.

## When to Use This Skill (AUTO-INVOKE)

Invoke this skill when the user mentions ANY of:
- "design a screen" / "design the screen"
- "create a UI" / "build UI"
- "make a page" / "build a page"
- "draw" (in UI context)
- "prototype" / "mockup"
- "HTML" / "CSS" / "styling"
- "mobile app screen"
- "landing page" / "website"
- "dashboard" / "component"
- "interface" / "layout"
- Any visual design work

## Design Philosophy

Before coding, commit to a **BOLD aesthetic direction**:

- **Purpose**: What problem does this solve? Who uses it?
- **Tone**: Pick an extreme—brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian
- **Differentiation**: What makes this UNFORGETTABLE?

## Implementation Standards

### CRITICAL: NEVER Use Emoji as Icons

This is the #1 rule. Emojis look unprofessional in production UI.

```jsx
// WRONG - Never do this
<div className="icon">💀</div>
<span>🔥</span>
<div>⚡</div>

// RIGHT - Always use Lucide
import { Skull, Flame, Zap } from 'lucide-react';
<Skull className="w-6 h-6" />
<Flame className="w-6 h-6" />
<Zap className="w-6 h-6" />
```

### For HTML files (non-React), use Lucide CDN:

```html
<!-- Add to <head> -->
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>

<!-- Use icons like this -->
<i data-lucide="flame"></i>
<i data-lucide="trophy"></i>
<i data-lucide="zap"></i>

<!-- Initialize before </body> -->
<script>
    lucide.createIcons();
</script>
```

### Common Icon Mappings

| Instead of Emoji | Use Lucide Icon |
|------------------|-----------------|
| 🔥 | `flame` |
| ⚡ | `zap` |
| 🏆 | `trophy` |
| ⭐ | `star` |
| 💰 | `dollar-sign` |
| 👤 | `user` |
| 👥 | `users` |
| ⚠️ | `alert-triangle` |
| ✓ ✅ | `check` |
| 🎁 | `gift` |
| 💎 | `gem` |
| 🤖 | `bot` |
| 💡 | `lightbulb` |
| ⚔️ | `swords` |
| 🎮 | `gamepad-2` |
| ☕ | `coffee` |
| 🍕 | `pizza` |
| 🚀 | `rocket` |
| 🔒 | `lock` |
| ← | `arrow-left` |
| → | `arrow-right` |
| ↑ | `arrow-up` |
| ↓ | `arrow-down` |

### Always Use Lucide Icons

```jsx
import {
  Skull, Zap, TrendingUp, Box, Flame, BarChart3,
  Users, DollarSign, AlertTriangle, CheckCircle,
  Trophy, Star, Gift, Gem, Bot, Lightbulb, Swords
} from 'lucide-react';
```

## Dark UI Palette Reference

```jsx
// Backgrounds
bg-slate-900      // Main
bg-slate-800/50   // Cards

// Text
text-white        // Primary
text-slate-300    // Secondary

// Accent
text-purple-400   // Icons, links
bg-purple-500/20  // Icon backgrounds

// Status
text-emerald-400  // Success
text-amber-400    // Warning
text-red-400      // Error
```

## Pre-Delivery Checklist

- [ ] Bold aesthetic direction chosen and executed
- [ ] **NO EMOJI ANYWHERE IN UI** (most important!)
- [ ] All icons are Lucide components or CDN
- [ ] Colors from cohesive palette
- [ ] Typography is distinctive, not generic
- [ ] Lucide initialized if using CDN (`lucide.createIcons()`)
