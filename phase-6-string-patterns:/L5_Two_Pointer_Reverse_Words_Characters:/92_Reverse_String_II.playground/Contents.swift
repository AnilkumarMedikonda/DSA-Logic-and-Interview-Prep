import Foundation

// MARK: - Problem
/*
 #92 — LC 541: Reverse String II (Easy)

 Given a string `s` and an integer `k`, reverse the FIRST k characters
 of EVERY 2k-character block, counting from the start of the string.
 Leave the second k of each block untouched.

 Edge rules (where the problem actually lives):
   - Fewer than k chars remain        -> reverse ALL of them.
   - Between k and 2k-1 chars remain  -> reverse the first k, keep rest.

 Examples:
   "abcdefg", k=2 -> "bacdfeg"
       block "abcd": reverse "ab" -> "ba", keep "cd"
       block "efg" : reverse "ef" -> "fe", keep "g"
   "abcd",    k=2 -> "bacd"
   "abcdefg", k=3 -> "cbadefg"   (reverse "abc", keep "def"; "g" < k -> reverse all)
   "ab",      k=4 -> "ba"        (< k remain from the start -> reverse all)

 Constraints:
   1 <= s.count <= 10^4
   1 <= k <= 10^4
   lowercase English letters.

 Pattern: Segment Reversal in Strides — #91's swap loop, parameterized
 to [left, right], driven by a 2k stride. The ENTIRE problem is one
 clamp on the segment's right bound.
*/

// MARK: - Brute Force
/*
 First working attempt this session: string-building. Walk each block,
 build the reversed first-half by PREPENDING chars into a temp string,
 manually copy the untouched second half.

 Why it's the weaker solution:
   - temp = String(c) + temp reallocates on every + -> O(k^2) per block,
     O(n * k) overall in the worst case, plus O(n) extra space.
   - Manually copying the keep-region is extra code the in-place version
     doesn't need at all (untouched means UNTOUCHED).
   - min() is a predefined function (house rules) — kept here verbatim
     as the "before" picture; fixed in the optimised version.

 Kept for the record as the correctness baseline.
*/

func reverseStrBruteForce(_ s: String, _ k: Int) -> String {
    let words = Array(s)
    var result = ""
    var i = 0

    while i < words.count {
        // end of the reverse-region (exclusive)
        let oneEnd = i + k < words.count ? i + k : words.count

        var temp = ""
        for j in i..<oneEnd {
            temp = String(words[j]) + temp   // prepend = reverse
        }
        result += temp

        // untouched second half of the block, copied manually
        let nextEnd = i + 2 * k < words.count ? i + 2 * k : words.count
        if oneEnd < nextEnd {
            for j in oneEnd..<nextEnd {
                result += String(words[j])
            }
        }

        i += 2 * k
    }

    return result
}

// MARK: - Optimised
/*
 In-place segment reversal:
   1. Helper: #91's converging-pointer swap, parameterized to [left, right].
   2. Stride block starts: i = 0, 2k, 4k, ... (while loop; stride(from:to:by:)
      is a predefined function per house rules).
   3. THE problem line — clamp the right bound:
        right = min(i + k - 1, count - 1)   ... as a ternary.
      Both edge rules collapse into this single clamp: a short final
      block automatically reverses only what exists.
   4. The keep-region needs NO code — we simply never touch [right+1, i+2k-1].

 Swap discipline (bug hit this session): temp must save the side that
 gets OVERWRITTEN FIRST —
   let temp = chars[left]; chars[left] = chars[right]; chars[right] = temp
 Writing chars[left] twice leaves chars[right] unmodified and corrupts
 the array.
*/

func reverse(_ chars: inout [Character], _ left: Int, _ right: Int) {
    var left = left
    var right = right

    while left < right {
        let temp = chars[left]
        chars[left] = chars[right]
        chars[right] = temp
        left += 1
        right -= 1
    }
}

func reverseStr(_ s: String, _ k: Int) -> String {
    var chars = Array(s)
    var i = 0

    while i < chars.count {
        let right = i + k - 1 < chars.count - 1 ? i + k - 1 : chars.count - 1
        reverse(&chars, i, right)
        i += 2 * k
    }

    return String(chars)
}

