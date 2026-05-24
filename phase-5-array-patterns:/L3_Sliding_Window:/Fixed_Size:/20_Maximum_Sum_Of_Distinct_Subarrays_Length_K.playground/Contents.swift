import Foundation

//: 20_Maximum_Sum_Of_Distinct_Subarrays_Length_K
// Pattern: Fixed Size Sliding Window + HashMap

/*
 Problem:

 Given an integer array nums and an integer k,
 return the maximum sum of a subarray of length k
 where all elements are distinct.

 If no valid subarray exists return 0.

 Example:

 nums = [1,5,4,2,9,9,9]
 k = 3

 Output: 15
 */


// MARK: - Brute Force

func maximumSubarraySumBruteForce(_ nums: [Int], _ k: Int) -> Int {

    var maxSum = 0

    for i in 0...(nums.count - k) {

        var map = [Int: Int]()
        var sum = 0
        var isValid = true

        for j in i..<(i + k) {

            if let count = map[nums[j]] {
                map[nums[j]] = count + 1
                isValid = false
            } else {
                map[nums[j]] = 1
            }

            sum += nums[j]
        }

        if isValid {
            maxSum = max(maxSum, sum)
        }
    }

    return maxSum
}

/*
 Time  : O(n * k)
 Space : O(k)
 */


// MARK: - Optimized (Interview Preferred)

func maximumSubarraySum(_ nums: [Int], _ k: Int) -> Int {

    guard nums.count >= k else { return 0 }

    var map = [Int: Int]()
    var windowSum = 0
    var maxSum = 0

    // First Window
    for i in 0..<k {

        windowSum += nums[i]

        if let count = map[nums[i]] {
            map[nums[i]] = count + 1
        } else {
            map[nums[i]] = 1
        }
    }

    if map.count == k {
        maxSum = windowSum
    }

    // Slide Window
    for right in k..<nums.count {

        let outgoing = nums[right - k]
        let incoming = nums[right]

        // Remove outgoing
        windowSum -= outgoing

        if let count = map[outgoing] {

            map[outgoing] = count - 1

            if map[outgoing] == 0 {
                map.removeValue(forKey: outgoing)
            }
        }

        // Add incoming
        windowSum += incoming

        if let count = map[incoming] {
            map[incoming] = count + 1
        } else {
            map[incoming] = 1
        }

        // Valid Window
        if map.count == k {
            maxSum = max(maxSum, windowSum)
        }
    }

    return maxSum
}

/*
 Time  : O(n)
 Space : O(k)

 Maintain:
 1. windowSum
 2. frequencyMap

 Valid Window:
 map.count == k
 */


// MARK: - Test

let nums = [1,5,4,2,9,9,9]
let k = 3

print("Brute Force :", maximumSubarraySumBruteForce(nums, k))
print("Optimized   :", maximumSubarraySum(nums, k))


/*
==================================================
QUICK INTERVIEW NOTE
==================================================

Pattern:
Fixed Size Sliding Window + HashMap

Condition:
All elements in window must be distinct

--------------------------------------------------

Brute Force

Generate every window of size k

Use HashMap to detect duplicates

Calculate sum

Time  : O(n * k)
Space : O(k)

--------------------------------------------------

Optimized (Interview Preferred)

Build first window

Maintain:

windowSum
frequencyMap

Remove outgoing element

windowSum -= outgoing

Decrease frequency

Remove key if frequency becomes 0

--------------------------------------------------

Add incoming element

windowSum += incoming

Increase frequency

--------------------------------------------------

Valid Window

map.count == k

Reason:

Window Size = k
Unique Elements = k

=> All elements are distinct

--------------------------------------------------

Time  : O(n)
Space : O(k)

==================================================
RECOGNITION
==================================================

✓ Fixed window size k

✓ Distinct elements

✓ Maximum / Minimum / Sum

Think:

Sliding Window + HashMap

==================================================
INTERVIEW PREFERENCE
==================================================

Brute Force:

Easy to explain

O(n * k)

--------------------------------------------------

Optimized:

Sliding Window + HashMap

O(n)

✓ Expected Interview Solution
✓ Most Asked Approach

==================================================
*/
