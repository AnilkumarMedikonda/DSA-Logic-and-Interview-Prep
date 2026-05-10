import UIKit

// 26_Join_Array_Of_Strings

/*
 =====================================================
 Method 1:
 Using First Element Check
 (Cleaner Interview Approach)
 =====================================================

 1. Traverse array
 2. First word -> add directly
 3. Remaining words ->
    add delimiter + word
 */


var array1 = ["apple", "banana", "mango"]

var result1 = ""


// Traverse array
for i in 0..<array1.count {
    
    let word = array1[i]
    
    
    // First word
    if i == 0 {
        
        result1 += word
        
    } else {
        
        result1 += ",\(word)"
    }
}

print("Method 1:", result1)

// Output:
// apple,banana,mango


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Cleaner logic because:
 ✅ avoids extra delimiter at beginning
 ✅ easier interview explanation
 */



// =====================================================
// Method 2:
// Using Last Element Check
// =====================================================

var array2 = ["apple", "banana", "mango"]

var result2 = ""


// Traverse array
for i in 0..<array2.count {
    
    let word = array2[i]
    
    
    // Last word
    if i < array2.count - 1 {
        result2 += "\(word),"
    } else {
        result2 += word
    }
}

print("Method 2:", result2)

// Output:
// apple,banana,mango


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Avoids extra delimiter at end.
 */
