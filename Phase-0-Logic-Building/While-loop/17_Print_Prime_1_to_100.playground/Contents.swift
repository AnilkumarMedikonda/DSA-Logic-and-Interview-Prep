
import UIKit

// ==================================================
// Problem: Print prime numbers from 1 to 100
// ==================================================



// --------------------------------------------------
// Approach 1: Brute Force (While Loop)
// --------------------------------------------------

// Approach:
// 1. For each number, check divisibility from 2 to n-1
// 2. If divisible → not prime
// 3. Else → prime

// Time Complexity: O(n²)
// Space Complexity: O(1)

var n = 2

while n <= 100 {
    
    var isPrime = true
    var i = 2
    
    while i < n {
        if n % i == 0 {
            isPrime = false
            break
        }
        i += 1
    }
    
    if isPrime {
        print(n, terminator: " ")
    }
    
    n += 1
}

print("\n----------------")



// --------------------------------------------------
// Approach 2: Optimized (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Check divisibility only till √n
// 2. If any divisor found → not prime

// Time Complexity: O(n√n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Reduces unnecessary checks
// - Faster than brute force

var num = 2

while num <= 100 {
    
    var isPrime = true
    var i = 2
    
    while i * i <= num {
        if num % i == 0 {
            isPrime = false
            break
        }
        i += 1
    }
    
    if isPrime {
        print(num, terminator: " ")
    }
    
    num += 1
}
