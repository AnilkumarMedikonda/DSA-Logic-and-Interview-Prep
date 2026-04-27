// --------------------------------------------------
// Approach 1: Brute Force (repeat-while)
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

var number1 = 12
var number2 = 18

var i = 1
var hcf = 1

repeat {
    if number1 % i == 0 && number2 % i == 0 {
        hcf = i   // store highest factor
    }
    
    i += 1
    
} while i <= min(number1, number2)

print("HCF (Brute) ---> \(hcf)")


// --------------------------------------------------
// Approach 2: Euclidean Algorithm (Optimal)
// --------------------------------------------------

// Time Complexity: O(log n)
// Space Complexity: O(1)

var a = 12
var b = 18

repeat {
    let temp = b
    b = a % b
    a = temp
    
} while b != 0

print("HCF (Optimal) ---> \(a)")
