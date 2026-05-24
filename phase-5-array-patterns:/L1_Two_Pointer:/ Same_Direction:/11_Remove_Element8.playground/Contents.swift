import Foundation

//: 11_Remove_Element

/*
==================================================
PROBLEM
==================================================

Remove all occurrences of given value
from array in-place.

Return count of remaining elements.

==================================================
EXAMPLE
==================================================

Input:
nums = [0,1,2,2,3,0,4,2]

val = 2

Output:
[0,1,3,0,4]

Count:
5

==================================================
IMPORTANT
==================================================

Need:
remove target value

Modify same array.

==================================================
BRUTE FORCE
==================================================

IDEA:
Store only valid values
inside another array.

TIME  : O(n)
SPACE : O(n)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [0,1,2,2,3,0,4,2]

var val = 2

var result = [Int]()

var count = 0

for i in 0..<nums.count {

    /*
     Keep valid values
     */

    if nums[i] != val {

        result.append(nums[i])

        count += 1
    }
}

print(count)

print(result)


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MOST IMPORTANT IDEA:

Read Pointer
+
Write Pointer

==================================================
LEFT POINTER
==================================================

Stores:
next valid position

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

nums = [0,1,2,2,3,0,4,2]

var left = 0
var right = 0

while right < nums.count {

    /*
     Valid value found
     */

    if nums[right] != val {

        nums[left] = nums[right]

        left += 1
    }

    /*
     Read pointer always moves
     */

    right += 1
}

/*
 Remaining element count
 */

print(left)

/*
 Valid values
 */

for i in 0..<left {

    print(nums[i], terminator: " ")
}


/*
==================================================
DRY RUN
==================================================

nums = [0,1,2,2,3]

val = 2

left = 0
right = 0

0 != 2

place 0

left = 1

--------------------------------

1 != 2

place 1

left = 2

--------------------------------

2 == 2

skip

==================================================
MOST IMPORTANT LEARNING
==================================================

Read pointer:
reads every element

Write pointer:
stores next valid position

==================================================
COMMON MISTAKES
==================================================

1. Using opposite-end pointers

Wrong pattern.

Correct:
Same Direction Two Pointer.

--------------------------------------------------

2. Moving left every iteration

Wrong.

Move only when valid value found.

--------------------------------------------------

3. Forgetting in-place modification

Need:
modify same array.

==================================================
*/
