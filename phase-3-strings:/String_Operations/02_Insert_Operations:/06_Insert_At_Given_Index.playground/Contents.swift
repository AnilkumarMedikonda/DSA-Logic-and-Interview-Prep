import UIKit


// MARK: - 06_Insert_At_Given_Index

/*
 Problem:
 - Insert character at given index

 Input:
 string = "Sift"
 insert = "w"
 index = 1

 Output:
 Swift
*/


// MARK: - Approach: String Index

/*
 Approach:
 - Convert integer index to String.Index
 - Insert character using insert()

 Time: O(n)
 Space: O(1)

 Interview:
 - Important Swift string indexing problem
*/

var str = "Sift"

let insertCharacter: Character = "w"

let index = 1

let position = str.index(str.startIndex, offsetBy: index)

str.insert(insertCharacter, at: position)

print(str)


// T - O(n)
// S - O(1)
