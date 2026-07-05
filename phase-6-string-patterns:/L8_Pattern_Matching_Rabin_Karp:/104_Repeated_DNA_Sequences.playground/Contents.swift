import Foundation

// MARK: - Problem
/*
 LC 187 — Repeated DNA Sequences (Medium) — #104
 Return all 10-letter substrings occurring MORE THAN ONCE. Any order.
 "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT" -> ["AAAAACCCCC","CCCCCAAAAA"]
 Edge: count <= 10 -> [] ; window seen 3+ times appears ONCE in output.
*/

// MARK: - Brute Force — pairwise window comparison, O(n²·10)
func dnaSequenceBruteForce(_ s: String) -> [String] {

    let chars = Array(s)
    let n = chars.count
    let windowSize = 10

    if n <= windowSize {        // <= : at 10 exactly, nothing can repeat
        return []
    }

    var result: [String] = []
    var alreadyAdded = Set<String>()
    let lastStart = n - windowSize

    for i in 0...lastStart {

        let current = String(chars[i..<i + windowSize])

        if alreadyAdded.contains(current) {
            continue
        }

        var k = i + 1           // while, not (i+1)...lastStart — no crash at i == lastStart

        while k <= lastStart {

            var j = 0
            while j < windowSize && chars[i + j] == chars[k + j] {
                j += 1
            }

            if j == windowSize {
                result.append(current)
                alreadyAdded.insert(current)
                break
            }

            k += 1
        }
    }

    return result
}

// MARK: - Optimised — fixed window + hashmap, O(n·10)
func findRepeatedDnaSequences(_ s: String) -> [String] {

    var result = [String]()
    let chars = Array(s)
    let n = chars.count
    let windowSize = 10

    if n <= windowSize {
        return result
    }

    var windowCounts = [String: Int]()
    var start = 0
    let lastStart = n - windowSize

    while start <= lastStart {

        let window = String(chars[start..<start + windowSize])

        if let existingCount = windowCounts[window] {
            let newCount = existingCount + 1
            windowCounts[window] = newCount     // persist — or counts freeze at 1

            if newCount == 2 {                  // 1->2 transition, AFTER increment
                result.append(window)
            }
        } else {
            windowCounts[window] = 1
        }

        start += 1
    }

    return result
}

// MARK: - Traps
/*
 1. existingCount == 2 instead of newCount == 2 -> fires on 3rd occurrence,
    misses windows seen exactly twice.
 2. newCount computed but never written back -> counts freeze at 1 -> always [].
 3. Guard < 10 instead of <= 10 -> invalid range crash at exactly 10 chars.
 4. Inner (i+1)...lastStart -> crash when i == lastStart; use while.
 5. Appending on count > 1 -> duplicates in output; 1->2 is the only moment.
 6. String-building windows (current += ...) -> slice once / compare by index.
*/

// MARK: - Tests
let testCases: [(String, [String])] = [
    ("AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT", ["AAAAACCCCC", "CCCCCAAAAA"]),
    ("AAAAAAAAAAAAA", ["AAAAAAAAAA"]),   // 4 occurrences -> once
    ("AAAAAAAAAAA", ["AAAAAAAAAA"]),     // exactly 2 -> catches trap 1
    ("AAAAAAAAAA", []),                    // exactly 10
    ("AAAA", []),                          // old crash case
    ("", [])
]

for (input, expected) in testCases {
    print("expected \(expected) | brute \(dnaSequenceBruteForce(input)) | optimised \(findRepeatedDnaSequences(input))")
}

// MARK: - Interview Q&A (compressed)
/*
 Pattern    : fixed sliding window + frequency hashmap (anagram-cluster
              family) — NOT Rabin-Karp, despite the folder name.
 Dedupe     : append on the 1->2 count transition, checked after increment.
 Better?    : constants only — rolling hash (O(1) window update) or 2-bit
              ACGT encoding (20-bit Int keys). Still O(n). Concept-only.
 Variable L?: LC 1044, binary search + rolling hash, Hard, skipped (#105).
*/
