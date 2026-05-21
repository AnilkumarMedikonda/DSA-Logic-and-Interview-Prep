import UIKit

//: 18_Wiggle_Sort_II (Optional)

/*
==================================================
PROBLEM
==================================================

Given an integer array.

Rearrange elements such that:

nums[0] < nums[1] > nums[2] < nums[3] > nums[4] ...

This is called:

Wiggle Order

==================================================
EXAMPLE
==================================================

Input:

[1,5,1,1,6,4]

Output:

[1,6,1,5,1,4]

==================================================
VALIDATION
==================================================

1 < 6

6 > 1

1 < 5

5 > 1

1 < 4

Condition satisfied.

==================================================
PATTERN
==================================================

Sorting + Rearrangement

==================================================
MAIN IDEA
==================================================

Step 1:

Sort array

--------------------------------------------------

Step 2:

Split into two halves

Small Half

Large Half

--------------------------------------------------

Step 3:

Place elements alternately

small
large
small
large

==================================================
VISUAL
==================================================

Sorted:

[1,1,1,4,5,6]

Small Half:

[1,1,1]

Large Half:

[4,5,6]

--------------------------------------------------

Build Result:

1,6,1,5,1,4

==================================================
TIME  : O(n log n)
SPACE : O(n)

==================================================
INTERVIEW NOTE
==================================================

This is considered:

Advanced Problem

Lower interview frequency than:

Sliding Window

HashMap

Binary Search

Trees

Good to understand.

Not mandatory before interviews.

==================================================
*/

var nums = [1,5,1,1,6,4]

/*
==================================================
STEP 1
SORT ARRAY
==================================================
*/

nums.sort()

/*
Sorted:

[1,1,1,4,5,6]
*/

var result = Array(repeating: 0,
                   count: nums.count)

/*
==================================================
STEP 2
POINTERS
==================================================
*/

var left = (nums.count - 1) / 2
var right = nums.count - 1

/*
left  -> last element of small half

right -> last element of large half

==================================================
STEP 3
BUILD WIGGLE ARRAY
==================================================
*/

for i in 0..<nums.count {

    if i % 2 == 0 {

        result[i] = nums[left]

        left -= 1

    } else {

        result[i] = nums[right]

        right -= 1
    }
}

print(result)

/*
==================================================
OUTPUT
==================================================

[1,6,1,5,1,4]

==================================================
DRY RUN
==================================================

Sorted:

[1,1,1,4,5,6]

--------------------------------------------------

left  = 2 -> value 1

right = 5 -> value 6

--------------------------------------------------

i = 0

result[0] = 1

left = 1

--------------------------------------------------

i = 1

result[1] = 6

right = 4

--------------------------------------------------

i = 2

result[2] = 1

left = 0

--------------------------------------------------

i = 3

result[3] = 5

right = 3

--------------------------------------------------

i = 4

result[4] = 1

left = -1

--------------------------------------------------

i = 5

result[5] = 4

right = 2

--------------------------------------------------

Final:

[1,6,1,5,1,4]

==================================================
COMPLEXITY
==================================================

TIME : O(n log n)

WHY?

Sorting dominates complexity.

--------------------------------------------------

SPACE : O(n)

WHY?

Extra result array used.

==================================================
MOST IMPORTANT LEARNING
==================================================

Need pattern:

small < large > small < large

--------------------------------------------------

Take values from:

Small Half

Large Half

alternately.

==================================================
MEMORY TRICK
==================================================

Even Index:

Take Small Half

--------------------------------------------------

Odd Index:

Take Large Half

==================================================
COMMON MISTAKES
==================================================

1. Taking values from
front of sorted array.

May violate wiggle condition.

--------------------------------------------------

2. Forgetting to use
reverse halves.

Need largest remaining
values first.

--------------------------------------------------

3. Assuming full sorting
creates wiggle order.

Wrong.

Need rearrangement.

==================================================
INTERVIEW RECOMMENDATION
==================================================

Understand once.

Keep notes.

Do not spend too much time
on optimal virtual indexing solution.

Move next to:

Sliding Window Pattern

Higher interview ROI.

==================================================
*/
