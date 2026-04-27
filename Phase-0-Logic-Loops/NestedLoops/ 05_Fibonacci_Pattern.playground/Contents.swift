import UIKit

// ==================================================
// Problem: Print Fibonacci pattern row by row
// ==================================================

var a = 0
var b = 1

for i in 1...4 {              // number of rows
    
    for _ in 1...i {          // numbers per row
        
        print(a, terminator: " ")
        
        let next = a + b
        a = b
        b = next
    }
    
    print()   // next row
}
