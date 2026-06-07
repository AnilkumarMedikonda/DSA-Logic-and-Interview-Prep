# 🚀 Swift DSA Journey

---

# 🧠 About This Repository

This repository documents my journey of learning **Data Structures & Algorithms using Swift**.

The main focus is on:

* Building strong logical thinking
* Improving problem-solving skills
* Writing clean and scalable Swift code
* Understanding time & space complexity
* Solving interview-oriented problems step by step
* Strengthening optimization and pattern recognition skills

---

# 📂 Learning Phases

---

## 🔹 Phase 0 – Logic Building ✅

Focused on building:

* Loop thinking
* Iteration logic
* Dry-run ability
* Pattern understanding

### 📌 Topics Covered

* While Loop
* Repeat-While Loop
* For Loop
* Nested Loops
* Break & Continue
* Mathematical Series
* Mixed Logical Problems
* Star Patterns

📁 `phase-0-logic-building/`

---

## 🔹 Phase 1 – Complexity ✅

Focused on understanding:

* Time Complexity
* Space Complexity
* Optimization thinking

### 📌 Topics Covered

* Big-O Notation
* Best / Worst Case Analysis
* Auxiliary Space
* In-place vs Extra Space
* Recursion Stack
* Brute Force vs Optimized Thinking

📁 `phase-1-complexity/`

---

## 🔹 Phase 2 – Arrays ✅

Focused on solving:

* Traversal problems
* Searching problems
* Frequency problems
* Logical & applied array problems

### 📌 Topics Covered

* Array Traversal
* Insert / Delete Operations
* Searching Techniques
* Sorting Operations
* Reverse Operations
* Rotation Operations
* Merge / Split Operations
* Aggregate & Comparative Thinking
* Pair Sum Problems
* Frequency Counting
* HashMap / Dictionary Problems

📁 `phase-2-arrays/`

---

## 🔹 Phase 3 – Strings ✅

Focused on:

* String traversal
* String manipulation
* Character analysis
* Word-level thinking
* ASCII manipulation
* Reverse logic

### 📌 Topics Covered

* String Traversal
* Character Operations
* Reverse Operations
* Palindrome Problems
* Character Frequency Problems
* Duplicate Handling
* Word-Level Problems
* String Transformation
* Case Conversion
* Space Handling
* Two Pointer String Problems
* String Comparison Problems

📁 `phase-3-strings/`

---

## 🔹 Phase 4 – HashMap Thinking ✅

Focused on:

* Frequency counting
* Lookup optimization
* Pair sum logic
* Duplicate handling
* Prefix Sum + HashMap
* Hash-based problem solving

### 📌 Topics Covered

* Frequency Counting
* Duplicate Detection
* Pair Sum Problems
* Common / Unique Elements
* Anagram Problems
* Hash-Based Lookup
* Prefix Sum Problems
* Subarray Sum Problems
* String HashMap Problems

📁 `phase-4-hashmap/`

---

## 🔹 Phase 5 – Array Patterns 🚀 (Current)

Focused on:

* Pattern recognition
* Interview-style problem solving
* Optimization techniques
* Subarray-based problems
* Advanced traversal thinking

### 📌 Topics Covered

#### L1 — Two Pointer Patterns ✅

* Opposite Ends (Valid Palindrome, Two Sum II, Container With Most Water, 3Sum, 4Sum, Trapping Rain Water)
* Same Direction (Remove Duplicates, Move Zeroes, Squares of Sorted Array, Find Duplicate)
* K Sum Pattern (Two Sum, 3Sum, 4Sum)

#### L2 — Partition Problems ✅

* Sort Colors (Dutch National Flag)
* Partition Array By Odd And Even
* Partition Array Around A Pivot
* Wiggle Sort II

#### L3 — Sliding Window Patterns ✅

* Fixed Size Window (Permutation In String, Sliding Window Maximum)
* Variable Size Window (Min Size Subarray Sum, Longest Substring Without Repeating, Longest K Distinct, Fruits Into Baskets, Binary Subarrays With Sum, Subarrays With K Different, Min Window Substring, Longest Repeating Character Replacement)
* Monotonic Window (Sliding Window Maximum, Longest Continuous Subarray Abs Diff Limit)

