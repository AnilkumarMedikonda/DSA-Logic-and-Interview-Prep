import Foundation

// MARK: - Problem 79: Minimum Window With All Characters Of Pattern
/*
 Given string s and pattern p, find the smallest substring of s that
 contains all characters of p, including duplicates. Return "" if none.

 Example 1: s = "this is a test string", p = "tist" -> "t stri"
 Example 2: s = "geeksforgeeks", p = "ork"          -> "ksfor"

 Same core pattern as #78 (LC 76) — different platform (GFG), same problem.

 Rule: window's count >= required count for every character in p.
 Not == (too strict — harmless extras would fail),
 not >= 1 (too weak — misses duplicate requirements).
*/

var s = "this is a test string"
var p = "tist"

// MARK: - Brute Force
// T - O(n^2 * k)   S - O(n)

func isValidWindow(_ hashMap: [Character: Int], _ t: String) -> Bool {

    var tMap = [Character: Int]()

    for ch in t {
        if let count = tMap[ch] {
            tMap[ch] = count + 1
        } else {
            tMap[ch] = 1
        }
    }

    for (key, value) in tMap {
        if let hCount = hashMap[key] {
            if hCount < value {
                return false
            }
        } else {
            return false
        }
    }

    return true
}

func minWindow(_ s: String, _ p: String) -> String {

    let words = Array(s)
    var answer = ""
    var minLength = Int.max

    for i in 0..<words.count {

        var hashMap: [Character: Int] = [:]
        var str = ""

        for j in i..<words.count {
            let char = words[j]
            str += String(char)

            if let count = hashMap[char] {
                hashMap[char] = count + 1
            } else {
                hashMap[char] = 1
            }

            if isValidWindow(hashMap, p), str.count < minLength {
                minLength = str.count
                answer = str
                break
            }
        }
    }

    return answer
}

print("Brute Force:", minWindow(s, p))

// MARK: - Optimized (Sliding Window)
// T - O(n + m)   S - O(k)

func optmisedMinimWinwo(_ s: String, _ t: String) -> String {

    let words = Array(s)
    var left = 0
    var tMap = [Character: Int]()
    var sMap = [Character: Int]()

    for char in t {
        if let count = tMap[char] {
            tMap[char] = count + 1
        } else {
            tMap[char] = 1
        }
    }

    let required = tMap.count
    var formed = 0
    var minumLength = Int.max
    var minumWindow = ""

    for right in 0..<words.count {
        let char = words[right]

        if let count = sMap[char] {
            sMap[char] = count + 1
        } else {
            sMap[char] = 1
        }

        if let scount = sMap[char], let tcount = tMap[char], tcount == scount {
            formed += 1
        }

        while formed == required {
            let length = right - left + 1
            if length < minumLength {
                minumWindow = String(words[left...right])
                minumLength = length
            }

            let leftChar = words[left]
            if let count = sMap[leftChar] {
                sMap[leftChar] = count - 1
            } else {
                sMap[leftChar] = -1
            }

            if let scount = sMap[leftChar], let tcount = tMap[leftChar], scount < tcount {
                formed -= 1
            }
            left += 1
        }
    }
    return minumWindow
}

print("Optimized:  ", optmisedMinimWinwo(s, p))

// MARK: - Bugs Caught During Review
/*
 1. isValidWindow looped over hashMap (window) instead of tMap (requirement)
    -> extra unneeded characters triggered else { return false } wrongly.
    -> fix: loop over tMap only.

 2. Comparison was backwards: `value < tValue`
    -> fix: `hCount < value` — window's count less than required = invalid.

 3. Checked `count > 0` (just presence) — fails for duplicate chars in p.
    -> fix: compare window count >= required count via tMap frequency.

 4. `break` missing from brute force inner loop.
    -> fix: break immediately once valid window found for current i.
*/

// MARK: - Test Cases (Brute Force)
print("---- Brute Force ----")
print(minWindow("this is a test string", "tist"))   // "t stri"
print(minWindow("geeksforgeeks", "ork"))            // "ksfor"
print(minWindow("a", "a"))                          // "a"
print(minWindow("a", "aa"))                         // ""
print(minWindow("abc", "ac"))                       // "abc"
print(minWindow("abc", "xyz"))                      // ""

// MARK: - Test Cases (Optimized)
print("---- Optimized ----")
print(optmisedMinimWinwo("this is a test string", "tist"))   // "t stri"
print(optmisedMinimWinwo("geeksforgeeks", "ork"))            // "ksfor"
print(optmisedMinimWinwo("a", "a"))                          // "a"
print(optmisedMinimWinwo("a", "aa"))                         // ""
print(optmisedMinimWinwo("abc", "ac"))                       // "abc"
print(optmisedMinimWinwo("abc", "xyz"))                      // ""
