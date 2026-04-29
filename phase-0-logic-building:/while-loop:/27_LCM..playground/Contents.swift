import UIKit



import UIKit

// ==================================================
// Problem: Find LCM (Least Common Multiple)
// Example: 12, 18 → LCM = 36
// ==================================================



// --------------------------------------------------
// Approach 1: Basic Loop (1 to n)
// --------------------------------------------------

// Approach:
// 1. Check numbers from 1 onwards
// 2. First number divisible by both → LCM

// Time Complexity: O(a * b)
// Space Complexity: O(1)

var a1 = 12
var b1 = 18

var i1 = 1

while true {
    if i1 % a1 == 0 && i1 % b1 == 0 {
        print("LCM (Basic) ---> \(i1)")
        break
    }
    i1 += 1
}

print("----------------")



// --------------------------------------------------
// Approach 2: Start from max(a, b)
// --------------------------------------------------

// Time Complexity: Better than above

var a2 = 12
var b2 = 18

var i2 = max(a2, b2)

while true {
    if i2 % a2 == 0 && i2 % b2 == 0 {
        print("LCM (Start from max) ---> \(i2)")
        break
    }
    i2 += 1
}

print("----------------")



// --------------------------------------------------
// Approach 3: Jump by max (Better Brute)
// --------------------------------------------------

// Approach:
// Instead of +1, jump by max(a, b)

// Time Complexity: Faster than brute

var a3 = 12
var b3 = 18

var step = max(a3, b3)
var i3 = step

while true {
    if i3 % a3 == 0 && i3 % b3 == 0 {
        print("LCM (Jump) ---> \(i3)")
        break
    }
    i3 += step
}

print("----------------")



// --------------------------------------------------
// Approach 4: Using HCF (BEST APPROACH ✅)
// --------------------------------------------------

// Formula:
// LCM = (a * b) / HCF

// Time Complexity: O(log n)
// Space Complexity: O(1)

// Step 1: Find HCF using Euclidean Algorithm

func hcf(_ a: Int, _ b: Int) -> Int {
    var x = a
    var y = b
    
    while y != 0 {
        let temp = y
        y = x % y
        x = temp
    }
    
    return x
}

// Step 2: Compute LCM

func lcm(_ a: Int, _ b: Int) -> Int {
    return (a * b) / hcf(a, b)
}

print("LCM (Best) ---> \(lcm(12, 18))")
