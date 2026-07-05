import Foundation

// MARK: - Problem
/*
 Pattern Searching Using Z-Algorithm — #108
 ⚠️ SKIPPED — concept-only, READ-NOT-DERIVED. Repo completeness file.
 Same task as #100/#106: find occurrences of `needle` in `haystack`,
 this time via the Z-array. Third linear-time tool for the same job.
*/

// MARK: - Concept
/*
 Z-ARRAY: for string t, z[i] = length of the longest substring starting at
 i that matches a PREFIX of t. (Compare with LPS, which looks at borders
 ENDING at i — Z looks forward from i, LPS looks backward to i.)

 Example: t = "aabxaab"
   index:  0  1  2  3  4  5  6
   z:      -  1  0  0  3  1  0
   (z[4] = 3: "aab" starting at 4 matches the prefix "aab")

 PATTERN SEARCH: build combined = needle + "#" + haystack, compute its
 Z-array; every position where z[i] == needle.count is a full match.
 O(n + m) time — the Z-box trick (maintaining an interval [l, r] of the
 rightmost prefix-match found so far and reusing earlier z-values inside
 it) is what makes the construction linear.
*/

// MARK: - Optimised (Z-algorithm) — reference
func zAlgorithmSearch(_ haystack: String, _ needle: String) -> [Int] {

    if needle.isEmpty || needle.count > haystack.count {
        return []
    }

    let needleChars = Array(needle)
    let haystackChars = Array(haystack)
    let m = needleChars.count

    // combined = needle + "#" + haystack
    var combined = [Character]()
    for char in needleChars {
        combined.append(char)
    }
    combined.append("#")
    for char in haystackChars {
        combined.append(char)
    }

    let total = combined.count
    var z = [Int](repeating: 0, count: total)

    // Z-box [left, right]: rightmost interval matching a prefix
    var left = 0
    var right = 0
    var i = 1

    while i < total {

        if i < right {
            // Inside the box: reuse the mirrored value, capped at the box edge
            let mirrored = z[i - left]
            let remaining = right - i
            if mirrored < remaining {
                z[i] = mirrored
            } else {
                z[i] = remaining
            }
        }

        // Extend past the box by direct comparison
        while i + z[i] < total && combined[z[i]] == combined[i + z[i]] {
            z[i] += 1
        }

        // Update the box if this match reaches further right
        if i + z[i] > right {
            left = i
            right = i + z[i]
        }

        i += 1
    }

    // Positions in combined where the full needle matches -> haystack indices
    var result = [Int]()
    var position = m + 1        // first haystack char in combined

    while position < total {
        if z[position] == m {
            result.append(position - m - 1)
        }
        position += 1
    }

    return result
}

// MARK: - Traps
/*
 1. Z vs LPS confusion: Z looks FORWARD from i (prefix match starting at i);
    LPS looks at borders ENDING at i. Different arrays, related uses.
 2. Forgetting the "#" separator -> needle can match across the boundary.
 3. Inside-the-box value must be capped at right - i (can't trust the
    mirror past the verified region) — uncapped copy is the classic Z bug.
 4. Haystack index recovery: position - needle.count - 1 (the separator!).
*/

// MARK: - Tests
let testCases: [(String, String, [Int])] = [
    ("sadbutsad", "sad", [0, 6]),          // finds ALL occurrences (vs #100's first)
    ("aaaaa", "aa", [0, 1, 2, 3]),
    ("leetcode", "leeto", []),
    ("abcbc", "bc", [1, 3]),
    ("a", "a", [0])
]

for (haystack, needle, expected) in testCases {
    let result = zAlgorithmSearch(haystack, needle)
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
 THE sentence:
 "The Z-array stores, for each position, how long a prefix of the string
  repeats starting there; building needle + '#' + haystack and reading
  positions where z equals the needle length finds all matches in O(n+m)."

 vs KMP : same bound, arguably simpler to reason about; KMP is the
          standard name-drop, Z is the contest tool. Knowing both exist
          is plenty.
 Note   : unlike #100's scan (first occurrence), this naturally returns
          ALL occurrences — the one practical edge worth remembering.
*/
