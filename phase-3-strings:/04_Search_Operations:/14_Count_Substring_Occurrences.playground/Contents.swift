import UIKit

// 14_Count_Substring_Occurrences

/*
 =====================================================
 Approach:
 Sliding Window + Counter
 =====================================================

 1. Traverse main string
 2. Create substring manually
 3. Compare with findStr
 4. If matched:
    increase count
 */


var str = "abcabcabc"

var findStr = "abc"

var count = 0

// Traverse string
for i in 0..<str.count {
    
    var temp = ""
    
    // Create substring manually
    for j in 0..<findStr.count {
        if i + j < str.count {
            let index = str.index(str.startIndex, offsetBy: i + j)
            temp += String(str[index])
        }
    }
    
    // Match found
    if temp == findStr {
        count += 1
    }
}

print(count)

// Output: 3


/*
 =====================================================
 Dry Run
 =====================================================

 abcabcabc

 i = 0
 temp = "abc"
 ✅ count = 1

 i = 1
 temp = "bca"
 ❌

 i = 2
 temp = "cab"
 ❌

 i = 3
 temp = "abc"
 ✅ count = 2

 i = 6
 temp = "abc"
 ✅ count = 3


 =====================================================
 Time Complexity
 =====================================================

 O(n * m)

 n = main string length
 m = substring length


 =====================================================
 Space Complexity
 =====================================================

 O(m)

 Because temporary substring is created
 */
