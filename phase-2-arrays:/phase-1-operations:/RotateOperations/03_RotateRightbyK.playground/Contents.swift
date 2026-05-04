import UIKit

// MARK: - Rotate Right by k (Reversal Algorithm)

/*
 Problem:
 Rotate array to the RIGHT by k positions

 Input:
 [1,2,3,4,5], k = 2

 Output:
 [4,5,1,2,3]
 */

/*
 Approach:
 1) Reverse whole array
 2) Reverse first k elements
 3) Reverse remaining n-k elements

 Pattern:
 [A | B] → B A
 (A = first n-k, B = last k)
 */

/*
 Time Complexity:
 O(n)  → each element is visited/swapped once

 Space Complexity:
 O(1)  → in-place, no extra memory
 */

/*
 Edge Cases:
 k > n  → k = k % n
 k = 0  → no change
 n = 0  → return
 */

// MARK: - Helper Function

func reverse(_ l: Int, _ r: Int, _ arr: inout [Int]) {
    var left = l
    var right = r
    
    while left < right {
        arr.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// MARK: - Right Rotation Function

func rightRotate(_ arr: inout [Int], _ kInput: Int) {
    let n = arr.count
    if n == 0 { return }
    
    let k = kInput % n   // normalize
    
    reverse(0, n - 1, &arr)
    reverse(0, k - 1, &arr)
    reverse(k, n - 1, &arr)
}

// MARK: - Example

var arr = [1,2,3,4,5]
rightRotate(&arr, 2)

print(arr) // [4,5,1,2,3]
