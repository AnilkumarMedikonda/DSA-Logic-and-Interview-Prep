import UIKit

// 03_Traverse_String


// MARK: - 03_Traverse_String

/*
 Problem:
 - Traverse and print all characters in string

 Input:
 string = "Swift"

 Output:
 S w i f t
*/


// MARK: - Approach: For-In Loop

/*
 Approach:
 - Traverse string using for-in loop
 - Print each character

 Time: O(n)
 Space: O(1)

 Interview:
 - Basic string traversal concept
*/

var str = "Swift"

for character in str {
    
    print(character, terminator: " ")
}


// T - O(n)
// S - O(1)
