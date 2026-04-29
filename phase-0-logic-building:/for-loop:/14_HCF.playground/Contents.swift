import UIKit

// ==================================================
// Problem: Find HCF (Highest Common Factor)
// Example: 12, 18 → HCF = 6
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let number1 = 12
let number2 = 18

var hcf = 1

for i in 1...min(number1, number2) {
    if number1 % i == 0 && number2 % i == 0 {
        hcf = i   // keep updating max common factor
    }
}

print("HCF ---> \(hcf)")
