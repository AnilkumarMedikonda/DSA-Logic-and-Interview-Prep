import Foundation

//:33_Longest_Continuous_Subarray_With_Absolute_Diff_Less_Than_Or_Equal_To_Limit

// Pattern: Variable Size Sliding Window + Monotonic Deques

/*
==================================================
PROBLEM
==================================================

Given an integer array nums
and an integer limit.

Return the length of the longest
continuous subarray such that:

maxElement - minElement <= limit

==================================================
EXAMPLE
==================================================

Input:

nums = [8,2,4,7]
limit = 4

Subarrays:

[8]
max = 8
min = 8

8 - 8 = 0

Valid

--------------------------------

[2,4]

max = 4
min = 2

4 - 2 = 2

Valid

Length = 2

--------------------------------

[2,4,7]

max = 7
min = 2

7 - 2 = 5

Invalid

5 > 4

==================================================
OUTPUT
==================================================

2

==================================================
KEY OBSERVATION
==================================================

For every window
we need:

Maximum Element

Minimum Element

Very frequently.

Brute Force:

Recalculate max/min
for every subarray.

Too expensive.

Need:

Maximum -> O(1)

Minimum -> O(1)

==================================================
PATTERN
==================================================

Variable Size Sliding Window

+
Monotonic Max Queue

+
Monotonic Min Queue

==================================================
*/


// MARK: - Brute Force O(n²)

/*
==================================================
IDEA
==================================================

Generate every subarray.

Maintain:

currentMax
currentMin

while expanding.

If:

currentMax - currentMin <= limit

update answer.

==================================================
*/

var nums = [8,2,4,7]
var limit = 4

var bruteForceAnswer = 0

for start in 0..<nums.count {

    var currentMax = Int.min
    var currentMin = Int.max

    for end in start..<nums.count {

        let number = nums[end]

        currentMax = max(
            currentMax,
            number
        )

        currentMin = min(
            currentMin,
            number
        )

        if currentMax - currentMin <= limit {

            bruteForceAnswer = max(
                bruteForceAnswer,
                end - start + 1
            )
        }
    }
}

print("Brute Force:", bruteForceAnswer)

/*
Output:

2
*/


/*
==================================================
BRUTE FORCE DRY RUN
==================================================

nums = [8,2,4,7]

limit = 4

--------------------------------

start = 0

[8]

max = 8
min = 8

difference = 0

Valid

answer = 1

--------------------------------

[8,2]

max = 8
min = 2

difference = 6

Invalid

--------------------------------

start = 1

[2]

difference = 0

Valid

answer = 1

--------------------------------

[2,4]

max = 4
min = 2

difference = 2

Valid

answer = 2

--------------------------------

[2,4,7]

max = 7
min = 2

difference = 5

Invalid

Final Answer

2

==================================================
COMPLEXITY
==================================================

Time  : O(n²)

Space : O(1)

==================================================
*/


// MARK: - Optimized O(n)

/*
==================================================
KEY IDEA
==================================================

Need:

Maximum

Minimum

inside current window.

Use:

maxDeque
minDeque

Store indices.

==================================================
MAX DEQUE
==================================================

Maintain decreasing order.

Example:

8 7 4 2

Front

8

Maximum

==================================================
MIN DEQUE
==================================================

Maintain increasing order.

Example:

2 4 7 8

Front

2

Minimum

==================================================
*/

var left = 0
var optimizedAnswer = 0

var maxDeque = [Int]()
var minDeque = [Int]()

for right in 0..<nums.count {

    /*
     --------------------------------
     STEP 1

     Maintain Max Deque

     Decreasing Order
     --------------------------------
     */

    while let lastIndex = maxDeque.last,
          nums[lastIndex] < nums[right] {

        maxDeque.removeLast()
    }

    maxDeque.append(right)

    /*
     --------------------------------
     STEP 2

     Maintain Min Deque

     Increasing Order
     --------------------------------
     */

    while let lastIndex = minDeque.last,
          nums[lastIndex] > nums[right] {

        minDeque.removeLast()
    }

    minDeque.append(right)

    /*
     --------------------------------
     STEP 3

     Invalid Window?

     max - min > limit

     Shrink Window
     --------------------------------
     */

    while let maxIndex = maxDeque.first,
          let minIndex = minDeque.first,
          nums[maxIndex] - nums[minIndex] > limit {

        if let firstIndex = maxDeque.first,
           firstIndex == left {

            maxDeque.removeFirst()
        }

        if let firstIndex = minDeque.first,
           firstIndex == left {

            minDeque.removeFirst()
        }

        left += 1
    }

    /*
     --------------------------------
     STEP 4

     Update Answer
     --------------------------------
     */

    optimizedAnswer = max(
        optimizedAnswer,
        right - left + 1
    )
}

print("Optimized:", optimizedAnswer)

/*
Output:

2
*/


/*
==================================================
OPTIMIZED DRY RUN
==================================================

nums = [8,2,4,7]

limit = 4

==================================================

right = 0

window

[8]

maxDeque

[8]

minDeque

[8]

difference

8 - 8 = 0

Valid

answer = 1

==================================================

right = 1

window

[8,2]

Maximum

8

Minimum

2

difference

6

Invalid

Move Left

window

[2]

difference

0

Valid

==================================================

right = 2

window

[2,4]

Maximum

4

Minimum

2

difference

2

Valid

answer = 2

==================================================

right = 3

window

[2,4,7]

Maximum

7

Minimum

2

difference

5

Invalid

Move Left

window

[4,7]

difference

3

Valid

answer = 2

==================================================

Final Answer

2

==================================================
IMPORTANT CONDITIONS
==================================================

Maximum

nums[maxDeque.first]

--------------------------------

Minimum

nums[minDeque.first]

--------------------------------

Valid Window

max - min <= limit

--------------------------------

Invalid Window

max - min > limit

--------------------------------

Update Answer

answer = max(
    answer,
    right - left + 1
)

==================================================
WHY REMOVE SMALLER VALUES?
==================================================

Current:

8 4

New:

7

4 < 7

Remove 4

Deque:

8 7

Reason:

4 can never become
maximum again.

==================================================
WHY REMOVE LARGER VALUES?
==================================================

Current:

2 4 7

New:

1

Remove:

7
4
2

Deque:

1

Reason:

They can never become
minimum again.

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n²)

Space : O(1)

--------------------------------

Optimized

Time  : O(n)

Space : O(n)

==================================================
WHY O(n)?
==================================================

Each index:

Inserted once

Removed once

from both deques.

Total:

O(2n)

=
O(n)

==================================================
MEMORY TRICK
==================================================

Need:

Maximum
Minimum

Use:

maxDeque
minDeque

--------------------------------

maxDeque

Decreasing Order

--------------------------------

minDeque

Increasing Order

--------------------------------

Invalid

max - min > limit

Shrink Window

--------------------------------

Valid

Update Answer

==================================================
INTERVIEW IMPORTANCE
==================================================

Difficulty : Medium

Priority   : ⭐⭐⭐⭐⭐

Must Practice 5 Times

Very Common

Sliding Window
+
Monotonic Queue

Related:

239 Sliding Window Maximum

Sliding Window Minimum

1438 Longest Continuous Subarray

==================================================
INTERVIEW SUMMARY
==================================================

Need Maximum + Minimum
inside current window.

Use Two Monotonic Deques.

maxDeque

decreasing

minDeque

increasing

If:

max - min > limit

Move Left

Track longest valid length.

Time : O(n)

==================================================
*/
