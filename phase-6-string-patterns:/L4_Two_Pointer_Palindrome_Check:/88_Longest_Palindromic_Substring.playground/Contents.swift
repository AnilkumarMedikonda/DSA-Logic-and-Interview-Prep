import Foundation

// MARK: - Problem
/*
 #88 — LC 5: Longest Palindromic Substring (Medium)

 Given a string `s`, return the LONGEST SUBSTRING of `s` that is a
 palindrome. Substring = contiguous. Return the string, not the length.

 Examples:
   "babad"   -> "bab"   ("aba" is equally valid)
   "cbbd"    -> "bb"
   "a"       -> "a"
   "ac"      -> "a"     (any single char)
   "racecar" -> "racecar"

 Constraints:
   1 <= s.count <= 1000
   s consists of letters and digits.

 Pattern: Expand Around Center (Two Pointers, diverging)
 Inversion from #87: there pointers CONVERGE inward to VERIFY a
 palindrome; here they DIVERGE outward to DISCOVER one.
*/

// MARK: - Brute Force
/*
 Idea:
   Check every substring (i, j) for palindrome-ness; keep the longest.

 Why it fails at scale:
   n^2 substrings x O(n) check = O(n^3).
   n = 1000 -> ~10^9 ops -> borderline TLE.

 Note: helper takes ([Character], left, right) — no string building,
 no String -> Array conversion per check (both are hidden O(n) costs).
*/

func isPalindrome(_ chars: [Character], _ left: Int, _ right: Int) -> Bool {
    var left = left
    var right = right

    while left < right {
        if chars[left] != chars[right] {
            return false
        }
        left += 1
        right -= 1
    }

    return true
}

func longestPalindromeBruteForce(_ s: String) -> String {
    let words = Array(s)
    var bestStart = 0
    var bestLength = 1   // constraint guarantees count >= 1

    for i in 0..<words.count {
        for j in i..<words.count {
            let length = j - i + 1
            if length > bestLength && isPalindrome(words, i, j) {
                bestStart = i
                bestLength = length
            }
        }
    }

    return String(words[bestStart..<(bestStart + bestLength)])
}

// MARK: - Optimised
/*
 Idea (Expand Around Center):
   Every palindrome has a center. Stand at each center and grow
   left/right outward while chars match — finds the longest palindrome
   AT that center in one pass.

 Centers: 2n - 1 total.
   - n odd centers:   ON each char        -> expand(i, i)
   - n-1 even centers: BETWEEN char pairs -> expand(i, i+1)  <- "bb" case

 expand returns only the LENGTH; start/end are reconstructed from
 center index i:
   start = i - (len - 1) / 2
   end   = i + len / 2
 The asymmetry (len-1 vs len) makes one formula work for BOTH parities:
   odd  "bab": i=1, len=3 -> start = 1 - 1 = 0, end = 1 + 1 = 2  ✓
   even "bb" : i=1, len=2 -> start = 1 - 0 = 1, end = 1 + 1 = 2  ✓
 (Alternative: return (start, length) tuple from expand — less math
  to fumble under interview pressure.)
*/

func expand(_ chars: [Character], _ left: Int, _ right: Int) -> Int {
    var left = left
    var right = right

    while left >= 0 && right < chars.count && chars[left] == chars[right] {
        left -= 1
        right += 1
    }

    // loop overshot by one on both sides:
    // valid palindrome is [left+1, right-1], length = right - left - 1
    return right - left - 1
}

func longestPalindrome(_ s: String) -> String {
    let words = Array(s)
    var start = 0
    var end = 0

    for i in 0..<words.count {
        let oddLength = expand(words, i, i)
        let evenLength = expand(words, i, i + 1)

        let len = oddLength > evenLength ? oddLength : evenLength

        if len > end - start + 1 {
            start = i - (len - 1) / 2
            end = i + len / 2
        }
    }

    return String(words[start...end])
}

// MARK: - Dry Run
/*
 longestPalindrome("cbbd"), chars = [c, b, b, d]

 i = 0 ('c'):
   odd  expand(0,0): 'c'=='c' ✓ -> left=-1, right=1 -> -1 >= 0 ✗ stop
        return 1 - (-1) - 1 = 1                       // "c"
   even expand(0,1): 'c' != 'b' ✗ loop never runs
        return 1 - 0 - 1 = 0                          // empty
   len = 1 > (0 - 0 + 1 = 1)? NO -> keep start=0, end=0

 i = 1 ('b'):
   odd  expand(1,1): 'b'=='b' ✓ -> left=0, right=2
                     'c' != 'b' ✗ stop -> 2 - 0 - 1 = 1   // "b"
   even expand(1,2): 'b'=='b' ✓ -> left=0, right=3     <- FINDS ANSWER
                     'c' != 'd' ✗ stop -> 3 - 0 - 1 = 2   // "bb"
   len = 2 > 1 ✓
     start = 1 - (2-1)/2 = 1 - 0 = 1
     end   = 1 + 2/2     = 1 + 1 = 2                   // [1, 2] = "bb"

 i = 2 ('b'):
   odd  expand(2,2) -> 'b' vs 'd' after one step -> 1  // "b"
   even expand(2,3) -> 'b' != 'd' -> 0
   len = 1 > 2? NO

 i = 3 ('d'):
   odd  expand(3,3) -> 1                               // "d"
   even expand(3,4) -> right=4 < 4 ✗ immediately -> 0  // no crash!
   len = 1 > 2? NO

 Result: words[1...2] = "bb" ✓

 Off-by-one intuition for expand:
   the loop moves pointers THEN the next check fails, so on exit
   left/right sit ONE step OUTSIDE the palindrome. Step back in:
   length = (right-1) - (left+1) + 1 = right - left - 1.
   Immediate mismatch -> formula gives 0 naturally, no special case.
*/

