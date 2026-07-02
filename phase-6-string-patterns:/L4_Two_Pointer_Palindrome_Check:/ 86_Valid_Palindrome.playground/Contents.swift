import Foundation

// LeetCode 125 — Valid Palindrome | Easy | Two Pointers

// NOTE: Only keep letters & numbers, ignore case

// MARK: - Brute Force

// filter + reverse + compare

// Time: O(n) | Space: O(n)

// INTERVIEW: Start here, explain before coding
func isPalindromeBrute(_ s: String) -> Bool {
    
    var str = ""
    var reverstr = ""
    
    for ch in s.lowercased() {
        if ch.isLetter || ch.isNumber {
            str += "\(ch)"
        }
    }
    
    var i = str.count - 1
    
    while i >= 0 {
        let index = str.index(str.startIndex, offsetBy: i)
        reverstr += String(str[index])
        i -= 1
    }
    
    return str == reverstr
}

// MARK: - Optimal ⭐️ BEST
// two pointers, skip non-alphanumeric, capture char after skip

// Time: O(n) | Space: O(1)

// INTERVIEW: Interviewer expects this — no extra space

// INTERVIEW: Always capture char AFTER skip loop

// INTERVIEW: Array(s) avoids Swift index complexity

func isPalindromeOptimal(_ s: String) -> Bool {
    
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1
    
    while left < right {
        
        // skip non-alphanumeric
        while left < right && !chars[left].isLetter && !chars[left].isNumber {
            left += 1
        }
        
        while left < right && !chars[right].isLetter && !chars[right].isNumber {
            right -= 1
        }
        
        let leftChar = chars[left]    // capture AFTER skip
        let rightChar = chars[right]  // capture AFTER skip
        
        if leftChar.lowercased() != rightChar.lowercased() {
            return false
        }
        
        left += 1
        right -= 1
    }
    
    return true  // loop done = palindrome
}

// MARK: - Tests
let tests: [(String, Bool)] = [
    ("A man, a plan, a canal: Panama", true),
    ("race a car",                     false),
    (" ",                              true),
    ("a",                              true),
    ("ab",                             false)
]

print("--- Brute Force ---")

for (i, t) in tests.enumerated() {
    let r = isPalindromeBrute(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | \(t.0)")
}

print("\n--- Optimal ⭐️ ---")

for (i, t) in tests.enumerated() {
    let r = isPalindromeOptimal(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | \(t.0)")
}
