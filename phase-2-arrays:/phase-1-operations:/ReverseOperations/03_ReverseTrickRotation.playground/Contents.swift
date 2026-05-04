import UIKit
// MARK: - Reverse Trick (Array Rotation)

/*
 Problem:
 Rotate array to the RIGHT by k steps

 Example:
 Input  : [1, 2, 3, 4, 5, 6, 7], k = 3
 Output : [5, 6, 7, 1, 2, 3, 4]

 Approach (Reverse Trick):
 1. Reverse full array
 2. Reverse first k elements
 3. Reverse remaining elements

 Time Complexity  : O(n)
   - Reverse full array → O(n)
   - Reverse first k → O(k)
   - Reverse remaining → O(n-k)
   - Total → O(n)

 Space Complexity : O(1)
   - In-place, no extra array
*/

// MARK: - Helper: Reverse Function

func reverse(_ arr: inout [Int], _ start: Int, _ end: Int) {
    var left = start
    var right = end

    while left < right {
        arr.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// MARK: - Main: Rotate Right

func rotateRight(_ arr: inout [Int], _ k: Int) {
    let n = arr.count
    guard n > 0 else { return }

    let k = k % n

    // Step 1: Reverse full array
    reverse(&arr, 0, n - 1)

    // Step 2: Reverse first k elements
    reverse(&arr, 0, k - 1)

    // Step 3: Reverse remaining elements
    reverse(&arr, k, n - 1)
}

// MARK: - Test
var array = [1, 2, 3, 4, 5, 6, 7]
rotateRight(&array, 3)
print("Rotated Array:", array) // [5, 6, 7, 1, 2, 3, 4]
