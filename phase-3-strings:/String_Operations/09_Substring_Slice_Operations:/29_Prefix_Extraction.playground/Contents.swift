import UIKit

// 29_Prefix_Extraction

/*
 =====================================================
 Method 1:
 While Loop Traversal
 =====================================================

 1. Start from beginning
 2. Traverse until given length
 3. Build prefix manually
 */


var str1 = "SwiftProgramming"

var length1 = 5

var result1 = ""

var i = 0


// Extract prefix
while i < length1 {
    
    let index = str1.index(str1.startIndex, offsetBy: i)
    
    result1 += String(str1[index])
    
    i += 1
}

print("Method 1:", result1)

// Output:
// Swift


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Clean manual traversal approach.
 */


// =====================================================
// Method 2:
// For Loop Traversal
// =====================================================

/*
 1. Traverse from 0 to length
 2. Append characters
 */


var str2 = "SwiftProgramming"

var length2 = 5

var result2 = ""


// Extract prefix
for i in 0..<length2 {
    
    let index = str2.index(str2.startIndex, offsetBy: i)
    
    result2 += String(str2[index])
}

print("Method 2:", result2)

// Output:
// Swift


/*
 =====================================================
 Dry Run
 =====================================================

 SwiftProgramming

 i = 0 -> S
 result = "S"

 i = 1 -> w
 result = "Sw"

 i = 2 -> i
 result = "Swi"

 i = 3 -> f
 result = "Swif"

 i = 4 -> t
 result = "Swift"


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = prefix length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string created


 =====================================================
 Interview Recommendation
 =====================================================

 ✅ Both approaches are good

 While loop:
 better for pointer-style logic

 For loop:
 cleaner and more readable
 */
