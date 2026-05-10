import UIKit

// 25_Split_By_Delimiter

var str = "apple,banana,mango"
//

// =====================================================
// Method 2:
// Manual Traversal
// (Best Interview Approach)
// =====================================================

var str2 = "apple,banana,mango"

var twoArray = [String]()

var result = ""


// Traverse string
for char in str2 {
    
    // Delimiter found
    if "\(char)" == "," {
        
        twoArray.append(result)
        
        result = ""
        
    } else {
        
        result += "\(char)"
    }
}


// Append last word
twoArray.append(result)

print(twoArray)

// Output:
// ["apple", "banana", "mango"]


/*
 =====================================================
 Dry Run
 =====================================================

 apple,banana,mango

 Build:
 "apple"

 "," found
 append:
 ["apple"]

 Reset:
 ""

 Build:
 "banana"

 "," found
 append:
 ["apple", "banana"]

 Build:
 "mango"

 Append last word


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result array used


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Manual parsing
 ✅ Delimiter handling
 ✅ Traversal logic
 ✅ No predefined split function
 */
