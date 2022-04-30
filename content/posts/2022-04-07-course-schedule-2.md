---
title: "Course Schedule 2"
date: 2022-04-07T11:31:39-04:00
categories:
  - dev
tags:
  - python
  - interviewing
---

There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

### Example 1:

```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: [0,1]
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
```

### Example 2:

```
Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
Output: [0,2,1,3]
Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
```

### Example 3:

```
Input: numCourses = 1, prerequisites = []
Output: [0]
```

## Intuition

Approach 1: Using Depth First Search

Suppose we are at a node in our graph during the depth first traversal. Let's call this node A.

The way DFS would work is that we would consider all possible paths stemming from A before finishing up the recursion for A and moving onto other nodes. All the nodes in the paths stemming from the node A would have A as an ancestor. The way this fits in our problem is, all the courses in the paths stemming from the course A would have A as a prerequisite.

Now we know how to get all the courses that have a particular course as a prerequisite. If a valid ordering of courses is possible, the course A would come before all the other set of courses that have it as a prerequisite. This idea for solving the problem can be explored using depth first search.

``` python
from collections import defaultdict
from typing import List

import pytest


class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:

        # build a list of classes mapped to pre-reqs
        self.pre_req_dict = defaultdict(list)
        for a, b in prerequisites:
            self.pre_req_dict[a].append(b)

        self.results = []
        self.have_taken = [0] * numCourses

        for course in range(numCourses):
            if not self.eval_pre_reqs(course):
                return []
        else:
            return self.results

    def eval_pre_reqs(self, course):

        if self.have_taken[course]:
            return self.have_taken[course] == 1

        self.have_taken[course] = -1

        for pre_req in self.pre_req_dict[course]:
            if not self.eval_pre_reqs(pre_req):
                return False

        self.have_taken[course] = 1
        self.results.append(course)
        return True

@pytest.mark.parametrize("num_courses,pre_req,expected", [
    (4, [[1, 0], [2, 0], [3, 1], [3, 2]], [0, 1, 2, 3]),
    (2, [[1, 0]], [0, 1])
])
class TestClass:
    def test_simple_case(self, num_courses, pre_req, expected):
        s = Solution()
        order = s.findOrder(num_courses, pre_req)
        assert order == expected
```
