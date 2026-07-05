import Foundation

// MARK: - Problem
/*
 Number of Occurrences of Pattern in Text — #110 (final Phase 6 folder)
 ⚠️ SKIPPED — concept-only. This is #108 returning a COUNT instead of the
 index list (or #100's scan counting instead of early-returning).
 Repo completeness file.

 ("sadbutsad", "sad") -> 2   |   ("aaaaa", "aa") -> 4 (overlaps count)
*/

// MARK: - Practical version — #100's forward scan, counting
/*
 At interview constraints, the O(n·m) scan with a counter IS the answer.
 The Z/KMP versions below-referenced only matter at competitive scale.
*/

func countOccurrences(_ haystack: String, _ needle: String) -> Int {

    if needle.isEmpty || needle.count > haystack.count {
        return 0
    }

    let haystackChars = Array(haystack)
    let needleChars = Array(needle)
    let lastStart = haystackChars.count - needleChars.count

    var count = 0

    for i in 0...lastStart {

        var j = 0

        while j < needleChars.count && haystackChars[i + j] == needleChars[j] {
            j += 1
        }

        if j == needleChars.count {
            count += 1          // no early return — count ALL, overlaps included
        }
    }

    return count
}

// MARK: - Traps
/*
 1. Early-returning on first match (#100 habit) — this problem wants ALL.
 2. Skipping ahead by needle.count after a match -> misses OVERLAPPING
    occurrences ("aaaaa"/"aa" is 4, not 2). Advance by 1 always.
 3. Empty needle: define as 0 here (counting convention), unlike #100's
    index convention of returning 0.
*/

// MARK: - Tests
let testCases: [(String, String, Int)] = [
    ("sadbutsad", "sad", 2),
    ("aaaaa", "aa", 4),          // overlaps — the trap 2 case
    ("leetcode", "leeto", 0),
    ("abababa", "aba", 3),       // overlapping again
    ("a", "a", 1),
    ("ab", "abc", 0)
]

for (haystack, needle, expected) in testCases {
    let result = countOccurrences(haystack, needle)
    let status: String
    if result == expected {
        status = "✅"
    } else {
        status = "❌ got \(result)"
    }
    print("(\"\(haystack)\", \"\(needle)\"): expected \(expected) \(status)")
}

// MARK: - Interview Q&A (the deliverable)
/*
 "Same scan as LC 28, counting every full match instead of returning the
  first — advancing by 1 each time so overlapping occurrences count.
  At scale, Z-array (#108) or KMP (#100) gives the count in O(n+m):
  with Z, count positions where z == pattern length; with KMP, count the
  times the match state reaches full and fall back via lps to continue."

 --- PHASE 6 CLOSES HERE ---
 L7: 100 ✅ 101 ✅ 102 ✓ref 103 ✅
 L8: 104 ✅ 105 ✓ref 106 ✓ref 107 ✓concept
 L9: 108 ✓ref 109 ✓ref 110 ✓ref
 Solved with own hands: 100, 101, 103, 104 (+ cold rewrites).
 Read-not-derived reference: KMP/LPS, rolling hash, Z-array.
 Next: Linked List / Stack.
*/
