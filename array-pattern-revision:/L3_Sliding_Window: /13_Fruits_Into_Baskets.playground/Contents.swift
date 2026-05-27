import Foundation

// ──────────────────────────────────────────
// LeetCode 904 — Fruits Into Baskets
// Difficulty: Medium  |  Pattern: Sliding Window
// Same as: Longest Substring With At Most K Distinct (k = 2)
// ──────────────────────────────────────────

// MARK: - Problem

/*
 You have a row of fruit trees. You have 2 baskets, each holds
 only one fruit type. Pick fruits continuously — stop when you
 need a 3rd type. Return maximum fruits you can pick.

 Input:  [1, 2, 1]
 Output: 3  →  pick all

 Input:  [0, 1, 2, 2]
 Output: 3  →  [1, 2, 2]

 Input:  [1, 2, 3, 2, 2]
 Output: 4  →  [2, 3, 2, 2]

 Key insight:
 2 baskets = at most 2 distinct fruit types = k = 2
 Exactly same as Problem 12 with k hardcoded to 2
*/

// MARK: - Interview Q&A

/*
 Q: How is this different from Problem 12?
 A: Same problem — k = 2 hardcoded instead of variable

 Q: How do you track fruit types in window?
 A: HashMap — key is fruit type, value is count

 Q: When do you shrink the window?
 A: while distinct types > 2 → remove left fruit, left++

 Q: Why remove key when count hits 0?
 A: Key staying in map inflates distinct count — must remove

 Q: Time and space?
 A: O(n) time | O(k) space — map holds at most k+1 types
*/

// MARK: - Brute Force  O(n²) time  O(k) space

/*
 Strategy:
 - Fix i as start
 - Expand j, track fruit types via hashMap
 - When types > 2 → break
 - Track max length

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ fruits: [Int]) -> Int {

    let k      = 2
    var answer = 0

    for i in 0..<fruits.count {

        var hashMap        = [Int: Int]()
        var uniqueTypes    = 0

        for j in i..<fruits.count {

            let fruit = fruits[j]

            if let count = hashMap[fruit] {
                hashMap[fruit] = count + 1
            } else {
                hashMap[fruit] = 1
                uniqueTypes += 1
            }

            if uniqueTypes <= k {
                answer = max(answer, j - i + 1)
            } else {
                break
            }
        }
    }

    return answer
}

// MARK: - Optimal ⭐️  O(n) time  O(k) space

/*
 Strategy:
 - expand right → add fruit, increment count
 - while distinct > 2 → shrink left
   → decrement count, if 0 remove key, uniqueTypes--
   → left++
 - track max window

 INTERVIEW: Same sliding window as Problem 12 — k = 2
 INTERVIEW: Use leftFruit not fruit — avoid variable shadowing
*/

func optimised(_ fruits: [Int]) -> Int {

    let k           = 2
    var hashMap     = [Int: Int]()
    var uniqueTypes = 0
    var left        = 0
    var answer      = 0

    for right in 0..<fruits.count {

        let fruit = fruits[right]

        if let count = hashMap[fruit] {
            hashMap[fruit] = count + 1
        } else {
            hashMap[fruit] = 1
            uniqueTypes += 1
        }

        while uniqueTypes > k {

            let leftFruit = fruits[left]

            if let count = hashMap[leftFruit] {
                hashMap[leftFruit] = count - 1
                if hashMap[leftFruit] == 0 {
                    hashMap.removeValue(forKey: leftFruit)
                    uniqueTypes -= 1
                }
            }
            left += 1
        }

        answer = max(answer, right - left + 1)
    }

    return answer
}

// MARK: - Tests

let tests: [([Int], Int)] = [
    ([1, 2, 1],       3),
    ([0, 1, 2, 2],    3),
    ([1, 2, 3, 2, 2], 4),
    ([1, 1, 1, 1],    4),
    ([3, 3, 3, 1, 2, 1, 1, 2, 3, 3, 4], 5)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}
