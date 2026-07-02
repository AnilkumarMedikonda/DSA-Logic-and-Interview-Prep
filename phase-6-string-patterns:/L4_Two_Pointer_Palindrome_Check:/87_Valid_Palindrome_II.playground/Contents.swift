import Foundation

// MARK: - Problem
/*
 #87 — LC 680: Valid Palindrome II (Easy)

 Given a string `s`, return true if `s` can become a palindrome
 after deleting AT MOST one character (zero deletions allowed).

 Examples:
   "aba"   -> true   (already palindrome)
   "abca"  -> true   (delete 'c' -> "aba")
   "abc"   -> false  (one deletion is not enough)
   "cbbcc" -> false  (no single deletion works)

 Constraints:
   1 <= s.count <= 10^5
   s consists of lowercase English letters only.

 Pattern: Two Pointers + One Skip Decision
*/

// MARK: - Brute Force
/*
 Idea:
   1. If s is already a palindrome -> true.
   2. Otherwise, try deleting each index one at a time and
      check if the remainder is a palindrome.

 Why it works: with k = 1, some single index must be the deleted one.
 Why it fails at scale: n deletions x O(n) check = O(n^2);
 n = 10^5 -> ~10^10 ops -> TLE.
*/

// Helper (array-based, no String round-trip)
func isValidPalindrome(words: [Character]) -> Bool {
    var left = 0
    var right = words.count - 1

    while left < right {
        if words[left] != words[right] {
            return false
        }
        left += 1
        right -= 1
    }

    return true
}

func isValidPalindromeBrute(_ s: String) -> Bool {
    let words = Array(s)

    if isValidPalindrome(words: words) {
        return true
    }

    for i in 0..<words.count {
        var newWords = words
        newWords.remove(at: i)

        if isValidPalindrome(words: newWords) {
            return true
        }
    }

    return false
}

// MARK: - Optimised
/*
 Idea (Two Pointers + One Skip):
   Scan with left/right pointers as a normal palindrome check.
   At the FIRST mismatch, a deletion means moving exactly ONE pointer:
     - delete left char  -> check subrange [left+1, right]
     - delete right char -> check subrange [left, right-1]
   If EITHER subrange is a plain palindrome -> true, else false.
   No mismatch at all -> already a palindrome -> true.

 Key: must test BOTH branches (||). Greedy single-side skip fails.
 No mutation, no remove(at:) — index-based subrange checks only.
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

func isValidPalindromeOpti(_ s: String) -> Bool {
    let words = Array(s)
    var left = 0
    var right = words.count - 1

    while left < right {
        if words[left] != words[right] {
            return isPalindrome(words, left + 1, right) || isPalindrome(words, left, right - 1)
        }
        left += 1
        right -= 1
    }

    return true // no mismatch found — already a palindrome
}

// MARK: - Dry Run
/*
 s = "abca", words = [a, b, c, a]

   left=0, right=3: a == a  -> match, move both -> left=1, right=2
   left=1, right=2: b != c  -> MISMATCH, branch:

     skipLeft  = isPalindrome(words, 2, 2)  // subrange "c"
                 left=2, right=2 -> loop skipped -> true
     -> return true || ... = true            (short-circuits)

 s = "cbbcc", words = [c, b, b, c, c]

   left=0, right=4: c == c  -> match -> left=1, right=3
   left=1, right=3: b != c  -> MISMATCH, branch:

     skipLeft  = isPalindrome(words, 2, 3)  // "bc"
                 b != c -> false
     skipRight = isPalindrome(words, 1, 2)  // "bb"
                 b == b -> true? NO — wait, trace fully:
                 left=1, right=2: b == b -> left=2, right=1 -> loop ends -> true?

                 Careful: skipRight checks [1, 2] = "bb" -> true,
                 BUT that only proves s[1...2] is a palindrome.
                 The OUTER chars already matched (c...c at 0 and 4),
                 and deleting index 3 gives "cbbc":
                   c/c match, b/b match -> palindrome? "cbbc" -> YES.

                 Re-check by hand: "cbbcc" delete index 3 ('c') -> "cbbc"
                 c-b-b-c -> palindrome! So answer is TRUE, not false.

                 CORRECTION: earlier session notes said "cbbcc" -> false.
                 That was wrong. "cbbcc" -> true (delete the c at index 3).
                 The brute force also returns true — run the tests below.

 Lesson reinforced: always dry-run the "known" answer too.
*/

