import UIKit

// 15_Count_Spaces

var str = "Hello Swift World"

var spaceCount = 0


// Traverse string
for char in str {
    
    // Check space
    if char == " " {
        
        spaceCount += 1
    }
}

print(spaceCount)

// Output:
// 2



/*
 =====================================================
 Dry Run
 =====================================================

 Hello Swift World


 space after Hello -> 1

 space after Swift -> 2


 Final Output:
 2


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

 If character is space:
 increase count.
 */
