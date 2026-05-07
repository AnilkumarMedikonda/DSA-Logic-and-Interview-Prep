import UIKit

// MARK: - 07_Count_Even_Odd
/*
 Approach:
 - Traverse array once
 - Use modulo operator
 - Count even and odd numbers separately
 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5,6]

var evenCount = 0
var oddCount = 0

for number in array {
    
    if number % 2 == 0 {
        evenCount += 1
    } else {
        oddCount += 1
    }
}

print("Even:", evenCount)
print("Odd:", oddCount)
