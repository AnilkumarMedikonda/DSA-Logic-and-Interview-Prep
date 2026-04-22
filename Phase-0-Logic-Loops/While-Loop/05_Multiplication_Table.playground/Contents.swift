
import Foundation



// Problem: Print multiplication table of a given number (n × 1 to n × 10)

// --------------------------------------------------
// Approach 1 (While Loop)
// --------------------------------------------------

// Approach:
// 1. Take input number n
// 2. Initialize i = 1
// 3. Run loop while i <= 10
// 4. Multiply n * i
// 5. Print result
// 6. Increment i

// Time Complexity: O(1)
// The loop runs a fixed 10 times, independent of input size

// Space Complexity: O(1)



let n = 5
var i = 1

print("While Loop Approach:")

while i <= 10 {
    print("\(n) * \(i) = \(n * i)")
    i += 1
}


print("----------------")


// --------------------------------------------------
// Better Approach (For Loop)
// --------------------------------------------------

// Approach:
// Use for loop for fixed range (1 to 10)


// Time Complexity: O(1)
// Loop runs constant number of times (10)

// Space Complexity: O(1)


let n2 = 5

print("For Loop Approach:")

for i in 1...10 {
    print("\(n2) * \(i) = \(n2 * i)")
}
