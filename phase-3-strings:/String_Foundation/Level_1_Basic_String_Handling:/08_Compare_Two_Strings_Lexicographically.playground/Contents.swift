import UIKit

// 08_Compare_Two_Strings_Lexicographically

var str1 = "cat"

var str2 = "car"

var result = ""


// Traverse strings
for i in 0..<str1.count {
    
    let index1 = str1.index(str1.startIndex,
                            offsetBy: i)
    
    let index2 = str2.index(str2.startIndex,
                            offsetBy: i)
    
    
    let str1AsciiValue = str1[index1].asciiValue!
    
    let str2AsciiValue = str2[index2].asciiValue!
    
    
    // Compare ASCII values
    if str1AsciiValue > str2AsciiValue {
        
        result = "\(str1) > \(str2)"
        
        break
        
    } else if str2AsciiValue > str1AsciiValue {
        
        result = "\(str2) > \(str1)"
        
        break
    }
}


// Equal strings
if result == "" {
    
    result = "Both Strings Equal"
}

print(result)

// Output:
// cat > car



/*
 =====================================================
 Dry Run
 =====================================================

 str1 = "cat"
 str2 = "car"


 c == c

 a == a

 t -> 116
 r -> 114


 116 > 114


 Result:
 cat > car


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = minimum string length


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Compare both strings
 character by character.

 First mismatch decides:
 greater or smaller string.
 */
