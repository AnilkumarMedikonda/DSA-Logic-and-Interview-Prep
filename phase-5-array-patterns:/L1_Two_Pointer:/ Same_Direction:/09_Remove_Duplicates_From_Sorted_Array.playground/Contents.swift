import Foundation

//: 09_Remove_Duplicates_From_Sorted_Array

/*
==================================================
PROBLEM
==================================================

Remove duplicates from sorted array
in-place.

Return count of unique elements.

==================================================
EXAMPLE
==================================================

Input:
[0,0,1,1,1,2,2,3,3,4]

Output:
5

Modified array:
[0,1,2,3,4]

==================================================
IMPORTANT
==================================================

Array already sorted.

Duplicates become adjacent.

==================================================
BRUTE FORCE
==================================================

IDEA:
Check duplicates manually
using nested loops.

Store unique values
in another array.

TIME  : O(n²)
SPACE : O(n)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [0,0,1,1,1,2,2,3,3,4]

var uniqueArray = [Int]()

for i in 0..<nums.count {

    var isContains = false

    for j in (i + 1)..<nums.count {

        if nums[j] == nums[i] {

            isContains = true
            break
        }
    }

    if !isContains {

        uniqueArray.append(nums[i])
    }
}

print(uniqueArray)


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
next unique value position

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

nums = [0,0,1,1,1,2,2,3,3,4]

var left = 1
var right = 1

while right < nums.count {

    /*
     New unique value found
     */

    if nums[right] != nums[right - 1] {

        nums[left] = nums[right]

        left += 1
    }

    /*
     Read pointer always moves
     */

    right += 1
}

/*
 Count of unique elements
 */

print(left)

/*
 Unique values
 */

for i in 0..<left {

    print(nums[i], terminator: " ")
}


/*
==================================================
DRY RUN
==================================================

Input:
[0,0,1,1,2]

left = 1
right = 1

right = 1
0 == 0
skip

right = 2
1 != 0

place 1 at left index

[0,1,1,1,2]

left = 2

==================================================
MOST IMPORTANT LEARNING
==================================================

Read pointer:
reads every element

Write pointer:
stores next unique value

==================================================
COMMON MISTAKES
==================================================

1. Moving left every iteration

Wrong:
left should move ONLY
when unique value found.

--------------------------------------------------

2. Copying wrong value

Correct:
nums[left] = nums[right]

--------------------------------------------------

3. Using opposite-end pointers

Wrong pattern.

Correct:
Same Direction Two Pointer.

==================================================
*/
