# 📒 Phase 5 — Array Patterns

---

## 🧠 Objective

Build strong problem-solving skills using core array patterns by focusing on:

* Two Pointer — opposite ends and same direction
* K Sum patterns — Two Sum, 3Sum, 4Sum
* Partition — Dutch National Flag
* Sliding Window — fixed size, variable size, monotonic window
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
* Wiggle Sort II (Optional)

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

---

## 🧩 Problems Practiced

### L1 — Two Pointer (14 problems)

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

**K Sum Pattern**
* 01 Two Sum
* 02 3Sum
* 03 4Sum

### L2 — Partition (4 problems)

* 15 Sort Colors
* 16 Partition Array By Odd And Even
* 17 Partition Array Around A Pivot
* 18 Wiggle Sort II (Optional)

### L3 — Sliding Window (12 problems)

**Fixed Size**
* 22 Permutation In String
* 23 Sliding Window Maximum (Fixed)

**Variable Size**
* 24 Minimum Size Subarray Sum
* 25 Longest Substring Without Repeating Characters
* 26 Longest Substring With At Most K Distinct
* 27 Fruits Into Baskets
* 28 Binary Subarrays With Sum
* 29 Subarrays With K Different Integers
* 30 Minimum Window Substring
* 31 Longest Repeating Character Replacement

**Monotonic Window**
* 32 Sliding Window Maximum
* 33 Longest Continuous Subarray Absolute Diff Limit

---

## 🧩 How I Approached Problems

1. Understand the problem
2. Perform a dry run
3. Identify the pattern — opposite ends / same direction / window
4. Start with brute force
5. Identify the bottleneck
6. Optimise using the right technique
7. Analyse time and space complexity
8. Handle edge cases properly

---

## ⚙️ Key Learnings

### Two Pointer — Opposite Ends
* Sort first — enables two pointer and easy duplicate skip
* left < right vs left <= right — always check if pointers can meet
* smaller side is the bottleneck — process that side first
* skip duplicate i before loop, skip duplicate left/right after match

### Two Pointer — Same Direction
* insertPos tracks next valid slot
* swapAt takes indices not values
* != condition triggers the action — not what you want to skip

### K Sum Pattern
* Fix one pointer, reduce to K-1 sum
* 3Sum = fix i + Two Sum II
* 4Sum = fix i + fix j + Two Sum II

### Partition — Dutch National Flag
* Three pointers — low, mid, high
* mid doesn't move after swap with high — unseen element
* mid moves after swap with low — already seen element
* Same structure — replace 0/1/2 with conditions

### Sliding Window — Variable Size
* expand right → shrink left when invalid
* while for minimum problems
* if for maximum problems
* exactly(k) = atMost(k) - atMost(k-1)
* remove key from HashMap when count hits 0

### Sliding Window — Monotonic Window
* Deque stores indices not values
* front = max (maxDeque) or min (minDeque)
* remove front when outside window
* remove back when useless
* two deques for max AND min tracking

---

## ⚙️ Pattern Recognition

```
Opposite Ends     → sorted, pairs, palindrome, container
Same Direction    → remove, move, duplicates, squares
K Sum             → fix pointers, reduce to smaller sum
Partition         → three zones, in-place rearrangement
Fixed Window      → permutation check, fixed size max/min
Variable Window   → longest/shortest subarray, count problems
Monotonic Window  → max or min of every sliding window
```

---

## ⏱️ Complexity Insight

* Two Pointer              → O(n) time    O(1) space
* K Sum                    → O(n²) time   O(1) space
* Partition                → O(n) time    O(1) space
* Sliding Window basic     → O(n) time    O(1) space
* Sliding Window + HashMap → O(n) time    O(k) space
* Sliding Window + Deque   → O(n) time    O(k) space
* Brute Force              → O(n²) / O(n³) time

---

## 🔥 Key Formulas

```
water[i]                   = min(maxLeft, maxRight) - height[i]
windowSize - maxFreq <= k  → valid window  (Longest Repeating)
exactly(k)                 = atMost(k) - atMost(k-1)
max - min <= limit         → valid window  (Abs Diff Limit)
zeroCount <= k             → valid window  (Max Consecutive Ones)
front < right - k + 1      → outside window → remove from deque
```

---

## 🔥 Outcome

After completing this phase, I can:

* Identify Two Pointer direction — opposite or same
* Apply Dutch National Flag to any partition problem
* Apply sliding window for subarray and substring problems
* Use deque for monotonic window problems
* Recognise exactly(k) = atMost(k) - atMost(k-1) pattern
* Explain brute force and optimal clearly in interviews
* Handle all edge cases confidently

---

## 🚀 Next Step

Move to:
👉 **Phase 6 — Prefix Sum + Binary Search**

Upcoming focus:

* Prefix Sum arrays
* Range sum queries
* Binary Search on sorted arrays
* Binary Search on answers
* 2D prefix sum problems

---

## 💡 Final Note

This phase is not just about memorising patterns.

It is about:

* Asking — which pattern does this problem belong to?
* Building optimization thinking
* Reducing brute force to linear time
* Writing clean Swift solutions with proper notes
* Understanding why each technique works — not just how
