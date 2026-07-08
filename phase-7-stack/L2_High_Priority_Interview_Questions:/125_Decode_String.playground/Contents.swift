// 125_Decode_String
// LC 394 — Medium — Stack

// MARK: - Problem
/*
 Given an encoded string, decode it. Encoding rule: k[encoded_string],
 meaning encoded_string inside the brackets is repeated exactly k times.

 - k is always a positive integer (can be multi-digit: 12, 100)
 - Input is always valid — brackets are balanced
 - Nesting is allowed, and that's the whole difficulty

 Examples:
 "3[a]2[bc]"     → "aaabcbc"
 "3[a2[c]]"      → "accaccacc"
 "2[abc]3[cd]ef" → "abcabccdcdcdef"

 Why stack: on ']' you need the MOST RECENTLY opened '[' — its count
 and the string being built before it. Nested brackets resolve
 inner-first = LIFO.
 */

// MARK: - Brute Force
/*
 Repeatedly find the INNERMOST "k[...]" (a bracket pair containing no
 other brackets), expand it in place, and rescan from the start.
 Each pass is O(n) and there are O(n) bracket pairs → O(n²) passes
 over a string that is also growing → much worse than the stack pass.
 */
func decodeStrBrute(_ s: String) -> String {
    var work = Array(s)

    var hasBracket = true
    while hasBracket {
        hasBracket = false

        // find innermost '[' : the last '[' before the first ']'
        var openIndex = -1
        var closeIndex = -1
        var i = 0
        while i < work.count {
            if work[i] == "[" {
                openIndex = i
            } else if work[i] == "]" {
                closeIndex = i
                break
            }
            i += 1
        }

        if openIndex >= 0, closeIndex > openIndex {
            hasBracket = true

            // read multi-digit k backwards from openIndex
            var numStart = openIndex - 1
            while numStart >= 0, work[numStart].isNumber {
                numStart -= 1
            }
            numStart += 1

            var k = 0
            var d = numStart
            while d < openIndex {
                if let digit = work[d].wholeNumberValue {
                    k = k * 10 + digit
                }
                d += 1
            }

            // inner segment (no nested brackets by construction)
            var segment = [Character]()
            var j = openIndex + 1
            while j < closeIndex {
                segment.append(work[j])
                j += 1
            }

            // rebuild: prefix + segment×k + suffix
            var next = [Character]()
            var p = 0
            while p < numStart {
                next.append(work[p])
                p += 1
            }
            for _ in 0..<k {
                for ch in segment {
                    next.append(ch)
                }
            }
            var q = closeIndex + 1
            while q < work.count {
                next.append(work[q])
                q += 1
            }
            work = next
        }
    }

    var result = ""
    for ch in work {
        result.append(ch)
    }
    return result
}

// MARK: - Optimised (Two Stacks)
/*
 Single pass, four cases per char:
 digit  → build currentNumber (×10 + digit, handles multi-digit)
 '['    → push both currents, reset both
 ']'    → pop k and prev; currentString = prev + currentString × k
 letter → append to currentString
 */
func decodeStr(_ s: String) -> String {

    var numberStack = [Int]()
    var stringStack = [String]()

    var currentNumber = 0
    var currentString = ""

    for char in s {

        if char.isNumber {
            if let digit = char.wholeNumberValue {
                currentNumber = currentNumber * 10 + digit
            }

        } else if char == "[" {
            numberStack.append(currentNumber)
            stringStack.append(currentString)
            currentString = ""
            currentNumber = 0

        } else if char == "]" {
            let repeatCount = numberStack.removeLast()
            let prev = stringStack.removeLast()

            var repeated = ""
            for _ in 0..<repeatCount {
                repeated += currentString
            }
            currentString = prev + repeated   // prev FIRST — replace, not append

        } else {
            currentString.append(char)
        }
    }

    return currentString
}

