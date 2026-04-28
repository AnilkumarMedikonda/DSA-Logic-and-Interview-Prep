import UIKit
/*
 Problem:
 Half Diamond Pattern with flat top (rows 5 & 6 same)

 Approach:
 - totalRows = 10 → split into 2 halves
 - First half (1...5) → increase
 - Second half (6...10) → decrease
 - Do NOT increase at row 5 → keeps 5 & 6 same

 Time: O(n^2)
 Space: O(1)
*/

import UIKit

var n = 1
let totalRows = 10
let mid = totalRows / 2   // 5

for i in 1...totalRows {
    
    for _ in 1...n {
        print("*", terminator: "")
    }
    
    print()
    
    if i < mid {
        n += 1
    } else if i > mid {
        n -= 1
    }
    // when i == mid → do nothing (keeps same value)
}
