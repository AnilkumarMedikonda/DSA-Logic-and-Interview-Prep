import UIKit

var greeting = "Hello, playground"

// 12_Count_Digits_Letters_SpecialCharacters

var str = "Swift123@#"

var letters = 0

var digits = 0

var specialCharacters = 0


// Traverse string
for char in str {
    
    let asciiValue = char.asciiValue!
    
    
    // Check letters
    if (asciiValue >= 65 && asciiValue <= 90) ||
       (asciiValue >= 97 && asciiValue <= 122) {
        
        letters += 1
    }
    
    
    // Check digits
    else if asciiValue >= 48 &&
            asciiValue <= 57 {
        
        digits += 1
    }
    
    
    // Special characters
    else {
        
        specialCharacters += 1
    }
}

print("Letters:", letters)

print("Digits:", digits)

print("Special Characters:", specialCharacters)


// Output:
// Letters: 5
// Digits: 3
// Special Characters: 2



/*
 =====================================================
 Dry Run
 =====================================================

 Swift123@#


 S -> Letter = 1

 w -> Letter = 2

 i -> Letter = 3

 f -> Letter = 4

 t -> Letter = 5


 1 -> Digit = 1

 2 -> Digit = 2

 3 -> Digit = 3


 @ -> Special = 1

 # -> Special = 2


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Traverse string.

 Check ASCII ranges for:
 1. Letters
 2. Digits
 3. Special characters

 Increase respective counts.
 */
