import Foundation

// MARK: - Problem
/*
 LC 1408 — String Matching in an Array (Easy)
 Level: L7_Pattern_Matching_KMP — Problem #103

 Given an array of strings `words`, return all strings in `words` that are
 a SUBSTRING of another word in the array. Return in any order.

 Example 1:
   Input:  words = ["mass","as","hero","superhero"]
   Output: ["as","hero"]
   ("as" is inside "mass", "hero" is inside "superhero")

 Example 2:
   Input:  words = ["leetcode","et","code"]
   Output: ["et","code"]

 Example 3:
   Input:  words = ["blue","green","bu"]
   Output: []
   ("bu" is NOT a substring of "blue" — substring means CONTIGUOUS)

 Edge cases:
   - Duplicates ["a","a"] -> ["a"] (different index counts as "another word";
     break after first hit prevents adding twice... per i it's added once,
     and each i is a separate candidate, so ["a","a"] -> ["a","a"]? NO —
     each index is its own candidate: i=0 matches j=1, i=1 matches j=0,
     so output is ["a","a"]. LeetCode accepts this (both entries qualify).
   - The longest word can never be in the answer.
   - A word never matches against itself (same index).
*/

// MARK: - Brute Force (pairwise check — this IS the intended solution)
/*
 Constraints are tiny (words.count <= 100, word length <= 30), so checking
 all pairs is the expected answer. The substring primitive is #100's
 forward scan — reused, not rewritten.

 Direction: words[i] is the NEEDLE (candidate), words[j] is the HAYSTACK
 (potential container). The answer collects needles, not haystacks.
*/

// Reused from Problem #100
func indexOfFirstOccurrenceBrute(_ haystack: String, _ needle: String) -> Int {

    if needle.isEmpty {
        return 0
    }

    if needle.count > haystack.count {
        return -1
    }

    let haystackChars = Array(haystack)
    let needleChars = Array(needle)

    let lastValidStart = haystackChars.count - needleChars.count

    for i in 0...lastValidStart {

        var j = 0

        while j < needleChars.count && haystackChars[i + j] == needleChars[j] {
            j += 1
        }

        if j == needleChars.count {
            return i
        }
    }

    return -1
}

func stringMatching(_ words: [String]) -> [String] {

    var result: [String] = []

    for i in 0..<words.count {

        for j in 0..<words.count {

            // A word never matches against itself
            if i == j {
                continue
            }

            let container = words[j]

            // Early skip: candidate can't fit inside a shorter container
            if words[i].count > container.count {
                continue
            }

            // #100's scan as the substring primitive (no .contains())
            if indexOfFirstOccurrenceBrute(container, words[i]) != -1 {
                result.append(words[i])     // append the NEEDLE, not the container
                break                       // found once — stop, no duplicates per i
            }
        }
    }

    return result
}

// MARK: - Optimised
/*
 There is no meaningful optimised version at these constraints.
 (A suffix automaton over the concatenated words exists in theory —
 nobody asks it.) Brute force IS the answer; say so confidently.
*/

// MARK: - Dry Run
/*
 words = ["mass","as","hero","superhero"]

 i=0 "mass":
   j=1 "as"        -> "mass".count > "as".count -> skip
   j=2 "hero"      -> same length as "mass", scan -> -1
   j=3 "superhero" -> scan -> -1                   -> not added
 i=1 "as":
   j=0 "mass"      -> scan finds "as" at index 1   -> append "as", break ✅
 i=2 "hero":
   j=0 "mass"      -> -1
   j=1 "as"        -> "hero".count > "as".count -> skip
   j=3 "superhero" -> found at index 5             -> append "hero", break ✅
 i=3 "superhero":
   longest word — every j either shorter (skip) or scan fails -> not added

 result = ["as","hero"] ✅
*/

// MARK: - Complexity
/*
 Time : O(k² · n · m) where k = words.count, n/m = word lengths.
        At k <= 100, length <= 30: worst ~10⁴ pairs x ~900 char ops — trivial.
 Space: O(result) + char arrays per scan.
*/

// MARK: - Traps
/*
 1. Appending words[j] (the container) instead of words[i] (the contained) —
    the "hero vs superhero" role reversal. The answer wants the SMALL word.
    (My bug 1.)
 2. Inner loop starting at j = i -> word matches itself -> everything gets
    appended. Inner loop must cover the FULL range with a j != i skip —
    containers can appear BEFORE the candidate ("as" needs "mass" at a
    lower index). (My bug 2.)
 3. .contains() — banned; #100's forward scan is the primitive. The
    argument order is (haystack, needle) — container first. (My bug 3.)
 4. Missing break -> a word contained in several others gets appended
    multiple times.
 5. "bu" vs "blue": substring requires contiguous characters — this is not
    a subsequence check.
 6. Self-check heuristic: the longest word can never appear in the output.
*/

// MARK: - Tests
let testCases: [(input: [String], expected: [String])] = [
    (["mass", "as", "hero", "superhero"], ["as", "hero"]),
    (["leetcode", "et", "code"], ["et", "code"]),
    (["blue", "green", "bu"], []),
    (["a", "a"], ["a", "a"]),               // duplicates: both indices qualify
    (["abc"], []),                            // single word — nothing to contain it
    (["a", "ab", "abc"], ["a", "ab"]),        // chain containment
    (["xyz", "x", "yz", "xy"], ["x", "yz", "xy"])
]

var testIndex = 1
for testCase in testCases {
    let result = stringMatching(testCase.input)

    // Order-independent comparison without .sorted(): count-match both ways
    var matches = result.count == testCase.expected.count
    if matches {
        for word in testCase.expected {
            var found = false
            var occurrencesExpected = 0
            var occurrencesResult = 0
            for expectedWord in testCase.expected {
                if expectedWord == word {
                    occurrencesExpected += 1
                }
            }
            for resultWord in result {
                if resultWord == word {
                    occurrencesResult += 1
                }
            }
            if occurrencesExpected == occurrencesResult {
                found = true
            }
            if found == false {
                matches = false
                break
            }
        }
    }

    let status: String
    if matches {
        status = "✅"
    } else {
        status = "❌ got \(result)"
    }

    print("Test \(testIndex) \(testCase.input): expected \(testCase.expected) \(status)")
    testIndex += 1
}

// MARK: - Interview Q&A
/*
 Q1: What's your approach?
 A : Pairwise brute force — for each candidate word, scan every other word
     as a potential container using a forward substring scan. Constraints
     (<=100 words, <=30 chars) make this trivially fast; this is the
     intended solution.

 Q2: Which word goes in the result — container or contained?
 A : The contained (needle). "as" and "hero", not "mass" and "superhero".
     Sanity check: the longest word can never be in the answer.

 Q3: Why does the inner loop cover the full range instead of j > i?
 A : Containment isn't symmetric with array order — the container may sit
     at a lower index than the candidate. Only the j == i pair is skipped.

 Q4: How do you avoid duplicate entries in the result?
 A : break after the first container is found — each candidate is appended
     at most once per index.

 Q5: Could you speed this up asymptotically?
 A : A suffix automaton (or generalized suffix tree) over all words gives
     near-linear total time, but at these constraints it's pure over-
     engineering — I'd mention it exists and stick with the pairwise scan.

 Q6: Substring vs subsequence?
 A : Substring = contiguous ("bu" is NOT in "blue"). Subsequence allows
     gaps. This problem is strictly substring.
*/
