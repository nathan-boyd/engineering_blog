---
title: "Implementing a LRU Cache"
date: 2022-04-05T06:39:18-04:00
categories:
  - dev
  - challenges
tags:
  - python
  - interviewing
---

## The challenge

Implement an LRUCache class.


Functions should include:
- LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
- int get(int key) Return the value of the key if the key exists, otherwise return -1.
- void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.


## Examples
```
Input:
["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]

Output:
[null, null, null, 1, null, -1, null, -1, 3, 4]

Explanation
LRUCache lRUCache = new LRUCache(2);
lRUCache.put(1, 1); // cache is {1=1}
lRUCache.put(2, 2); // cache is {1=1, 2=2}
lRUCache.get(1);    // return 1
lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
lRUCache.get(2);    // returns -1 (not found)
lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
lRUCache.get(1);    // return -1 (not found)
lRUCache.get(3);    // return 3
lRUCache.get(4);    // return 4
```

## The Solution

This question requires prior knowledge or a sympathetic interviewer. You need to understand that an LRU cache is a replacement algorithm that removes the least recently used value to make room for new value.

I think this challenge is about knowing the idioms of the language you're working in. Since we're using python we should know that the ordered dict class offers some of the basic functionality we'll need.

LRU Operations:
- Get the key / Check if the key exists
- Put the key
- Delete the first added key

Our solution will be to build our cache on top of the OrderedDict class. I'll also provide a solution without help from that class.

### Complexity Analysis

- Time Complexity O(1) both for put and get since all operations with an ordered dictionary are based on hash map operations
- Space complexity : O(n)

### With Ordered Dict

Python's collections library has an ordered dictionary class that offerers an excellent jumping point for an LRU cache.

``` python
class LRUCache(collections.OrderedDict):

    def __init__(self, capacity: int):
      self.capacity = capacity


    def get(self, key: int) -> int:

      if key not in self:
        return -1

      self.move_to_end(key)

      return self[key]


    def put(self, key: int, value: int) -> None:

      if key in self:
        self.move_to_end(key)

      self[key] = value

      if len(self) > self.capacity:
        self.popitem(last=False)
```

### From scratch

If we can't use the ordered dict class we can implement our LRUCache with some help from KVP, Node, and Double Linked List classes.

``` python
class KeyValuePair:
    def __init__(self, key, value):
        self.key = key
        self.value = value


class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.previous = None


class DoublyLinkedList:
    def __init__(self):
        self.root = Node(None)
        self.capacity = 0

        self.root.next = self.root
        self.root.previous = self.root

    def unshift(self, data):
        node = Node(data)
        self.move_front(node)
        self.capacity += 1
        return node

    def move_front(self, node):
        if node is None:
            return None
        elif node.prev is not None and node.next is not None:
            self.isolate(node)

        node.prev = self.root
        node.next = self.root.next
        self.root.next.previous = node
        self.root.next = node
        return node

    def remove_tail(self):
        if self.capacity == 0:
            return None

        removed = self.isolate(self.root.previous)
        self.capacity -= 1
        return removed

    @staticmethod
    def isolate(node):
        node.next.previous = node.previous
        node.previous.next = node.next
        node.next = None
        node.previous = None
        return node


class LRUCache:
    def __init__(self, max_size=10):
        if max_size <= 0:
            raise Exception("LRU Cache size must be greater than 0")
        self.max_size = max_size
        self.list = DoublyLinkedList()
        self.nodes = {}

    def set(self, key, value):
        node = self.nodes.get(key, None)
        if node is not None:
            node.data.value = value
            self.list.move_front(node)
            return

        if self.list.capacity == self.max_size:
            expired = self.list.remove_tail()
            del self.nodes[expired.data.key]

        self.nodes[key] = self.list.unshift(KeyValuePair(key, value))

    def get(self, key):
        node = self.nodes.get(key, None)
        if node is None:
            return None

        self.list.move_front(node)
        return node.data.value
```
