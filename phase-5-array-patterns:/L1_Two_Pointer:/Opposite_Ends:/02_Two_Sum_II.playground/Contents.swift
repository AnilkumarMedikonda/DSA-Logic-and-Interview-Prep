import Foundation

//: Playground - 02_Two_Sum_II

/*
============================================================
02_Two_Sum_II
============================================================

PROBLEM:
Given a sorted array and target,
return indices of two numbers
whose sum == target.

EXAMPLE:
nums = [1,2,3,4,6]
target = 8

OUTPUT:
[1,5]

WHY?
2 + 6 = 8

============================================================
PATTERN
============================================================

Two Pointer / Opposite Ends

WHY THIS PATTERN?
Array already sorted.

============================================================
BRUTE FORCE
============================================================

IDEA:
Check every possible pair.

TIME  : O(n²)
SPACE : O(1)

WHY NOT BEST?
Nested loops repeat work.

============================================================
OPTIMIZED IDEA
============================================================

left  -> start
right -> end

Find:
sum = nums[left] + nums[right]

------------------------------------------------------------
CASE 1
------------------------------------------------------------

sum == target

Answer found.

------------------------------------------------------------
CASE 2
------------------------------------------------------------

sum < target

Need bigger sum.

Move:
left += 1

WHY?
Array sorted.
Moving left forward increases value.

------------------------------------------------------------
CASE 3
------------------------------------------------------------

sum > target

Need smaller sum.

Move:
right -= 1

WHY?
Array sorted.
Moving right backward decreases value.

============================================================
OPTIMIZED COMPLEXITY
============================================================

TIME  : O(n)
SPACE : O(1)

WHY O(n)?
Each pointer moves at most once.

============================================================
COMMON MISTAKES
============================================================

1. Moving both pointers together

2. Forgetting array is sorted

3. Using nested loops in optimized

4. Wrong pointer movement

============================================================
PATTERN SIGNALS
============================================================

- sorted array
- pair sum
- target sum

=> Two Pointer / Opposite Ends

============================================================
*/


// MARK: - Input

var nums = [1,2,3,4,6]
var target = 8


// MARK: ====================================================
// MARK: - BRUTE FORCE
// MARK: ====================================================

/*
BRUTE FORCE:
Check every pair
*/

print("===== BRUTE FORCE =====")

for i in 0..<nums.count {

    for j in i + 1..<nums.count {

        print("""
        Checking:
        \(nums[i]) + \(nums[j])
        """)

        if nums[i] + nums[j] == target {

            print("Indices:", i, j)
            print("Values:", nums[i], nums[j])

            break
        }
    }
}


// MARK: ====================================================
// MARK: - OPTIMIZED TWO POINTER
// MARK: ====================================================

/*
OPTIMIZED:
Use sorted property
*/

print("\n===== OPTIMIZED =====")

var left = 0
var right = nums.count - 1

while left < right {

    let sum = nums[left] + nums[right]

    print("""
    Checking:
    \(nums[left]) + \(nums[right]) = \(sum)
    """)

    if sum == target {

        print("Indices:", left, right)
        print("Values:", nums[left], nums[right])

        break
    }

    else if sum < target {

        /*
         Need bigger sum
         Move left
         */

        left += 1
    }

    else {

        /*
         Need smaller sum
         Move right
         */

        right -= 1
    }
}


/*
============================================================
INTERVIEW SUMMARY
============================================================

BRUTE FORCE:
Check all pairs

OPTIMIZED:
Use sorted array + two pointers

============================================================
MOST IMPORTANT LEARNING
============================================================

Pointer movement depends on:
current sum

sum < target
=> move left

sum > target
=> move right

============================================================
WHY TWO POINTER WORKS?
============================================================

Because array sorted.

Sorted order allows:
- increasing sum
- decreasing sum

using pointer movement.

============================================================
INTERVIEW EXPECTATION
============================================================

Interviewers usually expect:
1. Brute force idea
2. Complexity discussion
3. Two pointer optimization
4. WHY pointer moves

============================================================
*/
