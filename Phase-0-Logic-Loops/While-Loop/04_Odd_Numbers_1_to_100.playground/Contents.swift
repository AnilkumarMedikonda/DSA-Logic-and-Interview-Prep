import UIKit


// Problem: Print odd numbers from 1 to 100

// --------------------------------------------------
// Approach 1 (Basic):
// Check each number using modulo
// --------------------------------------------------

// Time Complexity: O(n)
// Loop runs 100 times

var n1 = 1

print("Basic Approach:")

while n1 <= 100 {
    if n1 % 2 != 0 {
        print(n1)
    }
    n1 += 1
}


// --------------------------------------------------
// Approach 2 (Optimized):
// Start from 1 and increment by 2
// --------------------------------------------------

// Time Complexity: O(n)
// Loop runs ~50 times (fewer iterations)

var n2 = 1

print("\nOptimized Approach:")

while n2 <= 100 {
    print(n2)
    n2 += 2
}
