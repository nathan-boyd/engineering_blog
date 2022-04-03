---
title: "Islands in the Sun"
date: 2022-04-02T19:01:58-04:00
categories:
  - dev
  - challenges
tags:
  - python
---

A 2D binary grid represents a land map. The map consists of '1's and '0's where the 1's are land and the 0's are water. Given this map, count the number of islands

## Example

```
Input: map = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
Output: 3
```

## The plan

If we treat the map as an undirected graph then we can walk the associated tree structure and count islands as we go.

## The Algorithm

Walk the map, if a node's value is '1' then we initiate a depth first traversal. During this traversal every visited land node's value is set to '#' to mark it as visited. If we count the number of times we trigger a traversal, we have our count of islands.

```python3
import pytest


def num_islands(grid):

    if not grid:
        return 0

    island_count = 0
    for i in range(len(grid)):
        for j in range(len(grid[0])):
            if grid[i][j] == '1':
                dfs_traverse(grid, i, j)
                island_count += 1
    return island_count


def dfs_traverse(grid, i, j):

    if i < 0 or j < 0:
        return

    if i >= len(grid) or j >= len(grid[0]):
        return

    if grid[i][j] != '1':
        return

    grid[i][j] = '#'

    dfs_traverse(grid, i + 1, j)
    dfs_traverse(grid, i - 1, j)
    dfs_traverse(grid, i, j + 1)
    dfs_traverse(grid, i, j - 1)


@pytest.mark.parametrize("map,expected", [
    ([["1", "1", "0", "0", "0"],
      ["1", "1", "0", "0", "0"],
      ["0", "0", "1", "0", "0"],
      ["0", "0", "0", "1", "1"]], 3),
    ([["0", "0"],
      ["0", "0"]], 0),
    ([["1", "1"],
      ["1", "1"]], 1),
])
class TestClass:
    def test_simple_case(self, map, expected):
        assert num_islands(map) == expected
```
