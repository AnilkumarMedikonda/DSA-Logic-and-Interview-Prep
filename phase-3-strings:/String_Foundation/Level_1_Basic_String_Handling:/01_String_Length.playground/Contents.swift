import UIKit
// 01_String_Length

/*
 =====================================================
 Approach:
 Manual Traversal
 =====================================================

 1. Traverse string
 2. Increase length count
 3. Final count = string length
 */


var str = "Swift"

var length = 0


// Traverse string
for c in str {
    
    length += 1
}

print(length)

// Output:
// 5


/*
 =====================================================
 Dry Run
 =====================================================

 "Swift"


 S -> length = 1

 w -> length = 2

 i -> length = 3

 f -> length = 4

 t -> length = 5


 Final Length:
 5


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
 Why This Is Good For Interview
 =====================================================

 ✅ Manual traversal
 ✅ No predefined functions
 ✅ String iteration understanding
 ✅ Beginner-friendly logic
 */