// MARK: - Dry Run
/*
 reverseStr("abcdefg", k = 2), chars = [a,b,c,d,e,f,g], count = 7

 i = 0:
   right = (0+1 < 6) ? 1 : 6 = 1
   reverse [0,1]: swap a<->b -> [b,a,c,d,e,f,g]
   i += 4 -> 4
 i = 4:
   right = (4+1 < 6) ? 5 : 6 = 5
   reverse [4,5]: swap e<->f -> [b,a,c,d,f,e,g]
   i += 4 -> 8
 i = 8 >= 7 -> stop.  Result "bacdfeg" ✓
 (indices 2,3 and 6 never touched — the keep-regions, zero code)

 reverseStr("abcdefg", k = 3):
 i = 0: right = (2 < 6) ? 2 : 6 = 2 -> reverse [0,2] -> [c,b,a,d,e,f,g]
 i = 6: right = (8 < 6) ? 8 : 6 = 6 -> reverse [6,6] -> loop body never
        runs (left == right) — single char, correctly untouched
 Result "cbadefg" ✓

 reverseStr("ab", k = 4):              <- THE CLAMP TEST
 i = 0: right = (3 < 1) ? 3 : 1 = 1 -> reverse [0,1] -> [b,a]
 i = 8 >= 2 -> stop.  Result "ba" ✓
 (without the clamp, right = 3 -> index out of bounds crash)

 Broken-swap counterexample (the session bug):
   var temp = chars[right]
   chars[left] = chars[right]
   chars[left] = temp          // <- left written TWICE, right never
 On "ab": [a,b] -> chars[0]=b, chars[0]=b -> [b,b]. Corruption, not
 reversal — and a one-iteration dry run catches it instantly.
*/

// MARK: - Complexity
/*
 Brute Force (string building):
   Time:  O(n * k) worst case — prepend reallocation inside each block
   Space: O(n) — result + temp strings

 Optimised (in-place segments):
   Time:  O(n) — every index swapped at most once
   Space: O(n) for Array(s); O(1) extra beyond it
*/

// MARK: - Traps
/*
 1. THE SWAP BUG: assigning chars[left] twice (temp saved from the
    wrong side) leaves chars[right] unwritten. temp must capture the
    element being OVERWRITTEN FIRST. Dry-run one iteration before
    trusting any swap. (Hit this session — swap was written correctly
    twice in #91, so this was transcription, not understanding. The
    fix habit: trace, don't re-read.)

 2. Asserting expected output in a comment (// bacdfeg) without running
    it — #89 Trap 6 resurfacing. Comments claiming outputs must be
    verified outputs.

 3. Only processing the first block — forgetting the outer 2k stride
    turns the problem into #91. (First attempt this session.)

 4. Missing the clamp -> index out of bounds the moment k > remaining
    chars ("ab", k=4). The clamp REPLACES both edge rules in the
    problem statement; no if/else casing needed.

 5. Clamp arithmetic: right bound is i + k - 1 (inclusive), not i + k.
    Mixing inclusive/exclusive conventions between the helper and the
    clamp is an instant off-by-one.

 6. String building in the loop (temp = String(c) + temp): O(k^2)
    per block via reallocation, O(n) space — and manual copying of
    keep-regions that in-place never touches. Fourth occurrence of
    the string-building trap this phase (#87, #88, #89, here).

 7. House rules: min() is predefined — clamp via ternary. var temp
    where let suffices.

 8. Function naming collision: overloading reverse(_:_:) for both the
    String-returning attempt and the inout helper compiles (different
    signatures) but reads ambiguously — distinct names per role.
*/

// MARK: - Tests
print("--- Brute Force (string building) ---")
print(reverseStrBruteForce("abcdefg", 2))  // "bacdfeg"
print(reverseStrBruteForce("abcd", 2))     // "bacd"
print(reverseStrBruteForce("abcdefg", 3))  // "cbadefg"
print(reverseStrBruteForce("ab", 4))       // "ba"
print(reverseStrBruteForce("a", 1))        // "a"

print("--- Optimised (in-place segments) ---")
print(reverseStr("abcdefg", 2))  // "bacdfeg"
print(reverseStr("abcd", 2))     // "bacd"
print(reverseStr("abcdefg", 3))  // "cbadefg"
print(reverseStr("ab", 4))       // "ba"       <- clamp test
print(reverseStr("a", 1))        // "a"
print(reverseStr("abcdefgh", 2)) // "bacdfegh" <- exact 2k blocks

// MARK: - Interview Q&A
/*
 Q1. How do the two stated edge rules disappear from the code?
 A1. Both are the same statement: "reverse [i, min(i+k-1, n-1)]".
     A remainder shorter than k clamps to the array end (reverse all);
     a remainder between k and 2k-1 never clamps (reverse exactly k)
     and the untouched tail needs no handling. One ternary, zero cases.

 Q2. Why is the in-place version O(n) when there's a nested loop?
 A2. The helper's swaps partition the array: each index participates in
     at most one segment and is swapped at most once. Outer stride +
     inner swaps together touch each element O(1) times.

 Q3. Why does temp save chars[left] and not chars[right]?
 A3. temp preserves whichever value the FIRST assignment destroys.
     chars[left] is overwritten first, so it must be saved first.
     Symmetric version (save right, write right first) is equally
     valid — the invariant is "save before you clobber".

 Q4. What breaks with for i in stride(from: 0, to: n, by: 2*k)?
 A4. Nothing functionally — but stride is a predefined function under
     house rules; the while + i += 2*k form is equivalent and explicit.

 Q5. Where does segment reversal go next?
 A5. LC 557 (#93): reverse EVERY word in place — segments found by
     scanning for spaces instead of fixed strides. LC 151 (#94):
     reverse-of-reverse composition. Same helper, smarter boundaries.
*/
