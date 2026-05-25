import Foundation

//: 26_Longest_Substring_With_At_Most_K_Distinct
// Pattern: Variable Size Sliding Window + HashMap

/*
==================================================
PROBLEM
==================================================
Given a string s and an integer k,
find the length of the longest substring
that contains at most k distinct characters.

==================================================
EXAMPLE
==================================================
Input:  s = "eceba", k = 2
Output: 3
Reason: "ece" → length = 3

==================================================
PATTERN
==================================================
Variable Size Sliding Window + HashMap
==================================================
*/

// MARK: - Brute Force O(n²)

let s = "eceba"
let k = 2
let words = Array(s)
var longestLength = 0

for i in 0..<words.count {

    var hashMap = [Character:Int]()
    var uniqueCount = 0

    for j in i..<words.count {

        let ch = words[j]

        if let count = hashMap[ch] {
            hashMap[ch] = count + 1
        } else {
            hashMap[ch] = 1
            uniqueCount += 1
        }

        if uniqueCount <= k {
            longestLength = max(longestLength, j - i + 1)
        } else {
            break
        }
    }
}

print(longestLength)

// MARK: - Optimized O(n)

var left = 0
var answer = 0
var hashMap = [Character:Int]()

for right in 0..<words.count {

    let ch = words[right]
    hashMap[ch, default: 0] += 1

    while hashMap.count > k {
        let leftChar = words[left]
        hashMap[leftChar, default: 0] -= 1
        if hashMap[leftChar] == 0 {
            hashMap.removeValue(forKey: leftChar)
        }
        left += 1
    }

    answer = max(answer, right - left + 1)
}

print(answer)

/*
==================================================
DRY RUN
==================================================
s = "eceba", k = 2

right=0 → {e:1}         → distinct=1 → answer=1
right=1 → {e:1,c:1}     → distinct=2 → answer=2
right=2 → {e:2,c:1}     → distinct=2 → answer=3 ✅
right=3 → {e:2,c:1,b:1} → distinct=3 > k → shrink
        → remove e,c    → {e:1,b:1}  → left=2 → answer=3
right=4 → {e:1,b:1,a:1} → distinct=3 > k → shrink
        → remove e      → {b:1,a:1}  → left=3 → answer=3

Final Answer: 3

==================================================
MAIN IDEA
==================================================
Expand  → move right pointer
Invalid → distinct > k → shrink from left
Update  → max(answer, right - left + 1)

==================================================
COMPLEXITY
==================================================
Brute Force → Time: O(n²)  Space: O(k)
Optimized   → Time: O(n)   Space: O(k)

==================================================
KEY DIFFERENCE FROM PROBLEM 25
==================================================
Problem 25 → No repeating → shrink when hashMap[ch] > 1
Problem 26 → K distinct   → shrink when hashMap.count > k

==================================================
MEMORY TRICK
==================================================
distinct <= k → Expand
distinct >  k → Shrink
Longest       → Update Maximum

==================================================
INTERVIEW IMPORTANCE
==================================================
Difficulty : Medium
Priority   : ⭐⭐⭐⭐⭐
Must Practice 4-5 Times
==================================================
*/
