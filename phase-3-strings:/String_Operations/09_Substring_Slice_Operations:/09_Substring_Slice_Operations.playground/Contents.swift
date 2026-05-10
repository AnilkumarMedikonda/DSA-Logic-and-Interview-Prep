import UIKit

// 09_Substring_Slice_Operations

/*
 =====================================================
 Method 1:
 Fixed Range Traversal
 =====================================================

 1. Traverse fixed indexes
 2. Build substring manually
 */


var str1 = "SwiftProgramming"

var result1 = ""


// Fixed range
for i in 0...4 {
    
    let index = str1.index(str1.startIndex, offsetBy: i)
    
    result1 += String(str1[index])
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

 Beginner friendly approach.
 */



// =====================================================
// Method 2:
// Dynamic Start & End Index
// (Best Interview Approach)
// =====================================================

/*
 1. Take start and end indexes
 2. Traverse that range
 3. Build substring manually
 */


var str2 = "SwiftProgramming"

var start = 0

var end = 4

var result2 = ""


// Dynamic traversal
for i in start...end {
    
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

 start = 0
 end = 4


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

 n = substring length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string created


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Dynamic range handling
 ✅ Manual traversal
 ✅ Reusable logic
 ✅ Better flexibility
 */
