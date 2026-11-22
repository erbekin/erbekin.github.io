+++
title = 'Interactive Tape Canvas'
date = 2026-11-22T18:32:00+03:00
draft = false
tags = ['javascript', 'canvas', 'web']
summary = "A small canvas experiment: click to shoot a colored tape across the screen."
+++

An earlier experiment: a full-screen canvas where each click sends a coloured square sliding across the screen. The colour is derived from the click position.

```javascript
static getRandomColor(clickX, clickY) {
  const r = Math.floor((clickX / canvas.width) * 255);
  const g = Math.floor((clickY / canvas.height) * 255);
  const b = Math.floor(((clickX + clickY) / (canvas.width + canvas.height)) * 255);
  return `rgb(${r}, ${g}, ${b})`;
}
```

The orientation (horizontal/vertical), direction, width and position are random; clicks during an animation are ignored.
