import Foundation

//: 22_Permutation_In_String
// Pattern: Fixed Size Sliding Window + Frequency Map

/*
 Problem:

 Given two strings s1 and s2,
 return true if s2 contains a permutation of s1.

 Otherwise return false.

 Example:

 s1 = "ab"
 s2 = "eidbaooo"

 Output:

 true

 Reason:

 "ba" is a permutation of "ab"
 */


// MARK: - Brute Force

func isAnagram(_ s: String, _ p: String) -> Bool {

    if s.count != p.count {
        return false
    }

    var sMap = [Character:Int]()
    var pMap = [Character:Int]()

    for ch in s {

        if let count = sMap[ch] {
            sMap[ch] = count + 1
        } else {
            sMap[ch] = 1
        }
    }

    for ch in p {

        if let count = pMap[ch] {
            pMap[ch] = count + 1
        } else {
            pMap[ch] = 1
        }
    }

    return sMap == pMap
}

func checkInclusionBruteForce(_ s1: String, _ s2: String) -> Bool {

    let chars = Array(s2)

    for start in 0...(chars.count - s1.count) {

        var word = ""

        for end in start..<(start + s1.count) {
            word += String(chars[end])
        }

        if isAnagram(word, s1) {
            return true
        }
    }

    return false
}

/*
 Time  : O(n * k)
 Space : O(k)
 */


// MARK: - Optimized (Interview Preferred)

func checkInclusion(_ s1: String, _ s2: String) -> Bool {

    let pattern = Array(s1)
    let chars = Array(s2)

    let windowSize = pattern.count

    if chars.count < windowSize {
        return false
    }

    var patternMap = [Character:Int]()
    var windowMap = [Character:Int]()

    // Build Pattern Map
    for ch in pattern {

        if let count = patternMap[ch] {
            patternMap[ch] = count + 1
        } else {
            patternMap[ch] = 1
        }
    }

    // First Window
    for i in 0..<windowSize {

        let ch = chars[i]

        if let count = windowMap[ch] {
            windowMap[ch] = count + 1
        } else {
            windowMap[ch] = 1
        }
    }

    if windowMap == patternMap {
        return true
    }

    // Slide Window
    for right in windowSize..<chars.count {

        let incoming = chars[right]
        let outgoing = chars[right - windowSize]

        // Remove Outgoing
        if let count = windowMap[outgoing] {

            windowMap[outgoing] = count - 1

            if windowMap[outgoing] == 0 {
                windowMap.removeValue(forKey: outgoing)
            }
        }

        // Add Incoming
        if let count = windowMap[incoming] {
            windowMap[incoming] = count + 1
        } else {
            windowMap[incoming] = 1
        }

        if windowMap == patternMap {
            return true
        }
    }

    return false
}

/*
 Time  : O(n)
 Space : O(k)

 Maintain:

 patternMap
 windowMap

 Slide Window:

 - outgoing
 + incoming
 */


// MARK: - Test

let s1 = "ab"
let s2 = "eidbaooo"

print(checkInclusionBruteForce(s1, s2))
print(checkInclusion(s1, s2))


/*
==================================================
QUICK INTERVIEW NOTE
==================================================

Pattern:

Fixed Size Sliding Window
+
Frequency Map

--------------------------------------------------

Brute Force

Generate every window
of size s1.count

Check if window
is an anagram of s1

If found:
return true

Time  : O(n * k)
Space : O(k)

--------------------------------------------------

Optimized (Interview Preferred)

Build:

patternMap
windowMap

Build first window

Compare maps

--------------------------------------------------

Slide Window

Remove outgoing character

windowMap[outgoing] -= 1

If count becomes 0:
remove key

--------------------------------------------------

Add incoming character

windowMap[incoming] += 1

--------------------------------------------------

If:

windowMap == patternMap

return true

--------------------------------------------------

Time  : O(n)
Space : O(k)

==================================================
RECOGNITION
==================================================

✓ Permutation

✓ Anagram

✓ Fixed Length Substring

✓ Character Frequency Match

Think:

Sliding Window + Frequency Map

==================================================
INTERVIEW PREFERENCE
==================================================

Brute Force:
O(n * k)

Optimized:
O(n)

✓ Very Frequently Asked
✓ Must Practice Multiple Times

==================================================
MEMORY TRICK
==================================================

Question 21:

Return all indices

--------------------------------------------------

Question 22:

Return true / false

--------------------------------------------------

Same Pattern:

Pattern Map

Window Map

Slide Window

Compare Maps

==================================================
*/
