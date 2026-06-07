# 📒 Phase 5 — Array Patterns

---

## 🧠 Objective

Build strong problem-solving skills using core array patterns by focusing on:

* Two Pointer — opposite ends and same direction
* K Sum patterns — Two Sum, 3Sum, 4Sum
* Partition — Dutch National Flag
* Sliding Window — fixed size, variable size, monotonic window
* Prefix Sum — 1D, XOR, 2D
* Pattern recognition across problems
* Reducing O(n²) / O(n³) to O(n) solutions

This phase focuses on understanding how to:
👉 Identify which pattern a problem belongs to — not just memorise solutions.

---

## 📌 Topics Covered

### L1 — Two Pointer

#### Opposite Ends
* Valid Palindrome
* Two Sum II
* Container With Most Water
* 3Sum
* 4Sum
* Trapping Rain Water
* Reverse Sorted Array In Place
* Minimum Difference Pair

#### Same Direction
* Remove Duplicates From Sorted Array
* Remove Duplicates From Sorted Array II
* Remove Element
* Move Zeroes
* Squares of a Sorted Array
* Find The Duplicate Number

#### K Sum Pattern
* Two Sum
* 3Sum
* 4Sum

### L2 — Partition (Dutch National Flag)
* Sort Colors
* Partition Array By Odd And Even
* Partition Array Around A Pivot
* Wiggle Sort II

### L3 — Sliding Window

#### Fixed Size
* Permutation In String
* Sliding Window Maximum (Fixed)

#### Variable Size
* Minimum Size Subarray Sum
* Longest Substring Without Repeating Characters
* Longest Substring With At Most K Distinct
* Fruits Into Baskets
* Binary Subarrays With Sum
* Subarrays With K Different Integers
* Minimum Window Substring
* Longest Repeating Character Replacement

#### Monotonic Window
* Sliding Window Maximum
* Longest Continuous Subarray Absolute Diff Limit

### L4 — Prefix Based ✅

#### Prefix Sum
* Range Sum Query Immutable
* Find Pivot Index
* Subarray Sum Equals K
* Continuous Subarray Sum
* Product Of Array Except Self
* Count Subarrays With Equal 0s And 1s
* Number Of Subarrays With Sum In Range

#### Prefix XOR
* Single Number
* XOR Queries Of A Subarray
* Subarray With Given XOR
* Count Triplets With Equal XOR

#### Prefix 2D
* Range Sum Query 2D Immutable
* Matrix Block Sum
* Number Of Submatrices That Sum To Target
* Max Side Length Of Square

### L5 — Subarray Algorithms ✅

#### Kadane's Algorithm ✅
* Maximum Subarray — LC 53
* Maximum Sum Circular Subarray — LC 918
* Maximum Absolute Sum of Any Subarray — LC 1749
* Longest Turbulent Subarray — LC 978 ⏭️ Low Priority

#### Upcoming
* Max Product Subarray — LC 152
* Subarray XOR / Sum Problems

### L6 — Binary Search Patterns
* Binary Search on Index
* Binary Search on Answer

---

## 🧩 Problems Practiced

### L1 — Two Pointer (14 problems) ✅

**Opposite Ends**
* 01 Valid Palindrome
* 02 Two Sum II
* 03 Container With Most Water
* 04 3Sum
* 05 4Sum
* 06 Trapping Rain Water
* 07 Reverse Sorted Array In Place
* 08 Minimum Difference Pair

**Same Direction**
* 09 Remove Duplicates From Sorted Array
* 10 Remove Duplicates From Sorted Array II
* 11 Remove Element
* 12 Move Zeroes
* 13 Squares of a Sorted Array
* 14 Find The Duplicate Number

### L2 — Partition (4 problems) ✅
* 15 Sort Colors
* 16 Partition Array By Odd And Even
* 17 Partition Array Around A Pivot
* 18 Wiggle Sort II

### L3 — Sliding Window (12 problems) ✅

**Fixed Size**
* 19 Permutation In String
* 20 Sliding Window Maximum (Fixed)

