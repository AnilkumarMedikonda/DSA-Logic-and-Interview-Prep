import UIKit

/*
 ===========================================================
 LeetCode 796 - Rotate String
 ===========================================================

 Problem:
 Given two strings s and goal,
 return true if goal can be obtained by rotating s.

 Example

 s = "abcde"
 goal = "cdeab"

 Output

 true

 ===========================================================

 LEFT ROTATION

 abcde

 ↓

 bcdea

 ↓

 cdeab

 ↓

 deabc

 ↓

 eabcd

 ===========================================================

 APPROACH 1 - Brute Force

 1. Rotate string one time.
 2. Compare with goal.
 3. Repeat n times.

 Time  : O(n²)

 Space : O(n)

 ===========================================================

 APPROACH 2 - Optimal

 Observation

 Every rotation of s exists inside

 s + s

 Example

 s

 abcde

 s + s

 abcdeabcde

 Rotations

 abcde
 bcdea
 cdeab
 deabc
 eabcd

 Search goal inside s+s.

 Time  : O(n)

 ===========================================================
*/

// MARK: - Compare Two Arrays

func isEqual(_ first: [Character], _ second: [Character]) -> Bool {

    if first.count != second.count {
        return false
    }

    for i in 0..<first.count {

        if first[i] != second[i] {
            return false
        }
    }

    return true
}

// MARK: ====================================================
// MARK: Brute Force
// MARK: ====================================================

func rotateStringBruteForce(_ s: String, _ goal: String) -> Bool {

    if s.count != goal.count {
        return false
    }

    var chars = Array(s)
    let target = Array(goal)

    for _ in 0..<chars.count {

        // Compare current rotation
        if isEqual(chars, target) {
            return true
        }

        // Save first character
        let first = chars[0]

        // Shift every character left
        for i in 0..<chars.count - 1 {
            chars[i] = chars[i + 1]
        }

        // Put first character at end
        chars[chars.count - 1] = first
    }

    return false
}

// MARK: ====================================================
// MARK: Optimal
// MARK: ====================================================

func rotateStringOptimal(_ s: String,_ goal: String) -> Bool {

    if s.count != goal.count {
        return false
    }

    let doubled = s + s

    return doubled.contains(goal)
}

// MARK: ====================================================
// MARK: Test Cases
// MARK: ====================================================

print("Brute Force")
print(rotateStringBruteForce("abcde", "cdeab"))
print(rotateStringBruteForce("abcde", "abced"))
print(rotateStringBruteForce("aaaa", "aaaa"))
print(rotateStringBruteForce("abc", "cab"))

print("----------------------")

print("Optimal")
print(rotateStringOptimal("abcde", "cdeab"))
print(rotateStringOptimal("abcde", "abced"))
print(rotateStringOptimal("aaaa", "aaaa"))
print(rotateStringOptimal("abc", "cab"))
