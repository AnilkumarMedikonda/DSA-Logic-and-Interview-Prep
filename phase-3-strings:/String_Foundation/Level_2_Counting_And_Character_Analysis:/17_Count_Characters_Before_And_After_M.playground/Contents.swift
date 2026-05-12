import UIKit

// 17_Count_Characters_Before_And_After_M

var str = "applez"

var beforeMCount = 0

var afterMCount = 0


// Traverse string
for char in str {
    
    let asciiValue = char.asciiValue!
    
    
    // Before m
    if asciiValue < 109 {
        
        beforeMCount += 1
    }
    
    
    // After m
    else if asciiValue > 109 {
        
        afterMCount += 1
    }
}

print("Before m:", beforeMCount)

print("After m:", afterMCount)


// Output:
// Before m: 3
// After m: 3



/*
 =====================================================
 Dry Run
 =====================================================

 applez


 a -> 97  -> before m = 1

 p -> 112 -> after m = 1

 p -> 112 -> after m = 2

 l -> 108 -> before m = 2

 e -> 101 -> before m = 3

 z -> 122 -> after m = 3


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

 Compare ASCII values with:
 m -> 109

 < 109 -> before m
 > 109 -> after m
 */
