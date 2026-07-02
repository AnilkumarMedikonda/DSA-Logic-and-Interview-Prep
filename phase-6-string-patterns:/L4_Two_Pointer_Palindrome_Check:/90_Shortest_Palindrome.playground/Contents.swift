import Foundation

// MARK: - Problem
/*
 #90 — LC 214: Shortest Palindrome (Hard)

 Given a string `s`, you may add characters ONLY IN FRONT of it.
 Return the shortest palindrome you can form this way.

 Examples:
   "aacecaaa" -> "aaacecaaa"   (prepend "a";  prefix "aacecaa" was a palindrome)
   "abcd"     -> "dcbabcd"     (prepend "dcb"; only prefix "a" was a palindrome)
   ""         -> ""

 Constraints:
   0 <= s.count <= 5 * 10^4
   lowercase English letters.

 THE REFRAME (the whole problem):
   Whatever is prepended, the original s sits at the end, and the added
   chars must mirror s's TAIL. So:

     answer = reverse(tail) + s,  where s = longestPalindromicPrefix + tail

   Shorter tail = shorter answer, so we want the LONGEST PALINDROMIC
   PREFIX of s. Everything else is implementation.

 Pattern: KMP failure function (LPS array) on t = s + "#" + reverse(s)
*/

// MARK: - Brute Force
/*
 Idea:
   Try prefix lengths from LONGEST to shortest; the first prefix that
   is a palindrome wins. Then answer = reverse(remaining tail) + s.

 Why it fails at scale:
   Worst case (e.g. "aaab...") checks O(n) prefixes x O(n) each = O(n^2).
   n = 5 * 10^4 -> ~2.5 * 10^9 ops -> TLE on LeetCode. Correctness
   baseline only.
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

func shortestPalindromeBruteForce(_ s: String) -> String {
    let chars = Array(s)

    if chars.count <= 1 {
        return s
    }

    // longest palindromic prefix: try end index from last char downward
    var prefixEnd = chars.count - 1
    while prefixEnd > 0 {
        if isPalindrome(chars, 0, prefixEnd) {
            break
        }
        prefixEnd -= 1
    }
    // prefixEnd == 0 also fine: single char is always a palindrome

    // tail = chars[(prefixEnd + 1)...]; prepend its reverse
    var result: [Character] = []
    var i = chars.count - 1
    while i > prefixEnd {
        result.append(chars[i])
        i -= 1
    }
    result.append(contentsOf: chars)

    return String(result)
}

// MARK: - Optimised
/*
 Idea (KMP failure function):
   Build   t = s + "#" + reverse(s)
   Compute the LPS (Longest proper Prefix which is also Suffix) array
   of t. Then lps[t.count - 1] == length of the longest palindromic
   prefix of s.

 WHY IT WORKS:
   A suffix of t lives entirely inside reverse(s) (the "#" guarantees
   no prefix-suffix match can cross it). A suffix of reverse(s) is a
   REVERSED PREFIX of s. So "prefix of t == suffix of t" means:

     prefix of s == reverse(that same prefix of s)

   ...which is exactly "that prefix of s is a palindrome". LPS finds
   the LONGEST such match — the longest palindromic prefix.

 WHY "#" IS MANDATORY:
   s = "aaaa" -> without separator t = "aaaaaaaa", lps.last = 7, which
   exceeds s.count — the match bleeds across the boundary and claims a
   palindromic prefix longer than s itself. The separator (any char not
   in the alphabet) caps matches at s.count.

 LPS construction (standard KMP preprocessing):
   lps[i] = length of longest proper prefix of t[0...i] that is also a
   suffix of t[0...i]. Built in O(n) with the "fall back via lps" trick:
   on mismatch, len = lps[len - 1] — never recompare from scratch.
*/

