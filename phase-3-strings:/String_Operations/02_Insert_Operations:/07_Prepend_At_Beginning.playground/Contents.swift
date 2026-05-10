import UIKit

// 07_Prepend_At_Beginnin

/*
 Problem:
 Prepend a character/string at the beginning manually.

 Input:
 str = "ift"
 prepender = "S"

 Output:
 "Sift"
 */

var str = "ift"
var prepender = "S"

for char in prepender {
    str = "\(char)" + str
}
print(str)

/*
 Explanation:
 1. Loop through prepend string
 2. Add each character before existing string
 3. Store updated value back into str

 Dry Run:
 Initial -> "ift"

 char = "S"
 "S" + "ift" = "Sift"

 Final Output -> "Sift"
 */

/*
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)
 */
