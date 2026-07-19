
import Foundation


//: 12_Move_Zeroes


/*
==================================================
PROBLEM
==================================================

Move all zeroes to end
while maintaining
non-zero element order.

Modify array in-place.

==================================================
EXAMPLE
==================================================

Input:
[0,1,0,3,12]

Output:
[1,3,12,0,0]

==================================================
IMPORTANT
==================================================

Need:
1. Move zeroes to end
2. Preserve non-zero order

==================================================
BRUTE FORCE
==================================================

IDEA:
1. Store all non-zero values
2. Append all zeroes later

TIME  : O(n)
SPACE : O(n)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [0,1,0,3,12]

var result = [Int]()

/*
 Store non-zero values
 */

for num in nums {

    if num != 0 {

        result.append(num)
    }
}

/*
 Store zeroes
 */

for num in nums {

    if num == 0 {

        result.append(num)
    }
}

//print(result)

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n)

WHY?
First loop  -> O(n)
Second loop -> O(n)

O(n) + O(n)
= O(n)

--------------------------------------------------

SPACE : O(n)

WHY?
Extra result array used.

==================================================
*/


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MOST IMPORTANT IDEA:

Move non-zero values forward.

Zeroes automatically move backward.

==================================================
LEFT POINTER
==================================================

Tracks:
next non-zero position

==================================================
RIGHT POINTER
==================================================

Reads:
every element

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

nums = [0,1,0,3,12]

var left = 0
var right = 0

while right < nums.count {

    /*
     Non-zero value found
     */

    if nums[right] != 0 {

        nums.swapAt(right, left)

        left += 1
    }

    /*
     Read pointer always moves
     */

    right += 1
    
    print(nums, left, right)

}

//print(nums)

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n)

WHY?
Right pointer traverses
entire array once.

--------------------------------------------------

SPACE : O(1)

WHY?
No extra array used.

Only variables used.

==================================================
*/


/*
==================================================
DRY RUN
==================================================

Input:
[0,1,0,3,12]

left = 0
right = 0

0 found
skip

--------------------------------

right = 1

1 found

swap(1,0)

[1,0,0,3,12]

left = 1

==================================================
MOST IMPORTANT LEARNING
==================================================

Read pointer:
reads every element

Write pointer:
tracks next non-zero position

==================================================
COMMON MISTAKES
==================================================

1. Moving zeroes forward

Wrong.

Need:
move non-zero values forward.

--------------------------------------------------

2. Forgetting order preservation

Need:
stable movement.

--------------------------------------------------

3. Using opposite-end pointers

Wrong pattern.

Correct:
Same Direction Two Pointer.

==================================================
*/
