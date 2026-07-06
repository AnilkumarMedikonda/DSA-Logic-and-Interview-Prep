# Phase 6 — String Patterns (Problems #73–110)

Part of my DSA interview-prep journey in Swift.
Repo: [DSA-Logic-and-Interview-Prep](https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep) · Branch: `feature/string-patterns`

**Status: ✅ COMPLETE — 110/110 accounted for** (solved by hand or reference-filed by deliberate decision)

---

## Approach

Every solved problem follows the same workflow: **brute force first → optimise → review → playground file**. Each playground uses an eight-section MARK format:

`Problem → Brute Force → Optimised → Dry Run → Complexity → Traps → Tests → Interview Q&A`

House rules applied throughout:
- No predefined Swift convenience functions (`.max()`, `.reduce()`, `.sorted()`, `.contains()`)
- No force unwraps — explicit `if let / else` for all optionals
- `while` for condition-driven loops, `for-in` for bounded iteration
- `let` over `var` wherever mutation is absent

---

## Clusters

### Sliding Window — L1/L2
| Problem | LC | Status |
|---|---|---|
| Minimum Window Substring | 76 | ✅ |
| Smallest Range Covering K Lists | 632 | ✅ |

### Anagram / Permutation
| Problem | LC | Status |
|---|---|---|
| Permutation in String | 567 | ✅ |
| Find All Anagrams in a String | 438 | ✅ |
| Group Anagrams | 49 | ✅ |
| Valid Anagram | 242 | ✅ |

### Palindromes
Expand-around-center patterns, plus LC 214 (Shortest Palindrome) with `buildLPS` as read-not-derived reference.

### Two-Pointer Reversal
| Problem | LC | Status |
|---|---|---|
| Reverse String | 344 | ✅ |
| Reverse String II | 541 | ✅ |
| Reverse Words in a String | 151 | ✅ |
| Reverse Words in a String III | 557 | ✅ |
| Rotate String | 796 | ✅ |
| String Compression | 443 | ✅ first attempt |

Shared `segment-reverse` helper across the cluster.

### L7 — Pattern Matching: KMP
| # | Problem | LC | Status |
|---|---|---|---|
| 100 | Find First Occurrence in a String | 28 | ✅ solved — forward scan; KMP as reference |
| 101 | Repeated Substring Pattern | 459 | ✅ solved — divisor + modulo scan; `s+s` trick |
| 102 | Shortest Palindrome | 214 | 📖 reference (covered in palindrome cluster) |
| 103 | String Matching in an Array | 1408 | ✅ solved — pairwise scan reusing #100 |

### L8 — Pattern Matching: Rabin-Karp
| # | Problem | LC | Status |
|---|---|---|---|
| 104 | Repeated DNA Sequences | 187 | ✅ solved — fixed window + hashmap; cold rewrite done |
| 105 | Longest Duplicate Substring | 1044 | 📖 reference — binary search + rolling hash |
| 106 | Rabin-Karp Pattern Search | — | 📖 reference |
| 107 | Find All Good Strings | 1397 | 📖 concept-only — digit DP × KMP automaton |

### L9 — Pattern Matching: Z-Algorithm
| # | Problem | LC | Status |
|---|---|---|---|
| 108 | Pattern Searching Using Z-Algorithm | — | 📖 reference — Z-box construction |
| 109 | Min Characters to Add for Palindrome | — | 📖 reference — same LPS trick as #102 |
| 110 | Occurrences of Pattern in Text | — | 📖 reference — #100's scan, counting overlaps |

**Legend:** ✅ solved by hand (brute + optimised) · 📖 read-not-derived reference file (concept + interview Q&A; cold implementation deliberately not an objective)

---

## The Skip Decision (and why it's on purpose)

Full KMP, Rabin-Karp, and Z-algorithm **implementations** are deliberately deprioritized in favor of high-frequency interview patterns. At product companies, LC 28's accepted answer is the O(n·m) forward scan; the advanced algorithms are follow-up *talking points*, not coding expectations.

Each reference file therefore contains the concept, the traps, working reference code, and **the two-sentence interview answer** — e.g. for KMP:

> "KMP precomputes, for every prefix of the pattern, the longest border — a proper prefix that's also a suffix. On a mismatch we fall back to that border instead of restarting, so the text pointer never moves backwards, giving O(n+m) instead of O(n·m)."

Prep hours go where questions exist.

---

## Recurring Traps (hard-won this phase)

1. **String building in loops** (`result += String(char)`) — appeared three times (#100, #101, #104). Slice once or compare by index.
2. **Role reversal** between pattern/needle and search/haystack strings — including appending the container instead of the contained (#103).
3. **Forward scan vs converging two-pointer** — substring matching needs forward comparison.
4. **Dedupe triggers**: append on the count's 1→2 transition, checked *after* incrementing (#104 — both cold-rewrite bugs lived in these two lines).
5. **Range crashes**: `1...(n/2)` when n < 2; closed ranges that go invalid at the last iteration — `while` handles the empty case, `...` cannot.
6. **LPS build**: store the border *length* (not the index), never advance the index in the fallback branch, and build on the pattern only.

Biggest meta-lesson: **read-only code doesn't stick; derived code does.** The #104 cold rewrite failed at exactly the two lines that were read rather than derived. Attempt-first isn't a preference — it's how retention actually works.

---

## Key Reusable Primitives

- `indexOfFirstOccurrenceBrute(haystack, needle)` — the forward-scan substring search (#100), reused directly in #103, #101's s+s trick, and #110
- Segment-reverse helper — the two-pointer reversal cluster
- Fixed-window + frequency hashmap — anagram cluster and #104
- LPS build — one implementation, three uses (#100 KMP, #102/#109 palindrome prefix)

---

*Next: Phase 7 Stack (111–132) → Queue & Deque → Linked List → Trees → BST → Heap → Graph → Trie → Backtracking → Greedy → Intervals → Matrix → DP → Bit Manipulation — full plan in `ROADMAP.md` (problems 111–264, Blind75-complete). Mock interviews parallel from August. Target: August 2026.*
