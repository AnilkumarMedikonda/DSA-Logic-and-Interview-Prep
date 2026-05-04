import UIKit

import Foundation

// MARK: - Reverse Subarray (Two Pointer Approach)

/*
 Problem:
 Reverse elements from index i to j (inclusive) in-place

 Example:
 Input  : [1, 2, 3, 4, 5], i = 1, j = 3
 Output : [1, 4, 3, 2, 5]

 Approach:
 - Use two pointers (left = i, right = j)
 - Swap elements while moving inward

 Time Complexity  : O(n)   (technically O(n/2) → O(n))
 Space Complexity : O(1)   (in-place)
*/

func reverseSubarray(_ arr: inout [Int], _ i: Int, _ j: Int) {
    // Edge case handling
    if i < 0 || j >= arr.count || i >= j {
        return
    }

    var left = i
    var right = j

    while left < right {
        arr.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// MARK: - Test Cases

// 1. Normal Case
var t1 = [1, 2, 3, 4, 5]
reverseSubarray(&t1, 1, 3)
print("Test 1:", t1) // [1, 4, 3, 2, 5]

// 2. Full Array Reverse
var t2 = [5, 6, 7, 8, 9]
reverseSubarray(&t2, 0, 4)
print("Test 2:", t2) // [9, 8, 7, 6, 5]

// 3. Single Element Range
var t3 = [10, 20, 30]
reverseSubarray(&t3, 1, 1)
print("Test 3:", t3) // [10, 20, 30]

// 4. Two Elements Swap
var t4 = [1, 2, 3]
reverseSubarray(&t4, 0, 1)
print("Test 4:", t4) // [2, 1, 3]

// 5. Invalid Range (i > j)
var t5 = [1, 2, 3, 4]
reverseSubarray(&t5, 3, 1)
print("Test 5:", t5) // [1, 2, 3, 4]

// 6. Out of Bounds
var t6 = [1, 2, 3]
reverseSubarray(&t6, -1, 2)
print("Test 6:", t6) // [1, 2, 3]

// 7. Empty Array
var t7: [Int] = []
reverseSubarray(&t7, 0, 0)
print("Test 7:", t7) // []

// 8. Odd Length Middle Reverse
var t8 = [1, 2, 3, 4, 5]
reverseSubarray(&t8, 1, 3)
print("Test 8:", t8) // [1, 4, 3, 2, 5]

// 9. Even Length Full Reverse
var t9 = [1, 2, 3, 4]
reverseSubarray(&t9, 0, 3)
print("Test 9:", t9) // [4, 3, 2, 1]
