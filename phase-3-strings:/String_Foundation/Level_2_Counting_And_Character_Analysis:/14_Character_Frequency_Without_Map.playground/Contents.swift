import UIKit

// 14_Character_Frequency_Without_Map


var str = "banana"


// Traverse string
for i in 0..<str.count {
    
    let indexI = str.index(str.startIndex,
                           offsetBy: i)
    
    let currentChar = str[indexI]
    
    var isVisited = false
    
    
    // Check previous characters
    for k in 0..<i {
        
        let previousIndex = str.index(str.startIndex,
                                      offsetBy: k)
        
        
        // Already counted
        if str[previousIndex] == currentChar {
            
            isVisited = true
            
            break
        }
    }
    
    
    // Skip duplicates
    if isVisited {
        continue
    }
    
    
    var count = 0
    
    
    // Count frequency
    for j in 0..<str.count {
        
        let indexJ = str.index(str.startIndex,
                               offsetBy: j)
        
        if str[indexJ] == currentChar {
            
            count += 1
        }
    }
    
    
    print("\(currentChar) -> \(count)")
}


/*
 =====================================================
 Output
 =====================================================

 b -> 1
 a -> 3
 n -> 2



 =====================================================
 Dry Run
 =====================================================

 banana


 b -> count = 1

 a -> count = 3

 n -> count = 2

 a -> already counted -> skip

 n -> already counted -> skip

 a -> already counted -> skip


 =====================================================
 Time Complexity
 =====================================================

 O(n²)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Traverse string.

 If character already appeared:
 skip it.

 Otherwise:
 count frequency using second loop.
 */
