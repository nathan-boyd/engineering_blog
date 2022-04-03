---
title: "Client side syntax highlighting in Hugo"
date: 2022-04-02T20:18:56-04:00
categories:
  - blog
tags:
  - dev ops
---

There are existing docs about [Hugo Syntax Highliting](https://gohugo.io/content-management/syntax-highlighting/). They indicate that generating style sheets for syntax highlighting may be required but they don't present a complete picture. This is an attempt to create that picture.

Changes to `config.yaml`

``` yaml
pygmentsCodefences: true
pygmentsCodefencesGuessSyntax: true
pygmentsStyle: "monokai"
```

Create a directory for the code highlighting css

``` shell
mkdir static/css
```

Generate the syntax highlighting style sheet.

``` shell
hugo gen chromastyles --style=monokai > static/css/syntax.css
```
