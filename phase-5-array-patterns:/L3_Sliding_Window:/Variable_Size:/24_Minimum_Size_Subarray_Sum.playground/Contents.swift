import Foundation

//: 24_Minimum_Size_Subarray_Sum
// Pattern: Variable Size Sliding Window

/*
==================================================
PROBLEM
==================================================

Given an array of positive integers nums
and an integer target.

Return the minimum length of a subarray
whose sum is greater than or equal to target.

If no such subarray exists,
return 0.

==================================================
EXAMPLE
==================================================

target = 7

nums = [2,3,1,2,4,3]

Output:

2

Reason:

[4,3]

sum = 7

length = 2

==================================================
PATTERN
==================================================

Variable Size Sliding Window

==================================================
*/


// MARK: - Brute Force

let nums = [2,3,1,2,4,3]
let target = 7

var minimumLength = Int.max

for i in 0..<nums.count {

    var sum = 0

    for j in i..<nums.count {

        sum += nums[j]

        if sum >= target {

            minimumLength =
            min(minimumLength,
                j - i + 1)

            break
        }
    }
}

print(minimumLength)

/*
 Time  : O(n²)
 Space : O(1)
 */


// MARK: - Optimized (Interview Preferred)

var left = 0
var sum = 0
var answer = Int.max

for right in 0..<nums.count {

    sum += nums[right]

    while sum >= target {

        answer =
        min(answer,
            right - left + 1)

        sum -= nums[left]
        left += 1
    }
}

print(answer)

/*
 Time  : O(n)
 Space : O(1)
 */


/*
==================================================
DRY RUN
==================================================

target = 7

nums = [2,3,1,2,4,3]

--------------------------------------------------

right = 0

sum = 2

Not Valid

--------------------------------------------------

right = 1

sum = 5

Not Valid

--------------------------------------------------

right = 2

sum = 6

Not Valid

--------------------------------------------------

right = 3

sum = 8

Valid

Window:

[2,3,1,2]

length = 4

answer = 4

--------------------------------------------------

Shrink Window

Remove:

2

sum = 6

left = 1

Stop shrinking

--------------------------------------------------

right = 4

Add:

4

sum = 10

Valid

Window:

[3,1,2,4]

length = 4

answer = 4

--------------------------------------------------

Shrink

Remove:

3

sum = 7

left = 2

Still Valid

Window:

[1,2,4]

length = 3

answer = 3

--------------------------------------------------

Shrink Again

Remove:

1

sum = 6

left = 3

Stop

--------------------------------------------------

right = 5

Add:

3

sum = 9

Valid

Window:

[2,4,3]

length = 3

answer = 3

--------------------------------------------------

Shrink

Remove:

2

sum = 7

left = 4

Still Valid

Window:

[4,3]

length = 2

answer = 2

--------------------------------------------------

Shrink Again

Remove:

4

sum = 3

left = 5

Stop

==================================================
FINAL ANSWER
==================================================

2

==================================================
MAIN IDEA
==================================================

Expand window until:

sum >= target

--------------------------------------------------

Once valid:

Update minimum length

--------------------------------------------------

Shrink from left

to make window smaller

--------------------------------------------------

Continue until:

sum < target

Then expand again

==================================================
WINDOW FORMULA
==================================================

Length:

right - left + 1

Example:

left = 2
right = 4

length:

4 - 2 + 1

=

3

==================================================
WHY WHILE?
==================================================

Current Window:

[3,1,2,4]

sum = 10

Already Valid

--------------------------------------------------

Can we make it smaller?

Yes

Remove left element

--------------------------------------------------

Keep shrinking

while sum >= target

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n²)

Space : O(1)

--------------------------------------------------

Optimized

Time  : O(n)

Space : O(1)

--------------------------------------------------

Why O(n)?

Each element:

Added once

sum += nums[right]

--------------------------------------------------

Removed once

sum -= nums[left]

--------------------------------------------------

Total operations:

2n

=

O(n)

==================================================
RECOGNITION
==================================================

Question says:

✓ Minimum Length

✓ Smallest Window

✓ Smallest Subarray

✓ Sum Condition

Think:

Variable Size Sliding Window

==================================================
QUICK INTERVIEW NOTE
==================================================

Pattern:

Variable Size Sliding Window

--------------------------------------------------

Expand Window

sum += nums[right]

--------------------------------------------------

When:

sum >= target

Update answer

--------------------------------------------------

Shrink Window

sum -= nums[left]

left += 1

--------------------------------------------------

Window Length

right - left + 1

--------------------------------------------------

Time  : O(n)

Space : O(1)

--------------------------------------------------

Interview Preferred:
Optimized Solution

==================================================
MEMORY TRICK
==================================================

sum < target

→ Expand

--------------------------------------------------

sum >= target

→ Update Answer

→ Shrink

--------------------------------------------------

Minimum Problem

Shrink Aggressively

==================================================
*/
