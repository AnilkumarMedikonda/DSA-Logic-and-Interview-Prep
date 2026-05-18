//: 04_4Sum

import Foundation

/*
==================================================
PROBLEM
==================================================

Find all unique quadruplets
whose sum == target

nums   = [1,0,-1,0,-2,2]
target = 0

OUTPUT:
[
 [-2,-1,1,2],
 [-2,0,0,2],
 [-1,0,0,1]
]

==================================================
IMPORTANT
==================================================

1. Need ANY 4 elements
2. NOT subarray problem
3. Need UNIQUE quadruplets

==================================================
BRUTE FORCE
==================================================

IDEA:
Check every possible quadruplet

LOOPS:
4 nested loops

TIME  : O(n⁴)
SPACE : O(1)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [1,0,-1,0,-2,2]
var target = 0

var result = [[Int]]()

for i in 0..<nums.count {

    for j in (i + 1)..<nums.count {

        for k in (j + 1)..<nums.count {

            for l in (k + 1)..<nums.count {

                let sum =
                nums[i] +
                nums[j] +
                nums[k] +
                nums[l]

                if sum == target {

                    /*
                     Sort before duplicate check
                     */

                    let array = [
                        nums[i],
                        nums[j],
                        nums[k],
                        nums[l]
                    ].sorted()

                    if !result.contains(array) {

                        result.append(array)
                    }
                }
            }
        }
    }
}

print(result)


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MOST IMPORTANT IDEA:

4Sum =
2 Fixed Numbers
+
Two Pointer

==================================================
WHY SORT?
==================================================

Sorting helps:
1. Two Pointer movement
2. Duplicate handling

==================================================
POINTER LOGIC
==================================================

sum < target
=> need bigger sum
=> left++

sum > target
=> need smaller sum
=> right--

==================================================
TIME  : O(n³)
SPACE : O(1)

INTERVIEW:
Preferred optimized solution

==================================================
*/

nums.sort()

result = [[Int]]()

for i in 0..<nums.count {

    /*
     Skip duplicate first values
     */

    if i > 0 &&
        nums[i] == nums[i - 1] {

        continue
    }

    for j in (i + 1)..<nums.count {

        /*
         Skip duplicate second values
         */

        if j > i + 1 &&
            nums[j] == nums[j - 1] {

            continue
        }

        var left = j + 1
        var right = nums.count - 1

        while left < right {

            let sum =
            nums[i] +
            nums[j] +
            nums[left] +
            nums[right]

            if sum == target {

                let array = [
                    nums[i],
                    nums[j],
                    nums[left],
                    nums[right]
                ]

                result.append(array)

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

                left += 1
                right -= 1
            }

            else if sum < target {

                left += 1
            }

            else {

                right -= 1
            }
        }
    }
}

print(result)


/*
==================================================
INTERVIEW SUMMARY
==================================================

Brute Force
-> 4 loops
-> O(n⁴)

Optimized
-> sorting + Two Pointer
-> O(n³)

==================================================
MOST IMPORTANT LEARNING
==================================================

2Sum
-> Two Pointer

3Sum
-> Fixed + Two Pointer

4Sum
-> Two Fixed + Two Pointer

==================================================
COMMON MISTAKES
==================================================

1. Wrong left pointer setup

2. Forget sorting

3. Duplicate quadruplets

4. Wrong pointer movement

5. Forget duplicate skipping

==================================================
*/
