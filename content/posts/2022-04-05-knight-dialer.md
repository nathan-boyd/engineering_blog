---
title: "Knight Dialer"
date: 2022-04-05T18:47:36-04:00
categories:
  - dev
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

``` python
paths = {
    -1: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    0: [4, 6],
    1: [6, 8],
    2: [7, 9],
    3: [4, 8],
    4: [0, 3, 9],
    5: [],
    6: [0, 1, 7],
    7: [2, 6],
    8: [1, 3],
    9: [2, 4]
}
```

A brute force recursive solution

``` python
import pytest

from paths import paths


class Solution:

    def knightDialer(self, n: int, position=-1) -> int:
        if n == 0:
            return 1

        count = 0
        for neighbor in paths[position]:
            count += self.knightDialer(n - 1, neighbor)

        return count % (10 ** 9 + 7)


@pytest.mark.parametrize("jumps,expected_result", [
    (1, 10),
    (2, 20),
])
class TestClass:
    def test_simple_case(self, jumps, expected_result):
        s = Solution()
        result = s.knightDialer(jumps)
        assert result == expected_result
```

The previous solution with memoization

``` python
import pytest

from paths import paths

class Solution:

    cache = {}

    def knightDialer(self, n: int) -> int:
        return self.helper(n, -1) % (10 ** 9 + 7)

    def helper(self, idx, curr):

        if (idx, curr) in self.cache:
            return self.cache[(idx, curr)]

        if idx == 0:
            return 1

        count = 0
        for num in paths[curr]:
            count += self.helper(idx - 1, num)

        self.cache[(idx, curr)] = count
        return count


@pytest.mark.parametrize("jumps,expected_result", [
    (1, 10),
    (2, 20),
])
class TestClass:
    def test_simple_case(self, jumps, expected_result):
        s = Solution()
        result = s.knightDialer(jumps)
        assert result == expected_result
```

A solution with Dynamic Programming

``` python
import pytest
from paths import paths


class Solution:

    def count_hops(self, n: int) -> int:
        num_keys = 10
        all_jumps = [1] * num_keys

        for _ in range(n - 1):
            local_jumps = [0] * num_keys
            for i in paths:
                if i == -1: continue
                for j in paths[i]:
                    local_jumps[i] += all_jumps[j]
            all_jumps = local_jumps

        return sum(all_jumps) % (10 ** 9 + 7)


@pytest.mark.parametrize("test_args,expected", [
    (2, 20),
    (1, 10),
])
class TestClass:
    def test_simple_case(self, test_args, expected):
        s = Solution()
        assert s.count_hops(test_args) == expected
```
