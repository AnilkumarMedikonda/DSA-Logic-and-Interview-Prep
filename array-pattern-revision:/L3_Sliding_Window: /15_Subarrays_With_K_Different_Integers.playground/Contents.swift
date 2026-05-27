import Foundation

// ──────────────────────────────────────────
// LeetCode 992 — Subarrays With K Different Integers
// Difficulty: Hard  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given an integer array and k, return number of subarrays
 with exactly k different integers.

 Input:  nums = [1,2,1,2,3],  k = 2
 Output: 7

 Input:  nums = [1,2,1,3,4],  k = 3
 Output: 3

 Key insight:
 exactly(k) = atMost(k) - atMost(k - 1)
*/

// MARK: - Interview Q&A

/*
 Q: How is this related to Problem 14?
 A: Same trick — exactly(k) = atMost(k) - atMost(k-1)

 Q: How is this related to Problem 12?
 A: atMost helper is identical to longest substring with at most k distinct

 Q: Why while uniQueCount > k not == k?
 A: Shrink only when window exceeds k — == k means window is still valid

 Q: Why uniQueCount++ inside else only?
 A: Only increment when new character added — existing char doesn't add distinct

 Q: Why count += right - left + 1?
 A: All subarrays ending at right within window are valid — right-left+1 of them

 Q: Time and space?
 A: O(n) time — two passes of atMost | O(k) space — map holds at most k+1 keys
*/

// MARK: - Brute Force  O(n²) time  O(k) space

/*
 Strategy:
 - Fix i as start
 - Expand j, track distinct count via hashMap
 - When distinct == k → count++
 - When distinct > k → break

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: [Int], _ k: Int) -> Int {

    var answer = 0

    for i in 0..<nums.count {

        var hashMap     = [Int: Int]()
        var uniqueCount = 0

        for j in i..<nums.count {

            let num = nums[j]

            if let c = hashMap[num] {
                hashMap[num] = c + 1
            } else {
                hashMap[num] = 1
                uniqueCount += 1
            }

            if uniqueCount == k {
                answer += 1
            } else if uniqueCount > k {
                break
            }
        }
    }

    return answer
}

// MARK: - Helper — atMost

/*
 Count subarrays with at most k distinct integers.

 expand right → add to hashMap, if new → uniqueCount++
 while uniqueCount > k → shrink left
   → decrement count, if 0 remove key, uniqueCount--
   → left++
 count += right - left + 1
*/

func atMost(_ nums: [Int], _ k: Int) -> Int {

    var hashMap     = [Int: Int]()
    var uniqueCount = 0
    var left        = 0
    var count       = 0

    for right in 0..<nums.count {

        let rightNum = nums[right]

        if let c = hashMap[rightNum] {
            hashMap[rightNum] = c + 1
        } else {
            hashMap[rightNum] = 1
            uniqueCount += 1
        }

        while uniqueCount > k {

            let leftNum = nums[left]

            if let c = hashMap[leftNum] {
                hashMap[leftNum] = c - 1
                if hashMap[leftNum] == 0 {
                    hashMap.removeValue(forKey: leftNum)
                    uniqueCount -= 1
                }
            }

            left += 1
        }

        count += right - left + 1
    }

    return count
}

// MARK: - Optimal ⭐️  O(n) time  O(k) space

/*
 Strategy:
 - atMost(k)   → subarrays with at most k distinct
 - atMost(k-1) → subarrays with at most k-1 distinct
 - subtract    → subarrays with exactly k distinct

 INTERVIEW: exactly = atMost(k) - atMost(k-1) — reusable pattern
 INTERVIEW: Same atMost helper as Problem 12 and 14
*/

func optimised(_ nums: [Int], _ k: Int) -> Int {
    return atMost(nums, k) - atMost(nums, k - 1)
}

// MARK: - Tests

let tests: [(nums: [Int], k: Int, expected: Int)] = [
    ([1,2,1,2,3], 2, 7),
    ([1,2,1,3,4], 3, 3),
    ([1,2,1,2,3], 1, 5),
    ([1,2,3,4,5], 5, 1),
    ([1,1,1,1,1], 1, 15)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
