import UIKit

import Foundation

//: 25_Longest_Substring_Without_Repeating_Characters
// Pattern: Variable Size Sliding Window + HashMap

/*
==================================================
PROBLEM
==================================================

Given a string s,

find the length of the longest substring
without repeating characters.

==================================================
EXAMPLE
==================================================

Input:

s = "abcabcbb"

Output:

3

Reason:

"abc"

length = 3

==================================================
PATTERN
==================================================

Variable Size Sliding Window

+

HashMap

==================================================
*/


// MARK: - Brute Force

let s = "abcabcbb"
let words = Array(s)

var longestLength = 0

for i in 0..<words.count {

    var hashMap = [Character:Int]()

    for j in i..<words.count {

        let ch = words[j]

        if hashMap[ch] != nil {
            break
        }

        hashMap[ch] = 1

        longestLength =
        max(longestLength,
            j - i + 1)
    }
}

print(longestLength)

/*
 Time  : O(n²)
 Space : O(n)
 */


// MARK: - Optimized (Interview Preferred)

var left = 0
var answer = 0

var hashMap = [Character:Int]()

for right in 0..<words.count {

    let ch = words[right]

    if let count = hashMap[ch] {
        hashMap[ch] = count + 1
    } else {
        hashMap[ch] = 1
    }

    while hashMap[ch]! > 1 {

        let leftChar = words[left]

        if let count = hashMap[leftChar] {
            hashMap[leftChar] = count - 1
        }

        left += 1
    }

    answer =
    max(answer,
        right - left + 1)
}

print(answer)

/*
 Time  : O(n)
 Space : O(n)
 */


/*
==================================================
DRY RUN
==================================================

s = "abcabcbb"

--------------------------------------------------

right = 0

Window:

[a]

answer = 1

--------------------------------------------------

right = 1

Window:

[a,b]

answer = 2

--------------------------------------------------

right = 2

Window:

[a,b,c]

answer = 3

--------------------------------------------------

right = 3

Incoming:

a

Window:

[a,b,c,a]

Duplicate Found

--------------------------------------------------

Shrink

Remove:

a

Window:

[b,c,a]

Valid Again

answer = 3

--------------------------------------------------

right = 4

Incoming:

b

Window:

[b,c,a,b]

Duplicate

Shrink

Remove:

b

Window:

[c,a,b]

answer = 3

--------------------------------------------------

Continue

Final Answer:

3

==================================================
MAIN IDEA
==================================================

Expand window

until duplicate appears

--------------------------------------------------

Duplicate Found

Shrink from left

until duplicate removed

--------------------------------------------------

Keep track of

maximum window length

==================================================
WHY WHILE LOOP?
==================================================

Current Window:

[a,b,c,a]

Duplicate:

a

--------------------------------------------------

Need to keep shrinking

until:

a frequency = 1

--------------------------------------------------

while hashMap[ch]! > 1

==================================================
WINDOW LENGTH
==================================================

right - left + 1

Example:

left = 2

right = 4

Length:

4 - 2 + 1

=

3

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n²)

Space : O(n)

--------------------------------------------------

Optimized

Time  : O(n)

Space : O(n)

--------------------------------------------------

Why O(n)?

Each character:

Added once

Removed once

==================================================
RECOGNITION
==================================================

Question Says:

✓ Longest Substring

✓ No Repeating Characters

✓ Unique Characters

Think:

Sliding Window

+

HashMap

==================================================
QUICK INTERVIEW NOTE
==================================================

Pattern:

Variable Size Sliding Window

--------------------------------------------------

Expand

hashMap[ch] += 1

--------------------------------------------------

Duplicate?

hashMap[ch] > 1

--------------------------------------------------

Shrink

hashMap[leftChar] -= 1

left += 1

--------------------------------------------------

Update

maxLength =
max(maxLength,
    right - left + 1)

--------------------------------------------------

Time  : O(n)

Space : O(n)

--------------------------------------------------

Interview Preferred:
Optimized Solution

==================================================
MEMORY TRICK
==================================================

No Duplicate

→ Expand

--------------------------------------------------

Duplicate Found

→ Shrink

--------------------------------------------------

Longest Problem

→ Update Maximum Length

==================================================
INTERVIEW IMPORTANCE
==================================================

25_Longest_Substring_Without_Repeating

Difficulty : Medium

Priority   : ⭐⭐⭐⭐⭐

Very Frequently Asked

Must Practice 4-5 Times

==================================================
*/
