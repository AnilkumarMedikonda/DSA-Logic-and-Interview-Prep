//: 17_Partition_Array_Around_A_Pivot
// Dutch National Flag Pattern

import Foundation

/*
==================================================
PROBLEM
==================================================

Given an array and pivot value.

Partition array into:

1. Less than pivot
2. Equal to pivot
3. Greater than pivot

==================================================
EXAMPLE
==================================================

Input:

nums  = [9,12,3,5,14,10,10]
pivot = 10

Possible Output:

[9,3,5,10,10,14,12]

==================================================
IMPORTANT
==================================================

Need:

< pivot | = pivot | > pivot

No sorting required.

Only partition required.

==================================================
PATTERN
==================================================

Dutch National Flag

==================================================
MAIN IDEA
==================================================

Create three partitions:

Less Than Pivot

Equal To Pivot

Greater Than Pivot

==================================================
POINTERS
==================================================

low

Tracks:
next position for
smaller element

--------------------------------------------------

mid

Current element
being processed

--------------------------------------------------

high

Tracks:
next position for
larger element

==================================================
VISUAL
==================================================

|---- < pivot ----|---- = pivot ----|-- Unknown --|---- > pivot ----|

       low               mid                          high

==================================================
RULES
==================================================

Case 1:

nums[mid] < pivot

Belongs left partition

swap(low, mid)

low += 1
mid += 1

--------------------------------------------------

Case 2:

nums[mid] == pivot

Already belongs middle partition

mid += 1

--------------------------------------------------

Case 3:

nums[mid] > pivot

Belongs right partition

swap(mid, high)

high -= 1

IMPORTANT:

Do NOT move mid

Need to inspect
incoming value.

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

var nums = [9,12,3,5,14,10,10]
var pivot = 10

var low = 0
var mid = 0
var high = nums.count - 1

while mid <= high {

    if nums[mid] < pivot {

        nums.swapAt(low, mid)

        low += 1
        mid += 1

    } else if nums[mid] == pivot {

        mid += 1

    } else {

        nums.swapAt(mid, high)

        high -= 1
    }
}

print(nums)

/*
==================================================
OUTPUT
==================================================

Possible Output:

[9,3,5,10,10,14,12]

==================================================
DRY RUN
==================================================

nums = [9,12,3,5,14,10,10]

pivot = 10

--------------------------------------------------

low = 0
mid = 0
high = 6

--------------------------------------------------

nums[mid] = 9

9 < 10

swap(0,0)

low = 1
mid = 1

--------------------------------------------------

nums[mid] = 12

12 > 10

swap(1,6)

Array:

[9,10,3,5,14,10,12]

high = 5

mid stays

--------------------------------------------------

nums[mid] = 10

Equal pivot

mid = 2

--------------------------------------------------

nums[mid] = 3

3 < 10

swap(1,2)

Array:

[9,3,10,5,14,10,12]

low = 2
mid = 3

--------------------------------------------------

Continue until:

mid > high

==================================================
FINAL PARTITIONS
==================================================

[9,3,5]      < 10

[10,10]      = 10

[14,12]      > 10

==================================================
COMPLEXITY
==================================================

TIME : O(n)

WHY?

Each element processed
at most once.

No nested loops.

--------------------------------------------------

SPACE : O(1)

WHY?

Only:

low
mid
high

variables used.

No extra array.

==================================================
MOST IMPORTANT LEARNING
==================================================

Less than pivot:

Move Left

--------------------------------------------------

Equal pivot:

Stay Middle

--------------------------------------------------

Greater than pivot:

Move Right

==================================================
MEMORY TRICK
==================================================

small  -> low

equal  -> mid

large  -> high

==================================================
COMMON MISTAKES
==================================================

1. Using:

while mid < low

Wrong.

Need:

while mid <= high

--------------------------------------------------

2. Swapping when
value == pivot

Wrong.

Just:

mid += 1

--------------------------------------------------

3. Moving mid after
handling > pivot

Wrong.

New value came from
high side.

Need to inspect again.

--------------------------------------------------

4. Forgetting this is
partitioning problem.

Need:

< pivot | = pivot | > pivot

Not full sorting.

==================================================
RELATION TO SORT COLORS
==================================================

Sort Colors:

0 | 1 | 2

--------------------------------------------------

Partition Around Pivot:

< pivot | = pivot | > pivot

Same Dutch National Flag Pattern.

Only comparison changes.

==================================================
*/
