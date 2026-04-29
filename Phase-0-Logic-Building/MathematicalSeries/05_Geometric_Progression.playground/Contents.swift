import UIKit

// ==================================================
// Topic: Geometric Progression (GP)
// ==================================================

// Definition:
// A sequence where each term is multiplied by a constant ratio (r)

// Example:
// 2, 6, 18, 54, ...
// (Each term × 3)

// ==================================================
// Key Variables
// ==================================================

let a = 2   // First term
let r = 3   // Common ratio
let n = 5   // Number of terms

// ==================================================
// Logic (Loop Pattern)
// ==================================================

// Start with first term
var value = a

for _ in 1...n {
    print(value, terminator: " ")
    value *= r
}

// Output:
// 2 6 18 54 162

print("\n")

// ==================================================
// Notes
// ==================================================

// GP Pattern:
// a, a*r, a*r^2, a*r^3 ...

// Nth Term Formula:
// Tn = a * r^(n-1)

// ==================================================
// Edge Cases
// ==================================================

// r = 1   → same number repeated
// r = 0   → first term, then all 0
// r < 0   → signs alternate
// 0 < r < 1 → decreasing series

// ==================================================
// Complexity
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// ==================================================
// Interview Tips
// ==================================================

// AP = + d
// GP = * r

// Avoid hardcoding values
// Always use variables: a, r, n
