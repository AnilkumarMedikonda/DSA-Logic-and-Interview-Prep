import Foundation

// MARK: - Problem 78 (LC 76): Minimum Window Substring
/*
 Find the smallest substring of s that contains every character of t,
 including duplicates. Return "" if no such window exists.

 Example: s = "ADOBECODEBANC", t = "ABC" -> "BANC"
 Example: s = "a", t = "aa" -> ""
*/

var s = "ADOBECODEBANC"
var target = "ABC"

// MARK: - Brute Force
// T - O(n^2 * k)   S - O(n)

func isValidWindow(_ hashMap: [Character: Int], _ t: String) -> Bool {

    var tMap: [Character: Int] = [:]
    for char in t {
        if let count = tMap[char] {
            tMap[char] = count + 1
        } else {
            tMap[char] = 1
        }
    }

    for (char, count) in tMap {
        if let hCount = hashMap[char] {
            if hCount < count {
                return false
            }
        } else {
            return false
        }
    }
    return true
}

func minmumWindowSubstring(_ s: String, _ t: String) -> String {

    let words = Array(s)
    var minumWindow = ""
    var minumLength = Int.max

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

            if isValidWindow(hashMap, t), str.count < minumLength {
                minumWindow = str
                minumLength = str.count
                break
            }
        }
    }
    return minumWindow
}

print("Brute Force:", minmumWindowSubstring(s, target))

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

print("Optimized:  ", optmisedMinimWinwo(s, target))

// MARK: - Bugs Caught During Review
/*
 1. Decremented tMap instead of sMap on shrink -> fix: only sMap changes,
    tMap is the fixed target and never changes.
 2. Had `tcount < scount` for formed -= 1 -> backwards, fixed to
    `scount < tcount` (drop below requirement, not above).
 3. isValidWindow originally checked `count > 0` instead of per-char
    frequency -> failed on duplicate chars in t (e.g. "aab").
*/

// MARK: - Test Cases
print("---- Test Cases ----")
print(optmisedMinimWinwo("ADOBECODEBANC", "ABC"))      // "BANC"
print(optmisedMinimWinwo("a", "a"))                    // "a"
print(optmisedMinimWinwo("a", "aa"))                   // ""
print(optmisedMinimWinwo("aa", "aa"))                  // "aa"
print(optmisedMinimWinwo("bba", "ab"))                 // "ba"
print(optmisedMinimWinwo("cabwefgewcwaefgcf", "cae"))  // "cwae"
print(optmisedMinimWinwo("ab", "b"))                   // "b"
print(optmisedMinimWinwo("abc", "xyz"))                // ""

// MARK: - Test Cases (Brute Force)
print("---- Test Cases (Brute Force) ----")
print(minmumWindowSubstring("ADOBECODEBANC", "ABC"))      // "BANC"
print(minmumWindowSubstring("a", "a"))                    // "a"
print(minmumWindowSubstring("a", "aa"))                   // ""
print(minmumWindowSubstring("aa", "aa"))                  // "aa"
print(minmumWindowSubstring("bba", "ab"))                 // "ba"
print(minmumWindowSubstring("cabwefgewcwaefgcf", "cae"))  // "cwae"
print(minmumWindowSubstring("ab", "b"))                   // "b"
print(minmumWindowSubstring("abc", "xyz"))                // ""
