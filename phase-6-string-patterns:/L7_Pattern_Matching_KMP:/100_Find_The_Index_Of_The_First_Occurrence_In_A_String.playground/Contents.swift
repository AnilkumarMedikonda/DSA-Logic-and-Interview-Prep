import Foundation

// MARK: - Problem
/*
 LC 28 — Find the Index of the First Occurrence in a String (Easy)
 Level: L7_Pattern_Matching_KMP — Problem #100

 Given two strings `haystack` and `needle`, return the index of the FIRST
 occurrence of `needle` in `haystack`, or -1 if `needle` is not part of `haystack`.

 Example 1:
   Input:  haystack = "sadbutsad", needle = "sad"
   Output: 0   (occurs at 0 and 6 — first occurrence wins)

 Example 2:
   Input:  haystack = "leetcode", needle = "leeto"
   Output: -1

 Edge cases:
   - needle empty            -> 0 (by convention)
   - needle longer than hay  -> -1
   - needle == haystack      -> 0
   - match at the very end   -> still found (loop bound must allow it)
*/

// MARK: - Brute Force (forward two-pointer scan) — THE interview answer
/*
 For every valid starting index i in haystack, scan forward comparing
 haystack[i + j] with needle[j]. Break on mismatch, return i on full match.

 This is a FORWARD scan, not converging two-pointer.
 O(n·m) worst case — accepted answer for LC 28 at product companies.
*/

func indexOfFirstOccurrenceBrute(_ haystack: String, _ needle: String) -> Int {

    if needle.isEmpty {
        return 0
    }

    if needle.count > haystack.count {
        return -1
    }

    let haystackChars = Array(haystack)
    let needleChars = Array(needle)

    // Last index where needle can still fully fit
    let lastValidStart = haystackChars.count - needleChars.count

    for i in 0...lastValidStart {

        var j = 0

        // Condition-driven forward scan -> while loop
        while j < needleChars.count && haystackChars[i + j] == needleChars[j] {
            j += 1
        }

        if j == needleChars.count {
            return i        // first occurrence — return immediately
        }
    }

    return -1
}

// MARK: - Optimised (KMP) — O(n + m)
/*
 NOTE: read-not-derived. Reference only.
 Interview deliverable = brute force above + two-sentence KMP explanation:

 "KMP precomputes, for every prefix of the pattern, the longest border —
  a proper prefix that is also a suffix. On a mismatch we fall back to that
  border instead of restarting, so the text pointer never moves backwards,
  giving O(n+m) instead of O(n·m)."

 lps[i] answers: "on mismatch after position i, how much of the needle
 have I secretly already re-matched?"
*/

func indexOfFirstOccurrenceKMP(_ haystack: String, _ needle: String) -> Int {

    if needle.isEmpty {
        return 0
    }

    if needle.count > haystack.count {
        return -1
    }

    let haystackChars = Array(haystack)
    let needleChars = Array(needle)

    // ---- Step 1: Build LPS (on the NEEDLE only) ----
    var lps = [Int](repeating: 0, count: needleChars.count)
    var length = 0          // length of current border being extended
    var index = 1           // lps[0] is always 0

    while index < needleChars.count {
        if needleChars[index] == needleChars[length] {
            length += 1
            lps[index] = length     // store border LENGTH, not position
            index += 1
        } else {
            if length > 0 {
                length = lps[length - 1]    // fall back — do NOT advance index
            } else {
                lps[index] = 0
                index += 1
            }
        }
    }

    // ---- Step 2: Search — haystack pointer i NEVER moves backwards ----
    var i = 0
    var j = 0

    while i < haystackChars.count {
        if haystackChars[i] == needleChars[j] {
            i += 1
            j += 1

            if j == needleChars.count {
                return i - j        // match starts here
            }
        } else {
            if j > 0 {
                j = lps[j - 1]      // the KMP jump — skip re-matched chars
            } else {
                i += 1
            }
        }
    }

    return -1
}

// MARK: - Dry Run
/*
 Brute force: haystack = "abcbc", needle = "bc"
   i = 0: 'a' vs 'b' mismatch, j = 0
   i = 1: 'b'=='b' j=1, 'c'=='c' j=2 -> j == 2 == needle.count -> return 1 ✅

 KMP LPS build: needle = "ababc"
   index: 0  1  2  3  4
   char : a  b  a  b  c
   lps  : 0  0  1  2  0
   ("abab" -> prefix "ab" == suffix "ab" -> border length 2)

 KMP search: haystack = "aaaaab", needle = "aaab"  (brute force's worst case)
   lps of "aaab" = [0, 1, 2, 0]
   i=0..2 match a,a,a (j=3); 'a' vs 'b' mismatch -> j = lps[2] = 2 (i stays 3)
   haystack[3]=='a'==needle[2] -> i=4, j=3; haystack[4]=='a' vs 'b' -> j = lps[2] = 2
   haystack[4]=='a'==needle[2] -> i=5, j=3; haystack[5]=='b'==needle[3] -> j=4 == count
   return i - j = 6 - 4 = 2 ✅  (i never moved backwards)
*/

