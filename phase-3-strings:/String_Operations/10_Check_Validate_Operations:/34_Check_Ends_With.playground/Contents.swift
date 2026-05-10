import UIKit

//  var greeting =

/*
 =====================================================
 Method 1:
 Temporary Substring Matching
 =====================================================

 1. Find suffix start index
 2. Build substring manually
 3. Compare with suffix
 */


var str = "SwiftProgramming"

var suffix = "ming"

var temp = ""

var isEndsWith = false


// Start index of suffix
var start = str.count - suffix.count


// Build substring
for i in start..<str.count {
    
    let index = str.index(str.startIndex, offsetBy: i)
    
    temp += String(str[index])
}


// Compare
if temp == suffix {
    
    isEndsWith = true
}

print(isEndsWith)

// Output:
// true


/*
 =====================================================
 Dry Run
 =====================================================

 SwiftProgramming

 suffix = "ming"

 start = 16 - 4
 start = 12


 Extract:
 m
 mi
 min
 ming


 Compare:
 ming == ming

 ✅ true


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = suffix length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because temporary substring created
 */


// =====================================================
// Method 2:
// Direct Character Comparison
// (Best Interview Approach)
// =====================================================

var str2 = "SwiftProgramming"

var suffix2 = "ming"

var isMatch = true


// Length check
if suffix2.count > str2.count {
    
    isMatch = false
    
} else {
    
    // Start position
    let start = str2.count - suffix2.count
    
    
    // Compare characters
    for i in 0..<suffix2.count {
        
        let strIndex = str2.index(str2.startIndex,
                                  offsetBy: start + i)
        
        let suffixIndex = suffix2.index(suffix2.startIndex,
                                        offsetBy: i)
        
        
        // Mismatch found
        if str2[strIndex] != suffix2[suffixIndex] {
            
            isMatch = false
            
            break
        }
    }
}

print(isMatch)

// Output:
// true


/*
 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ No extra substring
 ✅ Optimized space
 ✅ Direct comparison
 ✅ Strong index handling
 */
