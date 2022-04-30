---
title: "Meeting Rooms 2"
date: 2022-04-05T18:14:19-04:00
categories:
  - dev
tags:
  - python
  - interviewing
---

Given an array of meeting time intervals intervals where `intervals[i] = [start, end]` return the minimum number of meeting rooms required.

## Examples

```
Example 1
Input: intervals = [[0,30],[5,10],[15,20]]
Output: 2

Example 2
Input: intervals = [[7,10],[2,4]]
Output: 1
```

## Intuition

The first thought that comes to mind is that we should sort the intervals by their starting times. This would allow us to implement a priority queue, add intervals as they begin pop them off as they end and the size of the queue will represent our required meeting rooms.

## Algorithm

1. Sort the meetings by their start time.
2. Initialize a new min-heap and add the first meeting's ending time to the heap.
    1. We only need to track the ending times since the end of the meeting indicates the room frees up
3. For every meeting room check if the minimum element of the heap i.e. the room at the top of the heap is free or not.
4. If the room is free, then we remove the topmost element and add it back with the ending time of the current meeting we are processing.
5. If not, then we allocate a new room and add it to the heap.
6. After iterating over all meetings all the meetings, the size of the heap will tell us the number of rooms allocated.

## Solution

``` python
from typing import List
import pytest
import heapq


class Solution:
    def minMeetingRooms(self, intervals: List[List[int]]) -> int:

        # sort by interval[0] the start time
        intervals = sorted(intervals, key=lambda x: x[0])

        # heap will be used as a priority queue
        heap = []

        for meeting in intervals:
            if heap and heap[0] <= meeting[0]:
                # If the new start time is greater than or equal to the existing end time,
                # means the room has been released, replace the previous time with the new ending time
                heapq.heapreplace(heap, meeting[1])
            else:
                # The room is still in use, add (push a new end time to min heap) a new room
                heapq.heappush(heap, meeting[1])

        return len(heap)


# intervals[i] = [start, end]
@pytest.mark.parametrize("test_args,expected", [
    ([[0, 30], [5, 10], [15, 20]], 2),
    ([[7, 10], [2, 4]], 1)
])
class TestClass:
    def test_simple_case(self, test_args, expected):
        s = Solution()
        result = s.minMeetingRooms(test_args)
        assert result == expected
```
