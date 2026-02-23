---
name: cinematic-ui-prototyper
description: "Create stunning dark cinematic HTML UI prototypes for apps. Starts with artistic philosophy, maps all screens needed, then produces standalone phone-frame HTML mockups with breathing animations, atmospheric glows, and premium dark aesthetics. Triggers on: 'prototype screens', 'design app UI', 'create mockups', 'draw screens', 'UI prototype', 'app screens', 'phone mockup', 'design prototype', 'screen design', or any request to create visual app screen prototypes."
---

# Cinematic UI Prototyper

Create museum-quality app screen prototypes as standalone HTML files. Each file is a self-contained phone-frame mockup with a dark cinematic aesthetic that feels like a real premium app.

## When to Use

- User wants to prototype app screens before building
- User says "draw the screens", "design the UI", "create mockups", "prototype the app"
- Creating a design system or brand kit for an app
- Visualizing what an app should look like before coding

## The Artistic Philosophy

You are not just making wireframes. You are creating **cinematic experiences**.

> "Standing at crossroads in the dark with just enough light to see the paths ahead."

**Core Principles:**
- **Void as canvas** -- The darkness isn't empty, it's the foundation. Light only where it earns its place.
- **Breathing, not static** -- Subtle animations signal life. A pulsing dot. A drifting glow. The UI feels alive.
- **Atmosphere over decoration** -- Radial gradient glows create mood. Constellation dots suggest vastness. No gratuitous ornament.
- **Typography as hierarchy** -- Display font for power (headings, numbers, scores). Body font for narrative (descriptions, instructions).
- **Color as meaning** -- Every color carries semantic weight. Not decorative, purposeful.

## Process

### Step 1: Screen Mapping

Before touching any HTML, **think comprehensively** about every screen the app needs:

1. List ALL user journeys end-to-end
2. Identify every state (empty, loading, active, error, success)
3. Group screens by flow (onboarding, core loop, settings, profile)
4. Number them for file naming: `10-landing.html`, `20-home.html`, `30-setup.html`...

Present the full screen map to the user for approval before creating files.

### Step 2: Brand Kit First

Before prototyping screens, establish a token system. Create a brand kit that defines:

**Surface Hierarchy** (darkest to lightest):
```css
--void:    /* The abyss. Main background. Near-black. */
--deep:    /* Recessed areas. Slightly lifted. */
--card:    /* Card backgrounds. Content containers. */
--raised:  /* Elevated cards. Hover states. */
--surface: /* Interactive surfaces. Inputs. */
--hover:   /* Hover/active states. */
```

**Semantic Colors:**
```css
--primary:  /* Main brand accent */
--secondary: /* Secondary accent */
--success:  /* Positive outcomes */
--danger:   /* Negative outcomes, deaths */
--warning:  /* Caution, medium states */
--info:     /* Information, tips */
```

**Text Hierarchy:**
```css
--white:   /* Primary text. High contrast. */
--ash:     /* Secondary text. Body copy. */
--smoke:   /* Tertiary. Labels, meta. */
--shadow:  /* Lowest contrast. Timestamps. */
```

**Typography:**
- Pick a **display font** (geometric/bold) for headings, numbers, scores
- Pick a **body font** (humanist/readable) for narrative text, descriptions
- Load from Google Fonts

### Step 3: Create Prototypes

Each HTML file is a standalone page showing one or more phone frames side-by-side.

## Phone Frame Template

```
Width: 375px
Height: 812px (iPhone viewport)
Border-radius: 40px
Border: 1px solid rgba(255,255,255,0.06)
Background: var(--void)
Notch: CSS ::before pseudo-element (150px wide, 34px tall, centered)
Overflow-y: auto (for scrollable screens)
```

When showing multiple states (e.g., "decision" and "consequence"), place frames side-by-side with labels above.

## Atmosphere Techniques

### Breathing Dots
Small colored circles that pulse. Signal active state or connection.
```css
@keyframes breathe {
  0%, 100% { opacity: 0.4; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.4); }
}
.breath-dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  background: var(--primary);
  animation: breathe 3s ease-in-out infinite;
}
```

