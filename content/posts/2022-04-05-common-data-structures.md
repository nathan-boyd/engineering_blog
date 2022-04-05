---
title: "Data Structures in Computer Science"
date: 2022-04-05T07:18:27-04:00
draft: true
categories:
  - dev
tags:
  - python
---

A data structure is a container that stores data with specific characteristics. Each data structure's characteristics determines its performance, some data structures be more performant for reads and others might be better at writes. Understanding these performance characteristics is essential and what we'll be diving deeper into.

Common data structures include:
- Arrays
- Stacks
- Queues
- Linked Lists
- Trees
- Graphs
- Hash Tables

## Arrays

Arrays are used to store lists of related information. They are the most commonly used data structure and often serve as building blocks for higher level structures like stacks and queues. Standard arrays may be one or two dimensional. Arrays are indexable, have fixed capacity, and are easy to traverse as demonstrated in the following.

``` python
values = [1, 2, 3]
for idx, val in enumerate(values):
    print(f"index: {idx}, value: {val}")
```

## Stacks - LIFO

A stack is a data type that is most easially described by definiing its operations
- Push which adds an element to the collection
- Pop which removes the most recently added element

The order in which elements are removed from the stack is called "Last In First Out" or LIFO.

Other common stack operations include:
- IsEmpty which returns true if the stack is empty
- Top wihch returns the top element without removing from the stack

Stacks are useful for maintaining a list of operations that may be undone or come back to later.
- Matching delimiters
- Programming language Call Stack

In the following example we implement a stack to check that all delimiters in a given string are properly closed.

``` python
def is_valid(s):

    stack = []
    mapping = {')': '(', '}': '{', ']': '['}

    for char in s:
        if char in mapping:
            if stack:
                top_element = stack.pop()
            else:
                top_element = '#'

            if mapping[char] != top_element:
                return False
        else:
            stack.append(char)

    return not stack
```

## Queues - FIFO

A queue is a data structure that service as a collection of elements who's primary characteristics are that it can be modified by the addition of entities at one end of the sequence and the removal of entities from the other end of the sequence. The operation of adding an element to the rear of the queue is known as enqueue, and the operation of removing an element from the front is known as dequeue. Other operations may also be allowed, often including a peek or front operation that returns the value of the next element to be dequeued without dequeuing it.

Queues are used when
- When a resource is shared among multiple consumers
- When data is transferred asynchronously between two processes
- In Operating systems:
  - Semaphores
  - First come first serve scheduling

In the following example we'll leverage a special type of python queue called a `deque` pronounced "deck". A deque is essentially a double ended queue.

``` python
def first_unique_char(s: str) -> int:
    values = {}
    queue = deque()
    for index, val in enumerate(s):
        values[val] = values.get(val, 0) + 1
        if values[val] == 1:
            queue.append((val, index))
        while queue and values[queue[0][0]] > 1:
            queue.popleft()
    return -1 if not queue else queue[0][1]
```

## Node

A node is a building block data structure. It commonly contains its data, a pointer to the next node, and in some cases a pointer to the previous node.

Applications of Nodes:
- Lists
- Trees

``` python
class Node:
    def __init__(self, value, next_node=None, prev_node=None):
        self.value = value
        self.next = next_node
        self.prev = prev_node

    def __str__(self):
        return str(self.value)
```

## Linked Lists

A linked list is a chain of Nodes. The list contains a head pointer which points to the first element of the linked list. If the list is empty then it points to null.

Applications of linked lists
- Implementation of stacks and queues
- Implementation of graphs
- Dynamic memory allocation

```
class LinkedList:
    def __init__(self, values=None):
        self.head = None
        self.tail = None
        if values is not None:
            for value in values:
                self.add_node(value)

    def __str__(self):
        return ' -> '.join([str(node) for node in self])

    def __len__(self):
        count = 0
        node = self.head
        while node:
            count += 1
            node = node.next
        return count

    def __iter__(self):
        current = self.head
        while current:
            yield current
            current = current.next

    @property
    def values(self):
        return [node.value for node in self]

    def add_node(self, value):
        if self.head is None:
            self.tail = self.head = Node(value)
        else:
            self.tail.next = Node(value)
            self.tail = self.tail.next
        return self.tail
```

## Graphs

A graph is a set of nodes that are connected to each other. Nodes are also called vertices and a pair of vertices (x,y) is called an edge. Edges indicate that vertex x is connected to vertex y. An edge may contain weight/cost, showing how much cost is required to traverse from vertex x to y. Unlike trees graphs can be cyclic, meaning if you follow edged away from a node you may end up back where you started.

Graphs are often used to represent
- computer networks
- stops on delivery routes
- relationships in social media

The following example generates a graph to determine if there is a route from one point to another

``` python
class Solution:
    def valid_path(self, edges: List[List[int]], start: int, end: int) -> bool:
        graph = self.build_graph(edges)
        return self.hasPath(graph, start, end, set())

    def build_graph(self, edges):
        graph = {}
        for edge in edges:
            a, b = edge
            if a not in graph:
                graph[a] = []
            if b not in graph:
                graph[b] = []
            graph[a].append(b)
            graph[b].append(a)
        return graph

    def hasPath(self, graph, source, destination, visited):
        if source == destination:
            return True
        if source in visited:
            return False
        visited.add(source)
        for neighbour in graph[source]:
            if self.hasPath(graph, neighbour, destination, visited):
                return True
        return False
```

## Trees

A tree is a type of graph that incorporates a hierarchical ordering of vertices and the edges that connect them. The key difference between a tree and graph is that a cycle cannot exist in a tree.

- General Tree
  - Nodes can have any number of children
- Binary Tree
  - Nodes can have up to two children.
- Binary Search Tree
  - A subtype of a binary tree that is
  - Nodes are organized for fast search, lookup, and addition / removal
  - For any node in the tree the following must be true
    - The left side child node must have a value less than the parent
    - The right side child node must have a value greater than the parent
- AVL Tree
  - Self balancing Binary Search Tree
  - Height two child subtrees of any node differ at most by one
- Red Black Tree
  - Self balancing Binary Search Tree
  - Can be balanced in less than three rotations
- B Tree
  - Self balancing tree that sorts data in logarithmic time
  - Fast search, sequential access, deletions, and insertions
  - Used in many storage systems and data bases


## Hash Tables

The process of uniquely identifying and storing objects with some pre-calculated unique index is known as hashing. This unique index is called a “key” and the object is stored as a “key-value” pair. The collection of such items is often called called a dictionary. Once the values are stored in the hash table their lookup is O(1) complexity, this characteristic makes them appealing for many use cases.

Two Sum, which finds complimentary integers that sum to a target, is often solved by using a dictionary or hash table to store values.

``` python
def twoSum(self, nums, target):
    hash_nums = {}
    for i, num in enumerate(nums):
        compliment = target - num
        if compliment in hash_nums:
            return [hash_nums[compliment], i]
            hash_nums[num] = i
```
