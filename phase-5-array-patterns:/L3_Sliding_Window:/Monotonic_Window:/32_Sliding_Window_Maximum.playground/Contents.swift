import Foundation

//: 32_Sliding_Window_Maximum
// Pattern: Fixed Size Sliding Window + Monotonic Deque

/*
==================================================
PROBLEM
==================================================

Given an integer array nums and an integer k.

There is a sliding window of size k moving
from left to right.

Return the maximum value from every window.

==================================================
EXAMPLE
==================================================

Input:

nums = [1,3,-1,-3,5,3,6,7]
k = 3

Windows:

[1,3,-1]      -> 3
[3,-1,-3]     -> 3
[-1,-3,5]     -> 5
[-3,5,3]      -> 5
[5,3,6]       -> 6
[3,6,7]       -> 7

Output:

[3,3,5,5,6,7]

==================================================
OBSERVATION
==================================================

For every window:

Find maximum value.

Brute Force:

Window 1:
[1,3,-1]

Maximum = 3

Window 2:
[3,-1,-3]

Maximum = 3

Window 3:
[-1,-3,5]

Maximum = 5

Repeat for every window.

==================================================
PATTERN
==================================================

Fixed Size Sliding Window

+
Monotonic Deque

==================================================
*/


// MARK: - Brute Force Solution O(n × k)

/*
==================================================
IDEA
==================================================

Generate every window of size k.

For every window:

Find maximum manually.

Append maximum to result.

==================================================
*/

var nums = [1,3,-1,-3,5,3,6,7]
var k = 3

var bruteForceResult = [Int]()

for start in 0...(nums.count - k) {

    var maximum = nums[start]

    for index in start..<(start + k) {

        if nums[index] > maximum {
            maximum = nums[index]
        }
    }

    bruteForceResult.append(maximum)
}

print("Brute Force:", bruteForceResult)

/*
Output:

[3,3,5,5,6,7]
*/

/*
==================================================
BRUTE FORCE DRY RUN
==================================================

nums = [1,3,-1,-3,5,3,6,7]

k = 3

--------------------------------

Window

[1,3,-1]

Maximum = 3

Result

[3]

--------------------------------

Window

[3,-1,-3]

Maximum = 3

Result

[3,3]

--------------------------------

Window

[-1,-3,5]

Maximum = 5

Result

[3,3,5]

--------------------------------

Window

[-3,5,3]

Maximum = 5

Result

[3,3,5,5]

--------------------------------

Window

[5,3,6]

Maximum = 6

Result

[3,3,5,5,6]

--------------------------------

Window

[3,6,7]

Maximum = 7

Result

[3,3,5,5,6,7]

==================================================
COMPLEXITY
==================================================

Time  : O(n × k)

Space : O(1)

==================================================
PROBLEM
==================================================

Maximum is recalculated
for every window.

Lots of repeated work.

==================================================
*/


// MARK: - Optimized Solution O(n)

/*
==================================================
KEY INSIGHT
==================================================

Need maximum in O(1).

Use Monotonic Deque.

Store indices.

Maintain decreasing order.

Front always contains
maximum element index.

==================================================
EXAMPLE
==================================================

Deque Values

[7,5,3]

Front
 ↓

[7,5,3]

Maximum = 7

==================================================
WHY REMOVE SMALLER VALUES?
==================================================

Current:

[5,3]

New Element:

6

3 < 6

remove 3

5 < 6

remove 5

Deque:

[6]

Reason:

Smaller values can never
be maximum while 6 exists.

==================================================
*/

var deque = [Int]()
var optimizedResult = [Int]()

for right in 0..<nums.count {

    /*
     --------------------------------
     STEP 1

     Remove expired indices

     Outside current window
     --------------------------------
     */

    while let firstIndex = deque.first,
          firstIndex <= right - k {

        deque.removeFirst()
    }

    /*
     --------------------------------
     STEP 2

     Remove smaller values

     Maintain decreasing order
     --------------------------------
     */

    while let lastIndex = deque.last,
          nums[lastIndex] < nums[right] {

        deque.removeLast()
    }

    /*
     --------------------------------
     STEP 3

     Add current index
     --------------------------------
     */

    deque.append(right)

    /*
     --------------------------------
     STEP 4

     Window formed?

     right >= k - 1
     --------------------------------
     */

    if right >= k - 1,
       let firstIndex = deque.first {

        optimizedResult.append(
            nums[firstIndex]
        )
    }
}

print("Optimized:", optimizedResult)

/*
Output:

[3,3,5,5,6,7]
*/


/*
==================================================
OPTIMIZED DRY RUN
==================================================

nums = [1,3,-1,-3,5]
k = 3

==================================================

right = 0

value = 1

deque = [0]

values

[1]

Window not formed

==================================================

right = 1

value = 3

1 < 3

remove index 0

deque = []

append 1

deque = [1]

values

[3]

Window not formed

==================================================

right = 2

value = -1

append 2

deque = [1,2]

values

[3,-1]

Window formed

Maximum

= nums[1]

= 3

Result

[3]

==================================================

right = 3

value = -3

append 3

deque = [1,2,3]

values

[3,-1,-3]

Maximum

= nums[1]

= 3

Result

[3,3]

==================================================

right = 4

Remove expired

index 1

because

1 <= right-k

1 <= 1

remove

deque

[2,3]

value = 5

-3 < 5

remove

-1 < 5

remove

deque = []

append 4

deque = [4]

values

[5]

Maximum

= 5

Result

[3,3,5]

Continue...

Final Result

[3,3,5,5,6,7]

==================================================
WHY STORE INDICES?
==================================================

Need to know whether
an element left the window.

Example:

Window:

indices

0 1 2

Next Window:

1 2 3

Index 0 expired.

Easy to detect using index.

==================================================
IMPORTANT CONDITIONS
==================================================

1. Remove Expired

firstIndex <= right - k

--------------------------------

2. Remove Smaller

nums[lastIndex]
<
nums[right]

--------------------------------

3. Window Ready

right >= k - 1

--------------------------------

4. Maximum

nums[deque.first]

==================================================
MAIN IDEA
==================================================

Remove Expired

↓

Remove Smaller

↓

Insert Current Index

↓

Take Front Maximum

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n × k)
Space : O(1)

--------------------------------

Optimized

Time  : O(n)

Space : O(k)

==================================================
WHY O(n)?
==================================================

Every index:

Inserted once

Removed once

Total Operations:

2n

Therefore:

O(n)

==================================================
MEMORY TRICK
==================================================

Monotonic Deque

Front
=
Maximum

--------------------------------

Remove Expired

--------------------------------

Remove Smaller

--------------------------------

Append Current

--------------------------------

Take Front Maximum

==================================================
INTERVIEW IMPORTANCE
==================================================

Difficulty : Hard

Priority   : ⭐⭐⭐⭐⭐

Must Practice 5-6 Times

Classic Monotonic Queue Problem

Related Problems:

Sliding Window Maximum
Daily Temperatures
Next Greater Element
Stock Span
Largest Rectangle Histogram

==================================================
INTERVIEW SUMMARY
==================================================

Fixed Size Window

Need Maximum Quickly

Store Indices In Deque

Maintain Decreasing Order

Front Always Gives Maximum

Time : O(n)

==================================================
*/
