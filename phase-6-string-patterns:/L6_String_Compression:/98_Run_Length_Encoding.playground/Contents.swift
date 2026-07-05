import Foundation

// MARK: - Problem
/*
 #98 — Run-Length Encoding (GfG standard; Amazon/Microsoft phone-screen warm-up)

 Given a string of lowercase letters, compress it by replacing each run
 of consecutive identical characters with the character followed by its
 count (character FIRST, then count — opposite of #97's say()).

   "aaaabbbccd"       → "a4b3c2d1"
   "abc"              → "a1b1c1"
   "wwwwaaadexxxxxx"  → "w4a3d1e1x6"
   "aaaaaaaaaaa"      → "a11"   (11 a's — multi-digit count)
   ""                 → ""

 Base variant: always write the count, even when it is 1.

 Related: LC 443 String Compression (in-place, omits count 1),
          LC 38 Count and Say (count-first order).
 Decode ("a4b3" → "aaaabbb") is tracked as a SEPARATE problem.
*/

// MARK: - Brute Force / Optimised (same — single-pass simulation)
/*
 Brute and optimised are identical here: one forward scan, one run
 counter. Skeleton is the same as #97's say():
   - fix the current character
   - inner while counts the run AND advances i past it
   - flush: character + count
 Rule locked in from the #97 bug: the inner run-counting loop fully
 owns i — nothing outside it touches i.
*/
func runLengthEncode(_ s: String) -> String {
    var result = ""
    let chars = Array(s)
    var i = 0

    while i < chars.count {
        var count = 0
        let currentChar = chars[i]

        while i < chars.count && chars[i] == currentChar {
            count += 1
            i += 1
        }

        result += "\(currentChar)\(count)"
    }

    return result
}

// MARK: - Dry Run (encode "aaaabbbccd" → "a4b3c2d1")
/*
 chars = ["a","a","a","a","b","b","b","c","c","d"], i = 0

 RUN 1 (i = 0): currentChar = "a"
   inner loop: a,a,a,a match → count = 4, i = 4 (lands on "b")
   append "a" + "4" → result = "a4"

 RUN 2 (i = 4): currentChar = "b"
   inner loop: b,b,b match → count = 3, i = 7 (lands on "c")
   append → result = "a4b3"

 RUN 3 (i = 7): currentChar = "c"
   inner loop: c,c match → count = 2, i = 9 (lands on "d")
   append → result = "a4b3c2"

 RUN 4 (i = 9): currentChar = "d"
   inner loop: d matches → count = 1, i = 10 (past end)
   append → result = "a4b3c2d1"

 Outer check: 10 < 10 false → return "a4b3c2d1" ✅
*/

// MARK: - Complexity
/*
 Time  O(n) — every character visited exactly once by the inner loop.
 Space O(n) for the output. Worst case the encoding EXPANDS the input:
 no repeats ("abc" → "a1b1c1") gives output length 2n.
*/

// MARK: - Traps
/*
 1. Order confusion with #97: RLE is char-then-count ("a4");
    Count and Say's say() is count-then-char ("4a"). One skeleton,
    two problems — the interpolation line is the only difference.
    Don't share one hardcoded function between them.
 2. Extra i += 1 after the inner loop (the bug from the first
    attempt): the inner loop already leaves i on the next run's
    first character. Double-advance skips it and splits/merges runs.
 3. Multi-digit counts: "aaaaaaaaaaa" (11 a's) → "a11". String(count)
    interpolation handles this automatically; only in-place variants
    (LC 443) need digit-by-digit writing.
 4. LC 443 variant confusion: 443 omits the count when a run has
    length 1 ("abc" stays "abc"); base RLE always writes it
    ("abc" → "a1b1c1"). Confirm the variant with the interviewer.
 5. Empty string: chars.count = 0 → outer loop never runs →
    returns "" cleanly. No special case needed.
*/

// MARK: - Tests
func runTests() {
    let encodeCases: [(input: String, expected: String)] = [
        ("aaaabbbccd", "a4b3c2d1"),
        ("abc", "a1b1c1"),
        ("wwwwaaadexxxxxx", "w4a3d1e1x6"),
        ("a", "a1"),
        ("", ""),
        ("aaaaaaaaaaa", "a11")          // 11 a's — multi-digit count
    ]

    for testCase in encodeCases {
        let got = runLengthEncode(testCase.input)
        if got == testCase.expected {
            print("✅ encode(\"\(testCase.input)\") → \"\(got)\"")
        } else {
            print("❌ encode(\"\(testCase.input)\") → \"\(got)\", expected \"\(testCase.expected)\"")
        }
    }
}

runTests()

// MARK: - Interview Q&A
/*
 Q1. When is RLE actually a good compression scheme?
 A1. When the data has long runs — bitmap images, sensor data with
     repeated readings. For text with few repeats it EXPANDS the
     input ("abc" → "a1b1c1", 2x size). Worst case output is 2n.

 Q2. How would you only keep the encoding if it's shorter?
 A2. Encode, compare lengths, return the shorter of encoded/original.
     One extra O(1) comparison after the O(n) pass.

 Q3. Difference from LC 443 String Compression?
 A3. Three: 443 is in-place on a Character array with O(1) extra
     space; 443 omits the count for runs of length 1; 443 writes
     multi-digit counts digit-by-digit into the array. Same
     run-counting core.

 Q4. Can encode be done in-place like 443?
 A4. Only if the encoding never grows past the original (not
     guaranteed for base RLE since count 1 is always written), so
     in-place needs either the 443 omit-1 rule or a right-to-left
     pass after computing the final length.

 Q5. Natural follow-up the interviewer will ask?
 A5. Decode it back ("a4b3" → "aaaabbb") — tracked as a separate
     problem. Key challenge there: multi-digit counts ("a11" = eleven
     a's) require building the number digit-by-digit, and digit
     characters in the ORIGINAL string make plain RLE ambiguous.
*/
