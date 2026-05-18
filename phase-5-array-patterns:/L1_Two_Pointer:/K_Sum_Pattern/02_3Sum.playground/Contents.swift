//: 03_3Sum

import Foundation

/*
==================================================
PROBLEM
==================================================

Find all unique triplets
whose sum == target

nums   = [-1,0,1,2,-1,-4]
target = 0

OUTPUT:
[
 [-1,-1,2],
 [-1,0,1]
]

==================================================
IMPORTANT
==================================================

1. Need ANY 3 elements
2. NOT subarray problem
3. Need UNIQUE triplets

==================================================
BRUTE FORCE
==================================================

IDEA:
Check every possible triplet

LOOPS:
3 nested loops

TIME  : O(n³)
SPACE : O(1)

INTERVIEW:
Good starting approach
Not optimized

==================================================
*/

var nums = [-1,0,1,2,-1,-4]
var target = 0

var results = [[Int]]()

for i in 0..<nums.count {

    for j in (i + 1)..<nums.count {

        for k in (j + 1)..<nums.count {

            let sum =
            nums[i] +
            nums[j] +
            nums[k]

            if sum == target {

                /*
                 Sort before checking
                 duplicate
                 */

                let array = [
                    nums[i],
                    nums[j],
                    nums[k]
                ].sorted()

                if !results.contains(array) {

                    results.append(array)
                }
            }
        }
    }
}

print(results)


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MOST IMPORTANT IDEA:

3Sum =
Fixed Number
+
Two Sum

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
TIME  : O(n²)
SPACE : O(1)

INTERVIEW:
Preferred optimized solution

==================================================
*/

results = [[Int]]()

nums.sort()

for i in 0..<nums.count {

    /*
     Skip duplicate fixed values
     */

    if i > 0 &&
        nums[i] == nums[i - 1] {

        continue
    }

    var left = i + 1
    var right = nums.count - 1

    while left < right {

        let sum =
        nums[i] +
        nums[left] +
        nums[right]

        if sum == target {

            let array = [
                nums[i],
                nums[left],
                nums[right]
            ]

            results.append(array)

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

print(results)


/*
==================================================
INTERVIEW SUMMARY
==================================================

Brute Force
-> 3 loops
-> O(n³)

Optimized
-> sorting + Two Pointer
-> O(n²)

==================================================
MOST IMPORTANT LEARNING
==================================================

3Sum =
Fixed Number
+
Two Pointer

==================================================
COMMON MISTAKES
==================================================

1. Forget sorting

2. Wrong pointer movement

3. Duplicate triplets

4. Forget duplicate skipping

==================================================
*/
