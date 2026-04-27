import UIKit

// ==================================================
// Problem: Print first N Fibonacci numbers
// Example: n = 10
// Output: 0 1 1 2 3 5 8 13 21 34
// ==================================================



// --------------------------------------------------
// Approach 1: While Loop (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Initialize first two numbers (a = 0, b = 1)
// 2. Print current value (a)
// 3. Calculate next = a + b
// 4. Update a = b, b = next
// 5. Repeat for n times

// Time Complexity: O(n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - No extra space
// - Simple and efficient
// - No recursion overhead

var n = 10

var a = 0
var b = 1
var i = 1

while i <= n {
    print(a, terminator: " ")
    
    let next = a + b
    a = b
    b = next
    
    i += 1
}

print("\n----------------")



// --------------------------------------------------
// Approach 2: For Loop
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

let count = 10

var x = 0
var y = 1

for _ in 1...count {
    print(x, terminator: " ")
    
    let next = x + y
    x = y
    y = next
}

print("\n----------------")



// --------------------------------------------------
// Approach 3: Recursion (NOT BEST ❌)
// --------------------------------------------------

// Time Complexity: O(2^n)
// Space Complexity: O(n)

// ❌ Not best: very slow for large n

func fib(_ n: Int) -> Int {
    if n <= 1 { return n }
    return fib(n - 1) + fib(n - 2)
}

// Example:
for i in 0..<10 {
    print(fib(i), terminator: " ")
}
