import Foundation

// MARK: - Problem
/*
 LC 1044 — Longest Duplicate Substring (Hard)
 Level: L8_Pattern_Matching_Rabin_Karp — Problem #105

 ⚠️ STATUS: SKIPPED — concept-only. This file exists for repo completeness.
 Solution below is READ-NOT-DERIVED. Interview deliverable is the
 two-sentence concept in the Q&A, not this code. See #104 Q6.

 Given a string s, return the longest substring that occurs 2 or more
 times (occurrences may overlap). Return "" if none exists.

 Example 1:
   Input:  s = "banana"
   Output: "ana"        (occurs at index 1 and 3 — overlapping is fine)

 Example 2:
   Input:  s = "abcd"
   Output: ""

 Constraints on LeetCode: n up to 3 * 10^4 — O(n²) substring hashing TLEs;
 the intended solution is binary search + rolling hash.
*/

// MARK: - Brute Force (conceptual — do not submit)
/*
 For every length L from n-1 down to 1, run #104's hashmap-of-windows with
 windowSize = L; first L with a repeat wins. O(n²) windows x O(L) hashing
 = O(n³)-ish. Correct, TLEs. Its only value: seeing that #104 generalizes.
*/

// MARK: - Optimised (binary search on length + Rabin-Karp) — READ-NOT-DERIVED
/*
 Two composed ideas:

 1. BINARY SEARCH ON ANSWER (owned from Phase 5 — LC 875/1011/410):
    If a duplicate substring of length L exists, then a duplicate of every
    shorter length exists too (take its prefix). Monotonic predicate ->
    binary search the largest L where hasDuplicate(L) is true.

 2. ROLLING HASH (the L8 material — reference only):
    To check one length L in O(n), hash every L-window. Recomputing each
    hash costs O(L); instead treat the window as a base-26 number and
    slide: newHash = (oldHash - leftChar * base^(L-1)) * base + rightChar,
    all mod a large prime. O(1) per slide.
    Hash collisions are possible -> on hash match, optionally verify by
    direct comparison (kept here for correctness over speed).

 Total: O(n log n) expected.
*/

func longestDupSubstring(_ s: String) -> String {

    let chars = Array(s)
    let n = chars.count

    if n < 2 {
        return ""
    }

    // Map chars to 0...25 values once
    var values = [Int](repeating: 0, count: n)
    let aValue = Int(Character("a").asciiValue ?? 97)
    var index = 0
    while index < n {
        if let ascii = chars[index].asciiValue {
            values[index] = Int(ascii) - aValue
        }
        index += 1
    }

    let base = 26
    let modulus = 1_000_000_007

    // Modular multiplication safe for 64-bit: values stay < modulus (~1e9),
    // products < ~1e18 < Int.max (~9.2e18) — direct multiply is safe here.

    // Returns the start index of a duplicated window of length length,
    // or -1 if none exists.
    func startOfDuplicate(_ length: Int) -> Int {

        if length == 0 {
            return 0
        }

        // base^(length-1) mod modulus — for removing the leftmost char
        var highestPower = 1
        var powerCount = 1
        while powerCount < length {
            highestPower = (highestPower * base) % modulus
            powerCount += 1
        }

        // Hash of the first window
        var hash = 0
        var i = 0
        while i < length {
            hash = (hash * base + values[i]) % modulus
            i += 1
        }

        // hash -> list of start indices with that hash (collision buckets)
        var seen: [Int: [Int]] = [:]
        seen[hash] = [0]

        var start = 1
        let lastStart = n - length

        while start <= lastStart {

            // Slide: remove left char, append right char
            let leaving = (values[start - 1] * highestPower) % modulus
            hash = (hash - leaving + modulus) % modulus     // + modulus: avoid negative
            hash = (hash * base + values[start + length - 1]) % modulus

            if let candidates = seen[hash] {

                // Hash match — verify to rule out collisions
                for candidate in candidates {

                    var j = 0
                    while j < length && chars[candidate + j] == chars[start + j] {
                        j += 1
                    }

                    if j == length {
                        return start        // true duplicate
                    }
                }

                var updated = candidates
                updated.append(start)
                seen[hash] = updated
            } else {
                seen[hash] = [start]
            }

            start += 1
        }

        return -1
    }

    // Binary search the largest length with a duplicate
    var low = 1
    var high = n - 1
    var bestStart = -1
    var bestLength = 0

    while low <= high {

        let mid = low + (high - low) / 2
        let foundStart = startOfDuplicate(mid)

        if foundStart != -1 {
            bestStart = foundStart
            bestLength = mid
            low = mid + 1           // try longer
        } else {
            high = mid - 1          // too long — try shorter
        }
    }

    if bestStart == -1 {
        return ""
    }

    return String(chars[bestStart..<bestStart + bestLength])
}

