import UIKit
// ==================================================
// Problem: Check if a number is Armstrong
// Example: 153 → Armstrong
//          123 → Not Armstrong
// ==================================================



// --------------------------------------------------
// Approach 1: Modulo + pow (BEST APPROACH ✅)
// --------------------------------------------------

import Foundation

// Power function (avoids pow())
func power(_ base: Int, _ exp: Int) -> Int {
    var result = 1
    for _ in 0..<exp {
        result *= base
    }
    return result
}

// --------------------------------------------------
// Approach 1: Modulo + Custom Power (BEST ✅)
// --------------------------------------------------

var number = 9474
let original = number

var temp = number
var digits = 0

// Count digits
while temp > 0 {
    digits += 1
    temp /= 10
}

var sum = 0

while number > 0 {
    let digit = number % 10
    sum += power(digit, digits)
    number /= 10
}

print(sum == original ? "Armstrong" : "Not Armstrong")

print("----------------")

// --------------------------------------------------
// Approach 2: String + pow()
// --------------------------------------------------

let num = 9474
let digitCount = String(num).count

var sum2 = 0

for char in String(num) {
    if let digit = Int(String(char)) {
        sum2 += Int(pow(Double(digit), Double(digitCount)))
    }
}

print(sum2 == num ? "Armstrong (String)" : "Not Armstrong")
