
import UIKit

import UIKit

// ==================================================
// Problem: Armstrong Number (General case)
// Example: 153 → 1³ + 5³ + 3³ = 153
// ==================================================

// Time Complexity: O(d²)  (because of power function inside loop)
// Space Complexity: O(1)



// --------------------------------------------------
// Step 1: Initialize
// --------------------------------------------------

var number = 153
let original = number
var temp = number

var digitCount = 0



// --------------------------------------------------
// Step 2: Count number of digits
// --------------------------------------------------

repeat {
    digitCount += 1
    temp /= 10
} while temp > 0



// --------------------------------------------------
// Step 3: Calculate sum of (digit ^ digitCount)
// --------------------------------------------------

temp = number
var sum = 0

repeat {
    let digit = temp % 10
    sum += power(digit, digitCount)
    temp /= 10
} while temp > 0



// --------------------------------------------------
// Step 4: Check Armstrong
// --------------------------------------------------

if sum == original {
    print("Armstrong Number")
} else {
    print("Not Armstrong Number")
}



// --------------------------------------------------
// Helper Function: Power
// --------------------------------------------------

func power(_ base: Int, _ exp: Int) -> Int {
    var result = 1
    
    for _ in 1...exp {
        result *= base
    }
    
    return result
}