// MARK: - Complexity
/*
 Brute force:
   Time : O(n · m) worst case (e.g. "aaaa...ab" / "aaab"), ~O(n) typical inputs
   Space: O(n + m) for the character arrays

 KMP:
   Time : O(n + m) — every lps fallback of j is paid for by a prior j increment;
          i only ever increases
   Space: O(n + m) char arrays + O(m) LPS array
*/

// MARK: - Traps
/*
 1. String-building brute force ("resut += String(char)") — O(m) allocations per
    comparison. Compare chars by index instead. (My attempt 1.)
 2. Moving the match check OUTSIDE the inner loop — then you only match
    suffixes of haystack, not substrings. (My attempt 2.)
 3. Default return 0 instead of -1 — silently claims a match at index 0.
 4. Empty needle must return 0, handled as an explicit early check.
 5. Outer loop over full haystack instead of 0...lastValidStart — either
    index-out-of-range or wasted iterations.
 6. Forward scan, NOT converging two-pointer — recurring trap in this cluster.
 7. KMP LPS build: loop bound is needleChars.count, NOT haystackChars.count —
    LPS is built on the needle against itself. (My cold-rewrite bug 1.)
 8. KMP LPS build: store lps[index] = length, NOT = index. (Cold-rewrite bug 2.)
 9. KMP LPS fallback branch (length = lps[length - 1]) must NOT advance index —
    incrementing there corrupts the table.
10. KMP jump is j = lps[j - 1] — not lps[j], not j - 1.
*/

// MARK: - Tests
let testCases: [(haystack: String, needle: String, expected: Int)] = [
    ("sadbutsad", "sad", 0),
    ("leetcode", "leeto", -1),
    ("abcbc", "bc", 1),
    ("a", "a", 0),
    ("aaaaab", "aaab", 2),          // brute force worst case
    ("mississippi", "issip", 4),
    ("mississippi", "issipi", -1),
    ("", "", 0),
    ("abc", "", 0),
    ("ab", "abc", -1),              // needle longer than haystack
    ("hello", "lo", 3)              // match at the very end
]

var testIndex = 1
for testCase in testCases {
    let bruteResult = indexOfFirstOccurrenceBrute(testCase.haystack, testCase.needle)
    let kmpResult = indexOfFirstOccurrenceKMP(testCase.haystack, testCase.needle)

    let bruteStatus: String
    if bruteResult == testCase.expected {
        bruteStatus = "✅"
    } else {
        bruteStatus = "❌ got \(bruteResult)"
    }

    let kmpStatus: String
    if kmpResult == testCase.expected {
        kmpStatus = "✅"
    } else {
        kmpStatus = "❌ got \(kmpResult)"
    }

    print("Test \(testIndex): expected \(testCase.expected) | brute \(bruteStatus) | KMP \(kmpStatus)")
    testIndex += 1
}

// MARK: - Interview Q&A
/*
 Q1: What's the time complexity of your solution?
 A : O(n·m) worst case for the forward scan — worst case is inputs like
     "aaaa...ab" with needle "aaab" where every start almost fully matches.
     Typical inputs behave close to O(n) because mismatches happen early.

 Q2: Can you do better?
 A : Yes — KMP achieves O(n+m). It precomputes, for every prefix of the
     pattern, the longest border (proper prefix that is also a suffix).
     On mismatch we fall back to that border instead of restarting, so the
     text pointer never moves backwards.

 Q3: What does the LPS array actually store?
 A : lps[i] = length of the longest proper prefix of needle[0...i] that is
     also a suffix ending at i. Practically: "on mismatch, how much have I
     already re-matched without knowing it."

 Q4: Why does the haystack pointer never need to move backwards in KMP?
 A : Because the border guarantees the last lps[j-1] characters of the text
     already equal the first lps[j-1] characters of the needle — re-checking
     them is provably redundant.

 Q5: Why is brute force acceptable here in an interview?
 A : LC 28 is an implementation question, not an algorithms question. A clean,
     correct O(n·m) scan with the KMP trade-off explained scores better than a
     fumbled O(n+m) attempt. I'd reach for KMP only if the interviewer pushes
     or the constraints demand it.

 Q6: Alternatives to KMP?
 A : Rabin-Karp (rolling hash, O(n+m) expected) and the Z-algorithm — both
     also linear; KMP is the canonical answer for this question.
*/