// MARK: - Complexity
/*
 Brute Force:
   Time:  O(n^3) — n^2 substrings x O(n) palindrome check
   Space: O(n)   — char array

 Optimised (Expand Around Center):
   Time:  O(n^2) — (2n - 1) centers x O(n) worst-case expansion
   Space: O(n) for Array(s); O(1) extra beyond it

 Why optimised wins: expansion STOPS at first mismatch instead of
 re-checking whole substrings from scratch.

 (O(n) exists — Manacher's algorithm — but expand-around-center is
  the expected interview answer; don't chase Manacher's yet.)
*/

// MARK: - Traps
/*
 1. MISSING EVEN CENTERS — the #1 bug. Only expanding (i, i) misses
    every even-length palindrome; "cbbd" returns "c" instead of "bb".
    There are 2n - 1 centers, not n.

 2. Off-by-one in expand's return: on loop exit, pointers are one step
    OUTSIDE the palindrome -> length = right - left - 1 (not right - left + 1).

 3. Center-math reconstruction: start = i - (len-1)/2, end = i + len/2.
    Forgetting the -1 breaks odd lengths; using -1 in both breaks even.
    If unsure under pressure, return (start, length) from expand instead.

 4. Building substrings inside the loop (newStr += ...) or converting
    String <-> Array per check: hidden O(n) copies that silently
    inflate brute force beyond O(n^3). Index on ONE shared array.

 5. expand(i, i+1) at the last index: right < chars.count fails
    immediately and returns 0 — the guard is INSIDE the while
    condition, so no explicit bounds check is needed. Know why.

 6. Slicing Swift strings in a hot loop is expensive — track indices,
    slice ONCE at the end.

 7. max(_:_:) is a predefined function — use the ternary comparison
    per house rules.
*/

// MARK: - Tests
print("--- Brute Force ---")
print(longestPalindromeBruteForce("babad"))    // "bab" (or "aba")
print(longestPalindromeBruteForce("cbbd"))     // "bb"
print(longestPalindromeBruteForce("a"))        // "a"
print(longestPalindromeBruteForce("ac"))       // "a"
print(longestPalindromeBruteForce("aaaa"))     // "aaaa"
print(longestPalindromeBruteForce("racecar"))  // "racecar"

print("--- Optimised ---")
print(longestPalindrome("babad"))    // "bab" (or "aba")
print(longestPalindrome("cbbd"))     // "bb"  <- catches missing even centers
print(longestPalindrome("a"))        // "a"
print(longestPalindrome("ac"))       // "a"
print(longestPalindrome("aaaa"))     // "aaaa"
print(longestPalindrome("racecar"))  // "racecar"
print(longestPalindrome("abb"))      // "bb"  <- even palindrome at the END

// MARK: - Interview Q&A
/*
 Q1. How many centers must you check, and why?
 A1. 2n - 1: n odd centers (on each char) + n - 1 even centers
     (between adjacent pairs). Odd expansions can only ever produce
     odd-length palindromes, so skipping even centers misses "bb".

 Q2. Why is expand-around-center O(n^2) but faster than brute in
     practice, given brute is "only" O(n^3)?
 A2. Expansion stops at the FIRST mismatch — most centers die in O(1).
     Brute re-validates every substring from scratch even when a
     smaller inner substring already failed.

 Q3. How does this relate to #87 (Valid Palindrome II)?
 A3. Same two-pointer machinery, opposite direction:
     #87 converges inward to VERIFY a given palindrome;
     #88 diverges outward to DISCOVER the longest one.

 Q4. Follow-up: can you do better than O(n^2)?
 A4. Yes — Manacher's algorithm, O(n), reuses previously computed
     palindrome radii via mirror symmetry around the current rightmost
     palindrome. Rarely expected to be coded in interviews; name it
     and explain the mirror idea.

 Q5. Follow-up: Longest Palindromic SUBSEQUENCE (LC 516)?
 A5. Different problem — non-contiguous. Interval DP:
     dp[i][j] = LPS length in s[i...j];
     s[i]==s[j] -> 2 + dp[i+1][j-1], else max-of-two subranges.
     O(n^2) time and space. (Related: LC 1216 from #87's follow-up
     reduces to n - LPS <= k.)

 Q6. Count ALL palindromic substrings instead of the longest (LC 647)?
 A6. Identical expand-around-center skeleton — increment a counter on
     every successful expansion step instead of tracking the max.

 Q7. Why track indices and slice once at the end?
 A7. Swift String slicing/building in a hot loop causes repeated
     allocations and copies; integer index bookkeeping is free.
*/
