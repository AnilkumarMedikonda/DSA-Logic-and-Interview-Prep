//: 10_Remove_Duplicates_From_Sorted_Array_II

import Foundation

/*
==================================================
PROBLEM
==================================================

Remove duplicates from sorted array.

Each element can appear:
AT MOST 2 times.

Modify array in-place.

Return count of valid elements.

==================================================
EXAMPLE
==================================================

Input:
[0,0,1,1,1,1,2,3,3]

Output:
[0,0,1,1,2,3,3]

==================================================
IMPORTANT
==================================================

Previous problem:
allow only 1 occurrence

Current problem:
allow maximum 2 occurrences

==================================================
BRUTE FORCE
==================================================

IDEA:
Count occurrences manually.

Store only first 2 occurrences
inside another array.

TIME  : O(n²)
SPACE : O(n)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [0,0,1,1,1,1,2,3,3]

var result = [Int]()

for i in 0..<nums.count {

    var count = 0

    /*
     Count occurrences
     */

    for j in 0...i {

        if nums[i] == nums[j] {

            count += 1
        }
    }

    /*
     Allow at most 2 occurrences
     */

    if count <= 2 {

        result.append(nums[i])
    }
}

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
HUGE INSIGHT
==================================================

Compare current value with:

nums[left - 2]

WHY?

Because:
maximum 2 duplicates allowed.

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

nums = [0,0,1,1,1,1,2,3,3]

/*
 First 2 elements always valid
 */

var left = 2
var right = 2

while right < nums.count {

    /*
     Valid occurrence found
     */

    if nums[right] != nums[left - 2] {

        nums[left] = nums[right]

        left += 1
    }

    /*
     Read pointer always moves
     */

    right += 1
}

/*
 Count of valid elements
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

Input:
[1,1,1,2]

left = 2
right = 2

nums[right] = 1
nums[left - 2] = 1

same
skip

right++

nums[right] = 2
nums[left - 2] = 1

different
place 2

==================================================
INTERVIEW SUMMARY
==================================================

Previous problem:
compare with left - 1

Current problem:
compare with left - 2

because:
2 duplicates allowed.

==================================================
MOST IMPORTANT LEARNING
==================================================

Controlled duplicate allowance.

Advanced Same Direction
Two Pointer pattern.

==================================================
COMMON MISTAKES
==================================================

1. Using left - 1

Wrong for this problem.

Need:
left - 2

--------------------------------------------------

2. Moving left every iteration

Wrong.

Move only when valid value found.

--------------------------------------------------

3. Forgetting first 2 elements
always valid.

==================================================
*/

