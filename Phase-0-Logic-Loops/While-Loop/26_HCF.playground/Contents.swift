import UIKit

import UIKit

// ==================================================
// Problem: Find HCF (GCD) of two numbers
// Example: a = 12, b = 18 → HCF = 6
// ==================================================



// --------------------------------------------------
// Approach 1: Brute Force
// --------------------------------------------------

// Approach:
// 1. Loop from 1 to min(a, b)
// 2. Check if both divisible
// 3. Track maximum common divisor

// Time Complexity: O(n)
// Space Complexity: O(1)

var a1 = 12
var b1 = 18

var hcf1 = 1
var i = 1

while i <= min(a1, b1) {
    if a1 % i == 0 && b1 % i == 0 {
        hcf1 = i
    }
    i += 1
}

print("HCF (Brute) ---> \(hcf1)")

print("----------------")



// --------------------------------------------------
// Approach 2: Euclidean Algorithm (BEST ✅)
// --------------------------------------------------

// Approach:
// gcd(a, b) = gcd(b, a % b)
// Repeat until b == 0

// Time Complexity: O(log n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Very fast
// - Reduces problem size quickly
// - Standard interview solution

var a2 = 12
var b2 = 18

while b2 != 0 {
    let temp = b2
    b2 = a2 % b2
    a2 = temp
}

print("HCF (Euclidean) ---> \(a2)")

print("----------------")



// --------------------------------------------------
// Approach 3: Recursive Euclidean (Optional)
// --------------------------------------------------

// Time Complexity: O(log n)
// Space Complexity: O(log n) (call stack)

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }
    return gcd(b, a % b)
}

print("HCF (Recursive) ---> \(gcd(12, 18))")
