import UIKit

var greeting = "Hello, playground"


// Problem: Print even numbers from 1 to 100

// Approach:
// 1. Initialize n = 1
// 2. Run loop while n <= 100
// 3. Check if n is divisible by 2 (n % 2 == 0)
// 4. If yes, print the number
// 5. Increment n by 1

// Dry Run:
// n = 1 → skip
// n = 2 → print
// n = 3 → skip
// ...

// Time Complexity: O(n)
// Loop runs 100 times and each iteration does constant work

var n = 1

while n <= 100 {
    if n % 2 == 0 {
        print("Number --- \(n)")
    }
    n += 1
}

