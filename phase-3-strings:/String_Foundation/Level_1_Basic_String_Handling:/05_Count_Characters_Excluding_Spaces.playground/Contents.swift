import UIKit

// 05_Count_Characters_Excluding_Spaces

var str = "Hello World"

var count = 0


// Traverse string
for char in str {
    
    // Ignore spaces
    if char != " " {
        
        count += 1
    }
}

print(count)

// Output:
// 10



/*
 =====================================================
 Dry Run
 =====================================================

 H -> 1
 e -> 2
 l -> 3
 l -> 4
 o -> 5

 space -> skip

 W -> 6
 o -> 7
 r -> 8
 l -> 9
 d -> 10


 Final Output:
 10


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Traverse string.

 If character is not space:
 increase count.
 */
