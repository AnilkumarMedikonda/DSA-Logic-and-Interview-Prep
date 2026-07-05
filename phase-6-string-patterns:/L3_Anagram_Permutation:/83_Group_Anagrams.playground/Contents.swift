import UIKit

// MARK: - Problem
// 83. Group Anagrams (LeetCode 49)
// Group all anagrams together. Anagrams = same chars, same counts.
// ["eat","tea","tan","ate","nat","bat"] -> [["eat","tea","ate"],["tan","nat"],["bat"]]
// Pattern: HASHING / GROUPING — not sliding window.

// MARK: - Brute Force
// Compare each ungrouped string's frequency map with every later
// ungrouped string. visited prevents duplicate groups.
// T: O(n² * k)   S: O(n + k)
func groupAnagramsBruteForce(_ strs: [String]) -> [[String]] {

    var groups = [[String]]()
    var visited = [Bool](repeating: false, count: strs.count)

    for i in 0..<strs.count {

        if visited[i] { continue }

        var iMap = [Character: Int]()
        for char in strs[i] {
            if let count = iMap[char] {
                iMap[char] = count + 1
            } else {
                iMap[char] = 1
            }
        }

        var group = [String]()

        for j in i..<strs.count {

            if visited[j] { continue }

            var jMap = [Character: Int]()
            for char in strs[j] {
                if let count = jMap[char] {
                    jMap[char] = count + 1
                } else {
                    jMap[char] = 1
                }
            }

            if jMap == iMap {
                group.append(strs[j])
                visited[j] = true
            }
        }

        groups.append(group)
    }

    return groups
}

// MARK: - Optimised (Frequency Signature)
// Every anagram produces the same signature ("eat" -> "a1e1t1").
// Use it as a dictionary key — the dictionary does the grouping.
// T: O(n * k)   S: O(n * k)


func groupAnagramsOptimised(_ strs: [String]) -> [[String]] {

    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    var groups = [String: [String]]()   // signature -> words

    for word in strs {

        // 1. Frequency map
        var charMap = [Character: Int]()
        for char in word {
            if let count = charMap[char] {
                charMap[char] = count + 1
            } else {
                charMap[char] = 1
            }
        }

        // 2. Signature in FIXED a-z order (dictionary order is random)
        var signature = ""
        for letter in alphabet {
            if let count = charMap[letter] {
                signature += "\(letter)\(count)"
            }
        }

        // 3. Append word to its group
        if var existingGroup = groups[signature] {
            existingGroup.append(word)
            groups[signature] = existingGroup
        } else {
            groups[signature] = [word]
        }
    }

    // 4. Collect groups
    var result = [[String]]()
    for (_, group) in groups {
        result.append(group)
    }
    return result
}

// MARK: - Dry Run
// eat -> a1e1t1 | tea -> a1e1t1 | tan -> a1n1t1
// ate -> a1e1t1 | nat -> a1n1t1 | bat -> a1b1t1
// [a1e1t1: [eat,tea,ate]] [a1n1t1: [tan,nat]] [a1b1t1: [bat]]

// MARK: - Traps
// 1. Build signature by walking a-z, NEVER by iterating charMap —
//    Swift dictionary order is random, "e1a1t1" != "a1e1t1".
// 2. Counts belong in the key: "aab" -> a2b1, "abb" -> a1b2.
// 3. Brute force: visited array + outer skip + inner loop from i.

// MARK: - Tests
let input = ["eat", "tea", "tan", "ate", "nat", "bat"]

print(groupAnagramsBruteForce(input))
// [["eat","tea","ate"], ["tan","nat"], ["bat"]]

print(groupAnagramsOptimised(input))
// same groups, order may vary

print(groupAnagramsOptimised([""]))            // [[""]]
print(groupAnagramsOptimised(["a"]))           // [["a"]]
print(groupAnagramsOptimised(["aab", "abb"]))  // [["aab"], ["abb"]]
