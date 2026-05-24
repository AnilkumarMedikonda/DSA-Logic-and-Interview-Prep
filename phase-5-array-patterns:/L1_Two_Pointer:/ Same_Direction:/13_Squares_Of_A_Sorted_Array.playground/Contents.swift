import Foundation


//: 13_Squares_Of_A_Sorted_Array


/*
==================================================
PROBLEM
==================================================

Return squares of sorted array
also in sorted order.

==================================================
EXAMPLE
==================================================

Input:
[-4,-1,0,3,10]

Output:
[0,1,9,16,100]

==================================================
IMPORTANT
==================================================

Negative numbers become positive
after squaring.

Sorted order breaks after square.

==================================================
BRUTE FORCE
==================================================

IDEA:
1. Square every element
2. Sort again

TIME  : O(n log n)
SPACE : O(n)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [-4,-1,0,3,10]

for i in 0..<nums.count {

    let value = nums[i]

    nums[i] = value * value
}

print(nums.sorted())

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n log n)

WHY?

Squaring -> O(n)

Sorting  -> O(n log n)

Total:
O(n log n)

--------------------------------------------------

SPACE : O(n)

WHY?

Sorting usually uses
extra space internally.

==================================================
*/


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MOST IMPORTANT IDEA:

Largest square comes from:
largest absolute value.

Usually at:
array ends.

==================================================
LEFT POINTER
==================================================

Tracks:
start of array

==================================================
RIGHT POINTER
==================================================

Tracks:
end of array

==================================================
IMPORTANT
==================================================

Largest square belongs at:
end of result array.

==================================================
TIME  : O(n)
SPACE : O(n)

INTERVIEW:
Preferred solution

==================================================
*/

nums = [-4,-1,0,3,10]

var result = Array(
    repeating: 0,
    count: nums.count
)

var left = 0
var right = nums.count - 1

/*
 Fill result from end
 */

var index = nums.count - 1

while left <= right {

    let leftSquare =
    nums[left] * nums[left]

    let rightSquare =
    nums[right] * nums[right]

    /*
     Larger square goes at end
     */

    if leftSquare > rightSquare {

        result[index] = leftSquare

        left += 1

    } else {

        result[index] = rightSquare

        right -= 1
    }

    index -= 1
}

print(result)

/*
==================================================
COMPLEXITY
==================================================

TIME  : O(n)

WHY?

Each pointer moves
through array once.

--------------------------------------------------

SPACE : O(n)

WHY?

Extra result array used.

==================================================
*/


/*
==================================================
DRY RUN
==================================================

Input:
[-4,-1,0,3,10]

Squares:
16,1,0,9,100

Largest:
100

Place at:
result end

==================================================
MOST IMPORTANT LEARNING
==================================================

Largest absolute value
creates largest square.

Handle largest squares first.

==================================================
COMMON MISTAKES
==================================================

1. Sorting again unnecessarily

Brute force:
O(n log n)

Optimized:
O(n)

--------------------------------------------------

2. Filling result from front

Wrong.

Largest squares belong at end.

--------------------------------------------------

3. Forgetting negative values
can create larger squares.

==================================================
*/
