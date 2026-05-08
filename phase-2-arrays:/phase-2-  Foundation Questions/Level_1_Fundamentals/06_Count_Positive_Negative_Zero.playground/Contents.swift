import UIKit
// MARK: - 06_Count_Positive_Negative_Zero

/*
 Approach:
 - Traverse array once
 - Check:
   positive (> 0)
   negative (< 0)
   zero (== 0)
 - Increment respective counters

 Time: O(n)
 Space: O(1)
*/

var array = [1,-2,0,4,-5,0]

var pCount = 0
var nCount = 0
var zeroCount = 0

for number in array {
    
    if number > 0 {
        pCount += 1
        
    } else if number < 0 {
        nCount += 1
        
    } else {
        zeroCount += 1
    }
}

print("Positive:", pCount)
print("Negative:", nCount)
print("Zero:", zeroCount)
