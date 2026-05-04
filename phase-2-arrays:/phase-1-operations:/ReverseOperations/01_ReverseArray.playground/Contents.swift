import UIKit

import Foundation

// MARK: - Reverse Array (Two Pointer Approach - Recommended)

/*
 🎯 Why Two Pointer Approach?

 - Very easy to explain
 - Readable logic (left ↔ right)
 - No complex index math
 - Less chance of bugs

 Common pattern used in:
 - Reverse string
 - Palindrome check
 - Two-pointer problems
*/

var array = [1, 2, 3, 4]

var left = 0
var right = array.count - 1

while left < right {
    array.swapAt(left, right)
    left += 1
    right -= 1
}

print("Reversed Array:", array)

// Time Complexity: O(n)
// Space Complexity: O(1)



// ==========================================
// 2. For-loop Approach (Index Based)
// ==========================================

var arr1 = [1, 2, 3, 4]

for i in 0..<arr1.count / 2 {
    let temp = arr1[i]
    arr1[i] = arr1[arr1.count - 1 - i]
    arr1[arr1.count - 1 - i] = temp
}

print("For-loop Reverse:", arr1)

// Time Complexity: O(n)
// Space Complexity: O(1)
