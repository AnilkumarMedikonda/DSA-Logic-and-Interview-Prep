import Foundation

//  242_Decode_Ways.swift
//  LeetCode 91
//
//  PROBLEM
//  Letters A–Z are encoded as numbers: 'A' -> "1" ... 'Z' -> "26".
//  Given a digit string, return the NUMBER OF WAYS to decode it.
//
//  EXAMPLE
//  s = "12"   ->  2      "AB" (1 2)  or  "L" (12)
//  s = "226"  ->  3      "BZ", "VF", "BBF"
//  s = "06"   ->  0      leading zeros are not allowed
//
//  CONSTRAINTS
//  1 <= s.count <= 100
//  digits only, may contain leading zeros
//
//  THE SHAPE — Climbing Stairs with rules.
//  At each position take ONE digit or TWO digits, exactly like
//  taking 1 step or 2 steps. The difference: some moves are illegal.
//
//  THE SIX LINES
//  1. STATE       dp[i] = number of ways to decode the first i chars
//  2. OPTIONS     one digit  -> valid if it is not '0'
//                 two digits -> valid if the pair is 10...26
//  3. COMBINER    +   (counting problem)
//  4. TRANSITION  dp[i] = dp[i-1] (if one-digit ok)
//                       + dp[i-2] (if two-digit ok)
//  5. BASE        dp[0] = 1   (one way to decode nothing)
//  6. ANSWER      dp[n]
//
//  THE TWO-DIGIT CHECK WITHOUT CONVERSION
//  A valid pair is 10...26, which means:
//     first digit is "1"  -> any second digit
//     first digit is "2"  -> second digit up to "6"
//  Leading zeros are excluded automatically — "0" is neither.
//  No string building, no optional, no force unwrap.

//====================================================
// MARK: - Shared helper : is chars[i-2], chars[i-1] a valid pair?
//====================================================

func isValidPair(_ first: Character, _ second: Character) -> Bool {

    if first == "1" {
        return true
    }

    if first == "2" && second <= "6" {
        return true
    }
    return false
}

//====================================================
// MARK: - Solution 1 : Tabulation
// Time  : O(n)
// Space : O(n)   the dp array
//====================================================

func numDecodings(_ s: String) -> Int {

    let chars = Array(s)
    let n = chars.count

    if n == 0 {
        return 0
    }

    var dp = Array(repeating: 0, count: n + 1)

    dp[0] = 1

    if chars[0] != "0" {
        dp[1] = 1
    }

    // guard BEFORE the loop — 2...1 traps when n == 1
    if n == 1 {
        return dp[1]
    }

    for i in 2...n {

        // one digit
        if chars[i-1] != "0" {
            dp[i] += dp[i-1]
        }

        // two digits
        if isValidPair(chars[i-2], chars[i-1]) {
            dp[i] += dp[i-2]
        }
    }
    return dp[n]
}

print("[1] Tabulation :", numDecodings("12"))

print("")

//====================================================
// MARK: - Solution 2 : Space Optimized   <-- INTERVIEW ANSWER
// Time  : O(n)
// Space : O(1)   transition reaches back exactly 2
//====================================================

func numDecodingsOptimized(_ s: String) -> Int {

    let chars = Array(s)
    let n = chars.count

    if n == 0 {
        return 0
    }

    var prev2 = 1                                // dp[0]
    var prev1 = chars[0] == "0" ? 0 : 1          // dp[1]

    if n == 1 {
        return prev1
    }

    for i in 2...n {

        var current = 0

        // one digit
        if chars[i-1] != "0" {
            current += prev1
        }

        // two digits
        if isValidPair(chars[i-2], chars[i-1]) {
            current += prev2
        }

        prev2 = prev1
        prev1 = current
    }
    return prev1
}

print("[2] Optimized  :", numDecodingsOptimized("12"))

print("")

//====================================================
// MARK: - Traced version
//====================================================

func numDecodingsTrace(_ s: String) -> Int {

    let chars = Array(s)
    let n = chars.count

    if n == 0 {
        return 0
    }

    var dp = Array(repeating: 0, count: n + 1)

    dp[0] = 1

    if chars[0] != "0" {
        dp[1] = 1
    }

    print("s = \"\(s)\"")

    print("dp[0] = 1   (empty string, one way)")

    print("dp[1] = \(dp[1])   (first char is \"\(chars[0])\")")

    if n == 1 {
        print("\nanswer = \(dp[1])")

        return dp[1]
    }

    for i in 2...n {

        print("\ni = \(i)   looking at \"\(chars[i-2])\" and \"\(chars[i-1])\"")

        if chars[i-1] != "0" {
            dp[i] += dp[i-1]

            print("   one digit \"\(chars[i-1])\" is valid   += dp[\(i-1)] = \(dp[i-1])   dp[\(i)] = \(dp[i])")

        } else {
            print("   one digit \"0\" is invalid, skip")
        }

        if isValidPair(chars[i-2], chars[i-1]) {
            dp[i] += dp[i-2]

            print("   two digits \"\(chars[i-2])\(chars[i-1])\" in 10...26   += dp[\(i-2)] = \(dp[i-2])   dp[\(i)] = \(dp[i])")

        } else {
            print("   two digits \"\(chars[i-2])\(chars[i-1])\" not in 10...26, skip")
        }
    }

    print("\nfinal dp = \(dp)")

    return dp[n]
}

print("=========================================")

print("  TRACE   \"226\"")

print("=========================================")

print("result :", numDecodingsTrace("226"))

print("")

print("=========================================")

print("  TRACE   \"100\"   (the zero trap)")

print("=========================================")

print("result :", numDecodingsTrace("100"))

print("")

//====================================================
// MARK: - Verify
//====================================================

let cases: [(String, Int)] = [
    ("12",     2),
    ("226",    3),
    ("06",     0),
    ("0",      0),
    ("10",     1),
    ("100",    0),
    ("1",      1),
    ("27",     1),
    ("2101",   1),
    ("11106",  2)
]

print("=========================================")

print("  VERIFY")

print("=========================================")

for (text, expected) in cases {

    let a = numDecodings(text)
    let b = numDecodingsOptimized(text)
    let ok = (a == expected && b == expected)

    print("\"\(text)\"  ->  tab \(a)  opt \(b)   expected \(expected)   \(ok ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. `for i in 2...n` TRAPS when n == 1. Guard before the loop —
//     same trap as Coin Change with amount == 0.
//  2. Two-digit range is 10...26, NOT 1...26. "06" is 6, which is
//     inside 1...26 but still invalid because of the leading zero.
//  3. "0" alone -> 0 ways. Nothing maps to 0.
//  4. "10" -> 1 way. The 0 cannot stand alone but 10 works as a pair.
//  5. "100" -> 0 ways. 10 is fine, then the trailing 0 is stranded.
//  6. Comparing characters directly avoids Int(String(...))! —
//     no force unwrap, no built-in conversion, same result.
//  7. dp[0] = 1, not 0. The combiner is +, so the identity is 1.
