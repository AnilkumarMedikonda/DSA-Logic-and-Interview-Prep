import UIKit

// 10_Check_String_Empty

var str = "Swift"

var count = 0


// Traverse string
for char in str {
    count += 1
}


// Check empty
if count == 0 {
    print("Empty String")
    
} else {
    print("Not Empty")
}


// Output:
// Not Empty



/*
 =====================================================
 Dry Run
 =====================================================

 "Swift"


 S -> 1
 w -> 2
 i -> 3
 f -> 4
 t -> 5


 count != 0

 Result:
 Not Empty


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

 Traverse string
 and count characters.

 If count is 0:
 string is empty.
 */
