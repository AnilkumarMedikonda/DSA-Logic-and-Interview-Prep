import Foundation

// MARK: - Problem
/*
 #94 — LC 557: Reverse Words in a String III (Easy)

 Reverse the characters WITHIN each word; keep word order and
 whitespace exactly as-is.

   "Let's take LeetCode contest" -> "s'teL ekat edoCteeL tsetnoc"
   "Mr Ding"                     -> "rM gniD"

 Constraints:
   1 <= s.count <= 5 * 10^4
   Words separated by SINGLE spaces; NO leading/trailing spaces.
   (Clean-input guarantees — #93's whitespace war doesn't exist here.)

 Pattern: per-word segment reversal — #93's Step 3 alone.
 151 = 557 + whole-array reversal + whitespace cleanup.
*/

// MARK: - Brute Force
/*
 Tokenize into [String], reverse each word into a new array, rejoin.
 Correct but allocation-heavy: O(n) auxiliary (words array duplicates
 the content) — #93-brute structure where none is needed.

 Session bugs fixed from the first attempt:
   - swapAt() was used (predefined — house rules): manual temp swap.
   - `result += word + " "` trailed a space after the LAST word:
     separator goes BETWEEN words (i > 0 guard).
   - Unguarded final flush words.append(word) is safe ONLY because
     clean input guarantees a non-empty buffer at the end — the same
     line emits "" tokens on #93-style inputs.
*/

func reverseWordsBruteForce(_ s: String) -> String {
    var words = [String]()
    var buffer = ""

    for ch in s {
        if ch != " " {
            buffer += String(ch)
        } else {
            words.append(buffer)
            buffer = ""
        }
    }
    words.append(buffer)   // safe: clean input => non-empty last buffer

    var result = ""
    for i in 0..<words.count {
        var chars = Array(words[i])
        var left = 0
        var right = chars.count - 1

        while left < right {
            let temp = chars[left]
            chars[left] = chars[right]
            chars[right] = temp
            left += 1
            right -= 1
        }

        if i > 0 {
            result += " "
        }
        result += String(chars)
    }

    return result
}

// MARK: - Optimised
/*
 In-place, single buffer, nested scan:
   outer: start sits at a word's first char
   inner: end walks to the next space (or falls off the end)
   -> reverse [start, end - 1], jump start = end + 1

 Last word handled NATURALLY: the inner while exits at chars.count,
 so end - 1 is the final index — no virtual-space special case needed.
 (Alternative shape to #93's i == write trick; both valid.)
*/

func reverseChars(_ chars: inout [Character], _ left: Int, _ right: Int) {
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

func reverseWords(_ s: String) -> String {
    var chars = Array(s)
    var start = 0

    while start < chars.count {
        var end = start
        while end < chars.count, chars[end] != " " {
            end += 1
        }
        reverseChars(&chars, start, end - 1)
        start = end + 1
    }

    return String(chars)
}

// MARK: - Dry Run
/*
 reverseWords("Mr Ding"), chars = [M, r, ' ', D, i, n, g], count = 7

 start = 0:
   end: 0 'M' -> 1 'r' -> 2 ' ' stop, end = 2
   reverse [0, 1] -> [r, M, ' ', D, i, n, g]
   start = 3
 start = 3:
   end: 3..6 letters -> 7 == count stop, end = 7   <- falls off the end
   reverse [3, 6] -> [r, M, ' ', g, n, i, D]
   start = 8
 start = 8 >= 7 -> done.  "rM gniD" ✓

 Note the last word: no space triggers it — the inner loop's
 end < chars.count bound closes it. That IS the last-word trap,
 solved structurally instead of by special case.
*/

// MARK: - Complexity
/*
 Brute:     O(n) time, O(n) AUXILIARY space (words array + per-word copies)
 Optimised: O(n) time, O(1) AUXILIARY space — one chars buffer, two
            indices, one temp char. (Array(s)/String(chars) are Swift
            I/O conversions, not working storage.)
*/

// MARK: - Traps
/*
 1. swapAt(_:_:) is a predefined function — manual temp swap, always.
    (Slipped back in on the brute attempt after five correct manual
    swaps this level; habits regress under "easy problem" mode.)

 2. Trailing space from `+= word + " "` — separator BETWEEN words only
    (i > 0). Fails LeetCode's exact-match judge. (Also hit this
    session; same trap as #93 Trap 3.)

 3. Reaching for [String] tokenization when the problem is an in-place
    segment pass — O(n) aux where O(1) suffices. Clean-input problems
    are precisely the ones where in-place is easy; don't spend the
    allocation.

 4. Variable shadowing (words: [String] vs inner words: [Character])
    compiles but reads terribly — distinct names per role.

 5. start = end + 1 can land AT chars.count — the outer while guard
    absorbs it. Know why it's safe rather than trusting it.

 6. Complexity comment discipline: this solution is O(1) aux — writing
    "S - O(n)" undersells it. State auxiliary vs total explicitly.
*/

// MARK: - Tests
print("--- Brute Force ---")
print(reverseWordsBruteForce("Let's take LeetCode contest"))
// "s'teL ekat edoCteeL tsetnoc"
print(reverseWordsBruteForce("Mr Ding"))   // "rM gniD"
print(reverseWordsBruteForce("a"))         // "a"

print("--- Optimised (in-place) ---")
print(reverseWords("Let's take LeetCode contest"))
// "s'teL ekat edoCteeL tsetnoc"
print(reverseWords("Mr Ding"))   // "rM gniD"
print(reverseWords("a"))         // "a"
print(reverseWords("ab cd"))     // "ba dc"

// MARK: - Interview Q&A
/*
 Q1. How does this relate to LC 151 (#93)?
 A1. 557 is Step 3 of 151 alone, on guaranteed-clean input.
     151 = whole-array reversal + per-word reversal + whitespace
     cleanup. Own 151 and 557 is free; the reverse isn't true.

 Q2. Two ways to handle the last word?
 A2. (a) Virtual space: scan i <= count, treat i == count as a space
     (#93's shape). (b) Nested scan: inner loop's bounds check closes
     the word naturally (this file's shape). Same complexity; (b)
     needs no special-case reasoning, (a) generalizes when you're
     already walking char-by-char for other reasons.

 Q3. Why is the in-place version worth it on an Easy?
 A3. The problem's only real content IS the O(1)-aux discipline —
     tokenize-and-rebuild reduces it to trivia. Interviewers use 557
     as a speed check: fluent in-place segment work in under 10
     minutes signals the 151/186 family is owned.

 Q4. Unicode caveat worth saying aloud in an iOS interview?
 A4. Array(s) yields Characters (extended grapheme clusters), so
     emoji/combining marks survive reversal intact in Swift — unlike
     byte- or UTF-16-level reversal (NSString) which can corrupt
     surrogate pairs. One sentence of platform depth, cheap points.

 Q5. Related problems?
 A5. LC 151 (#93, the superset), LC 186 Reverse Words II (char-array
     in-place variant, premium), LC 344 (#91, the primitive).
*/