**Variable Size**
* 21 Minimum Size Subarray Sum
* 22 Longest Substring Without Repeating Characters
* 23 Longest Substring With At Most K Distinct
* 24 Fruits Into Baskets
* 25 Binary Subarrays With Sum
* 26 Subarrays With K Different Integers
* 27 Minimum Window Substring
* 28 Longest Repeating Character Replacement

**Monotonic Window**
* 29 Sliding Window Maximum
* 30 Longest Continuous Subarray Absolute Diff Limit

### L4 — Prefix Based (15 problems) ✅

**Prefix Sum**
* 31 Range Sum Query Immutable
* 32 Find Pivot Index
* 33 Subarray Sum Equals K
* 34 Continuous Subarray Sum
* 35 Product Of Array Except Self
* 36 Count Subarrays With Equal 0s And 1s
* 37 Number Of Subarrays With Sum In Range

**Prefix XOR**
* 38 Single Number
* 39 XOR Queries Of A Subarray
* 40 Subarray With Given XOR
* 41 Count Triplets With Equal XOR

**Prefix 2D**
* 42 Range Sum Query 2D Immutable
* 43 Matrix Block Sum
* 44 Number Of Submatrices That Sum To Target
* 45 Max Side Length Of Square

### L5 — Subarray Algorithms — Kadane's (3 problems) 🔄

**Kadane's Algorithm**
* 51 Maximum Subarray — LC 53 ✅
* 52 Maximum Sum Circular Subarray — LC 918 ✅
* 53 Maximum Absolute Sum of Any Subarray — LC 1749 ✅
* 54 Longest Turbulent Subarray — LC 978 ⏭️ Low Priority

**Upcoming**
* 55 Max Product Subarray — LC 152
* 56 Subarray XOR / Sum Problems

### L6 — Binary Search Patterns (Upcoming)
* Binary Search on Index
* Binary Search on Answer

---

## 🧩 How I Approached Problems

1. Understand the problem
2. Perform a dry run
3. Start with brute force solution
4. Identify the bottleneck
5. Recognize the pattern
6. Optimize using the right technique
7. Analyze time and space complexity
8. Handle edge cases properly

---

## ⚙️ Key Learnings

### Two Pointer
* Sort first when duplicates need to be skipped
* left < right vs left <= right — always check if pointers can meet
* swapAt takes indices not values
* Skip duplicate i before loop, skip duplicate left/right after match
* The smaller side is always the bottleneck

### Partition
* Dutch National Flag — three pointers low, mid, high
* mid doesn't move after swap with high — unseen element
* mid moves after swap with low — already seen element

### Sliding Window
* expand right → shrink left when invalid
* while for minimum window problems
* if for maximum window problems
* exactly(k) = atMost(k) - atMost(k-1)
* Remove key from HashMap when count hits 0
* Deque stores indices not values

### Prefix Sum
* Build prefix array once → answer range queries in O(1)
* prefix[i] = prefix[i-1] + nums[i-1]
* sumRange(l, r) = prefix[r+1] - prefix[l]
* Init map [0: 1] for frequency, [0: -1] for index problems
* Replace 0 → -1 to convert equal 0s and 1s to sum = 0
* Same remainder twice → subarray between is multiple of k
* Product except self → left pass × right pass, no division
* XOR range query → prefix[r] XOR prefix[l-1]
* 2D prefix → row-by-row compression then column prefix

### Kadane's Algorithm
* Initialize currentSum and maxSum with nums[0] — not 0 or Int.min
* At each index — extend or fresh start: if currentSum + nums[i] < nums[i] → reset
* Circular subarray — totalSum - minSubarray (Kadane's min)
* All negative edge case — totalSum == minSum → return maxSum only
* Absolute sum — max(maxSum, abs(minSum))
* Kadane's min — flip the comparison: if currentMin + nums[i] > nums[i] → reset

---

## ⚙️ Pattern Recognition

| Pattern | Trigger Words |
|---------|--------------|
| Two Pointer | sorted array, pairs, palindrome, duplicates |
| Partition | rearrange, group, sort colors, 0s 1s 2s |
| Sliding Window | subarray, substring, window, contiguous |
| Prefix Sum | range sum, subarray sum equals k, 2D matrix |
| Kadane's | maximum subarray, circular, absolute sum |
| Binary Search | sorted, find target, minimize maximum |
