import UIKit

// MARK: - 01_Access_Character_At_Index

/*
 Problem:
 - Access character at given index

 Input:
 string = "Swift"
 index = 2

 Output:
 i
*/


// MARK: - Approach: String Index

/*
 Approach:
 - Swift strings do not support direct indexing
 - Convert integer index to String.Index
 - Access character using calculated position

 Time: O(n)
 Space: O(1)

 Interview:
 - Important Swift String concept
*/

var string = "Swift"

let index = 2

let position = string.index(string.startIndex, offsetBy: index)

print(string[position])


// T - O(n)
// S - O(1)
