// MARK: - Problem
// LeetCode 3 — Longest Substring Without Repeating Characters
// Find the length of the longest substring with no repeating characters.
// "abcabcbb" -> 3 ("abc")


// MARK: - Interview Q&A
// Q1. Why sliding window? -> "longest substring" + constraint violated by adding chars
// Q2. Why dictionary over Set? -> jump left directly to duplicateIndex+1, O(1) instead of shrinking one at a time
// Q3. Why check index >= left? -> ignore stale duplicates that already fell outside the window
// Q4. Why lastIndex + 1, not lastIndex? -> lastIndex itself is the duplicate, must start window after it


// MARK: - Brute Force
// T - O(n^2)  S - O(n)

func lengthOfLongestSubstring(_ s: String) -> Int {

    var words = Array(s)
    var maxLength = 0

    for i in 0..<words.count {

        var str = ""
        var hashMap = [Character: Int]()

        for j in i..<words.count {
            let ch = words[j]
            str += String(words[j])

            if let count = hashMap[ch] {
                hashMap[ch] = count + 1
            } else {
                hashMap[ch] = 1
            }

            if hashMap.count == str.count {
                maxLength = max(maxLength, str.count)
            }
        }
    }

    return maxLength
}


// MARK: - Optimised
// T - O(n)  S - O(n)

func longestSubstringOptimised(_ s: String) -> Int {

    var left = 0
    var maxLength = 0
    var words = Array(s)
    var lastSeen = [Character: Int]()

    for right in 0..<words.count {
        let ch = words[right]

        if let index = lastSeen[ch], index + 1 > left {
            left = index + 1
        }
        lastSeen[ch] = right
        maxLength = max(maxLength, right - left + 1)
    }

    return maxLength
}


// MARK: - Dry Run

// "dvdf"

// right=0 d: left=0, map={d:0}, len=1, max=1

// right=1 v: left=0, map={d:0,v:1}, len=2, max=2

// right=2 d: dup at 0, left=1, map={d:2,v:1}, len=2, max=2

// right=3 f: left=1, map={d:2,v:1,f:3}, len=3, max=3

// answer = 3


// MARK: - Complexity
// Brute Force: O(n^2) time, O(n) space
// Optimised:   O(n) time, O(n) space


// MARK: - Traps
// 1. Forgetting index >= left check -> shrinks window on stale duplicates already outside it

// 2. Using lastIndex instead of lastIndex+1 -> window still contains the duplicate

// 3. Not updating lastSeen[ch] on every visit -> later checks use stale index

// 4. Force unwrapping map[ch]! -> crashes on first lookup, use if let


// MARK: - Tests

print(longestSubstringOptimised("abcabcbb"))  // 3
print(longestSubstringOptimised("bbbbb"))     // 1
print(longestSubstringOptimised("pwwkew"))    // 3
print(longestSubstringOptimised("abba"))      // 2
print(longestSubstringOptimised("dvdf"))      // 3
print(longestSubstringOptimised(""))          // 0
print(longestSubstringOptimised("a"))         // 1
