---
title: "Why Rust?"
date: 2022-04-29T21:34:23-04:00
draft: true
categories:
  - dev
tags:
  - trends
  - rust
---

Every year I look forward to the Stack Overflow Developer survey. There are always interesting imformation related to the tools and trends that are shaping software development. One metric that always catches my eye is the most loved languages. For five years running, Rust has taken the top spot as the most loved programming language. Why is rust so loved, what is it best at, where is it used in industry today?

The image below is captured from the [2021 Developer Survey](https://insights.stackoverflow.com/survey/2021)

![rust most loved](/img/posts/what-is-rust/rust_most_loved.png)

## Origins of Rust

Rust grew out of a personal project by Mozilla Research engineer Graydon Hoare in 2010. Hoare has said that the language was named after rust fungi which is so named for its robustness, a quality prized in systems programming languages.

## Release Cadence

The first Alpha releases of Rust occurred in 2012 with the first stable release in 2015. Since that first stable release, stable point releases are delivered every six weeks, while features are developed in nightly Rust with daily releases, then tested with beta releases that last six weeks.

## Syntax

The syntax of Rust is similar to C and C++

```rust
fn main() {
    println!("Hello, World!");
}
```

## Getting Stated

Rust's documentation is excellent and the installation instructions are no exceptino, I won't attempt to duplicate it here, but there are some highlights that deserve attention.

[rust tooling](https://www.rust-lang.org/tools/install)

### rustup

Rust provides a tool similar to other framework version managers like `nvm` or `rvm`. rustup installs and manages many Rust toolchains and presents them all through a single set of tools installed.

learn more about [rustup](https://rust-lang.github.io/rustup/index.html)


## Sources
https://en.wikipedia.org/wiki/Rust_(programming_language)
