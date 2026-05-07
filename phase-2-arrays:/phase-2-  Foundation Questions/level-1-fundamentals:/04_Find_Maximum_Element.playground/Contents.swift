import UIKit
// MARK: - 04_Find_Maximum_Element

/*
 Approach:
 - Initialize max with Int.min
 - Traverse array once
 - Update max when larger element found

 Time: O(n)
 Space: O(1)
*/

var array = [8,3,5,1,9]

var max = Int.min

for number in array {
    if number > max {
        max = number
    }
}

print(max)
