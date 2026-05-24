import Foundation

//: 21_Find_All_Anagrams_In_A_String
// Pattern: Fixed Size Sliding Window + Frequency Map

/*
 Problem:

 Given two strings s and p,
 return all starting indices of p's anagrams in s.

 Example:

 s = "cbaebabacd"
 p = "abc"

 Output:

 [0, 6]
 */


// MARK: - Brute Force

func isAnagram(_ word: String, _ p: String) -> Bool {

    var map = [Character:Int]()

    for ch in word {

        if let count = map[ch] {
            map[ch] = count + 1
        } else {
            map[ch] = 1
        }
    }

    for ch in p {

        if let count = map[ch] {
            map[ch] = count - 1
        } else {
            return false
        }
    }

    for (_, value) in map {

        if value != 0 {
            return false
        }
    }

    return true
}

func findAnagramsBruteForce(_ s: String, _ p: String) -> [Int] {

    let words = Array(s)

    var result = [Int]()

    for i in 0...(words.count - p.count) {

        var currentWord = ""

        for j in i..<(i + p.count) {
            currentWord += String(words[j])
        }

        if isAnagram(currentWord, p) {
            result.append(i)
        }
    }

    return result
}

/*
 Time  : O(n * k)
 Space : O(k)
 */


// MARK: - Optimized (Interview Preferred)

func findAnagrams(_ s: String, _ p: String) -> [Int] {

    let sChars = Array(s)
    let pChars = Array(p)

    let windowSize = pChars.count

    if sChars.count < windowSize {
        return []
    }

    var result = [Int]()

    var pMap = [Character:Int]()
    var windowMap = [Character:Int]()

    // Build pMap
    for ch in pChars {

        if let count = pMap[ch] {
            pMap[ch] = count + 1
        } else {
            pMap[ch] = 1
        }
    }

    // First Window
    for i in 0..<windowSize {

        let ch = sChars[i]

        if let count = windowMap[ch] {
            windowMap[ch] = count + 1
        } else {
            windowMap[ch] = 1
        }
    }

    if windowMap == pMap {
        result.append(0)
    }

    // Slide Window
    for right in windowSize..<sChars.count {

        let outgoing = sChars[right - windowSize]
        let incoming = sChars[right]

        // Remove outgoing
        if let count = windowMap[outgoing] {

            windowMap[outgoing] = count - 1

            if windowMap[outgoing] == 0 {
                windowMap.removeValue(forKey: outgoing)
            }
        }

        // Add incoming
        if let count = windowMap[incoming] {
            windowMap[incoming] = count + 1
        } else {
            windowMap[incoming] = 1
        }

        if windowMap == pMap {
            result.append(right - windowSize + 1)
        }
    }

    return result
}

/*
 Time  : O(n)
 Space : O(k)

 Maintain:
 pMap
 windowMap

 Slide Window:
 - outgoing
 + incoming
 */


// MARK: - Test

let s = "cbaebabacd"
let p = "abc"

print(findAnagramsBruteForce(s, p))
print(findAnagrams(s, p))


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

Generate every substring
of length p.count

Check if substring
is an anagram

Store starting index

Time  : O(n * k)
Space : O(k)

--------------------------------------------------

Optimized (Interview Preferred)

Build:

pMap
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

windowMap == pMap

Store starting index

result.append(index)

--------------------------------------------------

Time  : O(n)
Space : O(k)

==================================================
RECOGNITION
==================================================

✓ Anagram

✓ Permutation

✓ Fixed Length Substring

✓ Character Frequency

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
*/
