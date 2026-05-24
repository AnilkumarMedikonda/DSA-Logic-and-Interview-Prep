import Foundation

//: 19_Maximum_Average_Subarray_I
// Pattern: Fixed Size Sliding Window

/*
 Problem:
 Find the maximum average of any contiguous
 subarray of length k.

 nums = [1,12,-5,-6,50,3]
 k = 4

 Output: 12.75
*/


// MARK: - Brute Force

func findMaxAverageBruteForce(_ nums: [Int], _ k: Int) -> Double {

    var maxAverage = -Double.infinity

    for i in 0...(nums.count - k) {

        var sum = 0

        for j in i..<(i + k) {
            sum += nums[j]
        }

        let average = Double(sum) / Double(k)

        maxAverage = max(maxAverage, average)
    }

    return maxAverage
}

/*
 Time  : O(n * k)
 Space : O(1)
 */


// MARK: - Optimized

func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {

    var windowSum = 0

    for i in 0..<k {
        windowSum += nums[i]
    }

    var maxSum = windowSum

    for right in k..<nums.count {

        windowSum += nums[right]
        windowSum -= nums[right - k]

        maxSum = max(maxSum, windowSum)
    }

    return Double(maxSum) / Double(k)
}

/*
 Time  : O(n)
 Space : O(1)

 Fixed Window:
 + Incoming
 - Outgoing
 */


// MARK: - Test

let nums = [1,12,-5,-6,50,3]
let k = 4

print(findMaxAverageBruteForce(nums, k))
print(findMaxAverage(nums, k))


/*
==================================================
QUICK INTERVIEW NOTE
==================================================

Pattern:
Fixed Size Sliding Window

Brute Force:
Generate every window of size k.

Time  : O(n * k)
Space : O(1)

--------------------------------------------------

Optimized:
Build first window sum.

Slide Window:

+ nums[right]
- nums[right - k]

Update maxSum.

Time  : O(n)
Space : O(1)

--------------------------------------------------

Recognition:

✓ Subarray of size K
✓ Maximum Sum of size K
✓ Average of size K
✓ Fixed Length Window

Think:

Fixed Size Sliding Window

==================================================
*/
