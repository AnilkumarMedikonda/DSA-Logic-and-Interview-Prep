
/*
 Problem 25:
 Palindrome Number Pyramid (Array Approach)

 Output:
     5
    545
   54345
  5432345
 543212345

 Approach:
 - Outer loop → rows
 - Print spaces for alignment
 - Build a row array:
    • First decreasing numbers
    • Then increasing numbers (skip middle duplicate)
 - Print the row

 Time Complexity: O(n^2)
 Space Complexity: O(n)
*/

import UIKit

let totalRows = 5

for i in 1...totalRows {
    
    // spaces
    for _ in 0..<(totalRows - i) {
        print(" ", terminator: "")
    }
    
    var row: [Int] = []
    
    // decreasing part
    var num = 5
    for _ in 0..<i {
        row.append(num)
        num -= 1
    }
    
    // adjust (skip middle duplicate)
    num += 2
    
    // increasing part (safe)
    for _ in 0..<(i - 1) {
        row.append(num)
        num += 1
    }
    
    // print row
    for value in row {
        print(value, terminator: "")
    }
    
    print()
}
