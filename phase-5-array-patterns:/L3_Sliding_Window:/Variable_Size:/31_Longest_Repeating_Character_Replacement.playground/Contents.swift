import Foundation

//: 31_Longest_Repeating_Character_Replacement
// Pattern: Sliding Window + HashMap + Max Frequency

/*
==================================================
PROBLEM
==================================================

Given a string s and an integer k.

You can replace at most k characters.

Return the length of the longest substring
that can be converted into the same character.

==================================================
EXAMPLE
==================================================

Input:

s = "AABABBA"
k = 1

Output:

4

Explanation:

AABA

A = 3
B = 1

Replace:

B -> A

AAAA

Length = 4

==================================================
KEY INSIGHT
==================================================

Inside every window:

Keep the character with
maximum frequency.

Replace all remaining characters.

Replacements Needed

=
Window Length
-
Maximum Frequency

==================================================
IMPORTANT FORMULA
==================================================

replacementsNeeded

=
windowLength
-
maxFrequency

Valid Window

=
windowLength - maxFrequency <= k

Invalid Window

=
windowLength - maxFrequency > k

==================================================
PATTERN
==================================================

Variable Size Sliding Window

Expand Window
→ Move Right

Invalid Window
→ Shrink Left

Track Longest Valid Window

==================================================
*/

// MARK: - Brute Force O(n²)

let s = "AABABBA"
let k = 1

let characters = Array(s)

var longestLength = 0

for start in 0..<characters.count {

    var frequency = [Character:Int]()
    var maxFrequency = 0

    for end in start..<characters.count {

        let character = characters[end]

        if let count = frequency[character] {
            frequency[character] = count + 1
        } else {
            frequency[character] = 1
        }

        maxFrequency = max(
            maxFrequency,
            frequency[character]!
        )

        let windowLength =
        end - start + 1

        let replacementsNeeded =
        windowLength - maxFrequency

        if replacementsNeeded <= k {

            longestLength = max(
                longestLength,
                windowLength
            )
        }
    }
}

print(longestLength)

// Time  : O(n²)
// Space : O(26)

/*
==================================================
BRUTE FORCE IDEA
==================================================

Generate every substring.

For every substring:

1. Count frequencies
2. Find max frequency
3. Calculate replacements needed

windowLength - maxFrequency

4. If <= k

update answer

==================================================
*/


// MARK: - Optimized O(n)

var left = 0
var answer = 0
var maxFrequency = 0

var frequency = [Character:Int]()

for right in 0..<characters.count {

    let character = characters[right]

    if let count = frequency[character] {
        frequency[character] = count + 1
    } else {
        frequency[character] = 1
    }

    maxFrequency = max(
        maxFrequency,
        frequency[character]!
    )

    while (right - left + 1)
            - maxFrequency > k {

        let leftCharacter =
        characters[left]

        if let count =
            frequency[leftCharacter] {

            if count == 1 {

                frequency.removeValue(
                    forKey: leftCharacter
                )

            } else {

                frequency[leftCharacter] =
                count - 1
            }
        }

        left += 1
    }

    answer = max(
        answer,
        right - left + 1
    )
}

print(answer)

// Time  : O(n)
// Space : O(26)

/*
==================================================
DRY RUN
==================================================

s = "AABABBA"
k = 1

--------------------------------

right = 0

window

A

frequency

A = 1

maxFrequency = 1

windowLength = 1

1 - 1 = 0

Valid

answer = 1

--------------------------------

right = 1

window

AA

frequency

A = 2

maxFrequency = 2

windowLength = 2

2 - 2 = 0

Valid

answer = 2

--------------------------------

right = 2

window

AAB

frequency

A = 2
B = 1

maxFrequency = 2

windowLength = 3

3 - 2 = 1

Valid

answer = 3

--------------------------------

right = 3

window

AABA

frequency

A = 3
B = 1

maxFrequency = 3

windowLength = 4

4 - 3 = 1

Valid

answer = 4

--------------------------------

right = 4

window

AABAB

frequency

A = 3
B = 2

maxFrequency = 3

windowLength = 5

5 - 3 = 2

Invalid

2 > k

Move Left

window becomes valid

Continue...

Final Answer

=
4

==================================================
MOST IMPORTANT FORMULA
==================================================

windowLength
-
maxFrequency

Valid

<= k

Invalid

> k

==================================================
MAIN IDEA
==================================================

Expand Window
→ Move Right

Calculate

windowLength - maxFrequency

If Invalid

→ Move Left

Track

Maximum Valid Window Length

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n²)
Space : O(26)

Optimized

Time  : O(n)
Space : O(26)

==================================================
MEMORY TRICK
==================================================

Longest Repeating Character

Keep Most Frequent Character

Replace Remaining Characters

Needed Replacements

=
windowLength
-
maxFrequency

If Needed > k

→ Shrink

Else

→ Update Answer

==================================================
INTERVIEW IMPORTANCE
==================================================

Difficulty : Medium

Priority   : ⭐⭐⭐⭐⭐

Must Practice 5 Times

Very Common

Sliding Window
Frequency Map
Longest Valid Window

==================================================
*/
