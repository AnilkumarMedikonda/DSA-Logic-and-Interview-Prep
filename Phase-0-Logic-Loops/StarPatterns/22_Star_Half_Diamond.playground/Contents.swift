/*
 Problem:
 Print a Half Diamond Star Pattern for n = 9

 *
 **
 ***
 ****
 *****
 ****
 ***
 **
 *

 Approach:
 - Use one loop to iterate through rows (1 to n)
 - Maintain a variable `stars` to track number of stars per row
 - Calculate midpoint: mid = (n / 2) + 1
 - If current row < mid → increase stars
 - Else → decrease stars
 - Use inner loop to print stars for each row

 Time Complexity:
 O(n^2) → Nested loops (rows × stars)

 Space Complexity:
 O(1) → No extra space used
*/


import UIKit

let totalRows = 9
var stars = 1
let mid = (totalRows / 2) + 1

for i in 1...totalRows {
    
    for _ in 1...stars {
        print("*", terminator: "")
    }
    
    print()
    
    if i < mid {
        stars += 1
    } else {
        stars -= 1
    }
}

