import UIKit

var greeting = "Hello, playground"

 // Minimu
// MARK: - Find Minimum

/*
 Approach:
 - Initialize with a large value (Int.max)
 - Traverse array once
 - Update min when smaller element found

 Time: O(n)
 Space: O(1)
*/

var arr = [8, 3, 5, 1, 9]
var minValue = Int.max

for number in arr {
    if number < minValue {
        minValue = number
    }
}

print("Minimum:", minValue)
