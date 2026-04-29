import UIKit



// Problem: Find sum of first n natural numbers


// --------------------------------------------------
// Approach 1 (While Loop)
// --------------------------------------------------

// Approach:
// 1. Initialize n (input)
// 2. Initialize sum = 0
// 3. Run loop from 1 to n
// 4. Add each number to sum
// 5. Increment counter

// Time Complexity: O(n)
// Loop runs n times

// Space Complexity: O(1)

let n = 10

var i = 1
var sum = 0

while i <= n {
    sum += i
    i += 1
}

print("While Sum is:", sum)


print("----------------")


// --------------------------------------------------
// Approach 2 (For Loop)
// --------------------------------------------------

// Approach:
// Use for loop from 1 to n and accumulate sum

// Time Complexity: O(n)
// Space Complexity: O(1)

var sum2 = 0

for i in 1...n {
    sum2 += i
}

print("For Sum is:", sum2)


print("----------------")


// --------------------------------------------------
// Best Approach (Mathematical Formula)
// --------------------------------------------------

// Approach:
// Use formula: n * (n + 1) / 2

// Time Complexity: O(1)
// Constant time calculation

// Space Complexity: O(1)

let result = n * (n + 1) / 2

print("Formula Sum is:", result)
