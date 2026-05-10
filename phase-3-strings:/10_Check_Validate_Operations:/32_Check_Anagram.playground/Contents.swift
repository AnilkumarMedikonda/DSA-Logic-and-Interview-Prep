import UIKit

// 32_Check_Anagram

/*
 =====================================================
 Method 1:
 Nested Loop Matching
 =====================================================

 1. Compare lengths
 2. Check every character of str1
    exists in str2
 */


var str1 = "listen"

var str2 = "silent"


// Length check
if str1.count != str2.count {
    
    print("Not Anagram")
    
} else {
    
    var isAnagram = true
    
    
    // Traverse str1
    for i in 0..<str1.count {
        
        let index1 = str1.index(str1.startIndex, offsetBy: i)
        
        var isFound = false
        
        
        // Traverse str2
        for j in 0..<str2.count {
            
            let index2 = str2.index(str2.startIndex, offsetBy: j)
            
            
            // Character match
            if str1[index1] == str2[index2] {
                
                isFound = true
                
                break
            }
        }
        
        
        // Character missing
        if !isFound {
            
            isAnagram = false
            
            break
        }
    }
    
    
    // Result
    if isAnagram {
        
        print("Anagram")
        
    } else {
        
        print("Not Anagram")
    }
}


/*
 =====================================================
 Problem In This Approach
 =====================================================

 This approach fails for frequency cases.

 Example:

 str1 = "aab"
 str2 = "abb"

 It incorrectly says:
 ✅ Anagram

 Because it only checks existence,
 not frequency.


 =====================================================
 Time Complexity
 =====================================================

 O(n²)


 =====================================================
 Space Complexity
 =====================================================

 O(1)
 */


// =====================================================
// Method 2:
// Dictionary Frequency Count
// (Best Interview Approach)
// =====================================================

/*
 1. Compare lengths
 2. Count character frequencies
 3. Compare frequencies
 */


var first = "listen"

var second = "silent"


// Length check
if first.count != second.count {
    
    print("Not Anagram")
    
} else {
    
    var dict = [Character: Int]()
    
    
    // Count str1 characters
    for char in first {
        
        dict[char, default: 0] += 1
    }
    
    
    // Remove using str2
    for char in second {
        
        dict[char, default: 0] -= 1
    }
    
    
    var isAnagram = true
    
    
    // Check remaining counts
    for value in dict.values {
        
        if value != 0 {
            
            isAnagram = false
            
            break
        }
    }
    
    
    // Result
    if isAnagram {
        
        print("Anagram")
        
    } else {
        
        print("Not Anagram")
    }
}


/*
 =====================================================
 Dry Run
 =====================================================

 listen

 l -> 1
 i -> 1
 s -> 1
 t -> 1
 e -> 1
 n -> 1


 silent

 s -> -1
 i -> 0
 l -> 0
 e -> 0
 n -> 0
 t -> 0


 All frequencies become 0
 ✅ Anagram


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because dictionary used


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ HashMap / Dictionary usage
 ✅ Frequency counting
 ✅ Optimized solution
 ✅ Handles duplicate characters
 ✅ Standard interview approach
 */
