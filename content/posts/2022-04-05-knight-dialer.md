---
title: "Knight Dialer"
date: 2022-04-05T18:47:36-04:00
draft: true
categories:
  - dev
  - challenges
tags:
  - python
  - interviewing
---

The knight in chess has a unique movement, it may move two squares vertically and one square horizontally, or two squares horizontally and one square vertically (with both forming the shape of an L). Given a chess knight and a phone pad as shown below, the knight can only stand on a numeric cell

```
1 2 3
4 5 6
7 9 0
* 0 #
```

Given an integer n, return how many distinct phone numbers of length n we can dial. You are allowed to place the knight on any numeric cell initially and then you should perform n - 1 jumps to dial a number of length n. All jumps should be valid knight jumps. As the answer may be very large, return the answer modulo 109 + 7.

## Examples

```
Example 1:

Input: n = 1
Output: 10
Explanation: We need to dial a number of length 1, so placing the knight over any numeric cell of the 10 cells is sufficient.
Example 2:

Input: n = 2
Output: 20
Explanation: All the valid number we can dial are [04, 06, 16, 18, 27, 29, 34, 38, 40, 43, 49, 60, 61, 67, 72, 76, 81, 83, 92, 94]

Example 3:

Input: n = 3131
Output: 136006598
Explanation: Please take care of the mod.
```

## Intuition

There is an excellent [blog post](https://medium.com/hackernoon/google-interview-questions-deconstructed-the-knights-dialer-f780d516f029) written by a former Google Interview Alex Golec. His experience with this problem is invaluable and a must read to best understand this question.

We need to be able to derive our legal moves from any given location on the key pad, a map would be appropriate

```
neighbors_map = {
    0: (4, 6),
    1: (6, 8),
    2: (7, 9),
    3: (4, 8),
    4: (0, 3, 9),
    5: (),
    6: (0, 1, 7),
    7: (2, 6),
    8: (1, 3),
    9: (2, 4)
}

def neighbors(position):
    return NEIGHBORS_MAP[position]
```

A naive solution, generating all numbers and counting them

``` python
def yield_sequences(starting_position, num_hops, sequence=None):
    if sequence is None:
        sequence = [starting_position]

    if num_hops == 0:
        yield sequence
        return

    for neighbor in neighbors(starting_position):
        yield from yield_sequences(
            neighbor, num_hops - 1, sequence + [neighbor])

def count_sequences(starting_position, num_hops):
    num_sequences = 0
    for sequence in yield_sequences(starting_position, num_hops):
        num_sequences += 1
    return num_sequences
```

We could generate all the numbers and count them, but we dont actually use the numbers so why generate them when all we need is a count. If we count of numbers that can be generated from a given starting position in N hops is equal to the sum of the counts of hops that can be generated starting from each of its neighbors in N-1 hops. Stated mathematically as a recurrence relation.

Once you have this insight in hand, you can already move forward and solve this problem again. There are a number of implementations that use this fact, but let’s start with the one I see most often in interviews: the naive recursive approach:

A new naive solution

``` python
from neighbors import neighbors

def count_sequences(start_position, num_hops):
    if num_hops == 0:
        return 1

    num_sequences = 0
    for position in neighbors(start_position):
        num_sequences += count_sequences(position, num_hops - 1)
    return num_sequences

if __name__ == '__main__':
    print(count_sequences(6, 2))
```

The previous solution with memoizaion

``` python
def count_sequences(start_position, num_hops):
    cache = {}

    def helper(position, num_hops):
        if (position, num_hops) in cache:
            return cache[ (position, num_hops) ]

        if num_hops == 0:
            return 1

        else:
            num_sequences = 0
            for neighbor in neighbors(position):
                num_sequences += helper(neighbor, num_hops - 1)
            cache[ (position, num_hops) ] = num_sequences
            return num_sequences

    res = helper(start_position, num_hops)
    return res
```

A solution with Dynamic Programming

``` python
def neighbors(self, n: int) -> int:
    num_keys = 10
    all_jumps = [1] * num_keys

    for _ in range(n - 1):
        local_jumps = [0] * num_keys
        for i in self.neighbors_map:
            for j in self.neighbors_map[i]:
                local_jumps[i] += all_jumps[j]
        all_jumps = local_jumps

    return sum(all_jumps) % (10 ** 9 + 7)
```
