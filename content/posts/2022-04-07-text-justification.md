---
title: "Text Justification"
date: 2022-04-07T07:32:59-04:00
categories:
  - dev
tags:
  - python
  - interviewing
---

Given an array of strings words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.

You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.

Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

For the last line of text, it should be left-justified and no extra space is inserted between words.

Note:

A word is defined as a character sequence consisting of non-space caracters only.
Each word's length is guaranteed to be greater than 0 and not exceed maxWidth.
The input array words contains at least one word.h

## Examples

### Example 1:
```
Input: words = ["This", "is", "an", "example", "of", "text", "justification."], maxWidth = 16
Output:
[
   "This    is    an",
   "example  of text",
   "justification.  "
]
```

### Example 2:

```
Input: words = ["What","must","be","acknowledgment","shall","be"], maxWidth = 16
Output:
[
  "What   must   be",
  "acknowledgment  ",
  "shall be        "
]
Explanation: Note that the last line is "shall be    " instead of "shall     be", because the last line must be left-justified instead of fully-justified.
Note that the second line is also left-justified becase it contains only one word.
```

### Example 3:

```
Input: words = ["Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"], maxWidth = 20
Output:
[
  "Science  is  what we",
  "understand      well",
  "enough to explain to",
  "a  computer.  Art is",
  "everything  else  we",
  "do                  "
]
```

An implementation using round robin logic

``` python
import pytest


def fullJustify(words, maxWidth):
    result = []
    current = []
    num_of_letters = 0

    for w in words:
        if num_of_letters + len(w) + len(current) > maxWidth:
            for i in range(maxWidth - num_of_letters):
                current[i % (len(current) - 1 or 1)] += ' '
            result.append(''.join(current))
            current, num_of_letters = [], 0
        current += [w]
        num_of_letters += len(w)

    # Return a copy of the object left justified in a sequence of length width
    return result + [' '.join(current).ljust(maxWidth)]


@pytest.mark.parametrize("words,maxwidth,expected", [
    (["This", "is", "an", "example", "of", "text", "justification."], 16, [
        "This    is    an",
        "example  of text",
        "justification.  "]),
])
class TestClass:
    def test_simple_case(self, words, maxwidth, expected):
        res = fullJustify(words, maxwidth)
        assert res == expected
```
