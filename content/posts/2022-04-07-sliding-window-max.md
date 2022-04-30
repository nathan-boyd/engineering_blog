---
title: "Sliding Window Max"
date: 2022-04-07T10:42:02-04:00
categories:
  - dev
tags:
  - python
  - interviewing
---

You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position. Return the max sliding window.

## Examples

### Example 1:

```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation:
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
 ```

### Example 2:

```
Input: nums = [1], k = 1
Output: [1]
```


## Brute force solution

Time complexity : O(Nk), where N is number of elements in the array.
Space complexity : (N−k+1) for an output array.

``` python
from typing import List
import pytest


class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        nums_length = len(nums)
        if nums_length * k == 0:
            return []

        result = []
        for i in range(nums_length - k + 1):
            max_val = max(nums[i:i + k])
            result.append(max_val)

        return result

@pytest.mark.parametrize("nums,k,expected", [
    ([1, 3, -1, -3, 5, 3, 6, 7], 3, [3, 3, 5, 5, 6, 7]),
])
class TestClass:
    def test_simple_case(self, nums, k, expected):
        s = Solution()
        assert s.maxSlidingWindow(nums, k) == expected
```

## Deque Implementation

### Algorithm

- Process the first k elements separately to initiate the deque.
- Iterate over the array. At each step :
  - Clean the deque :
    - Keep only the indexes of elements from the current sliding window.
    - Remove indexes of all elements smaller than the current one, since they will not be the maximum ones.
- Append the current element to the deque.
- Append deque[0] to the output.
- Return the output array.

Time complexity : O(N)
Space complexity : O(N)


``` python
from collections import deque


class Solution:

    def maxSlidingWindow(self, nums, k):

        res = []
        bigger = deque()
        for i, n in enumerate(nums):

            # make sure the rightmost one is the smallest
            while bigger and nums[bigger[-1]] <= n:
                bigger.pop()

            # add in
            bigger += [i]

            # make sure the leftmost one is in-bound
            if i - bigger[0] >= k:
                bigger.popleft()

            # if i + 1 < k, then we are initializing the bigger array
            if i + 1 >= k:
                res.append(nums[bigger[0]])

        return res
```
