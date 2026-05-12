import UIKit

// 29_Reverse_Characters_Keep_Digits

/*
=====================================================
Method 1: Two Pointer (Best For Interview)
=====================================================
*/

var str1 = "a1b2c3"
var words1 = Array(str1)

var left = 0
var right = words1.count - 1

while left < right {
    
    let leftAscii = words1[left].asciiValue!
    let rightAscii = words1[right].asciiValue!
    
    // Skip left digit
    if leftAscii >= 48 && leftAscii <= 57 {
        left += 1
    }
    
    // Skip right digit
    else if rightAscii >= 48 && rightAscii <= 57 {
        right -= 1
    }
    
    // Swap characters
    else {
        words1.swapAt(left, right)
        left += 1
        right -= 1
    }
}

var result1 = ""

// Build final string
for word in words1 {
    result1 += "\(word)"
}

print(result1)

// Output:
// c1b2a3

/*
=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

=====================================================
Why This Is Best
=====================================================

✅ Two Pointer pattern
✅ Optimized traversal
✅ Standard interview approach
*/



/*
=====================================================
Method 2: Store Characters Separately
=====================================================
*/

var str2 = "a1b2c3"
var characters = [Character]()

// Store only alphabets
for char in str2 {
    
    let asciiValue = char.asciiValue!
    
    // Not digit
    if !(asciiValue >= 48 && asciiValue <= 57) {
        characters.append(char)
    }
}

print(characters)

// ["a", "b", "c"]

var result2 = ""
var right2 = characters.count - 1

// Build final string
for char in str2 {
    
    let asciiValue = char.asciiValue!
    
    // Keep digit same
    if asciiValue >= 48 && asciiValue <= 57 {
        result2 += "\(char)"
    }
    
    // Add reverse character
    else {
        result2 += "\(characters[right2])"
        right2 -= 1
    }
}

print(result2)

// Output:
// c1b2a3

/*
=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

=====================================================
Interview Note
=====================================================

✅ Easy to understand
❌ Extra storage used
❌ Less optimized than Two Pointer
*/
