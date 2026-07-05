# 📒 Phase 6 — String Patterns ✅ COMPLETE

---

## 🧠 Objective

Build strong problem-solving skills using core string patterns by focusing on:

* Sliding Window on strings — minimum window, multi-list range
* Anagram and Permutation — frequency map matching
* Palindromes — expand around center
* Two Pointer Reversal — in-place segment reversal
* Substring Search — forward scan two pointer
* Fixed Window + HashMap — frequency tracking with dedupe
* Pattern Matching concepts — KMP / LPS, Rabin-Karp rolling hash, Z-Algorithm
* Knowing when an algorithm is a coding expectation vs an interview talking point
* Reducing string-building O(n) extra space solutions to in-place index-based solutions

This phase focuses on understanding how to:
👉 Solve the high-frequency string problems by hand, and explain the advanced algorithms in two sentences — prep hours go where questions exist.

---

## 📌 Topics Covered

### L1 — Sliding Window
* Minimum Window Substring — LC 76
* Smallest Range Covering Elements from K Lists — LC 632

### L2 — Anagram / Permutation
* Permutation In String — LC 567
* Find All Anagrams In A String — LC 438
* Group Anagrams — LC 49
* Valid Anagram — LC 242

### L3 — Palindromes
* Expand Around Center patterns
* Shortest Palindrome — LC 214 (KMP — read-not-derived)

### L4 — Two Pointer Reversal
* Reverse String — LC 344
* Reverse String II — LC 541
* Reverse Words In A String — LC 151
* Reverse Words In A String III — LC 557
* Rotate String — LC 796
* String Compression — LC 443

### L7 — Pattern Matching (KMP)
* Find The Index Of The First Occurrence In A String — LC 28
* Repeated Substring Pattern — LC 459
* Shortest Palindrome — LC 214 📖
* String Matching In An Array — LC 1408

### L8 — Pattern Matching (Rabin-Karp)
* Repeated DNA Sequences — LC 187
* Longest Duplicate Substring — LC 1044 📖
* Rabin-Karp Pattern Search 📖
* Find All Good Strings — LC 1397 📖

### L9 — Pattern Matching (Z-Algorithm)
* Pattern Searching Using Z-Algorithm 📖
* Minimum Characters To Add For Palindrome 📖
* Number Of Occurrences Of Pattern In Text 📖

---

## 🧩 Problems Practiced

> ⚠️ Fill in exact problem numbers for 73–99 from the repo folder names — L7–L9 numbering below is final.

### L1 — Sliding Window ✅
* Minimum Window Substring — LC 76
* Smallest Range Covering Elements from K Lists — LC 632

### L2 — Anagram / Permutation ✅
* Permutation In String — LC 567
* Find All Anagrams In A String — LC 438
* Group Anagrams — LC 49
* Valid Anagram — LC 242

### L3 — Palindromes ✅
* Expand Around Center cluster
* Shortest Palindrome — LC 214 📖 read-not-derived

### L4 — Two Pointer Reversal (6 problems) ✅
* Reverse String — LC 344
* Reverse String II — LC 541
* Reverse Words In A String — LC 151
* Reverse Words In A String III — LC 557
* Rotate String — LC 796
* String Compression — LC 443 (solved first attempt)

### L7 — Pattern Matching KMP (4 problems) ✅
* 100 Find The Index Of The First Occurrence In A String — LC 28 ✅
* 101 Repeated Substring Pattern — LC 459 ✅
* 102 Shortest Palindrome — LC 214 📖
* 103 String Matching In An Array — LC 1408 ✅

### L8 — Pattern Matching Rabin-Karp (4 problems) ✅
* 104 Repeated DNA Sequences — LC 187 ✅ (+ cold rewrite retention check)
* 105 Longest Duplicate Substring — LC 1044 📖
* 106 Rabin-Karp Pattern Search 📖
* 107 Find All Good Strings — LC 1397 📖 concept-only

### L9 — Pattern Matching Z-Algorithm (3 problems) ✅
* 108 Pattern Searching Using Z-Algorithm 📖
* 109 Minimum Characters To Add For Palindrome 📖
* 110 Number Of Occurrences Of Pattern In Text 📖

✅ solved by hand (brute force + optimised) · 📖 read-not-derived reference file (concept + traps + interview Q&A; cold implementation deliberately not an objective)

---

## ✅ Phase 6 Total: Problems 73–110 Completed

