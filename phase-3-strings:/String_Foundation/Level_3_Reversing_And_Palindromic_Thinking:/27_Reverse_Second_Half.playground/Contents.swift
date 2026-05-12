import UIKit
// 27_Reverse_Second_Half

var str = "abcdef"
var reverseHalfStr = ""

// Middle index
var left = str.count / 2
var right = str.count - 1


// Add first half
for i in 0..<str.count / 2 {
    
    let index = str.index(str.startIndex,
                          offsetBy: i)
    reverseHalfStr += String(str[index])
}


// Reverse second half
while right >= left {
    
    let index = str.index(str.startIndex,
                          offsetBy: right)
    reverseHalfStr += String(str[index])
    right -= 1
}

print(reverseHalfStr)

// Output:
// abcfed

/*
 =====================================================
 Dry Run
 =====================================================
 abcdef

 First Half:
 abc

 Second Half:
 def

 Reverse:
 fed

 Final Output:
 abcfed
 =====================================================
 Time Complexity
 =====================================================
 O(n)
 
 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string created

 =====================================================
 Approach
 =====================================================
 Keep first half same.
 Traverse second half backward
 and append into result.
 */
