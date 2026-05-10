import UIKit

// 08_Remove_At_Given_Index
/*
 =====================================================
 Method 1: Using Built-in remove(at:)
 =====================================================
 
 Problem:
 Remove character at given index.

 Input:
 str = "Swift"
 index = 1

 Output:
 "Sift"
 */

var str1 = "Swift"
var index1 = 1

var strIndex = str1.index(str1.startIndex, offsetBy: index1)

str1.remove(at: strIndex)

print("Method 1 Output:", str1)

/*
 Explanation:
 1. Convert integer index into String.Index
 2. Remove character using remove(at:)
 3. Print updated string

 Time Complexity:
 O(n)

 Space Complexity:
 O(1)
 */



/*
 =====================================================
 Method 2: Manual Method Without Built-in
 =====================================================
 */

var str2 = "Swift"
var removeIndex = 1

var result = ""
var currentIndex = 0

for char in str2 {
    
    if currentIndex != removeIndex {
        result += String(char)
    }
    
    currentIndex += 1
}

print("Method 2 Output:", result)

/*
 Explanation:
 1. Traverse each character
 2. Skip character at removeIndex
 3. Append remaining characters into result

 Dry Run:
 S -> add
 w -> skip
 i -> add
 f -> add
 t -> add

 Result:
 "Sift"

 Time Complexity:
 O(n)

 Space Complexity:
 O(n)
 */
