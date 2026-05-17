import Foundation

//: - 05_4Sum

/*
============================================================
05_4Sum
============================================================

PROBLEM:
Find all unique quadruplets
whose sum == target

EXAMPLE:
nums   = [1,0,-1,0,-2,2]
target = 0

OUTPUT:
[
 [-2,-1,1,2],
 [-2,0,0,2],
 [-1,0,0,1]
]

============================================================
MOST IMPORTANT IDEA
============================================================

4Sum =
2 Fixed Numbers
+
Two Pointer

============================================================
*/


// MARK: ====================================================
// MARK: - INPUT
// MARK: ====================================================

var nums = [1,0,-1,0,-2,2]
var target = 0


// MARK: ====================================================
// MARK: - BRUTE FORCE
// MARK: ====================================================

/*
BRUTE FORCE IDEA

Check every possible quadruplet.

Need:
4 nested loops

Choose:
1st number
2nd number
3rd number
4th number

Check:
sum == target

TIME  : O(n⁴)
SPACE : O(1)

WHY O(n⁴)?
Checking all quadruplets.

============================================================
*/

print("===== BRUTE FORCE =====")

var bruteForceResults = [[Int]]()

for i in 0..<nums.count {

    for j in (i + 1)..<nums.count {

        for k in (j + 1)..<nums.count {

            for l in (k + 1)..<nums.count {

                let sum =
                nums[i] +
                nums[j] +
                nums[k] +
                nums[l]

                print("""
                Checking:
                \(nums[i]),
                \(nums[j]),
                \(nums[k]),
                \(nums[l])

                Sum = \(sum)
                """)

                if sum == target {

                    let quadruplet = [
                        nums[i],
                        nums[j],
                        nums[k],
                        nums[l]
                    ].sorted()

                    /*
                     Avoid duplicate quadruplets
                     */

                    if !bruteForceResults.contains(quadruplet) {

                        bruteForceResults.append(quadruplet)
                    }
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

4Sum =
2 Fixed Numbers
+
Two Pointer

Use:
1. Sorting
2. Two Pointer

TIME  : O(n³)
SPACE : O(1)

WHY O(n³)?

First loop  -> O(n)
Second loop -> O(n)
Two Pointer -> O(n)

Total:
O(n³)

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
     Skip duplicate first numbers
     */

    if i > 0 &&
        nums[i] == nums[i - 1] {

        continue
    }

    for j in (i + 1)..<nums.count {

        /*
         Skip duplicate second numbers
         */

        if j > i + 1 &&
            nums[j] == nums[j - 1] {

            continue
        }

        /*
         Remaining target
         */

        let remainingTarget =
        target - nums[i] - nums[j]

        /*
         Two Pointer
         */

        var left = j + 1
        var right = nums.count - 1

        while left < right {

            let sum =
            nums[left] + nums[right]

            print("""
            Checking:
            \(nums[i]),
            \(nums[j]),
            \(nums[left]),
            \(nums[right])

            Sum = \(nums[i] + nums[j] + sum)
            """)

            /*
             Valid quadruplet
             */

            if sum == remainingTarget {

                optimizedResults.append([
                    nums[i],
                    nums[j],
                    nums[left],
                    nums[right]
                ])

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
}

print("\nOptimized Results:")
print(optimizedResults)


/*
============================================================
DUPLICATE HANDLING
============================================================

1. Skip duplicate first numbers

2. Skip duplicate second numbers

3. Skip duplicate left values

4. Skip duplicate right values

WHY?
Need unique quadruplets only.

============================================================
COMMON MISTAKES
============================================================

1. Forget sorting

2. Wrong pointer movement

3. Forget duplicate skipping

4. Infinite loop after valid result

============================================================
INTERVIEW SUMMARY
============================================================

2Sum
-> Two Pointer

3Sum
-> Fixed + Two Pointer

4Sum
-> Two Fixed + Two Pointer

============================================================
*/
