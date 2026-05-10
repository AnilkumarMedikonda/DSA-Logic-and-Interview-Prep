import UIKit

// 33_Check_Starts_With

/*
 =====================================================
 Method 1:
 Temporary Substring Matching
 =====================================================

 1. Create substring manually
 2. Compare with prefix
 */


var str = "SwiftProgramming"

var prefix = "Swift"

var temp = ""

var isStartsWith = false


// Build substring manually
for i in 0..<prefix.count {
    
    let index = str.index(str.startIndex, offsetBy: i)
    
    temp += String(str[index])
}


// Compare
if temp == prefix {
    
    isStartsWith = true
}

print(isStartsWith)

// Output:
// true


/*
 =====================================================
 Dry Run
 =====================================================

 str = "SwiftProgramming"

 prefix = "Swift"


 Build:
 S
 Sw
 Swi
 Swif
 Swift


 Compare:
 Swift == Swift

 ✅ true


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = prefix length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because temporary substring created
 */