func buildLPS(_ chars: [Character]) -> [Int] {
    var lps = [Int](repeating: 0, count: chars.count)
    var len = 0   // length of current matched prefix
    var i = 1     // lps[0] is always 0

    while i < chars.count {
        if chars[i] == chars[len] {
            len += 1
            lps[i] = len
            i += 1
        } else {
            if len > 0 {
                len = lps[len - 1]   // fall back — do NOT advance i
            } else {
                lps[i] = 0
                i += 1
            }
        }
    }

    return lps
}

func shortestPalindrome(_ s: String) -> String {
    let chars = Array(s)

    if chars.count <= 1 {
        return s
    }

    // t = s + "#" + reverse(s)
    var t = chars
    t.append("#")
    var i = chars.count - 1
    while i >= 0 {
        t.append(chars[i])
        i -= 1
    }

    let lps = buildLPS(t)
    guard let last = lps.last else {
        return s
    }
    let palindromicPrefixLength = last

    // prepend reverse of the tail chars[palindromicPrefixLength...]
    var result: [Character] = []
    var j = chars.count - 1
    while j >= palindromicPrefixLength {
        result.append(chars[j])
        j -= 1
    }
    result.append(contentsOf: chars)

    return String(result)
}

// MARK: - Dry Run
/*
 shortestPalindrome("abcd"), chars = [a, b, c, d]

 t = "abcd" + "#" + "dcba" = [a, b, c, d, #, d, c, b, a]   (count 9)

 buildLPS(t):  (len = matched prefix length, i = position)
   i=1 'b' vs t[0]='a' ✗ len=0 -> lps[1]=0, i=2
   i=2 'c' vs 'a' ✗            -> lps[2]=0, i=3
   i=3 'd' vs 'a' ✗            -> lps[3]=0, i=4
   i=4 '#' vs 'a' ✗            -> lps[4]=0, i=5
   i=5 'd' vs 'a' ✗            -> lps[5]=0, i=6
   i=6 'c' vs 'a' ✗            -> lps[6]=0, i=7
   i=7 'b' vs 'a' ✗            -> lps[7]=0, i=8
   i=8 'a' vs 'a' ✓ len=1      -> lps[8]=1, i=9 done

   lps = [0,0,0,0,0,0,0,0,1] -> lps.last = 1
   longest palindromic prefix of "abcd" has length 1 ("a") ✓

 tail = chars[1...3] = "bcd" -> reversed "dcb"
 result = "dcb" + "abcd" = "dcbabcd" ✓

 -----------------------------------------------------------------

 shortestPalindrome("aacecaaa"):

 t = "aacecaaa" + "#" + "aaacecaa"
 lps.last works out to 7 -> palindromic prefix "aacecaa" (length 7)
 tail = "a" -> result = "a" + "aacecaaa" = "aaacecaaa" ✓
 (Trace the lps fall-backs by hand once — the len = lps[len-1] step
  fires several times; it is THE thing to understand about KMP.)

 -----------------------------------------------------------------

 Why "#" matters, s = "aaaa":
   with separator:    t = "aaaa#aaaa" -> lps.last = 4 = s.count ✓
                      (whole s is a palindrome, prepend nothing)
   without separator: t = "aaaaaaaa"  -> lps.last = 7 > s.count ✗
                      match bled across the boundary — nonsense answer.
*/

// MARK: - Complexity
/*
 Brute Force:
   Time:  O(n^2) — up to n prefixes x O(n) palindrome check
   Space: O(n)

 Optimised (KMP):
   Time:  O(n) — building t is O(n); LPS construction is O(n)
          (i only moves forward; len only decreases via fall-backs,
           and it can only decrease as much as it ever increased —
           amortized linear)
   Space: O(n) — t (length 2n + 1) and the lps array

 Alternative: Rabin-Karp rolling hash — compare forward hash of prefix
 vs backward hash incrementally, O(n) expected. Simpler to derive under
 pressure; KMP is the more transferable investment (LC 28, LC 459).
*/

