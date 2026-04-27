import UIKit


// Problem print sum of  Even numbers 1 to 100

// Approach:
// 1. Start from n = 1
// 2. Loop till 100
// 3. Check if number is even (n % 2 == 0)
// 4. Add to sum

// Time Complexity: O(n)
// Loop runs 100 times

// Space Complexity: O(1)

var sum = 0
var n = 1

while n <= 100 {
    if n % 2 == 0 {
        sum += n
    }
    n += 1
}

print("Basic Approach Sum ---> \(sum)")



// Approach:
// 1. Start from n = 2 (first even number)
// 2. Increment by 2 each time
// 3. Add directly to sum

// Time Complexity: O(n)
// Loop runs ~50 times (half iterations)

// Space Complexity: O(1)

var sumTwo = 0
var nTwo = 2

while nTwo <= 100 {
    sumTwo += nTwo
    nTwo += 2
}

print("Optimized Approach Sum ---> \(sumTwo)")
