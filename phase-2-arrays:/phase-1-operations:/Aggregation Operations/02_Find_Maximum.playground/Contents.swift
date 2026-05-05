import UIKit
// MARK: - 02_Find_Maximum

/*
 Approach:
 - Initialize max with first element (safe)
 - Traverse array once
 - Update max when larger element found

 Time: O(n)
 Space: O(1)
*/

var arr = [8, 3, 5, 1, 9]

if arr.isEmpty {
    print("array empty")
} else {
    var max = arr[0]

    for number in arr {
        if number > max {
            max = number
        }
    }

    print("Max:", max)
}
