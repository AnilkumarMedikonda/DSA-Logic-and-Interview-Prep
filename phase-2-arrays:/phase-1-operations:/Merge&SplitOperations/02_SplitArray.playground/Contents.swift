import UIKit
// MARK: - Split Array at Given Index

/*
 Approach:
 - Use index to divide array
 - Left  = elements from 0..<index
 - Right = elements from index..<n
 - Use loops (no built-in split)

 Time: O(n)
 Space: O(n)
*/

var arr2 = [1,2,3,4,5]
var idx = 2

if idx < 0 || idx > arr2.count {
    print("Invalid index")
} else {
    var l = [Int]()
    var r = [Int]()

    for i in 0..<idx {
        l.append(arr2[i])
    }

    for i in idx..<arr2.count {
        r.append(arr2[i])
    }

    print("Left:", l)
    print("Right:", r)
}
