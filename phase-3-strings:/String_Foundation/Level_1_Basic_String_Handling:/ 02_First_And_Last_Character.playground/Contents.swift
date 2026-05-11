import UIKit

// 02_First_And_Last_Character

var str = "Swift"
// First character index
let firstIndex = str.startIndex
print(str[firstIndex])
// Last character index
let lastIndex = str.index(before: str.endIndex)

print(str[lastIndex])


// Output:
// S
// t



/*
 =====================================================
 Dry Run
 =====================================================

 "Swift"


 First Character:
 S


 Last Character:
 t


 =====================================================
 Time Complexity
 =====================================================

 O(1)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Access:
 1. startIndex
 2. last index using endIndex

 Then print both characters.
 */