// MARK: - Dry Run
/*
 s = "banana", n = 6
 Binary search over lengths 1...5:
   mid = 3: windows "ban","ana","nan","ana" — "ana" repeats -> found,
            bestLength = 3, try longer (low = 4)
   mid = 4: "bana","anan","nana" — no repeat -> high = 3
   low(4) > high(3) -> stop. Answer: "ana" ✅

 Monotonicity check: "ana" (3) exists -> "an" (2) and "a" (1) also
 duplicate (prefixes of the two occurrences) — which is exactly why
 binary search is valid.
*/

// MARK: - Complexity
/*
 Time : O(n log n) expected — log n binary-search steps, each an O(n)
        rolling-hash pass (collision verification adds negligible expected
        cost with a large prime modulus).
 Space: O(n) for the hash buckets per pass.
*/

// MARK: - Traps
/*
 1. Forgetting + modulus before % when removing the left char -> negative
    hash -> wrong buckets. (The classic rolling-hash bug.)
 2. Trusting hash equality without verification -> collisions produce
    wrong answers. Bucket + direct compare handles it.
 3. Binary search direction: found -> go LONGER (low = mid + 1); the
    predicate is "a duplicate of this length exists", true on the left.
 4. base^(length-1), not base^length, for the leaving character's weight.
 5. This problem TLEs the natural #104 generalization — recognizing that
    the intended solution needs BOTH binary-search-on-answer AND rolling
    hash is why it's rated Hard and why it's skipped.
*/

// MARK: - Tests
let testCases: [(input: String, expected: String)] = [
    ("banana", "ana"),
    ("abcd", ""),
    ("aa", "a"),
    ("aaaaa", "aaaa"),
    ("abcabc", "abc"),
    ("a", ""),
    ("", "")
]

var testIndex = 1
for testCase in testCases {
    let result = longestDupSubstring(testCase.input)

    let status: String
    if result == testCase.expected {
        status = "✅"
    } else {
        status = "❌ got \"\(result)\""
    }

    print("Test \(testIndex) \"\(testCase.input)\": expected \"\(testCase.expected)\" \(status)")
    testIndex += 1
}

// MARK: - Interview Q&A
/*
 Q1 (the only answer that matters — the deliverable):
 "Longest duplicate substring is binary search on the answer length —
  if a duplicate of length L exists, every shorter length has one too,
  so the predicate is monotonic — combined with a rolling hash so each
  length is checked in O(n). Total O(n log n)."

 Q2: Why rolling hash instead of a hashmap of substrings per length?
 A : Slicing/hashing each window costs O(L); over all windows that's
     O(nL) per length and O(n²) overall — TLE at n = 3*10^4. The rolling
     update is O(1) per slide.

 Q3: How do you handle hash collisions?
 A : Bucket start indices by hash; on a hash match, verify with a direct
     character comparison. With a large prime modulus, expected extra cost
     is negligible.

 Q4: Where does the binary-search pattern come from?
 A : Same monotonic predicate structure as Koko (LC 875), Ship Packages
     (LC 1011), Split Array (LC 410) — Phase 5 material. The composition
     with rolling hash is what makes this Hard.

 Q5: Would you code this in an interview?
 A : No — I'd explain the composition (Q1) and note that implementing
     modular rolling hash correctly under time pressure is high-risk,
     low-frequency. If the interviewer wants depth, I'd derive the slide
     formula on the whiteboard rather than write collision-safe code.
*/
