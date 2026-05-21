import Foundation

//: 15_Sort_Colors
// Dutch National Flag Algorithm


/*
==================================================
PROBLEM
==================================================

Given an array containing:

0 = Red
1 = White
2 = Blue

Sort colors in-place.

Do NOT use:

sort()

==================================================
EXAMPLE
==================================================

Input:
[2,0,2,1,1,0]

Output:
[0,0,1,1,2,2]

==================================================
PATTERN
==================================================

Partition / Dutch National Flag

==================================================
MAIN IDEA
==================================================

Partition array into:

0's | 1's | Unknown | 2's

Use 3 pointers:

low
mid
high

==================================================
POINTER MEANING
==================================================

low:

Everything before low
contains only 0's

--------------------------------------------------

mid:

Current element
being processed

--------------------------------------------------

high:

Everything after high
contains only 2's

==================================================
VISUAL
==================================================

|----0's----|----1's----|--Unknown--|----2's----|
      low         mid                 high

==================================================
RULES
==================================================

Case 1:

nums[mid] == 0

0 belongs left side

swap(low, mid)

low += 1
mid += 1

--------------------------------------------------

Case 2:

nums[mid] == 1

Already in correct place

mid += 1

--------------------------------------------------

Case 3:

nums[mid] == 2

2 belongs right side

swap(mid, high)

high -= 1

IMPORTANT:

Do NOT move mid

Need to inspect
new incoming value.

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

var nums = [2,0,2,1,1,0]

var low = 0
var mid = 0
var high = nums.count - 1

while mid <= high {

    if nums[mid] == 0 {

        nums.swapAt(mid, low)

        low += 1
        mid += 1

    } else if nums[mid] == 1 {

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

[0,0,1,1,2,2]

==================================================
DRY RUN
==================================================

Input:

[2,0,2,1,1,0]

low = 0
mid = 0
high = 5

--------------------------------------------------

nums[mid] = 2

swap(0,5)

[0,0,2,1,1,2]

high = 4

--------------------------------------------------

nums[mid] = 0

swap(0,0)

low = 1
mid = 1

--------------------------------------------------

nums[mid] = 0

swap(1,1)

low = 2
mid = 2

--------------------------------------------------

nums[mid] = 2

swap(2,4)

[0,0,1,1,2,2]

high = 3

mid stays

--------------------------------------------------

nums[mid] = 1

mid = 3

--------------------------------------------------

nums[mid] = 1

mid = 4

Stop:

mid > high

==================================================
COMPLEXITY
==================================================

TIME : O(n)

WHY?

Each element is processed
at most once.

No nested loops.

--------------------------------------------------

SPACE : O(1)

WHY?

Only:

low
mid
high

variables are used.

No extra array.

==================================================
MEMORY TRICK
==================================================

0 -> Left

1 -> Middle

2 -> Right

--------------------------------------------------

0 -> low

1 -> mid

2 -> high

==================================================
COMMON MISTAKES
==================================================

1. Using sort()

Wrong.

Need O(n).

--------------------------------------------------

2. Moving mid after
handling value 2.

Wrong.

New value arrived
from high side.

Need to inspect it.

--------------------------------------------------

3. Forgetting swap
for value 2.

Must move 2
to right partition.

==================================================
*/
