import Foundation

//: 27_Fruits_Into_Baskets
// Pattern: Variable Size Sliding Window + HashMap

/*
==================================================
PROBLEM
==================================================
You have a row of fruit trees.
Each tree produces one type of fruit.
You have 2 baskets, each holds only one type.
Return the maximum number of fruits you can pick.

==================================================
EXAMPLE
==================================================
Input:  trees = [1, 2, 1, 2, 3], k = 2
Output: 4
Reason: [1, 2, 1, 2] → length = 4

==================================================
KEY INSIGHT
==================================================
This is exactly Problem 26 with k = 2 hardcoded!

Problem 26 → k distinct chars in string
Problem 27 → 2 distinct fruits in array

==================================================
PATTERN
==================================================
Variable Size Sliding Window + HashMap
==================================================
*/

// MARK: - Brute Force O(n²)

var trees = [1, 2, 1, 2, 3]
var k = 2
var maximumFruits = 0

for i in 0..<trees.count {

    var frequency: [Int: Int] = [:]
    var uniqueCount = 0

    for j in i..<trees.count {

        let tree = trees[j]

        if let count = frequency[tree] {
            frequency[tree] = count + 1
        } else {
            frequency[tree] = 1
            uniqueCount += 1
        }

        if uniqueCount <= k {
            maximumFruits = max(maximumFruits, j - i + 1)
        } else {
            break
        }
    }
}

print(maximumFruits)

// Time  : O(n²)
// Space : O(k)

// MARK: - Optimized O(n)

var left = 0
var answer = 0
var frequency: [Int: Int] = [:]

for right in 0..<trees.count {

    let tree = trees[right]
    frequency[tree, default: 0] += 1

    while frequency.count > k {
        let leftTree = trees[left]
        frequency[leftTree, default: 0] -= 1
        if frequency[leftTree] == 0 {
            frequency.removeValue(forKey: leftTree)
        }
        left += 1
    }

    answer = max(answer, right - left + 1)
}

print(answer)

// Time  : O(n)
// Space : O(k)

/*
==================================================
DRY RUN
==================================================
trees = [1, 2, 1, 2, 3], k = 2

right=0 → {1:1}         → distinct=1 → answer=1
right=1 → {1:1, 2:1}    → distinct=2 → answer=2
right=2 → {1:2, 2:1}    → distinct=2 → answer=3
right=3 → {1:2, 2:2}    → distinct=2 → answer=4 ✅
right=4 → {1:2, 2:2, 3:1} → distinct=3 > k → shrink
        → remove 1 → {1:1, 2:2, 3:1} → still 3 > k
        → remove 2 → {2:1, 3:1}      → distinct=2 ✅
        → left=2 → answer=4

Final Answer: 4

==================================================
MAIN IDEA
==================================================
Expand  → move right pointer
Invalid → frequency.count > k → shrink from left
Update  → max(answer, right - left + 1)

==================================================
COMPLEXITY
==================================================
Brute Force → Time: O(n²)  Space: O(k)
Optimized   → Time: O(n)   Space: O(k)

==================================================
KEY DIFFERENCE FROM PROBLEM 26
==================================================
Problem 26 → String  → [Character: Int]  → k given
Problem 27 → Array   → [Int: Int]        → k = 2

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
