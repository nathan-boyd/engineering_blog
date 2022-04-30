---
title: "Reconstruct Itinerary"
date: 2022-04-07T08:11:25-04:00
categories:
  - dev
tags:
  - python
  - interviewing
---

You are given a list of airline tickets where tickets[i] = [fromi, toi] represent the departure and the arrival airports of one flight. Reconstruct the itinerary in order and return it.

All of the tickets belong to a man who departs from "JFK", thus, the itinerary must begin with "JFK". If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string.

For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
You may assume all tickets form at least one valid itinerary. You must use all the tickets once and only once.


## Examples

```
Input: tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
Output: ["JFK","MUC","LHR","SFO","SJC"]

Input: tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"] but it is larger in lexical order.`
```

## Intiution

- Overall, we could consider this problem as a graph traversal problem, where an airport can be viewed as a vertex in graph and flight between airports as an edge in graph.
- As one might notice in the above example, the input graph is NOT what we call a DAG (Directed Acyclic Graph), since we could find at least a cycle in the graph.
- In addition, the graph could even have some duplicate edges (i.e. we might have multiple flights with the same origin and destination).


``` python
from collections import defaultdict
import pytest
from typing import List


def findItinerary(tickets: List[List[str]]) -> List[str]:

    # get depts -> dests (with dests in reverse sorted order, since we're popping)
    dept_to_dests = defaultdict(list)
    for dept, dest in sorted(tickets, reverse=True):
        dept_to_dests[dept].append(dest)

    route = []
    stack = ['JFK']

    while stack:
        while dept_to_dests[stack[-1]]:
            t_dest = dept_to_dests[stack[-1]].pop()
            stack.append(t_dest)

        route.append(stack.pop())

    return list(reversed(route))


@pytest.mark.parametrize("test_args,expected", [
    ([["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]], ["JFK", "MUC", "LHR", "SFO", "SJC"]),
])
class TestClass:
    def test_simple_case(self, test_args, expected):
        assert findItinerary(test_args) == expected
```
