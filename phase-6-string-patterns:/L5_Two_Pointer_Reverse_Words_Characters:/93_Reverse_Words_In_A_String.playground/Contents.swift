import Foundation

// MARK: - Problem
/*
 #93 — LC 151: Reverse Words in a String (Medium)

 Return the WORDS of `s` in REVERSE ORDER, single-space joined,
 no leading/trailing whitespace. Input may have extra spaces anywhere.

   "the sky is blue"  -> "blue is sky the"
   "  hello world  "  -> "world hello"
   "a good   example" -> "example good a"

 Constraints: 1 <= s.count <= 10^4; at least one word.
 Pattern: tokenize + backward join (brute) / reverse-of-reverse in place (opt).
*/

// MARK: - Brute Force
// Tokenize manually; walk words backward, space BETWEEN words only.
// Post-loop flush catches the LAST word (no trailing space triggers it).

func reverseWordsBruteForce(_ s: String) -> String {
    var words = [String]()
    var buffer = ""

    for ch in s {
        if ch != " " {
            buffer += String(ch)
        } else if !buffer.isEmpty {
            words.append(buffer)
            buffer = ""
        }
    }
    if !buffer.isEmpty {
        words.append(buffer)
    }

    var result = ""
    var i = words.count - 1
    while i >= 0 {
        result += words[i]
        if i > 0 {
            result += " "
        }
        i -= 1
    }

    return result
}

// MARK: - Optimised
/*
 Reverse-of-Reverse, in place:
   1. Compress spaces (write pointer): one space between words, none at edges.
   2. Reverse the ENTIRE array   -> word order flipped, letters backward.
   3. Reverse EACH word          -> letters fixed, order stays flipped.

 After step 1, logical length = `write`; chars beyond it are garbage —
 every later bound uses `write`, never chars.count.
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

func reverseWords(_ s: String) -> String {
    var chars = Array(s)

    // Step 1: compress spaces
    var write = 0
    var read = 0
    while read < chars.count {
        if chars[read] != " " {
            chars[write] = chars[read]
            write += 1
        } else if write > 0 && chars[write - 1] != " " {
            chars[write] = " "
            write += 1
        }
        read += 1
    }
    if write > 0 && chars[write - 1] == " " {   // trim single trailing space
        write -= 1
    }

    // Step 2: reverse whole (compressed) array
    reverse(&chars, 0, write - 1)

    // Step 3: reverse each word (i == write acts as a virtual space)
    var start = 0
    var i = 0
    while i <= write {
        if i == write || chars[i] == " " {
            reverse(&chars, start, i - 1)
            start = i + 1
        }
        i += 1
    }

    var result = ""
    var j = 0
    while j < write {
        result += String(chars[j])
        j += 1
    }
    return result
}

// MARK: - Dry Run
/*
 reverseWords("  hello world  ")
   Step 1: leading spaces skipped (write==0); internal space kept once;
           trailing trimmed -> "hello world", write = 11
   Step 2: reverse [0,10]   -> "dlrow olleh"
   Step 3: i=5 space -> reverse [0,4] -> "world olleh"
           i=11 virtual     -> reverse [6,10] -> "world hello" ✓

 Three-state picture:
   "hello world" -> "dlrow olleh" -> "world hello"
*/

// MARK: - Complexity
/*
 Brute: O(n) time, O(n) space (words array duplicates content)
 Opt:   O(n) time, O(1) AUXILIARY space (one mutated buffer;
        Array(s)/String are Swift I/O conversions, not working storage)
*/

// MARK: - Traps
/*
 1. Last word: brute needs the post-loop flush; opt needs the virtual
    space at i == write. Either miss silently drops the final word.
 2. Compress guards: write==0 (leading), chars[write-1] != " "
    (multiple internal), post-pass trim (trailing).
 3. Backward join: separator only when i > 0.
 4. After compression, use `write` everywhere — chars.count is stale.
 5. House rules: no split/joined/reversed — all manual.
*/

// MARK: - Tests
print("--- Brute Force ---")
print(reverseWordsBruteForce("the sky is blue"))   // "blue is sky the"
print(reverseWordsBruteForce("  hello world  "))   // "world hello"
print(reverseWordsBruteForce("a good   example"))  // "example good a"
print(reverseWordsBruteForce("   a   "))           // "a"

print("--- Optimised ---")
print(reverseWords("the sky is blue"))   // "blue is sky the"
print(reverseWords("  hello world  "))   // "world hello"
print(reverseWords("a good   example"))  // "example good a"
print(reverseWords("   a   "))           // "a"

// MARK: - Interview Q&A
/*
 Q1. Why does reverse-whole-then-each-word work?
 A1. Whole reversal flips word order but breaks letters; per-word
     reversal (an involution) fixes letters without touching order.

 Q2. Space complexity, precisely?
 A2. O(1) auxiliary — pointers + one temp char on a single buffer.
     Brute can't be adapted to this; it's a different algorithm.

 Q3. The real interview question (Microsoft/Amazon)?
 A3. "Now do it with O(1) extra" — the optimised version IS the answer;
     brute is the expected opener. Lead with brute, offer the upgrade.

 Q4. LC 557 relation?
 A4. 557 = step 3 alone on clean input. 151 cold => 557 free.

 Q5. Best single edge test?
 A5. "   a   " — exercises all three compress guards, a no-op whole
     reversal, and the virtual-space word close in one input.
*/
