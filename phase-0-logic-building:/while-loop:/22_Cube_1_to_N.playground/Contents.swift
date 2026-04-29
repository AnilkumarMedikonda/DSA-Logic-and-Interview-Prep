import UIKit

// ==================================================
// Problem 1: Print cubes from 1 to n
// Example: n = 5 → 1 8 27 64 125
// ==================================================



// --------------------------------------------------
// Approach 1: While Loop (BEST for basics ✅)
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

var n = 10
var i = 1

while i <= n {
    print(i * i * i, terminator: " ")
    i += 1
}

print("\n----------------")



// --------------------------------------------------
// Approach 2: For Loop
// --------------------------------------------------

for i in 1...n {
    print(i * i * i, terminator: " ")
}

print("\n----------------")



// ==================================================
// Problem 2: Sum of cubes from 1 to n
// Example: 1³ + 2³ + ... + n³
// ==================================================



// --------------------------------------------------
// Approach 1: Loop
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

var sum = 0

for i in 1...n {
    sum += i * i * i
}

print("Sum of cubes:", sum)

print("\n----------------")



// --------------------------------------------------
// Approach 2: Formula (BEST 🔥)
// --------------------------------------------------

// Formula:
// (n(n + 1) / 2)²

// Time Complexity: O(1)
// Space Complexity: O(1)

let formulaSum = (n * (n + 1) / 2) * (n * (n + 1) / 2)

print("Formula Sum:", formulaSum)
