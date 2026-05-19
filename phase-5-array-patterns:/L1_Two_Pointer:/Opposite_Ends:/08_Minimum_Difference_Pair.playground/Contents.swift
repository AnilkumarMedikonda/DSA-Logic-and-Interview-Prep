import Foundation

//: 08_Minimum_Difference_Pair
/*
==================================================
PROBLEM
==================================================

Find pair with minimum
absolute difference.

==================================================
EXAMPLE
==================================================

Input:
[10,3,20,8]

Output:
[8,10]

Difference:
2

==================================================
IMPORTANT
==================================================

Need:
smallest absolute difference
between 2 numbers.

==================================================
BRUTE FORCE
==================================================

IDEA:
Check every possible pair.

TIME  : O(n²)
SPACE : O(1)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [10,3,20,8]

var minDiff = Int.max

var numberOne = 0
var numberTwo = 0

for i in 0..<nums.count {

    for j in (i + 1)..<nums.count {

        let diff =
        abs(nums[i] - nums[j])

        if diff < minDiff {

            minDiff = diff

            numberOne = nums[i]
            numberTwo = nums[j]
        }
    }
}

print(numberOne, numberTwo)


/*
==================================================
OPTIMIZED
==================================================

MOST IMPORTANT IDEA:

After sorting:
closest numbers become neighbors.

Need only compare:
adjacent elements.

==================================================
WHY?
==================================================

Far elements usually create
larger differences.

Minimum difference most likely
between neighboring elements.

==================================================
TIME  : O(n log n)
SPACE : O(1)

==================================================
*/

nums = [10,3,20,8]

nums.sort()

print(nums)

minDiff = Int.max

numberOne = 0
numberTwo = 0

for i in 0..<nums.count - 1 {

    let difference =
    abs(nums[i] - nums[i + 1])

    if difference < minDiff {

        minDiff = difference

        numberOne = nums[i]
        numberTwo = nums[i + 1]
    }
}

print(numberOne, numberTwo)


/*
==================================================
INTERVIEW SUMMARY
==================================================

Brute Force
-> check every pair
-> O(n²)

Optimized
-> sorting + adjacent comparison
-> O(n log n)

==================================================
MOST IMPORTANT LEARNING
==================================================

Sorting reduces search space.

After sorting:
closest numbers become adjacent.

==================================================
COMMON MISTAKES
==================================================

1. Forget abs()

Wrong:
nums[i] - nums[j]

Correct:
abs(nums[i] - nums[j])

--------------------------------------------------

2. Using opposite-end pointers

Wrong optimization.

Correct:
adjacent comparison after sorting.

==================================================
*/
