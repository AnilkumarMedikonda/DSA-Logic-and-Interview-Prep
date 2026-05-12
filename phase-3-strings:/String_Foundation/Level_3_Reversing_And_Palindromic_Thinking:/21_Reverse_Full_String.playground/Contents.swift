import UIKit

// 21_Reverse_Full_String
/*
 =====================================================
 Method 1:
 Backward Traversal
 (Best For DSA Interview)
 =====================================================
 */


var str = "Swift"

var right = str.count - 1
var reverseStr = ""


// Traverse from end
while right >= 0 {
    let index = str.index(str.startIndex,
                          offsetBy: right)
    reverseStr += String(str[index])
    right -= 1
}

print(reverseStr)

// Output:
// tfiwS



/*
 =====================================================
 Dry Run
 =====================================================

 Swift


 t -> "t"

 f -> "tf"

 i -> "tfi"

 w -> "tfiw"

 S -> "tfiwS"


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Reverse traversal
 ✅ Simple logic
 ✅ Optimized approach
 ✅ Standard DSA pattern
 */

/*
 =====================================================
 Method 2:
 Front Insert / Prepend
 =====================================================
 */


var reverseStrTwo = ""


// Traverse string
for char in str {
    reverseStrTwo = "\(char)" + reverseStrTwo
}

print(reverseStrTwo)

// Output:
// tfiwS



/*
 =====================================================
 Dry Run
 =====================================================

 S -> "S"

 w -> "wS"

 i -> "iwS"

 f -> "fiwS"

 t -> "tfiwS"


 =====================================================
 Time Complexity
 =====================================================

 O(n²)

 Because front insertion
 shifts existing string


 =====================================================
 Space Complexity
 =====================================================

 O(n)


 =====================================================
 Interview Note
 =====================================================
 ✅ Creative logic
 ✅ Easy to understand
 ❌ Less optimized
 ❌ Not preferred for DSA rounds
 */
