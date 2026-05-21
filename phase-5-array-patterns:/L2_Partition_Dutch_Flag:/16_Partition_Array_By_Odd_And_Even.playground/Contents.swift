//: 16_Partition_Array_By_Odd_And_Even

import Foundation

/*
==================================================
PROBLEM
==================================================

Given an array,

Move all Odd numbers
to the left side

Move all Even numbers
to the right side

==================================================
EXAMPLE
==================================================

Input:

[1,2,3,4,5,6]

Possible Outputs:

[1,5,3,4,2,6]

OR

[1,3,5,2,4,6]

==================================================
IMPORTANT
==================================================

Need only partition.

No sorting required.

Need:

Odd Numbers | Even Numbers

==================================================
PATTERN
==================================================

Partition / Two Pointer

==================================================
MAIN IDEA
==================================================

Left Pointer:

Searches for wrong Even number.

--------------------------------------------------

Right Pointer:

Searches for wrong Odd number.

--------------------------------------------------

When both found:

Swap them.

==================================================
VISUAL
==================================================

Odd | Unknown | Even

 L             H

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

var nums = [1,2,3,4,5,6]

var low = 0
var high = nums.count - 1

while low < high {

    /*
     Skip correct odd numbers
     */

    while low < high &&
          nums[low] % 2 != 0 {

        low += 1
    }

    /*
     Skip correct even numbers
     */

    while low < high &&
          nums[high] % 2 == 0 {

        high -= 1
    }

    /*
     Found:
     Even on left
     Odd on right

     Swap them
     */

    if low < high {

        nums.swapAt(low, high)

        low += 1
        high -= 1
    }
}

print(nums)

/*
==================================================
OUTPUT
==================================================

[1,5,3,4,2,6]

==================================================
DRY RUN
==================================================

Input:

[1,2,3,4,5,6]

low = 0
high = 5

--------------------------------------------------

nums[low] = 1

Odd

Move low

low = 1

--------------------------------------------------

nums[high] = 6

Even

Move high

high = 4

--------------------------------------------------

Now:

low -> 2

high -> 5

Even on left

Odd on right

Swap

--------------------------------------------------

Array:

[1,5,3,4,2,6]

low = 2
high = 3

--------------------------------------------------

nums[2] = 3

Odd

Move low

low = 3

Stop

==================================================
COMPLEXITY
==================================================

TIME : O(n)

WHY?

Each pointer traverses
array at most once.

No nested loops.

--------------------------------------------------

SPACE : O(1)

WHY?

Only:

low
high

variables used.

No extra array.

==================================================
MOST IMPORTANT LEARNING
==================================================

Left Pointer:

Find wrong Even number.

--------------------------------------------------

Right Pointer:

Find wrong Odd number.

--------------------------------------------------

Swap them.

==================================================
MEMORY TRICK
==================================================

Left:

Skip Odd

--------------------------------------------------

Right:

Skip Even

--------------------------------------------------

Swap:

Even ↔ Odd

==================================================
COMMON MISTAKES
==================================================

1. Checking nums[low]
inside second while loop

Wrong.

Need:

nums[high]

--------------------------------------------------

2. Forgetting pointer updates
after swap

Need:

low += 1
high -= 1

--------------------------------------------------

3. Trying to sort array

Not required.

Need only partition.

==================================================
*/
