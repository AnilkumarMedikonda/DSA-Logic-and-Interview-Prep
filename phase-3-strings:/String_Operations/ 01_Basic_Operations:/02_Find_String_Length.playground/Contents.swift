import UIKit

// MARK: - 02_Find_String_Length

/*
 Problem:
 - Find length of string without using built-in count

 Input:
 string = "Swift"

 Output:
 5
*/


// MARK: - Approach: String Traversal

/*
 Approach:
 - Traverse each character in string
 - Increase count for every character

 Time: O(n)
 Space: O(1)

 Interview:
 - Basic string traversal problem
*/

var str = "Swift"

var count = 0

for character in str {
    
    count += 1
    
    print(character, terminator: " ")
}

print(count)


// T - O(n)
// S - O(1)
