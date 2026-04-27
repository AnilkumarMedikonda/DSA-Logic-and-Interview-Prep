import UIKit



// ==================================================
// Problem: Keep taking numbers until 0 is encountered
// Print the sum of all entered numbers
// Using: repeat-while (do-while)
// ==================================================

// NOTE:
// Playground → use simulated input (array)

// Time Complexity: O(n)
// Space Complexity: O(1)



// --------------------------------------------------
// Approach: Sentinel-Controlled Loop
// --------------------------------------------------

var inputs = [5, 3, 2, 7, 0]   // input sequence
var index = 0

var number = 0
var sum = 0

repeat {
    number = inputs[index]
    
    if number != 0 {
        sum += number
    }
    
    index += 1
    
} while number != 0

print("Sum ---> \(sum)")
