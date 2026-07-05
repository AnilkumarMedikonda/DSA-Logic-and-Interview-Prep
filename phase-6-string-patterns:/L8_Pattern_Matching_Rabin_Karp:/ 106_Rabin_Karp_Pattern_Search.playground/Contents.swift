import Foundation

// MARK: - Problem
/*
 Rabin-Karp Pattern Search — #106
 ⚠️ SKIPPED — concept-only, READ-NOT-DERIVED. Repo completeness file.
 Find the first index of `needle` in `haystack` (LC 28's task) using a
 rolling hash instead of KMP or the forward scan.
 Covered by: #100 (problem + forward scan + KMP) and #105 (rolling hash).
 This file just connects the two.
*/

// MARK: - Optimised (Rabin-Karp) — reference
/*
 Idea: hash the needle once. Roll a needle-length window hash across the
 haystack in O(1) per step. On hash match, verify by direct comparison
 (hashes can collide). O(n + m) expected time.
*/

func rabinKarpSearch(_ haystack: String, _ needle: String) -> Int {

    if needle.isEmpty {
        return 0
    }

    if needle.count > haystack.count {
        return -1
    }

    let haystackChars = Array(haystack)
    let needleChars = Array(needle)
    let n = haystackChars.count
    let m = needleChars.count

    let base = 256                      // full byte alphabet
    let modulus = 1_000_000_007

    func charValue(_ char: Character) -> Int {
        if let ascii = char.asciiValue {
            return Int(ascii)
        }
        return 0
    }

    // base^(m-1) — the leaving character's weight
    var highestPower = 1
    var powerCount = 1
    while powerCount < m {
        highestPower = (highestPower * base) % modulus
        powerCount += 1
    }

    // Hash the needle and the first haystack window
    var needleHash = 0
    var windowHash = 0
    var i = 0
    while i < m {
        needleHash = (needleHash * base + charValue(needleChars[i])) % modulus
        windowHash = (windowHash * base + charValue(haystackChars[i])) % modulus
        i += 1
    }

    var start = 0
    let lastStart = n - m

    while start <= lastStart {

        if windowHash == needleHash {

            // Verify — hash equality is not string equality (collisions)
            var j = 0
            while j < m && haystackChars[start + j] == needleChars[j] {
                j += 1
            }

            if j == m {
                return start
            }
        }

        // Roll to the next window (skip after the last one)
        if start < lastStart {
            let leaving = (charValue(haystackChars[start]) * highestPower) % modulus
            windowHash = (windowHash - leaving + modulus) % modulus     // + modulus: no negatives
            windowHash = (windowHash * base + charValue(haystackChars[start + m])) % modulus
        }

        start += 1
    }

    return -1
}

// MARK: - Traps
/*
 1. Skipping verification on hash match -> collisions give wrong answers.
 2. Missing + modulus before % on the removal step -> negative hash.
 3. Leaving char's weight is base^(m-1), not base^m.
 4. Rolling past the last window -> index out of range; guard start < lastStart.
 5. Worst case degrades to O(n·m) if every window hash-collides — expected
    O(n+m) relies on a large prime modulus.
*/

// MARK: - Tests
let testCases: [(String, String, Int)] = [
    ("sadbutsad", "sad", 0),
    ("leetcode", "leeto", -1),
    ("abcbc", "bc", 1),
    ("aaaaab", "aaab", 2),
    ("mississippi", "issip", 4),
    ("a", "a", 0),
    ("ab", "abc", -1)
]

for (haystack, needle, expected) in testCases {
    let result = rabinKarpSearch(haystack, needle)
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
 "Rabin-Karp hashes the pattern once, then rolls a same-length window hash
  across the text in O(1) per step, verifying on hash match to handle
  collisions — O(n+m) expected. KMP achieves the same bound
  deterministically, so Rabin-Karp's real edge is MULTI-pattern search
  (hash many patterns into one set) and 2D matching."

 vs KMP     : same expected bound; RK is probabilistic, KMP worst-case
              guaranteed. RK wins when searching many patterns at once.
 vs #100    : the brute-force forward scan remains the coding answer for
              LC 28; both RK and KMP are name-drops.
 Code live? : No — same verdict as #102/#105. Explain, don't implement.
*/
