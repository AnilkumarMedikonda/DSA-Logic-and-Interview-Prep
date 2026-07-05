import Foundation

// MARK: - Problem
/*
 #91 — LC 344: Reverse String (Easy)

 Reverse an array of characters IN PLACE.

   func reverseString(_ s: inout [Character])

 Examples:
   ["h","e","l","l","o"]     -> ["o","l","l","e","h"]
   ["H","a","n","n","a","h"] -> ["h","a","n","n","a","H"]
   ["a"]                     -> ["a"]   (single char — nothing to do)

 Constraints:
   1 <= s.count <= 10^5
   Must mutate in place, O(1) extra memory. Nothing is returned.

 Pattern: Converging Two Pointers — the palindrome VERIFY loop (#87)
 with the compare replaced by a SWAP.

 L5 note: this while-loop is the seed helper for the whole level —
 #92–95 all reuse "reverse a segment [left, right]" where segments
 do NOT start at index 0.
*/

// MARK: - Brute Force
/*
 (For the record only — violates the O(1)-space requirement.)

 Idea: build a new array back-to-front, then copy it over s.
   Time O(n), Space O(n) — correct output, wrong contract.

 The problem is really ABOUT the in-place constraint, so there is no
 meaningful brute/optimised split; the two-pointer swap IS the answer.
 Included as a variant below is the index-mirror for-loop form.
*/

// Variant A: index-mirror for-loop (works, less reusable)
func reverseStringMirror(_ s: inout [Character]) {
    for i in 0..<s.count / 2 {
        let temp = s[i]
        s[i] = s[s.count - 1 - i]
        s[s.count - 1 - i] = temp
    }
}

// MARK: - Optimised
/*
 Canonical form: converging left/right pointers, manual temp swap.

 Contract details that matter:
   - inout + no return: caller's array is mutated; returning it both
     defeats the point and mismatches LeetCode's Void signature.
   - Manual swap with let temp (house rules: no swapAt, no .reversed()).
   - count/2 iterations either way — odd-length middle char is
     correctly left untouched (left == right fails the loop condition).
*/

func reverseString(_ s: inout [Character]) {
    var left = 0
    var right = s.count - 1

    while left < right {
        let temp = s[left]
        s[left] = s[right]
        s[right] = temp
        left += 1
        right -= 1
    }
}

// MARK: - Dry Run
/*
 reverseString(["h","e","l","l","o"])

   left=0, right=4: swap h <-> o  -> [o,e,l,l,h]  left=1, right=3
   left=1, right=3: swap e <-> l  -> [o,l,l,e,h]  left=2, right=2
   left=2, right=2: 2 < 2 ✗ stop  — middle 'l' untouched

   Result: [o,l,l,e,h] ✓

 reverseString(["H","a","n","n","a","h"])   (even length)

   left=0, right=5: swap H <-> h  -> [h,a,n,n,a,H]  left=1, right=4
   left=1, right=4: swap a <-> a  -> unchanged      left=2, right=3
   left=2, right=3: swap n <-> n  -> unchanged      left=3, right=2
   3 < 2 ✗ stop

   Result: [h,a,n,n,a,H] ✓  (pointers CROSS on even length,
                             MEET on odd — both terminate correctly)
*/

// MARK: - Complexity
/*
 Time:  O(n) — n/2 swaps
 Space: O(1) — one temp Character per swap, in-place mutation

 Variant A (for-loop) is identical: O(n) / O(1).
*/

// MARK: - Traps
/*
 1. inout + return together — contradiction of the in-place contract.
    Mutate, return nothing, verify by printing the original after the
    call. (Hit this twice this session.)

 2. Reusing a mutated test variable for the second function call —
    reversing an already-reversed array prints the ORIGINAL and looks
    like a bug (or worse, silently "passes"). Fresh var per test.

 3. Loop bound: 0..<count/2 or while left < right. Writing
    0..<count re-reverses the second half back — array ends unchanged.

 4. Odd vs even termination: odd -> pointers MEET (left == right),
    even -> pointers CROSS (left > right). while left < right handles
    both; no special-casing needed.

 5. House rules: swapAt(_:_:) and .reversed() are predefined functions
    — manual temp swap.

 6. Prefer the left/right while form over index-mirror: #92–95 need
    segment reversal reverse(s, from: l, to: r) where segments start
    mid-array; the mirror form does not generalize.
*/

// MARK: - Tests
var t1: [Character] = ["h", "e", "l", "l", "o"]
reverseString(&t1)
print(t1)   // ["o","l","l","e","h"]

var t2: [Character] = ["H", "a", "n", "n", "a", "h"]
reverseString(&t2)
print(t2)   // ["h","a","n","n","a","H"]

var t3: [Character] = ["a"]
reverseString(&t3)
print(t3)   // ["a"]

var t4: [Character] = ["a", "b"]
reverseString(&t4)
print(t4)   // ["b","a"]

var t5: [Character] = ["h", "e", "l", "l", "o"]
reverseStringMirror(&t5)
print(t5)   // ["o","l","l","e","h"]  (variant A sanity check)

// MARK: - Interview Q&A
/*
 Q1. Why does the loop stop at the middle?
 A1. Each iteration fixes TWO positions (one from each end). After n/2
     swaps every position is placed; continuing would undo the work.

 Q2. What does inout actually do in Swift?
 A2. Copy-in copy-out semantics: the value is copied in, mutated, and
     written back on return (optimized to by-reference for arrays in
     practice). The & at the call site marks the mutation visibly.

 Q3. Can you do it with recursion?
 A3. Yes — swap(s, left, right) then recurse (left+1, right-1) — but
     O(n) stack depth violates the spirit of O(1) space. Mention, don't
     prefer.

 Q4. Why prefer while left < right over for i in 0..<count/2 here?
 A4. Identical for full-array reversal, but the while form generalizes
     to reversing a SEGMENT [l, r] — needed immediately in LC 541,
     551, 151 (reverse words/strides). One helper serves the level.

 Q5. Where does this build to?
 A5. LC 151 Reverse Words — the reverse-of-reverse composition: reverse
     the ENTIRE array, then re-reverse each word in place. This swap
     loop is the primitive both steps call.
*/
