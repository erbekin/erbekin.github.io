+++
title = 'LCG Loop Demo'
date = 2026-11-22T19:00:00+03:00
draft = false
tags = ['math', 'algorithms', 'demo']
summary = "Why a linear congruential generator always ends up in a loop, shown interactively."
+++

A linear congruential generator (LCG) produces numbers with the recurrence

```
X(n+1) = (a * X(n) + c) mod m
```

Play with the parameters below. Click a node to use it as the seed, or press *animate* to watch the walk.

{{< demo src="/demos/lcg-loop/" height="620" title="LCG loop demonstration" >}}

## Why it always loops

There are only `m` possible states (`0 … m-1`) and the next state depends only on the current one. Sooner or later a state repeats, and from then on the sequence cycles forever.

## Tails

If the map is not a bijection (for example `a` shares a factor with `m`), some seeds start on a *tail*: a few transient values that are never visited again before the sequence falls into a shorter cycle. Try the "tail + 2-cycle" preset.

## Full period

The Hull–Dobell theorem says the period is the full `m` exactly when:

1. `c` and `m` are coprime,
2. `a - 1` is divisible by every prime factor of `m`,
3. `a - 1` is divisible by 4 if `m` is divisible by 4.

The demo shows whether your parameters satisfy this.
