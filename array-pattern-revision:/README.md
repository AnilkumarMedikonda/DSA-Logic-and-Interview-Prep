# 📒 Array Pattern Revision — Two Pointer + Partition + Sliding Window

---

## 🧠 Objective

Build strong problem-solving skills using array patterns by focusing on:

* Two pointer technique
* Partition and rearrangement problems
* Sliding window for subarray / substring problems
* Deque-based window optimization
* HashMap-based window tracking
* Frequency counting in windows
* Monotonic data structure thinking

This phase focuses on understanding how to:
👉 Convert brute force O(n²) / O(n³) solutions into optimized O(n) solutions using pointer and window techniques.

---

## 📌 Topics Covered

### L1 — Two Pointer

* Valid Palindrome
* Two Sum II
* Container With Most Water
* 3Sum
* Trapping Rain Water
* Move Zeroes
* Squares of a Sorted Array

### L2 — Partition

* Sort Colors (Dutch National Flag)
* Partition Array Around Pivot

### L3 — Sliding Window

* Minimum Size Subarray Sum
* Longest Substring Without Repeating Characters
* Longest Substring With At Most K Distinct
* Fruits Into Baskets
* Binary Subarrays With Sum
* Subarrays With K Different Integers
* Minimum Window Substring
* Longest Repeating Character Replacement
* Sliding Window Maximum
* Longest Continuous Subarray Absolute Diff Limit
* Max Consecutive Ones III
* Permutation In String

---

## 🧩 Problems Practiced

### L1 — Two Pointer (7 problems)

* 01 Valid Palindrome
* 02 Two Sum II
* 03 Container With Most Water
* 04 3Sum
* 05 Trapping Rain Water
* 06 Move Zeroes
* 07 Squares of a Sorted Array

### L2 — Partition (2 problems)

* 08 Sort Colors
* 09 Partition Array Around Pivot

### L3 — Sliding Window (12 problems)

* 10 Minimum Size Subarray Sum
* 11 Longest Substring Without Repeating Characters
* 12 Longest Substring With At Most K Distinct
* 13 Fruits Into Baskets
* 14 Binary Subarrays With Sum
* 15 Subarrays With K Different Integers
* 16 Minimum Window Substring
* 17 Longest Repeating Character Replacement
* 18 Sliding Window Maximum
* 19 Longest Continuous Subarray Absolute Diff Limit
* 20 Max Consecutive Ones III
* 21 Permutation In String

---

## 🧩 How I Approached Problems

1. Understand the problem
2. Perform a dry run
3. Start with brute force solution
4. Identify the bottleneck
5. Recognize the pattern — two pointer / sliding window
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
* Identical structure to Sort Colors — just replace 0/1/2 with conditions

### Sliding Window

* expand right → shrink left when invalid
* while for minimum window problems
* if for maximum window problems
* exactly(k) = atMost(k) - atMost(k-1) — reusable pattern
* Remove key from HashMap when count hits 0
* Deque stores indices not values
* front of deque = max / min index of window
* Remove front when outside window, remove back when useless

---

## ⚙️ Pattern Recognition

```
Two Pointer     → sorted array, pairs, opposites, left-right inward
Partition       → rearrange in-place, three zones, Dutch National Flag
Sliding Window  → subarray / substring, contiguous elements, same direction
Deque Window    → max or min of every window, monotonic structure
```

---

## ⏱️ Complexity Insight

* Two Pointer               → O(n) time    O(1) space
* Partition                 → O(n) time    O(1) space
* Sliding Window basic      → O(n) time    O(1) space
* Sliding Window + HashMap  → O(n) time    O(k) space
* Sliding Window + Deque    → O(n) time    O(k) space
* Brute Force nested loops  → O(n²) / O(n³) time

---

## 🔥 Key Formulas

```
water[i]            = min(maxLeft, maxRight) - height[i]
windowSize - maxFreq <= k  → valid window (Problem 17)
exactly(k)          = atMost(k) - atMost(k-1)  (Problem 14, 15)
max - min <= limit  → valid window (Problem 19)
zeroCount <= k      → valid window (Problem 20)
```

---

## 🔥 Outcome

After completing this phase, I can:

* Solve Two Pointer problems confidently
* Identify partition problems and apply Dutch National Flag
* Apply sliding window for subarray and substring problems
* Use deque for sliding window max/min problems
* Recognise exactly(k) = atMost(k) - atMost(k-1) pattern
* Explain brute force and optimal solutions clearly in interviews
* Handle edge cases — left <= right, break conditions, key removal

---

## 🚀 Next Step

Move to:
👉 **Phase 5 — Prefix Sum + Binary Search**

Upcoming focus:

* Prefix Sum patterns
* Binary Search on arrays
* Binary Search on answers
* 2D prefix sum
* Range sum queries

---

## 💡 Final Note

This phase is not just about Two Pointer and Sliding Window.

It is about:

* Building pattern recognition
* Reducing brute force to linear time
* Improving interview problem-solving speed
* Writing clean Swift solutions with proper notes
* Understanding why each technique works — not just how