// MARK: - Traps
/*
 1. Solving the wrong problem: this is NOT "make any palindrome" — chars
    go in FRONT only. The reframe (find longest palindromic PREFIX,
    prepend reversed tail) IS the problem; without it you go nowhere.

 2. Omitting the "#" separator -> prefix-suffix match bleeds across the
    s/reverse(s) boundary ("aaaa" case) and reports length > s.count.

 3. LPS fall-back: on mismatch with len > 0, set len = lps[len - 1] and
    do NOT advance i, do NOT reset len to 0. Resetting to 0 gives wrong
    (too short) matches; advancing i skips comparisons.

 4. lps[i] is the longest PROPER prefix-suffix (proper = not the whole
    string) — that's why lps[0] = 0 always.

 5. Off-by-one at the seam: tail starts AT index palindromicPrefixLength
    (not +1). Prefix occupies [0, len-1]; tail is [len, n-1].

 6. Empty string / single char: return s directly — also guards the
    lps.last force-unwrap temptation (use guard let, house rules).

 7. Building reverse(s) with .reversed() is a predefined function —
    manual backward while-loop per house rules.
*/

// MARK: - Tests
print("--- Brute Force ---")
print(shortestPalindromeBruteForce("aacecaaa"))  // "aaacecaaa"
print(shortestPalindromeBruteForce("abcd"))      // "dcbabcd"
print(shortestPalindromeBruteForce(""))          // ""
print(shortestPalindromeBruteForce("a"))         // "a"
print(shortestPalindromeBruteForce("aa"))        // "aa"
print(shortestPalindromeBruteForce("aba"))       // "aba"
print(shortestPalindromeBruteForce("abb"))       // "bbabb"

print("--- Optimised (KMP) ---")
print(shortestPalindrome("aacecaaa"))  // "aaacecaaa"
print(shortestPalindrome("abcd"))      // "dcbabcd"
print(shortestPalindrome(""))          // ""
print(shortestPalindrome("a"))         // "a"
print(shortestPalindrome("aa"))        // "aa"
print(shortestPalindrome("aba"))       // "aba"
print(shortestPalindrome("abb"))       // "bbabb"
print(shortestPalindrome("aaaa"))      // "aaaa"  <- the "#" test

// MARK: - Interview Q&A
/*
 Q1. Walk me through the reframe.
 A1. Added chars go in front, so s's tail must be mirrored by them:
     answer = reverse(tail) + s. Minimizing the answer = minimizing the
     tail = maximizing the palindromic prefix. The search target is
     "longest palindromic prefix of s".

 Q2. Why does lps.last of s + "#" + reverse(s) equal that length?
 A2. Any suffix of t lies inside reverse(s) (separator blocks crossing),
     and a suffix of reverse(s) is a reversed prefix of s. So a
     prefix-suffix match of t asserts: prefix of s == its own reverse,
     i.e. that prefix is a palindrome. LPS maximizes the match length.

 Q3. Why is LPS construction O(n) when there's a nested-looking loop?
 A3. Amortized argument: i never moves backward (n increments), and len
     only decreases in fall-backs — but len can only decrease as much
     as it was ever incremented (at most n). Total work <= 2n.

 Q4. What breaks without the "#" separator?
 A4. For self-similar strings (s = "aaaa"), the prefix-suffix match
     spans the s/reverse(s) boundary and returns length > s.count —
     claiming a palindromic prefix longer than the string itself.

 Q5. Alternative O(n) approach?
 A5. Rabin-Karp: maintain forward and backward rolling hashes of each
     prefix; the longest index where they agree (verify on collision)
     is the palindromic prefix. Expected O(n), simpler derivation;
     KMP is deterministic.

 Q6. Where does this KMP machinery reappear?
 A6. LC 28 (strStr / substring search — LPS is the core), LC 459
     (Repeated Substring Pattern — answer read directly off lps.last),
     LC 1392 (Longest Happy Prefix — literally buildLPS alone).

 Q7. What if you could append at the END instead of the front?
 A7. Symmetric problem: find the longest palindromic SUFFIX, prepend
     nothing, append reverse of the head. Same KMP trick on
     reverse(s) + "#" + s.
*/
