// ==================================================
// Topic: Count numbers divisible by 7 but not by 5
// ==================================================

// Problem:
// Count all numbers between 1 and 500 that:
// 1. Are divisible by 7
// 2. Are NOT divisible by 5

// ==================================================
// Approach 1: Brute Force
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// Idea:
// Loop from 1 to 500
// Check both conditions

var count1 = 0

for i in 1...500 {
    
    if i % 7 == 0 && i % 5 != 0 {
        count1 += 1
    }
}

print("Brute Force Count =", count1)


// ==================================================
// Approach 2: Optimized (Better)
// ==================================================

// Time Complexity: O(n/7)
// Space Complexity: O(1)

// Idea:
// Iterate only multiples of 7
// Then filter out multiples of 5

var count2 = 0
var n = 7

while n <= 500 {
    
    if n % 5 != 0 {
        count2 += 1
    }
    
    n += 7
}

print("Optimized Count =", count2)