// MARK: - Dry Run
/*
 s = "3[a2[c]]"

 char  action                          numStack  strStack   currentNum  currentStr
 "3"   currentNumber = 3               []        []         3           ""
 "["   push 3, push ""; reset          [3]       [""]       0           ""
 "a"   append                          [3]       [""]       0           "a"
 "2"   currentNumber = 2               [3]       [""]       2           "a"
 "["   push 2, push "a"; reset         [3,2]     ["","a"]   0           ""
 "c"   append                          [3,2]     ["","a"]   0           "c"
 "]"   k=2, prev="a" → "a"+"cc"        [3]       [""]       0           "acc"
 "]"   k=3, prev=""  → ""+"accaccacc"  []        []         0           "accaccacc"

 return "accaccacc" ✓
 */

// MARK: - Complexity
/*
 Optimised: Time O(n × maxK) worst case — bounded by output length
            (e.g. "100[100[a]]" produces 10,000 chars).
            Space O(n) for the stacks + output.
 Brute:     Time O(n²) passes over a growing string — strictly worse.
            Space O(output).
 */

// MARK: - Traps
/*
 1. ']' must POP the string stack too — forgetting prev loses
    everything built before the '[' ("3[a]2[bc]" drops the "aaa").
 2. Replace, don't append: currentString = prev + repeated.
    += on top of the original gives k+1 copies ("3[a]" → "aaaa").
 3. prev goes FIRST: prev + repeated. Inverting scrambles nesting.
 4. Multi-digit k: currentNumber * 10 + digit. Single-digit parsing
    fails on "12[a]".
 5. char.wholeNumberValue is optional → if let, never force unwrap.
 6. String(repeating:count:) is a convenience initializer — build the
    repeat with a bounded for loop instead.
 7. String building: appending a Character is currentString.append(char),
    no String(char) wrap needed.
 */

// MARK: - Tests
let test1 = "3[a]2[bc]"       // "aaabcbc"
let test2 = "3[a2[c]]"        // "accaccacc"
let test3 = "2[abc]3[cd]ef"   // "abcabccdcdcdef"  (input, not output!)
let test4 = "12[x]"           // "xxxxxxxxxxxx" (multi-digit k)
let test5 = "abc"             // "abc" (no brackets at all)

print(decodeStr(test1))        // aaabcbc
print(decodeStr(test2))        // accaccacc
print(decodeStr(test3))        // abcabccdcdcdef
print(decodeStr(test4))        // xxxxxxxxxxxx
print(decodeStr(test5))        // abc

print(decodeStrBrute(test1))   // aaabcbc
print(decodeStrBrute(test2))   // accaccacc
print(decodeStrBrute(test3))   // abcabccdcdcdef
print(decodeStrBrute(test4))   // xxxxxxxxxxxx
print(decodeStrBrute(test5))   // abc

// MARK: - Interview Q&A
/*
 Q1. Why two stacks (or a stack of tuples)?
 A.  Each '[' opens a new context: the repeat count AND the string
     built so far must both be saved and restored together on ']'.

 Q2. How do you handle multi-digit counts like 100?
 A.  Accumulate: currentNumber = currentNumber * 10 + digit while
     consecutive digits arrive; '[' terminates the number.

 Q3. What exactly happens on ']'?
 A.  Pop k and prev. Repeat currentString k times, then
     currentString = prev + repeated. Prev first — you're resuming
     the outer string with the inner expansion appended.

 Q4. What's the worst-case time complexity?
 A.  O(output length), which can be exponential in nesting depth —
     "2[2[2[...a...]]]" doubles per level. The algorithm is linear
     in the size of what it must produce, so it's optimal.

 Q5. Could you solve it recursively instead?
 A.  Yes — recursion on '[' with the call stack replacing the explicit
     stacks; return (decodedSegment, nextIndex) from each level.
     Same complexity; the iterative version avoids stack-depth limits.

 Q6. Why is a queue wrong here?
 A.  ']' must match the most recent unmatched '[' — LIFO. FIFO would
     pair the first '[' with the first ']', breaking nesting.

 Q7. What single test case best catches order bugs?
 A.  "3[a2[c]]" — it fails if prev isn't popped, if prev/repeated are
     inverted, or if you append instead of replace.
 */
