import UIKit

// ==================================================
// Problem: Search for a number in a list
// Stop the loop immediately when found
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// Input
let numbers = [12, 5, 8, 21, 34, 7, 19, 45, 2, 16,
               9, 27, 33, 14, 6, 50, 11, 3, 25, 40]

let search = 33

var isFound = false

// Search logic
for number in numbers {
    
    if number == search {
        isFound = true
        print("Found: \(search)")
        break   // Stop loop immediately
    }
}

// Handle not found case
if !isFound {
    print("Not Found")
}
