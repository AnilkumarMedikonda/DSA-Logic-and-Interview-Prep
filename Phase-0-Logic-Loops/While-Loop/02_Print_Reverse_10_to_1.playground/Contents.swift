import UIKit

var greeting = "Hello, playground"


// Problem: Print numbers from 10 down to 1 using while loop

// Approach:
// 1. Initialize n = 10
// 2. Run loop while n > 0
// 3. Print n in each iteration
// 4. Decrement n by 1

// Dry Run:
// n = 10 → 9 → 8 → ... → 1

// Time Complexity: O(n)
// The loop runs n times and each iteration does constant work

var n = 10

while n > 0 {
    print("Number ---> \(n)")
    n -= 1
}