// MARK: - Complexity
/*
 Brute Force:
   Time:  O(n^2)  — n deletion attempts x O(n) palindrome check
                    (plus O(n) per remove(at:) copy)
   Space: O(n)    — copied array per iteration

 Optimised:
   Time:  O(n)    — one main scan + at most two O(n) subrange checks
   Space: O(n)    — Array(s) char buffer; O(1) extra beyond it
*/

// MARK: - Traps
/*
 1. Moving BOTH pointers on mismatch = simulating REPLACE, not DELETE.
    A deletion moves exactly one pointer. (Hit this twice this session.)

 2. Greedy single-side skip fails — must check BOTH branches:
    isPalindrome(left+1, right) || isPalindrome(left, right-1).

 3. Mutating with remove(at:) inside the "optimised" version:
    - O(n) per removal (drifts back to brute force)
    - second removal operates on an already-mutated array with
      shifted indices. Use index-based subrange checks instead.

 4. Missing left += 1 / right -= 1 in the match case -> infinite loop.

 5. Redundant upfront full-palindrome check before the main loop:
    the loop IS the check until first mismatch; end of loop -> return true.

 6. Trusting an expected answer without tracing it ("cbbcc" is TRUE —
    delete index 3 -> "cbbc").

 7. Swift: convert to Array(s) once; String index subscripting is
    slow and painful.
*/

// MARK: - Tests
print("--- Brute Force ---")
print(isValidPalindromeBrute("aba"))     // true  (already palindrome)
print(isValidPalindromeBrute("abca"))    // true  (delete 'c')
print(isValidPalindromeBrute("abc"))     // false
print(isValidPalindromeBrute("cbbcc"))   // true  (delete index 3 -> "cbbc")
print(isValidPalindromeBrute("deeee"))   // true  (delete 'd')
print(isValidPalindromeBrute("a"))       // true  (single char)
print(isValidPalindromeBrute("ab"))      // true  (delete either char)

print("--- Optimised ---")
print(isValidPalindromeOpti("aba"))      // true
print(isValidPalindromeOpti("abca"))     // true
print(isValidPalindromeOpti("abc"))      // false
print(isValidPalindromeOpti("cbbcc"))    // true
print(isValidPalindromeOpti("deeee"))    // true
print(isValidPalindromeOpti("a"))        // true
print(isValidPalindromeOpti("ab"))       // true

// MARK: - Interview Q&A
/*
 Q1. Why must you check BOTH skip branches on mismatch?
 A1. You cannot know locally which side's deletion leads to a valid
     palindrome. Example: "abca" at mismatch (b, c) — skipping right
     ("bc" remains? no — skipping LEFT leaves "c" -> works). Some inputs
     need skip-left, others skip-right; greedy one-side misses cases.

 Q2. Why does the mismatch branch return immediately — why no second
     decision point?
 A2. k = 1. After spending the single deletion, the rest must be a
     PLAIN palindrome, so the helper has no branching. A second
     mismatch after the skip means false.

 Q3. What does each edit operation mean for the two pointers?
 A3. DELETE  -> move ONE pointer (skip a char on one side)
     REPLACE -> move BOTH pointers (pretend they matched)
     INSERT  -> mirror of delete (insert on one side == delete on other)
     This mapping generalizes: LC 1216 (k deletions) becomes interval DP.

 Q4. Follow-up: at most k deletions (LC 1216 Valid Palindrome III)?
 A4. Two-pointer branching explodes exponentially. Use DP:
     dp[i][j] = min deletions to make s[i...j] a palindrome.
     s[i] == s[j] -> dp[i+1][j-1]; else 1 + min(dp[i+1][j], dp[i][j-1]).
     Answer: dp[0][n-1] <= k. O(n^2) time/space.

 Q5. Complexity of the optimised solution?
 A5. O(n) time — one scan plus at most two subrange checks triggered
     only at the first mismatch. O(n) space for the char array.

 Q6. Frequency note: Meta phone-screen staple; Amazon/Microsoft/Google
     use it as a warm-up before the k-deletions follow-up.
*/
