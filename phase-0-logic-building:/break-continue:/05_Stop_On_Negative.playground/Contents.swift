import UIKit


// ==================================================
// Problem: Print numbers until a negative appears
// Stop the loop when a negative number is found
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// Input (simulated)
let numbers = [12, 5, 8, 21, -34, 7, 19, 45]

// Loop
for number in numbers {
    
    if number < 0 {
        print("\nNegative Found → Stopped")
        break   // Stop loop
    }
    
    print(number, terminator: " ")
}
