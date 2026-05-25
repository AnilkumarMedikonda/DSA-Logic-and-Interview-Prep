import Foundation

//: 30_Minimum_Window_Substring
// Pattern: Variable Size Sliding Window + HashMap

/*
==================================================
PROBLEM
==================================================

Given two strings:

s = "ADOBECODEBANC"
t = "ABC"

Return the smallest substring of s
that contains all characters of t.

==================================================
EXAMPLE
==================================================

Input:

s = "ADOBECODEBANC"
t = "ABC"

Output:

"BANC"

==================================================
WHY?
==================================================

Need:

A = 1
B = 1
C = 1

Valid Windows:

ADOBEC      ✓
CODEBA      ✓
EBANC       ✓
BANC        ✓

Smallest:

BANC

Length:

4

==================================================
IMPORTANT
==================================================

Frequency Matters

Example:

t = "AABC"

Need:

A = 2
B = 1
C = 1

Window:

ABC

INVALID ❌

Because:

A appears only once.

==================================================
PATTERN
==================================================

Expand Right

↓

Window Becomes Valid

↓

Update Answer

↓

Shrink Left

↓

Find Smaller Valid Window

==================================================
*/


// MARK: - Input

let s = "ADOBECODEBANC"
let t = "ABC"

let words = Array(s)


// MARK: - Need Frequency Map

var need = [Character:Int]()

for ch in t {

    if let count = need[ch] {
        need[ch] = count + 1
    } else {
        need[ch] = 1
    }
}


// MARK: - Validation Function

func isValidWindow(_ window: [Character:Int], _ need: [Character:Int]) -> Bool {

    for (char, requiredCount) in need {
        if let currentCount = window[char] {
            if currentCount < requiredCount {
                return false
            }
        } else {
            return false
        }
    }
    return true
}


/*
==================================================
BRUTE FORCE SOLUTION
==================================================

Generate Every Substring

↓

Check Window Validity

↓

Keep Minimum Length Window

==================================================
*/

var bruteForceMinimumLength = Int.max
var bruteForceAnswer = ""

for i in 0..<words.count {

    var window = [Character:Int]()

    for j in i..<words.count {

        let ch = words[j]

        if let count = window[ch] {
            window[ch] = count + 1
        } else {
            window[ch] = 1
        }

        if isValidWindow(window, need) {

            let currentLength = j - i + 1

            if currentLength < bruteForceMinimumLength {

                bruteForceMinimumLength = currentLength

                bruteForceAnswer =
                String(words[i...j])
            }
        }
    }
}

print("Brute Force Answer:", bruteForceAnswer)

// Time  : O(n² × |t|)
// Space : O(|t|)

/*
==================================================
OPTIMIZED SLIDING WINDOW
==================================================

Expand Right

↓

Window Becomes Valid

↓

Update Minimum Answer

↓

Shrink Left

↓

Try Smaller Valid Window

==================================================
*/

var slidingWindow = [Character:Int]()

var left = 0

var minimumLength = Int.max
var startIndex = 0

for right in 0..<words.count {

    let rightChar = words[right]

    if let count = slidingWindow[rightChar] {
        slidingWindow[rightChar] = count + 1
    } else {
        slidingWindow[rightChar] = 1
    }

    while isValidWindow(slidingWindow, need) {
        let currentLength = right - left + 1

        if currentLength < minimumLength {
            minimumLength = currentLength
            startIndex = left
        }

        let leftChar = words[left]

        if let count = slidingWindow[leftChar] {
            if count == 1 {
                slidingWindow.removeValue(forKey: leftChar)
            } else {
                slidingWindow[leftChar] = count - 1
            }
        }

        left += 1
    }
}

var optimizedAnswer = ""

if minimumLength != Int.max {
    let endIndex = startIndex + minimumLength - 1
    optimizedAnswer = String(words[startIndex...endIndex])
}
print("Sliding Window Answer:", optimizedAnswer)

// Time  : O(n × |t|)
// Space : O(|t|)

/*
==================================================
DRY RUN
==================================================

s = "ADOBECODEBANC"
t = "ABC"

Need:

A = 1
B = 1
C = 1

==================================================
right = 0
==================================================

Window:

A

Valid?

No

Missing:

B
C

==================================================
right = 1
==================================================

Window:

AD

Invalid

==================================================
right = 2
==================================================

Window:

ADO

Invalid

==================================================
right = 3
==================================================

Window:

ADOB

Invalid

==================================================
right = 4
==================================================

Window:

ADOBE

Invalid

==================================================
right = 5
==================================================

Window:

ADOBEC

Contains:

A ✓
B ✓
C ✓

Valid

Length:

6

Store:

ADOBEC

--------------------------------------------------

Shrink

Remove A

Window:

DOBEC

Missing A

Invalid

Stop Shrinking

==================================================
Continue Expanding
==================================================

Window:

CODEBANC

Valid

--------------------------------------------------

Shrink

ODEBANC

Valid

--------------------------------------------------

Shrink

DEBANC

Valid

--------------------------------------------------

Shrink

EBANC

Valid

Length:

5

Update Answer

--------------------------------------------------

Shrink

BANC

Valid

Length:

4

Update Answer

--------------------------------------------------

Shrink

ANC

Missing B

Invalid

Stop Shrinking

==================================================
FINAL ANSWERS
==================================================

Brute Force:

BANC

--------------------------------

Sliding Window:

BANC

==================================================
COMPLEXITY
==================================================

Brute Force

Time:

O(n² × |t|)

Space:

O(|t|)

--------------------------------

Sliding Window

Time:

O(n × |t|)

Space:

O(|t|)

--------------------------------

Interview Optimal

Time:

O(n)

Space:

O(|t|)

Using:

formed
required

==================================================
MEMORY TRICK
==================================================

Minimum Window

=

Expand Until Valid

↓

Shrink While Valid

↓

Keep Smallest Window

==================================================
INTERVIEW TAKEAWAY
==================================================

Longest Problems

↓

Expand While Valid

--------------------------------

Minimum Window Problems

↓

Shrink While Valid

==================================================
PRIORITY
==================================================

Difficulty : Hard

Priority   : ⭐⭐⭐⭐⭐

Must Practice 5 Times
Classic Sliding Window Question
==================================================
*/
