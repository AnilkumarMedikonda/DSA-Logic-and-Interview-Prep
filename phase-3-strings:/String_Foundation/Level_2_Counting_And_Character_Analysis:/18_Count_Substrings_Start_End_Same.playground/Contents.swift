import UIKit

var str = "abcab"


// 18_Count_Substrings_Start_End_Same


var count = 0


// Traverse starting index
for i in 0..<str.count {
    
    // Traverse ending index
    for j in i..<str.count {
        
        let startIndex = str.index(str.startIndex,
                                   offsetBy: i)
        let endIndex = str.index(str.startIndex,
                                 offsetBy: j)
        // Check first and last character
        if str[startIndex] == str[endIndex] {
            count += 1
        }
    }
}

print(count)

// Output:
// 7



/*
 =====================================================
 Valid Substrings
 =====================================================

 a
 b
 c
 a
 b
 abca
 bcab


 Total:
 7



 =====================================================
 Dry Run
 =====================================================

 "abcab"


 i = 0

 a == a -> count = 1

 a != b

 a != c

 a == a -> count = 2

 a != b



 i = 1

 b == b -> count = 3

 b != c

 b != a

 b == b -> count = 4



 i = 2

 c == c -> count = 5



 i = 3

 a == a -> count = 6



 i = 4

 b == b -> count = 7



 =====================================================
 Time Complexity
 =====================================================

 O(n²)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Use nested loops.

 i -> starting index
 j -> ending index

 If:
 first character == last character

 then:
 valid substring found.
 */