```
L1 Sliding Window               2
L2 Anagram / Permutation        4
L3 Palindromes                  (fill from repo)
L4 Two Pointer Reversal         6
L7 Pattern Matching KMP         4   (3 solved + 1 reference)
L8 Pattern Matching Rabin-Karp  4   (1 solved + 3 reference)
L9 Pattern Matching Z-Algorithm 3   (3 reference)
──────────────────────────────────
Total                          38   (73–110)
```

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
9. For advanced algorithms — decide: code it, or explain it?

---

## ⚙️ Key Learnings

### Sliding Window on Strings
* expand right → shrink left when invalid — same shape as array windows
* Character frequency map + "formed count" instead of numeric sums
* Remove key from HashMap when count hits 0

### Anagram / Permutation
* Fixed window size = pattern length — slide by 1, update two map entries
* Compare frequency maps, or track a matched-characters counter
* Canonical key (sorted chars or count signature) groups anagrams

### Palindromes
* Expand around center — two calls per index (odd and even centers)
* Converging two pointer for validity checks only — expansion goes outward

### Two Pointer Reversal
* Segment-reverse helper — one function, reused across the whole cluster
* Reverse whole string then reverse each word — LC 151 shape
* Rotation check: rotated s is always a substring of s + s

### Substring Search (Forward Scan)
* Substring matching needs FORWARD scan — not converging two pointer
* Outer loop bound 0...(n - m) — only starts where needle still fits
* Compare chars[i + j] == needleChars[j] by index — never build strings in loops
* Default return -1, empty needle → 0

### Repeated Patterns
* Unit length must divide n evenly and can be at most n/2
* Verify in place: chars[i] == chars[i % len]
* s + s trick: repeated string appears inside (s+s) with first and last chars dropped
* Guard n < 2 before 1...(n/2) — invalid range crashes at runtime

### Fixed Window + HashMap
* Dedupe trigger: append exactly on the 1 → 2 count transition
* Check newCount AFTER incrementing — old count fires on 3rd occurrence
* Persist the incremented count back to the map — or counts freeze at 1
* Overlapping windows count — advance by 1 always, never by window size

### KMP / LPS (Read Not Derived)
* lps[i] = longest proper prefix that is also a suffix ending at i
* Meaning: "on mismatch, how much have I secretly already re-matched?"
* Store border LENGTH not index; fallback branch must NOT advance index
* Search jump is j = lps[j-1] — text pointer never moves backwards
* s + "#" + reversed(s) → LPS last value = longest palindromic prefix
* The "#" separator caps the border at s's true length

### Rabin-Karp / Z-Algorithm (Read Not Derived)
* Rolling hash slide: subtract leaving char × base^(m-1), multiply by base, add entering char
* + modulus before % — negative hash is THE classic rolling hash bug
* Hash equality is not string equality — always verify on match
* Rabin-Karp's real edge: MULTI-pattern search, not single pattern
* Z looks FORWARD from i (prefix match starting at i); LPS looks at borders ENDING at i
* Binary search on answer + rolling hash = Longest Duplicate Substring (monotonic predicate from Phase 5)

---

## ⚙️ Pattern Recognition

| Pattern | Trigger Words |
|---------|--------------|
| Sliding Window (string) | minimum window, substring containing, covering |
| Anagram / Permutation | anagram, permutation, rearrangement, same letters |
| Expand Around Center | longest palindromic substring, count palindromes |
| Two Pointer Reversal | reverse in place, reverse words, rotate string |
| Forward Scan Search | first occurrence, strStr, needle in haystack |
| Repeated Unit | repeated substring, constructed by copies |
| Fixed Window + HashMap | fixed-length substrings occurring more than once |
| KMP (talking point) | "can you do better than O(n·m)?" |
| Binary Search + Rolling Hash | longest duplicate, variable-length repeats (explain, don't code) |
| s + s Trick | rotation, repeated pattern |

---

## 🔑 Biggest Meta-Lesson

**Read-only code doesn't stick; derived code does.** The #104 cold rewrite failed at exactly the two lines that were read rather than derived. Attempt-first is how retention works.

---

## 🎯 Next Phase

**Phase 7 — Linked List / Stack** 🚀
Pointer reversal, fast/slow pointers, cycle detection, merge patterns, monotonic stack, and stack-based parsing — starting with LC 206 Reverse Linked List, the most-asked linked list question at every target company.
