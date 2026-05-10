import UIKit


// 30_Suffix_Extraction

/*
 =====================================================
 Method 1:
 While Loop Traversal
 =====================================================

 1. Calculate suffix start index
 2. Traverse until end
 3. Build suffix manually
 */


var str1 = "SwiftProgramming"

var length1 = 11

var result1 = ""


// Start index of suffix
var i = str1.count - length1


// Extract suffix
while i < str1.count {
    
    let index = str1.index(str1.startIndex, offsetBy: i)
    
    result1 += String(str1[index])
    
    i += 1
}

print("Method 1:", result1)

// Output:
// Programming


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Clean pointer traversal approach.
 */


// =====================================================
// Method 2:
// For Loop Traversal
// =====================================================

/*
 1. Calculate suffix start
 2. Traverse from start to end
 3. Build suffix manually
 */


var str2 = "SwiftProgramming"

var length2 = 11

var result2 = ""


// Suffix start index
var start = str2.count - length2


// Extract suffix
for i in start..<str2.count {
    
    let index = str2.index(str2.startIndex, offsetBy: i)
    
    result2 += String(str2[index])
}

print("Method 2:", result2)

// Output:
// Programming


/*
 =====================================================
 Dry Run
 =====================================================

 SwiftProgramming

 str.count = 16
 length = 11

 start = 16 - 11
 start = 5


 i = 5 -> P
 result = "P"

 i = 6 -> r
 result = "Pr"

 Continue until end


 Final Result:
 Programming


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = suffix length


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
 better pointer understanding

 For loop:
 cleaner and more readable
 */
