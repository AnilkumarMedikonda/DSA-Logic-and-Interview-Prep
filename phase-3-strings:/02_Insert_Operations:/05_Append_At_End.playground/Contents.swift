import UIKit


// MARK: - 05_Append_At_End

/*
 Problem:
 - Append string at end of existing string

 Input:
 string = "Swift"
 append = "UI"

 Output:
 SwiftUI
*/


// MARK: - Approach: Character Traversal

/*
 Approach:
 - Traverse append string
 - Add each character at end

 Time: O(n)
 Space: O(1)

 Interview:
 - Good practice for string traversal & append operations
*/

var str = "Swift"

for character in "UI" {
    str.append(character)
}

print(str)
// T - O(n)
// S - O(1)
