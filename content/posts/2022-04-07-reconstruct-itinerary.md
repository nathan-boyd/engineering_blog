---
title: "Reconstruct Itinerary"
date: 2022-04-07T08:11:25-04:00
categories:
  - dev
  - challenges
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

Overall, we could consider this problem as a graph traversal problem, where an airport can be viewed as a vertex in graph and flight between airports as an edge in graph.

As one might notice in the above example, the input graph is NOT what we call a DAG (Directed Acyclic Graph), since we could find at least a cycle in the graph.

In addition, the graph could even have some duplicate edges (i.e. we might have multiple flights with the same origin and destination).

First keep going forward until you get stuck. That's a good main path already. Remaining tickets form cycles which are found on the way back and get merged into that main path. By writing down the path backwards when retreating from recursion, merging the cycles into the main path is easy - the end part of the path has already been written, the start part of the path hasn't been written yet, so just write down the cycle now and then keep backwards-writing the path.
From JFK we first visit JFK -> A -> C -> D -> A. There we're stuck, so we write down A as the end of the route and retreat back to D. There we see the unused ticket to B and follow it: D -> B -> C -> JFK -> D. Then we're stuck again, retreat and write down the airports while doing so: Write down D before the already written A, then JFK before the D, etc. When we're back from our cycle at D, the written route is D -> B -> C -> JFK -> D -> A. Then we retreat further along the original path, prepending C, A and finally JFK to the route, ending up with the route JFK -> A -> C -> D -> B -> C -> JFK -> D -> A.


``` python
import pytest

from typing import List


def findItinerary(tickets: List[List[str]]) -> List[str]:
    graph = {}
    # Create a graph for each airport and keep list of airport reachable from it
    for src, dst in tickets:
        if src in graph:
            graph[src].append(dst)
        else:
            graph[src] = [dst]

    for src in graph.keys():
        graph[src].sort(reverse=True)
        # Sort children list in descending order so that we can pop last element
        # instead of pop out first element which is costly operation
    stack = []
    res = []
    stack.append("JFK")
    # Start with JFK as starting airport and keep adding the next child to traverse
    # for the last airport at the top of the stack. If we reach to an airport from where
    # we can't go further then add it to the result. This airport should be the last to go
    # since we can't go anywhere from here. That's why we return the reverse of the result
    # After this backtrack to the top airport in the stack and continue to traaverse it's children

    while len(stack) > 0:
        elem = stack[-1]
        if elem in graph and len(graph[elem]) > 0:
            # Check if elem in graph as there may be a case when there is no out edge from an airport
            # In that case it won't be present as a key in graph
            stack.append(graph[elem].pop())
        else:
            res.append(stack.pop())
            # If there is no further children to traverse then add that airport to res
            # This airport should be the last to go since we can't anywhere from this
            # That's why we return the reverse of the result

    res.reverse()
    return res


@pytest.mark.parametrize("test_args,expected", [
    ([["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]], ["JFK", "MUC", "LHR", "SFO", "SJC"]),
])
class TestClass:
    def test_simple_case(self, test_args, expected):
        assert findItinerary(test_args) == expected
```
