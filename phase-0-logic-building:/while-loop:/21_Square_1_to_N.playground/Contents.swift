import UIKit


// ==================================================
// Problem 1: Print squares from 1 to n
// Example: n = 5 → 1 4 9 16 25
// ==================================================


// --------------------------------------------------
// Approach 1: While Loop (BEST for beginners ✅)
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

var n = 5
var i = 1

while i <= n {
    print(i * i, terminator: " ")
    i += 1
}

print("\n----------------")



// --------------------------------------------------
// Approach 2: For Loop
// --------------------------------------------------

for i in 1...n {
    print(i * i, terminator: " ")
}

print("\n----------------")



// ==================================================
// Problem 2: Sum of squares from 1 to n
// Example: 1² + 2² + 3² + ... + n²
// ==================================================


// --------------------------------------------------
// Approach 1: Loop (Basic)
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

var sum = 0

for i in 1...n {
    sum += i * i
}

print("Sum of squares:", sum)

print("\n----------------")



// --------------------------------------------------
// Approach 2: Formula (BEST 🔥)
// --------------------------------------------------

// Formula:
// n(n + 1)(2n + 1) / 6

// Time Complexity: O(1)
// Space Complexity: O(1)

let formulaSum = n * (n + 1) * (2 * n + 1) / 6

print("Formula Sum:", formulaSum)
