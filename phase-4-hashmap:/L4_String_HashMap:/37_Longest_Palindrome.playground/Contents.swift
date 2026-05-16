import Foundation

//: 37_Longest_Palindrome


// MARK: - Problem Statement
/*
 Given a string,
 find the longest
 palindromic substring.
 */

// MARK: - Important Note
/*
 Palindrome means:
 string reads same
 forward and backward.
 */

// MARK: - Example
/*
 Input  :
 "babad"

 Output :
 "bab"

 or

 "aba"
 */


// MARK: - Brute Force Approach
/*
 1. Generate all substrings.
 2. Check whether substring
    is palindrome.
 3. Store longest palindrome.
 */

// MARK: - Brute Force Solution

var str = "babad"

var longestPalindromeBruteForce = ""


func isPalindrome(_ s: String) -> Bool {

    if s.count == 1 {
        return true
    }

    var left = 0
    var right = s.count - 1


    while left < right {

        let leftIndex = s.index(s.startIndex, offsetBy: left)
        let rightIndex = s.index(s.startIndex, offsetBy: right)


        if s[leftIndex] != s[rightIndex] {
            return false
        }

        left += 1
        right -= 1
    }

    return true
}


for i in 0..<str.count {

    var currentSubstring = ""


    for j in i..<str.count {

        let index = str.index(str.startIndex, offsetBy: j)

        currentSubstring += String(str[index])


        if isPalindrome(currentSubstring) {

            if currentSubstring.count > longestPalindromeBruteForce.count {

                longestPalindromeBruteForce = currentSubstring
            }
        }
    }
}

print("Brute Force :", longestPalindromeBruteForce)


// MARK: - Optimized Approach
/*
 Center Expansion Technique

 1. Every character can act as center.
 2. Expand left & right while characters match.
 3. Track longest palindrome.
 */

// MARK: - Optimized Solution

var longestPalindromeOptimized = ""

let chars = Array(str)


@MainActor
func expandAroundCenter(_ left: Int, _ right: Int) {

    var leftPointer = left
    var rightPointer = right


    while leftPointer >= 0,
          rightPointer < chars.count,
          chars[leftPointer] == chars[rightPointer] {

        let palindrome = String(chars[leftPointer...rightPointer])


        if palindrome.count > longestPalindromeOptimized.count {

            longestPalindromeOptimized = palindrome
        }

        leftPointer -= 1
        rightPointer += 1
    }
}


for i in 0..<chars.count {

    // Odd Length Palindrome
    expandAroundCenter(i, i)

    // Even Length Palindrome
    expandAroundCenter(i, i + 1)
}

print("Optimized :", longestPalindromeOptimized)


// MARK: - Step By Step Logic
/*
 Example:
 "babad"

 chars:
 [b, a, b, a, d]

 i = 1

 Odd Expansion:
 left = 1
 right = 1

 a == a
 palindrome = "a"

 Expand:
 left = 0
 right = 2

 b == b
 palindrome = "bab"

 Expand:
 left = -1
 right = 3

 Stop

 Longest = "bab"
 */


// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. Single Character
    "a"

 3. Entire String Palindrome
    "racecar"

 4. Multiple Palindromes
    "babad"

 5. Even Length Palindrome
    "cbbd"
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n³)
 Space : O(1)

 Optimized (Best For Interview)
 Time  : O(n²)
 Space : O(1)
 */
