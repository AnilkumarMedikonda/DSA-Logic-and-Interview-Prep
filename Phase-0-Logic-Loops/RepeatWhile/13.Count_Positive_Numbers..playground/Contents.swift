
import UIKit

// ==================================================
// Problem:
// Keep taking numbers until a negative number is found
// Count how many positive numbers were entered
// ==================================================

// NOTE:
// Playground → use simulated input (array)

// Time Complexity: O(n)
// Space Complexity: O(1)



// --------------------------------------------------
// Approach: Sentinel-Controlled Loop
// --------------------------------------------------

var numbers = [1, 2, 5, 7, -3, 9, 10]   // input sequence
var index = 0

var number = 0
var positiveCount = 0

repeat {
    number = numbers[index]
    
    if number > 0 {
        positiveCount += 1
    }
    
    index += 1
    
} while number >= 0 && index < numbers.count

print("Positive Count ---> \(positiveCount)")
