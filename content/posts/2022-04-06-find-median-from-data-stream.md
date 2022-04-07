---
title: "Find Median From Data Stream"
date: 2022-04-06T21:20:54-04:00
categories:
  - dev
  - challenges
tags:
  - python
  - interviewing
---

The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value and the median is the mean of the two middle values.

MedianFinder() initializes the MedianFinder object.
void addNum(int num) adds the integer num from the data stream to the data structure.
double findMedian() returns the median of all elements so far. Answers within 10-5 of the actual answer will be accepted.

For example, for arr = [2,3,4], the median is 3.
For example, for arr = [2,3], the median is (2 + 3) / 2 = 2.5.

Implement the MedianFinder class:

## Example

```
Input
["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
[[], [1], [2], [], [3], []]
Output
[null, null, null, 1.5, null, 2.0]

Explanation
MedianFinder medianFinder = new MedianFinder();
medianFinder.addNum(1);    // arr = [1]
medianFinder.addNum(2);    // arr = [1, 2]
medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
medianFinder.addNum(3);    // arr[1, 2, 3]
medianFinder.findMedian(); // return 2.0
```

## Intuition

### Sorting

``` python
import pytest


class MedianFinder:

    def __init__(self):
        self.values = []

    def addNum(self, num: int) -> None:
        self.values.append(num)

    def findMedian(self) -> float:
        s = sorted(self.values)
        n = len(self.values)

        if n % 2 == 1:
            return self.values[n // 2]

        return (self.values[n // 2] + self.values[n // 2 - 1]) / 2


@pytest.mark.parametrize("nums,expected", [
    ((1, 2, 3), 2)
])
class TestClass:
    def test_simple_case(self, nums, expected):
        m = MedianFinder()
        for val in nums:
            m.addNum(val)
        res = m.findMedian()
        assert res == expected
```

### Two heaps

``` python
from heapq import *


class MedianFinder:
    def __init__(self):

        # the smaller half of the list, max heap (invert min-heap)
        self.small = []

        # the larger half of the list, min heap
        self.large = []

    def addNum(self, num):
        if len(self.small) == len(self.large):
            heappush(self.large, -heappushpop(self.small, -num))
        else:
            heappush(self.small, -heappushpop(self.large, num))

    def findMedian(self):
        if len(self.small) == len(self.large):
            return float(self.large[0] - self.small[0]) / 2.0
        else:
            return float(self.large[0])
```