### Radial Gradient Glows
Subtle colored gradients that create mood behind content.
```css
.atmosphere-glow {
  position: absolute;
  width: 400px; height: 400px;
  background: radial-gradient(circle, rgba(COLOR, 0.06) 0%, transparent 70%);
  animation: breathe 5s ease-in-out infinite;
}
```

### Constellation Backgrounds
SVG dots connected by hair-thin lines. Suggest depth and scale.
```html
<svg class="constellation" viewBox="0 0 375 812">
  <circle cx="80" cy="220" r="2" fill="rgba(255,255,255,0.04)"/>
  <line x1="80" y1="220" x2="290" y2="180" stroke="rgba(255,255,255,0.02)" stroke-width="0.3"/>
</svg>
```

### Sheen Button Animation
A light sweep across buttons for premium feel.
```css
@keyframes sheen {
  0%, 100% { transform: translateX(-100%); }
  50% { transform: translateX(100%); }
}
.btn-primary::after {
  content: '';
  position: absolute; inset: 0;
  background: linear-gradient(135deg, transparent 40%, rgba(255,255,255,0.1) 50%, transparent 60%);
  animation: sheen 3s ease-in-out infinite;
}
```

### Shimmer (Progress Bars)
Moving highlight on filled bars.
```css
@keyframes shimmer {
  0% { transform: translateX(-100%); }
  100% { transform: translateX(200%); }
}
```

### Flatline (Death/End States)
SVG polyline that goes from heartbeat to flat, with scattered dots that fade. Use for failure/death screens.

## Icon Rules

**NEVER use emoji.** Always inline SVG.

```html
<!-- WRONG -->
<span>🔥</span>

<!-- RIGHT -->
<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/>
</svg>
```

Common inline SVG patterns needed: bolt, house, user, gear, arrow-left, chevron-right, check, x-mark, star, heart, dollar-sign, trending-up, shield, coffee, download, share.

## Card Pattern

```css
.card {
  background: var(--card);
  border: 1px solid rgba(255,255,255,0.04);
  border-radius: 12px;
  padding: 14px 16px;
}
```

Variation with accent border (for emphasis):
```css
.card-accent {
  border-left: 3px solid var(--primary);
}
```

## Bottom Navigation

4-5 tabs with SVG icons + 9px labels. Active tab gets the section's semantic color.

```css
.bottom-nav {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  height: 72px;
  background: var(--deep);
  border-top: 1px solid rgba(255,255,255,0.04);
  display: flex;
  align-items: center;
  justify-content: space-around;
  padding-bottom: 8px; /* safe area */
}
```

## Stat Display Pattern

For game stats, scores, or KPIs -- use "vital signs" style:
```
[colored number] [tiny uppercase label]
```
Numbers in font-display bold. Labels in 9-10px smoke uppercase. Separated by hairline dividers or spaced in a flex row.

## Gradient Text

```css
.gradient-text {
  background: linear-gradient(135deg, var(--primary), var(--secondary), var(--warning));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
```

## File Naming Convention

```
{number}-{screen-name}.html
```
Numbers in tens for grouping:
- 10-19: Onboarding/Landing
- 20-29: Home/Dashboard
- 30-39: Setup/Configuration
- 40-49: Core Gameplay/Main Flow
- 50-59: Results/Debrief
- 60-69: Analysis/Reports
- 70-79: Profile/History
- 80-89: Settings
- 90-99: Social/Misc

## Parallel Creation

When creating multiple prototype files, launch parallel agents (3-4 at a time) to build them simultaneously. Give each agent the full brand kit tokens and design specifications.

## Quality Checklist

Before delivering prototypes:
- [ ] Every screen uses the brand token system (no hardcoded colors)
- [ ] Zero emoji -- all icons are inline SVG
- [ ] Phone frame is 375x812 with notch and rounded corners
- [ ] At least one breathing animation per screen
- [ ] Atmosphere glow on key screens
- [ ] Typography uses both display and body fonts appropriately
- [ ] Multiple states shown where relevant (empty, active, error)
- [ ] Real sample data, not "Lorem ipsum"
- [ ] Cards follow the standard pattern (card bg + rgba border)
- [ ] Buttons have sheen animation
- [ ] Google Fonts loaded in head
