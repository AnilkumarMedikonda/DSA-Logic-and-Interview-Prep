
import Foundation

//: 04_3Sum


/*
============================================================
04_3Sum
============================================================

PROBLEM:
Find all unique triplets
whose sum == target

EXAMPLE:
nums   = [-1,0,1,2,-1,-4]
target = 0

OUTPUT:
[
 [-1,-1,2],
 [-1,0,1]
]

============================================================
MOST IMPORTANT IDEA
============================================================

3Sum =
Fixed Number
+
Two Sum

============================================================
*/


// MARK: ====================================================
// MARK: - INPUT
// MARK: ====================================================

var nums = [-1,0,1,2,-1,-4]
var target = 0


// MARK: ====================================================
// MARK: - BRUTE FORCE
// MARK: ====================================================

/*
BRUTE FORCE IDEA

Check every possible triplet.

Need:
3 nested loops

TIME  : O(n³)
SPACE : O(1)

WHY O(n³)?
Checking all triplets.
*/

print("===== BRUTE FORCE =====")

var bruteForceResults = [[Int]]()

for i in 0..<nums.count {

    for j in (i + 1)..<nums.count {

        for k in (j + 1)..<nums.count {

            let sum =
            nums[i] +
            nums[j] +
            nums[k]

            print("""
            Checking:
            \(nums[i]), \(nums[j]), \(nums[k])
            Sum = \(sum)
            """)

            if sum == target {

                let triplet = [
                    nums[i],
                    nums[j],
                    nums[k]
                ].sorted()

                /*
                 Avoid duplicate triplets
                 */

                if !bruteForceResults.contains(triplet) {

                    bruteForceResults.append(triplet)
                }
            }
        }
    }
}

print("\nBrute Force Results:")
print(bruteForceResults)


// MARK: ====================================================
// MARK: - OPTIMIZED SOLUTION
// MARK: ====================================================

/*
OPTIMIZED IDEA

3Sum =
Fixed Number
+
Two Sum

Use:
1. Sorting
2. Two Pointer

TIME  : O(n²)
SPACE : O(1)

WHY O(n²)?

Outer loop:
O(n)

Two Pointer:
O(n)

Total:
O(n²)

============================================================
WHY SORT?
============================================================

Sorting helps:
- Two Pointer movement
- duplicate handling

============================================================
POINTER LOGIC
============================================================

sum < remainingTarget
=> need bigger sum
=> move left

sum > remainingTarget
=> need smaller sum
=> move right

============================================================
*/

print("\n===== OPTIMIZED =====")

nums.sort()

print("Sorted:", nums)

var optimizedResults = [[Int]]()

for i in 0..<nums.count {

    /*
     Early stopping
     */

    if nums[i] > target &&
        target >= 0 {

        break
    }

    /*
     Skip duplicate fixed numbers
     */

    if i > 0 &&
        nums[i] == nums[i - 1] {

        continue
    }

    /*
     Remaining target
     */

    let remainingTarget =
    target - nums[i]

    /*
     Two Pointer
     */

    var left = i + 1
    var right = nums.count - 1

    while left < right {

        let sum =
        nums[left] +
        nums[right]

        print("""
        Checking:
        \(nums[i]), \(nums[left]), \(nums[right])
        Sum = \(nums[i] + sum)
        """)

        /*
         Valid triplet
         */

        if sum == remainingTarget {

            let triplet = [
                nums[i],
                nums[left],
                nums[right]
            ]

            optimizedResults.append(triplet)

            /*
             Skip duplicate left values
             */

            while left < right &&
                    nums[left] == nums[left + 1] {

                left += 1
            }

            /*
             Skip duplicate right values
             */

            while left < right &&
                    nums[right] == nums[right - 1] {

                right -= 1
            }

            /*
             Move both pointers
             */

            left += 1
            right -= 1
        }

        /*
         Need bigger sum
         */

        else if sum < remainingTarget {

            left += 1
        }

        /*
         Need smaller sum
         */

        else {

            right -= 1
        }
    }
}

print("\nOptimized Results:")
print(optimizedResults)


/*
============================================================
DUPLICATE HANDLING
============================================================

1. Skip duplicate fixed numbers

2. Skip duplicate left values

3. Skip duplicate right values

WHY?
Need unique triplets only.

============================================================
COMMON MISTAKES
============================================================

1. Forget sorting

2. Wrong pointer movement

3. Forget duplicate skipping

4. Treating as subarray problem

============================================================
INTERVIEW SUMMARY
============================================================

BRUTE FORCE:
3 nested loops

OPTIMIZED:
sorting + two pointer

MOST IMPORTANT LEARNING:
3Sum = Fixed Number + Two Sum

============================================================
*/
