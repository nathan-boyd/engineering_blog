---
title: "Subarray Sums Divisible by K"
date: 2022-04-06T20:12:06-04:00
categories:
  - dev
  - challenges
tags:
  - python
  - interviewing
---

Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum is divisible by k.

## Example

```
Input: nums = [4,5,0,-2,-3,1], k = 5
Output: 7
Explanation: There are 7 subarrays with a sum divisible by k = 5:
[4, 5, 0, -2, -3, 1], [5], [5, 0], [5, 0, -2, -3], [0], [0, -2, -3], [-2, -3]
```

## Intuitions

### Brute Force Approach

A naive but simple solution is to use the brute force approach. We can evaluate all possible sub-arrays and determine if the sum of each sub-arrays is divisible by k.

time complexity of this approach is O(n^2)
space complexity is O(1)

``` python
import pytest

def subarrays_div_by_k(nums, target):

    count = 0
    nums_count = len(nums)
    for start in range(nums_count):
        for end in range(start, nums_count):
            res = sum(nums[start:end+1])
            if res % target == 0:
                count += 1
    return count

@pytest.mark.parametrize("nums,target,expected", [
    ([4, 5, 0, -2, -3, 1], 5, 7),
    ([1, 1, 1, 1, 1, 1, 1], 8, 0),
    ([1, 2, 3, 4, 5, 6, 7, 0, -2, -3, 1], 4, 13),
    ([5], 9, 0),
])
class TestClass:
    def test_simple_case(self, nums, target, expected):
        result = subarrays_div_by_k(nums, target)
        assert result == expected
```

### Towards an Optimal Approach

When working with running sums like above we're recalculating a lot of values over and over again.

We can use use a hash map to store the previous sums / prefixsums. For this, we can store the occurrence of prefixSum % k at every iteration. If we have already seen this (prefixSum%k), we will add the number of occurrences of this to the answer.

``` python
import pytest
from typing import List

def subarrays_div_by_k(nums: List[int], k: int) -> int:

    # storing hashmap[0] = 1 as we have 0 sum at starting
    memo = {0: 1}
    answer = 0
    prefixSum = 0

    for i in range(len(nums)):
        prefixSum += nums[i]
        prefixSum %= k

        if prefixSum in memo:
            answer += memo[prefixSum]
            memo[prefixSum] += 1
        else:
            memo[prefixSum] = 1

    return answer

@pytest.mark.parametrize("nums,target,expected", [
    ([4, 5, 0, -2, -3, 1], 5, 7),
    ([1, 1, 1, 1, 1, 1, 1], 8, 0),
    ([1, 2, 3, 4, 5, 6, 7, 0, -2, -3, 1], 4, 13),
    ([5], 9, 0),
])
class TestClass:
    def test_simple_case(self, nums, target, expected):
        result = subarrays_div_by_k(nums, target)
        assert result == expected
```
