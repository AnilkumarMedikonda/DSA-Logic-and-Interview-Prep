import UIKit

// 16_Count_Character_Occurrence

var str = "banana"

let target: Character = "a"

var count = 0


// Traverse string
for char in str {
    
    // Match found
    if char == target {
        count += 1
    }
}

print(count)

// Output:
// 3



/*
 =====================================================
 Dry Run
 =====================================================

 banana


 b -> no match

 a -> count = 1

 n -> no match

 a -> count = 2

 n -> no match

 a -> count = 3


 Final Output:
 3


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

 If character matches target:
 increase count.
 */
