import UIKit


// Problem: Factorial of a number (1 to n)

// --------------------------------------------------
// Approach 1 (While Loop)
// --------------------------------------------------

// Approach:
// 1. Initialize i = 1 and result = 1
// 2. Run loop while i <= n
// 3. Multiply result with i (result *= i)
// 4. Increment i
// 5. Final result is factorial

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 5

var i = 1
var result = 1

while i <= n {
    result *= i
    i += 1
}

print("While Result is \(result)")


print("----------------")


// --------------------------------------------------
// Approach 2 (For Loop - Cleaner)
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

var result2 = 1

for i in 1...n {
    result2 *= i
}

print("For Result is \(result2)")
