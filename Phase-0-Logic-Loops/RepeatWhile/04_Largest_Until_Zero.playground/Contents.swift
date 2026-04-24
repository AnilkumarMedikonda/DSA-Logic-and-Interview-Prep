import UIKit


// ==================================================
// Problem: Keep taking numbers until 0 is encountered
// Print the largest number among all inputs
// Using: repeat-while (do-while)
// ==================================================

// NOTE:
// Playground → use simulated input (array)

// Time Complexity: O(n)
// Space Complexity: O(1)



// --------------------------------------------------
// Approach: Sentinel-Controlled Loop
// --------------------------------------------------

var inputs = [7, 2, 9, 4, 0]   // input sequence
var index = 0

var number = 0
var maxValue = Int.min   // start with smallest value

repeat {
    number = inputs[index]
    
    if number != 0 {
        maxValue = max(maxValue, number)
    }
    
    index += 1
    
} while number != 0

print("Largest ---> \(maxValue)")
