+++
title = 'Hello World'
date = 2026-11-22T18:31:00+03:00
draft = false
tags = ['meta', 'hugo']
summary = "This blog is now a minimal Hugo static site."
+++

Welcome! This site is built with [Hugo](https://gohugo.io/) and kept deliberately plain: text, a few links, nothing else.

## How it works

- Source lives on the `main` branch.
- `deploy.ps1` builds the site and publishes the output to the `gh-pages` branch.
- The previous React build is preserved on the `gh-page-old` branch.

```powershell
hugo new content posts/my-post.md
./deploy.ps1
```
