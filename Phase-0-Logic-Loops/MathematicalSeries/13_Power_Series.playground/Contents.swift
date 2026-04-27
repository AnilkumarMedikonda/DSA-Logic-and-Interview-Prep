import UIKit
// ==================================================
// Problem: Power Series
// ==================================================

let x = 2
let n = 3

var value = 1
var sum = 0

for _ in 0...n {
    
    print(value, terminator: " ")
    sum += value
    
    value *= x
}

print("\nSum = \(sum)")
