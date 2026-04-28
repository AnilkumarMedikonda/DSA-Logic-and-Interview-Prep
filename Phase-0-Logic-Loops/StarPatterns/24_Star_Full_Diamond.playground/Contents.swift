import UIKit

// 24_Star_Full_Diamond.
/*
 Problem:
 Centered Full Diamond Pattern

 Approach:
 - `stars` → controls number of stars (1,3,5,...)
 - `spaces` → controls leading spaces
 - Increase till mid, then decrease

 Time: O(n^2)
 Space: O(1)
*/

var spaces = 4
var stars = 1
let totalRows = 9
let mid = (totalRows / 2) + 1

for i in 1...totalRows {
    
    // safe: won't crash even if spaces = 0
    for _ in 0..<spaces {
        print(" ", terminator: "")
    }
    
    for _ in 0..<stars {
        print("*", terminator: "")
    }
    
    print()
    
    if i < mid {
        stars += 2
        spaces -= 1
    } else {
        stars -= 2
        spaces += 1
    }
}
