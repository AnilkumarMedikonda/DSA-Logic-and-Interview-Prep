import Foundation

//: 32_Group_Anagrams

// MARK: - Problem Statement
/*
 Given an array of strings,
 group all anagrams together.
 */

// MARK: - Important Note
/*
 Two strings are anagrams if:
 1. Both contain same characters.
 2. Character frequencies are same.
 3. Order can be different.
 */

// MARK: - Example
/*
 Input  :
 ["eat", "tea", "tan", "ate", "nat", "bat"]

 Output :
 [
   ["eat", "tea", "ate"],
   ["tan", "nat"],
   ["bat"]
 ]
 */


// MARK: - Brute Force Approach
/*
 1. Compare every string with remaining strings.
 2. Check whether both are anagrams.
 3. Group matching strings together.
 */

// MARK: - Brute Force Solution

var array = ["eat", "tea", "tan", "ate", "nat", "bat"]

var resultBruteForce: [[String]] = []

var visited = Array(repeating: false, count: array.count)

func isAnagram(_ str1: String, _ str2: String) -> Bool {

    if str1.count != str2.count {
        return false
    }

    var frequencyMap: [Character: Int] = [:]

    for ch in str1 {

        if let count = frequencyMap[ch] {
            frequencyMap[ch] = count + 1
        } else {
            frequencyMap[ch] = 1
        }
    }

    for ch in str2 {

        if let count = frequencyMap[ch] {
            frequencyMap[ch] = count - 1
        } else {
            return false
        }
    }

    for (_, value) in frequencyMap {

        if value != 0 {
            return false
        }
    }

    return true
}

for i in 0..<array.count {

    if visited[i] {
        continue
    }

    var group: [String] = [array[i]]

    visited[i] = true

    for j in i + 1..<array.count {

        if isAnagram(array[i], array[j]) {

            group.append(array[j])
            visited[j] = true
        }
    }

    resultBruteForce.append(group)
}

print("Brute Force :", resultBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Sort every word.
 2. Use sorted word as HashMap key.
 3. Group original words using same key.
 */

// MARK: - Optimized Solution

var groupMap: [String: [String]] = [:]

var resultOptimized: [[String]] = []

for word in array {

    let sortedWord = String(word.sorted())

    if let words = groupMap[sortedWord] {

        groupMap[sortedWord] = words + [word]

    } else {

        groupMap[sortedWord] = [word]
    }
}

for (_, value) in groupMap {
    resultOptimized.append(value)
}

print("Optimized :", resultOptimized)


// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. Single Word
    ["swift"]

 3. No Anagrams
    ["abc","def","ghi"]

 4. All Same Anagrams
    ["eat","tea","ate"]

 5. Mixed Length Strings
    ["ab","abc","bac"]
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n² * k)

 n = number of strings
 k = string length

 Space : O(n)

 Optimized (Best For Interview)
 Time  : O(n * k log k)

 n = number of strings
 k = string length

 Space : O(n)
 */
