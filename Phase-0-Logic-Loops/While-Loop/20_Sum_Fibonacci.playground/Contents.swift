import UIKit

// ==================================================
// Problem: Print Fibonacci Series and find its sum
// Example: n = 10
// Output: 0 1 1 2 3 5 8 13 21 34
// Sum = 88
// ==================================================


// --------------------------------------------------
// Approach 1: While Loop (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Initialize a = 0, b = 1
// 2. Print a
// 3. Add a to sum
// 4. Compute next = a + b
// 5. Update a = b, b = next
// 6. Repeat n times

// Time Complexity: O(n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Uses constant space
// - No recursion overhead
// - Simple and efficient

var n = 10
var count = 1

var a = 0
var b = 1
var sum = 0

while count <= n {
    print(a, terminator: " ")
    
    sum += a
    
    let next = a + b
    a = b
    b = next
    
    count += 1
}

print("\nSum of Fibonacci ---> \(sum)")


print("----------------")



// --------------------------------------------------
// Approach 2: For Loop
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

let total = 10

var x = 0
var y = 1
var sum2 = 0

for _ in 1...total {
    print(x, terminator: " ")
    
    sum2 += x
    
    let next = x + y
    x = y
    y = next
}

print("\nSum (For Loop) ---> \(sum2)")


print("----------------")



// --------------------------------------------------
// Approach 3: Recursion (NOT BEST ❌)
// --------------------------------------------------

// Time Complexity: O(2^n)
// Space Complexity: O(n)

// ❌ Not best: repeated calculations

func fib(_ n: Int) -> Int {
    if n <= 1 { return n }
    return fib(n - 1) + fib(n - 2)
}

var sum3 = 0

for i in 0..<10 {
    let value = fib(i)
    print(value, terminator: " ")
    sum3 += value
}

print("\nSum (Recursion) ---> \(sum3)")
