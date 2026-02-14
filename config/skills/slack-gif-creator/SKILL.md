---
name: slack-gif-creator
description: Knowledge and utilities for creating animated GIFs optimized for Slack. Provides constraints, validation tools, and animation concepts. Use when users request animated GIFs for Slack like "make me a GIF of X doing Y for Slack."
---

# Slack GIF Creator

Toolkit for creating animated GIFs optimized for Slack.

## Slack Requirements

**Dimensions:**
- Emoji GIFs: 128x128 (recommended)
- Message GIFs: 480x480

**Parameters:**
- FPS: 10-30 (lower = smaller file)
- Colors: 48-128 (fewer = smaller file)
- Duration: Under 3 seconds for emoji

## Core Workflow

```python
from core.gif_builder import GIFBuilder
from PIL import Image, ImageDraw

builder = GIFBuilder(width=128, height=128, fps=10)

for i in range(12):
    frame = Image.new('RGB', (128, 128), (240, 248, 255))
    draw = ImageDraw.Draw(frame)
    # Draw animation using PIL primitives
    builder.add_frame(frame)

builder.save('output.gif', num_colors=48, optimize_for_emoji=True)
```

## Drawing Graphics

Use PIL ImageDraw primitives:
```python
draw.ellipse([x1, y1, x2, y2], fill=(r, g, b), width=3)
draw.polygon(points, fill=(r, g, b), width=3)
draw.line([(x1, y1), (x2, y2)], fill=(r, g, b), width=5)
draw.rectangle([x1, y1, x2, y2], fill=(r, g, b), width=3)
```

**Don't use:** Emoji fonts (unreliable across platforms)

## Animation Concepts

- **Shake**: Offset position with sin/cos oscillation
- **Pulse**: Scale size with sin wave (0.8 to 1.2)
- **Bounce**: Use ease_out for landing, ease_in for falling
- **Spin**: `image.rotate(angle, resample=Image.BICUBIC)`
- **Fade**: Adjust alpha channel or use Image.blend
- **Slide**: Start off-screen, use ease_out for smooth stop

## Dependencies
```bash
pip install pillow imageio numpy
```