#### L4 — Prefix-Based Problems ✅

* Prefix Sum (Range Sum Query, Find Pivot Index, Subarray Sum Equals K, Continuous Subarray Sum, Product Except Self, Count Subarrays Equal 0s 1s, Subarrays With Sum In Range)
* Prefix XOR (Single Number, XOR Queries, Subarray With Given XOR, Count Triplets Equal XOR)
* 2D Prefix Sum (Range Sum Query 2D, Matrix Block Sum, Submatrices Sum To Target, Max Side Length Square)

#### L5 — Subarray Algorithms 🔄

* Kadane's Algorithm ✅
  * Maximum Subarray — LC 53 ✅
  * Maximum Sum Circular Subarray — LC 918 ✅
  * Maximum Absolute Sum of Any Subarray — LC 1749 ✅
  * Longest Turbulent Subarray — LC 978 ⏭️ Low Priority
* Max Product Subarray — LC 152 🔜
* Subarray XOR / Sum Problems 🔜

#### L6 — Binary Search Patterns

* Binary Search on Index
* Binary Search on Answer

📁 `phase-5-array-patterns/`

---

# 🔥 Upcoming Phases

* String Patterns
* Recursion
* Stack
* Queue
* Linked List
* Trees
* Graphs
* Heap / Priority Queue
* Greedy Algorithms
* Dynamic Programming
* Advanced DSA Patterns

---

# 🎯 Goals

* Build strong problem-solving skills
* Improve optimization thinking
* Write clean interview-ready solutions
* Master core DSA concepts using Swift
* Strengthen pattern recognition ability
* Crack product-based company interview by September 2026

---

# 💡 Learning Approach

For every problem:

1. Understand the problem
2. Perform a dry run
3. Start with brute force solution
4. Optimize step by step
5. Analyze time & space complexity
6. Handle edge cases properly
7. Compare multiple approaches

---

# ⚙️ Complexity Focus

Each solution includes:

* Brute Force Solution
* Optimized Solution ⭐️
* Time Complexity
* Space Complexity
* Interview Q&A Notes

---

# 🔥 Current Focus

👉 Phase 5 – Array Patterns — L5 Subarray Algorithms (Kadane's) 🚀

### ✅ Completed

* L1 Two Pointer — 14 problems
* L2 Partition — 4 problems
* L3 Sliding Window — 12 problems
* L4 Prefix Based — 15 problems

### 🔄 In Progress

* L5 Kadane's Algorithm — 3 of 4 problems done
  * ✅ LC 53 — Maximum Subarray
  * ✅ LC 918 — Maximum Sum Circular Subarray
  * ✅ LC 1749 — Maximum Absolute Sum of Any Subarray
  * ⏭️ LC 978 — Longest Turbulent Subarray (Low Priority)

### ⬜ Upcoming

* L5 Max Product Subarray — LC 152
* L5 Subarray XOR / Sum Problems
* L6 Binary Search Patterns

---

# 💡 Key Learnings Per Pattern

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
* Circular subarray — totalSum - minSubarray (run Kadane's min)
* All negative edge case — totalSum == minSum → return maxSum only
* Absolute sum — max(maxSum, abs(minSum))
* Kadane's min — flip the comparison: if currentMin + nums[i] > nums[i] → reset

---

# ⚙️ Pattern Recognition Table

| Pattern | Trigger Words |
|---------|--------------|
| Two Pointer | sorted array, pairs, palindrome, duplicates |
| Partition | rearrange, group, sort colors, 0s 1s 2s |
| Sliding Window | subarray, substring, window, contiguous |
| Prefix Sum | range sum, subarray sum equals k, 2D matrix |
| Kadane's | maximum subarray, circular, absolute, product |
| Binary Search | sorted, find target, minimize maximum |

---

# 💡 Key Learning Philosophy

This journey is not only about solving problems.

It is about:

* Asking — which pattern does this problem belong to?
* Building optimization thinking
* Improving interview problem-solving
* Strengthening logical reasoning
* Learning clean coding practices
* Developing scalable thinking
* Understanding patterns deeply instead of memorizing solutions

---

# 👨‍💻 Author

**Medikonda Anil Kumar**
iOS Developer | Swift | DSA | Problem Solving

📁 GitHub: https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep
