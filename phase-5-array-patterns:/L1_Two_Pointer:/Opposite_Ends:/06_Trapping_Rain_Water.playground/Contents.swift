import Foundation


//: 06_Trapping_Rain_Water

/*
==================================================
PROBLEM
==================================================

Given heights array,
calculate total trapped rain water.

==================================================
EXAMPLE
==================================================

Input:
[4,2,0,3,2,5]

Output:
9

==================================================
IMPORTANT UNDERSTANDING
==================================================

Water at current index depends on:

1. Left maximum wall
2. Right maximum wall

==================================================
MAIN FORMULA
==================================================

water =
min(leftMax, rightMax)
-
currentHeight

==================================================
WHY MINIMUM?
==================================================

Smaller wall limits water.

==================================================
BRUTE FORCE
==================================================

For every index:

1. Find left maximum
2. Find right maximum
3. Calculate trapped water

TIME  : O(n²)
SPACE : O(1)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var heights = [4,2,0,3,2,5]

var totalWater = 0

for i in 0..<heights.count {

    var leftMax = 0
    var rightMax = 0

    /*
     Find left maximum
     */

    for left in 0...i {

        leftMax =
        max(leftMax, heights[left])
    }

    /*
     Find right maximum
     */

    for right in i..<heights.count {

        rightMax =
        max(rightMax, heights[right])
    }

    /*
     Water at current index
     */

    let water =
    min(leftMax, rightMax)
    - heights[i]

    totalWater += water
}

print(totalWater)


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MOST IMPORTANT IDEA:

Smaller boundary decides water.

==================================================
WHY?
==================================================

If:

leftMax < rightMax

then:
left side water fully decided.

Else:
right side water fully decided.

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred optimized solution

==================================================
*/

totalWater = 0

var left = 0
var right = heights.count - 1

var leftMax = 0
var rightMax = 0

while left < right {

    /*
     Left boundary smaller
     */

    if heights[left] < heights[right] {

        /*
         Update left maximum
         */

        if heights[left] >= leftMax {

            leftMax = heights[left]
        }

        /*
         Water trapped on left
         */

        else {

            totalWater +=
            leftMax - heights[left]
        }

        left += 1
    }

    /*
     Right boundary smaller
     */

    else {

        /*
         Update right maximum
         */

        if heights[right] >= rightMax {

            rightMax = heights[right]
        }

        /*
         Water trapped on right
         */

        else {

            totalWater +=
            rightMax - heights[right]
        }

        right -= 1
    }
}

print(totalWater)


/*
==================================================
INTERVIEW SUMMARY
==================================================

Brute Force
-> Recalculate left/right max
-> O(n²)

Optimized
-> Maintain running max values
-> O(n)

==================================================
MOST IMPORTANT LEARNING
==================================================

Smaller boundary decides water.

==================================================
COMMON MISTAKES
==================================================

1. Forget subtract current height

Wrong:
min(leftMax, rightMax)

Correct:
min(leftMax, rightMax)
- currentHeight

--------------------------------------------------

2. Wrong pointer movement

3. Updating max incorrectly

4. Forget smaller boundary logic

==================================================
*/
