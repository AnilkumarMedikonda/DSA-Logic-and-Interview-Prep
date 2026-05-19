//: 14_Find_The_Duplicate_Number
import Foundation

/*
==================================================
PROBLEM
==================================================

Given array containing:

n + 1 integers

Numbers range:
1 to n

Only one duplicate exists.

Need:
find duplicate number.

==================================================
EXAMPLE
==================================================

Input:
[1,3,4,2,2]

Output:
2

==================================================
IMPORTANT
==================================================

Interview constraints:

1. Do not modify array
2. Use constant extra space

==================================================
BRUTE FORCE
==================================================

IDEA:
Check every pair
using nested loops.

TIME  : O(n²)
SPACE : O(1)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [1,3,4,2,2]

for i in 0..<nums.count {

    var isDuplicate = false

    for j in i + 1..<nums.count {

        if nums[i] == nums[j] {

            isDuplicate = true

            break
        }
    }

    if isDuplicate {

        print("Duplicate:", nums[i])

        break
    }
}

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n²)

WHY?

Nested loops compare
every pair.

--------------------------------------------------

SPACE : O(1)

WHY?

No extra data structure used.

==================================================
*/


/*
==================================================
BETTER SOLUTION - SORTING
==================================================

IDEA:
1. Sort array
2. Duplicate values become adjacent
3. Compare neighbors

TIME  : O(n log n)
SPACE : O(1)

INTERVIEW:
Better than brute force

==================================================
*/

nums = [1,3,4,2,2]

nums.sort()

for i in 0..<nums.count - 1 {

    if nums[i] == nums[i + 1] {

        print("Duplicate:", nums[i])

        break
    }
}

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n log n)

WHY?

Sorting dominates complexity.

--------------------------------------------------

SPACE : O(1)

WHY?

No extra array used.

==================================================
*/


/*
==================================================
HASHSET SOLUTION
==================================================

MOST IMPORTANT IDEA:

If value already exists
inside set:

duplicate found.

TIME  : O(n)
SPACE : O(n)

INTERVIEW:
Good intermediate solution

==================================================
*/

nums = [1,3,4,2,2]

var set = Set<Int>()

for num in nums {

    /*
     Duplicate found
     */

    if set.contains(num) {

        print("Duplicate:", num)

        break
    }

    /*
     Store value
     */

    set.insert(num)
}

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n)

WHY?

Single traversal.

HashSet lookup:
O(1)

--------------------------------------------------

SPACE : O(n)

WHY?

Extra set used.

==================================================
*/


/*
==================================================
OPTIMIZED - FLOYD CYCLE DETECTION
==================================================

MOST IMPORTANT IDEA:

Treat array like linked list.

Each value points to:
next index.

Duplicate creates cycle.

==================================================
SLOW POINTER
==================================================

Moves:
1 step

==================================================
FAST POINTER
==================================================

Moves:
2 steps

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

nums = [1,3,4,2,2]

/*
==================================================
PHASE 1
Find meeting point
==================================================
*/

var slow = nums[0]
var fast = nums[0]

repeat {

    /*
     Slow moves 1 step
     */

    slow = nums[slow]

    /*
     Fast moves 2 steps
     */

    fast = nums[nums[fast]]

} while slow != fast

/*
==================================================
PHASE 2
Find duplicate number
==================================================
*/

slow = nums[0]

while slow != fast {

    slow = nums[slow]

    fast = nums[fast]
}

print("Duplicate:", slow)

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n)

WHY?

Pointers traverse array
at most few times.

--------------------------------------------------

SPACE : O(1)

WHY?

Only variables used.

No extra array/set/map.

==================================================
DRY RUN
==================================================

nums = [1,3,4,2,2]

0 -> 1
1 -> 3
3 -> 2
2 -> 4
4 -> 2

Cycle formed at:
2

Duplicate:
2

==================================================
MOST IMPORTANT LEARNING
==================================================

Array can behave like:
linked list.

Duplicate creates:
cycle.

==================================================
COMMON MISTAKES
==================================================

1. Using opposite-end pointers

Wrong pattern.

--------------------------------------------------

2. Forgetting fast moves
2 steps.

--------------------------------------------------

3. Resetting wrong pointer
in phase 2.

Correct:
slow = nums[0]

--------------------------------------------------

4. Thinking this is normal
duplicate checking.

Actually:
cycle detection problem.

==================================================
*/
