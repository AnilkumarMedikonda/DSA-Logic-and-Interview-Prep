import Foundation

//  241_Word_Break.swift
//  LeetCode 139
//
//  PROBLEM
//  Given a string s and a list of words, return true if s can be
//  broken into a sequence of dictionary words. Words are REUSABLE.
//
//  EXAMPLE
//  s = "leetcode",      dict = ["leet", "code"]                  ->  true
//  s = "applepenapple", dict = ["apple", "pen"]                  ->  true
//  s = "catsandog",     dict = ["cats","dog","sand","and","cat"] ->  false
//
//  CONSTRAINTS
//  1 <= s.count <= 300
//  1 <= wordDict.count <= 1000
//  1 <= wordDict[i].count <= 20
//
//  THE REFRAME — this is Coin Change with strings.
//    Coin Change : can I reach AMOUNT 11 using these coins?
//    Word Break  : can I reach POSITION 8 using these words?
//  Words reusable -> UNBOUNDED, loop runs FORWARDS.
//  (Partition Equal Subset Sum was 0/1, so it ran backwards.)
//
//  THE SIX LINES
//  1. STATE       dp[i] = can the first i characters be broken?
//  2. OPTIONS     for every earlier j, is chars[j..<i] a word?
//  3. COMBINER    ||   (feasibility)
//  4. TRANSITION  dp[i] = dp[j] && chars[j..<i] is in the dictionary
//  5. BASE        dp[0] = true   (empty prefix is breakable)
//  6. ANSWER      dp[n]
//
//  SWIFT NOTE: Swift strings cannot be indexed by Int. Convert to
//  [Character] once and work with plain integers.

let s = "leetcode"
let words = ["leet", "code"]

//====================================================
// MARK: - Manual helper : distinct word lengths
//====================================================

func distinctLengths(_ wordDict: [String]) -> Set<Int> {

    var lengths = Set<Int>()

    for word in wordDict {
        lengths.insert(word.count)
    }
    return lengths
}

//====================================================
// MARK: - Solution 1 : Normal DP
// Time  : O(n^2 * k)   k = substring build cost
// Space : O(n)
//====================================================

func wordBreakNormal(_ s: String, _ wordDict: [String]) -> Bool {

    let chars = Array(s)
    let n = chars.count

    if n == 0 {
        return true
    }

    var wordSet = Set<String>()

    for word in wordDict {
        wordSet.insert(word)
    }

    var dp = Array(repeating: false, count: n + 1)
    dp[0] = true

    for i in 1...n {

        // j must stay BEFORE i — chars[j..<i] needs j <= i
        for j in 0..<i {

            if dp[j] {

                let word = String(chars[j..<i])

                if wordSet.contains(word) {
                    dp[i] = true

                    break
                }
            }
        }
    }
    return dp[n]
}

print("[1] Normal DP  :", wordBreakNormal(s, words))

print("")

//====================================================
// MARK: - Solution 2 : Optimized DP   <-- INTERVIEW ANSWER
// Time  : O(n * L * k)   L = number of DISTINCT word lengths
// Space : O(n)
//====================================================
//
// Instead of scanning every earlier j, only try the lengths that a
// dictionary word could actually have. With 1000 words but only 5
// distinct lengths, the inner loop runs 5 times, not 300.

func wordBreakOptimized(_ s: String, _ wordDict: [String]) -> Bool {

    let chars = Array(s)
    let n = chars.count

    if n == 0 {
        return true
    }

    var wordSet = Set<String>()

    for word in wordDict {
        wordSet.insert(word)
    }

    let wordLengths = distinctLengths(wordDict)

    var dp = Array(repeating: false, count: n + 1)
    dp[0] = true

    for i in 1...n {

        for length in wordLengths {

            // word too long to end at i
            if length > i {
                continue
            }

            let start = i - length

            // the part before this word must itself be breakable
            if !dp[start] {
                continue
            }

            let word = String(chars[start..<i])

            if wordSet.contains(word) {
                dp[i] = true

                break
            }
        }
    }
    return dp[n]
}

print("[2] Optimized  :", wordBreakOptimized(s, words))

print("")

//====================================================
// MARK: - Traced version
//====================================================

func wordBreakTrace(_ s: String, _ wordDict: [String]) -> Bool {

    let chars = Array(s)
    let n = chars.count

    if n == 0 {
        return true
    }

    var wordSet = Set<String>()

    for word in wordDict {
        wordSet.insert(word)
    }

    let wordLengths = distinctLengths(wordDict)

    var dp = Array(repeating: false, count: n + 1)
    dp[0] = true

    print("s = \"\(s)\"   dict = \(wordDict)")

    print("distinct lengths = \(wordLengths)")

    print("start dp = \(dp)")

    for i in 1...n {

        print("\ni = \(i)   prefix = \"\(String(chars[0..<i]))\"")

        for length in wordLengths {

            if length > i {
                print("   length \(length)  too long, skip")

                continue
            }

            let start = i - length

            if !dp[start] {
                print("   length \(length)  dp[\(start)] is false, skip")

                continue
            }

            let word = String(chars[start..<i])

            if wordSet.contains(word) {
                dp[i] = true

                print("   length \(length)  \"\(word)\" IS a word and dp[\(start)] is true  ->  dp[\(i)] = true")

                break

            } else {
                print("   length \(length)  \"\(word)\" not a word")
            }
        }
    }

    print("\nfinal dp = \(dp)")

    return dp[n]
}

print("=========================================")

print("  TRACE   \"catsandog\"")

print("=========================================")

print("result :", wordBreakTrace("catsandog", ["cats", "dog", "sand", "and", "cat"]))

print("")

//====================================================
// MARK: - Verify
//====================================================

let cases: [(String, [String], Bool)] = [
    ("leetcode",      ["leet", "code"],                      true),
    ("applepenapple", ["apple", "pen"],                      true),
    ("catsandog",     ["cats", "dog", "sand", "and", "cat"], false),
    ("a",             ["a"],                                 true),
    ("ab",            ["a"],                                 false),
    ("aaaaaaa",       ["aaa", "aaaa"],                        true)
]

print("=========================================")

print("  VERIFY")

print("=========================================")

for (text, dict, expected) in cases {

    let a = wordBreakNormal(text, dict)
    let b = wordBreakOptimized(text, dict)
    let ok = (a == expected && b == expected)

    print("\"\(text)\"  ->  normal \(a)  opt \(b)   expected \(expected)   \(ok ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Why Solution 2 is the interview answer
//====================================================
//
//  Say these in order:
//    1. "dp[i] means the first i characters can be fully broken."
//    2. "dp[0] is true — an empty prefix needs no words."
//    3. [write the code]
//    4. "For each position I check every word that could END there.
//        The word fits only if the part before it was breakable."
//    5. "Words are reusable, so this is unbounded and the loop runs
//        forwards. Partition Equal Subset Sum was 0/1 and ran
//        backwards."
//
//  The length-set trick in step 3 is worth calling out too: with
//  1000 words but 5 distinct lengths, the inner loop is 5, not 300.

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. Inner loop must be `0..<i`, NOT `0..<n`. chars[j..<i] traps
//     when j > i. It survives only because dp[j] is false for
//     j > i — relying on an accident.
//  2. Swift strings are not Int-indexable. Convert to [Character]
//     once; do not fight String.Index inside the loop.
//  3. Check `length <= i` BEFORE computing i - length, or you index
//     a negative slot.
//  4. dp[start] must be checked too. A word matching at the right
//     place is useless if the part before it was unbreakable —
//     "catsandog" fails exactly here.
//  5. `break` after setting dp[i] = true — one match is enough.
