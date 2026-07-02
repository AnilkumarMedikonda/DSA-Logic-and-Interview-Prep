import Foundation

// MARK: - Problem
/*
 #89 — LC 647: Palindromic Substrings (Medium)

 Given a string `s`, return the NUMBER of palindromic substrings in it.
 Count OCCURRENCES, not distinct strings — the same text at different
 positions counts each time.

 Examples:
   "abc" -> 3   ("a", "b", "c")
   "aaa" -> 6   ("a", "a", "a", "aa", "aa", "aaa")
   "aba" -> 4   ("a", "b", "a", "aba")

 Constraints:
   1 <= s.count <= 1000
   s consists of lowercase English letters.

 Pattern: Expand Around Center — #88's skeleton with ONE change:
 expand returns a COUNT (every successful outward step = one new
 palindrome at that center) instead of a length.
*/

// MARK: - Brute Force
/*
 Idea:
   Check every substring (i, j); count the palindromes.
   Same skeleton as #88's brute — count += 1 replaces max-tracking.

 Why it fails at scale:
   n^2 substrings x O(n) check = O(n^3); n = 1000 -> ~10^9 ops.

 Note: index-based helper on ONE shared array — no string building,
 no String -> Array conversion per check (standing rule since #87).
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

func countSubstringPalindromeBruteForce(_ s: String) -> Int {
    let words = Array(s)
    var count = 0

    for i in 0..<words.count {
        for j in i..<words.count {
            if isPalindrome(words, i, j) {
                count += 1
            }
        }
    }

    return count
}

// MARK: - Optimised
/*
 Idea (Expand Around Center, counting):
   For each of the 2n - 1 centers, expand outward while chars match.
   EVERY successful expansion step discovers one new, longer palindrome
   at that center -> count += 1 per step.

 Centers (same as #88):
   - n odd centers:    expand(i, i)     — palindrome ON a char
   - n-1 even centers: expand(i, i+1)   — palindrome BETWEEN chars

 No off-by-one reconstruction needed here — we never extract the
 substring, we only count. Simpler than #88 in that one respect.
*/

func expandAroundCenter(_ chars: [Character], _ left: Int, _ right: Int) -> Int {
    var left = left
    var right = right
    var count = 0

    while left >= 0 && right < chars.count && chars[left] == chars[right] {
        count += 1
        left -= 1
        right += 1
    }

    return count
}

func countSubstringPalindrome(_ s: String) -> Int {
    let chars = Array(s)
    var count = 0

    for i in 0..<chars.count {
        count += expandAroundCenter(chars, i, i)      // odd centers
        count += expandAroundCenter(chars, i, i + 1)  // even centers
    }

    return count
}

// MARK: - Dry Run
/*
 countSubstringPalindrome("aaa"), chars = [a, a, a]

 i = 0:
   odd  expand(0,0): (0,0) 'a'=='a' ✓ count=1 -> left=-1       stop
        contributes 1                                   // "a"
   even expand(0,1): (0,1) 'a'=='a' ✓ count=1 -> left=-1       stop
        contributes 1                                   // "aa"
   running total: 2

 i = 1:
   odd  expand(1,1): (1,1) ✓ count=1 -> (0,2) 'a'=='a' ✓ count=2
                     -> left=-1 stop
        contributes 2                                   // "a", "aaa"
   even expand(1,2): (1,2) ✓ count=1 -> (0,3) right=3 < 3 ✗ stop
        contributes 1                                   // "aa"
   running total: 5

 i = 2:
   odd  expand(2,2): ✓ count=1 -> (1,3) right=3 ✗ stop
        contributes 1                                   // "a"
   even expand(2,3): right=3 < 3 ✗ immediately
        contributes 0                                   // safe, no crash
   running total: 6  ✓

 Center contributions: 1 + 1 + 2 + 1 + 1 = 6
 Matches the hand count: three "a", two "aa", one "aaa".

 Key mental model: each outward step at a center is a DIFFERENT
 palindrome (longer by 2), so counting steps counts palindromes.
*/

