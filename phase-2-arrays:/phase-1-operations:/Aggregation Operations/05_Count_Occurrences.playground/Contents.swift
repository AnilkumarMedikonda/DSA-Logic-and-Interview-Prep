import UIKit

// MARK: - 05_Count_Occurrences

/*
 Approach:
 - Traverse array
 - Compare each element with target
 - Increment count when matched

 Time: O(n)
 Space: O(1)
*/

var count = 0
let target = 2
var arr = [1,2,2,3,2,4]

for number in arr {
    if number == target {
        count += 1
    }
}

print("Count:", count)
