import UIKit

// ==================================================
// Problem: Reverse a number
// Example: 1234 → 4321
// ==================================================



// --------------------------------------------------
// Approach 1: Modulo (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Extract last digit using n % 10
// 2. Build reverse = reverse * 10 + digit
// 3. Remove digit using n / 10
// 4. Repeat until n = 0

// Time Complexity: O(d)
// Space Complexity: O(1)

// ⭐ BEST APPROACH because:
// - No extra space used
// - Direct digit manipulation
// - Most efficient and preferred in interviews

var n = 1234
var reverse = 0

while n > 0 {
    let digit = n % 10
    reverse = reverse * 10 + digit
    n /= 10
}

print("Modulo Reverse:", reverse)


print("----------------")



// --------------------------------------------------
// Approach 2: String Method
// --------------------------------------------------

// Time Complexity: O(d)
// Space Complexity: O(d)

// ❌ Not best: uses extra space

let number = 1234
let reversedString = String(String(number).reversed())
let reversedNumber = Int(reversedString)!

print("String Reverse:", reversedNumber)


print("----------------")



// --------------------------------------------------
// Approach 3: Recursion
// --------------------------------------------------

// Time Complexity: O(d)
// Space Complexity: O(d)

// ❌ Not best: uses call stack

func reverseRec(_ n: Int, _ result: Int = 0) -> Int {
    if n == 0 { return result }
    return reverseRec(n / 10, result * 10 + n % 10)
}

print("Recursive Reverse:", reverseRec(1234))

 