// MARK: - Complexity
/*
 Brute Force:
   Time:  O(n^3) — n^2 substrings x O(n) check
   Space: O(n)   — char array

 Optimised:
   Time:  O(n^2) — (2n - 1) centers x O(n) worst-case expansion
   Space: O(n) for Array(s); O(1) extra beyond it

 (O(n) via Manacher's exists — radii computed by Manacher directly
  give the count as sum of (radius+1)/2 terms. Name-drop only.)
*/

// MARK: - Traps
/*
 1. Inner brute loop starting at 0 instead of i — counts prefixes of
    the WHOLE string repeatedly and never counts mid-string substrings.
    (Hit this on attempt 1.)

 2. Missing left += 1 / right -= 1 in the verify helper -> infinite
    loop. (Hit for the second time across problems — #87 and here.
    Write the pointer moves IMMEDIATELY after opening the while.)

 3. Missing even centers -> "aaa" gives 4 instead of 6.

 4. Counting DISTINCT palindromes instead of occurrences — the problem
    wants positions: two "aa"s in "aaa" count separately.

 5. String building in the hot loop (str += ...) + String -> Array
    conversion per check — hidden O(n) copies. Index one shared array.

 6. Testing with an undefined variable (print(f(s)) where s doesn't
    exist in the file) — always test with literals in playgrounds.

 7. Inconsistent helper signatures across the repo (labeled left:/right:
    vs unlabeled _) — standardize on unlabeled to match #87/#88.
*/

// MARK: - Tests
print("--- Brute Force ---")
print(countSubstringPalindromeBruteForce("abc"))      // 3
print(countSubstringPalindromeBruteForce("aaa"))      // 6
print(countSubstringPalindromeBruteForce("aba"))      // 4
print(countSubstringPalindromeBruteForce("a"))        // 1
print(countSubstringPalindromeBruteForce("aa"))       // 3
print(countSubstringPalindromeBruteForce("racecar"))  // 10

print("--- Optimised ---")
print(countSubstringPalindrome("abc"))      // 3
print(countSubstringPalindrome("aaa"))      // 6   <- catches missing even centers
print(countSubstringPalindrome("aba"))      // 4
print(countSubstringPalindrome("a"))        // 1
print(countSubstringPalindrome("aa"))       // 3   ("a", "a", "aa")
print(countSubstringPalindrome("racecar"))  // 10

// MARK: - Interview Q&A
/*
 Q1. Why does counting expansion steps count palindromes?
 A1. At a fixed center, each successful outward step produces a strictly
     longer palindrome (adds one char on each side) — distinct substring
     positions, one per step. Steps and palindromes are in 1:1
     correspondence at that center; centers partition all palindromes.

 Q2. How is this different from #88 (Longest Palindromic Substring)?
 A2. Identical expansion skeleton. #88 tracks the max length and must
     reconstruct start/end indices (off-by-one math); #89 just counts
     steps — no index reconstruction at all.

 Q3. Occurrences vs distinct — what changes if they ask for DISTINCT
     palindromic substrings?
 A3. Harder problem: need deduplication — a Set of substrings works but
     costs O(n^2) space of strings; the clean solution uses a
     palindromic tree (Eertree) or suffix automaton. Know the name,
     not the code.

 Q4. Can you do O(n)?
 A4. Manacher's — the radius array it computes per center directly
     yields each center's palindrome count without re-expanding.

 Q5. DP alternative?
 A5. dp[i][j] = s[i...j] is palindrome, filled by length:
     dp[i][j] = (s[i] == s[j]) && (j - i < 2 || dp[i+1][j-1]);
     count trues. O(n^2) time but O(n^2) SPACE — expand-around-center
     achieves the same time in O(1) extra space, so it dominates here.
     (The DP table matters when you need it as a building block, e.g.
     LC 131 Palindrome Partitioning.)

 Q6. Trilogy summary (#87 -> #88 -> #89):
     #87 converge inward to VERIFY one palindrome (+ one skip branch)
     #88 diverge outward to FIND the longest
     #89 diverge outward to COUNT them all
     One two-pointer engine, three questions.
*/
