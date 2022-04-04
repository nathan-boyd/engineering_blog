---
title: "Big O with Examples"
date: 2022-04-04T08:33:50-04:00
draft: true
---

## Summary

Big O notation is a way to talk about the complexity or resource utilization of an algorithm. It's commonly used to describe the worst, best, and average cases and compare one algorithm against another.

Often

The table below illustrates how the number of inputs can drive very large complexity.

| n    | Ω(log n) | Ω(n log n) | Ω(n<sup>2</sup>) | Ω(n!)       | Ω(n<sup>n</sup>) |
|------|----------|------------|------------------|-------------|------------------|
| 1    | 0        | 0          | 1                | 1           | 1                |
| 4    | 2        | 8          | 16               | 24          | 256              |
| 16   | 4        | 64         | 256              | 2 × 10^13   | 1 × 10^19        |
| 64   | 6        | 384        | 4096             | 1 × 10^89   | 3 × 10^115       |
| 256  | 8        | 2048       | 65536            | 8 × 10^506  | 3 × 10^616       |
| 1024 | 10       | 10240      | 1048576          | 5 × 10^2639 | 3 × 10^3082      |

## Estimating Big O

Small numbers fall away

## Examples

### Ω(1)

Ω(1) is constant "C" or fixed time, meaning that the operation is independent of the number of inputs. "Look up" operations like the following are good examples of constant time operations. Looking up a value in an array of 10 or 1000 are functionally equivalent. Other examples include the array push and pop functions.


``` python
def get_value(input, key):
    return input[key]
```

### Ω(log n)

``` python
```

### Ω(n)

``` python
```

### Ω(n log n)

``` python
```

### Ω(n<sup>2</sup>)

``` python
```

### Ω(n!)

``` python
```

### Ω(2<sup>n</sup>)

``` python
```
