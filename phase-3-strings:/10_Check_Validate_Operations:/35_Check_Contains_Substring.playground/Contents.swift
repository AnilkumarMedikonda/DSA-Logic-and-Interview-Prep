import UIKit

// 35_Check_Contains_Substring

/*
 =====================================================
 Method 1:
 Temporary Substring Matching
 =====================================================

 1. Traverse string
 2. Build substring using i + j
 3. Compare with findStr
 */


var str = "SwiftProgramming"

var findStr = "gram"

var isFound = false


// Traverse string
for i in 0..<str.count {
    
    var temp = ""
    
    
    // Build substring
    for j in 0..<findStr.count {
        
        if i + j < str.count {
            
            let index = str.index(str.startIndex,
                                  offsetBy: i + j)
            
            temp += String(str[index])
        }
    }
    
    
    // Match found
    if temp == findStr {
        
        isFound = true
        
        break
    }
}

print(isFound)

// Output:
// true


/*
 =====================================================
 Dry Run
 =====================================================

 SwiftProgramming

 gram


 Swi ❌
 wif ❌
 ift ❌
 ...
 gram ✅


 Result:
 true


 =====================================================
 Time Complexity
 =====================================================

 O(n * m)

 n = string length
 m = substring length


 =====================================================
 Space Complexity
 =====================================================

 O(m)

 Because temporary substring created
 */



// =====================================================
// Method 2:
// Direct Character Comparison
// (Best Interview Approach)
// =====================================================

var str2 = "SwiftProgramming"

var findStr2 = "gram"

var isContains = false


// Traverse string
for i in 0...(str2.count - findStr2.count) {
    
    var isMatch = true
    
    
    // Compare characters directly
    for j in 0..<findStr2.count {
        
        let strIndex = str2.index(str2.startIndex,
                                  offsetBy: i + j)
        
        let findIndex = findStr2.index(findStr2.startIndex,
                                       offsetBy: j)
        
        
        // Mismatch found
        if str2[strIndex] != findStr2[findIndex] {
            
            isMatch = false
            
            break
        }
    }
    
    
    // Match found
    if isMatch {
        
        isContains = true
        
        break
    }
}

print(isContains)

// Output:
// true


/*
 =====================================================
 Time Complexity
 =====================================================

 O(n * m)


 =====================================================
 Space Complexity
 =====================================================

 O(1)

 No temporary substring created


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Sliding Window thinking
 ✅ Direct comparison
 ✅ Optimized space
 ✅ Strong traversal logic
 */
