import Foundation

// LeetCode 15 — 3Sum | Medium | Two Pointers
//
// NOTE: Sort first → fix i → two pointer for remaining
//
// NOTE: Target is always 0
//
// NOTE: No duplicate triplets allowed

// MARK: - Interview

// Q: Why sort first?
//
// A: Enables two pointer + easy duplicate skip
//
// Q: How to avoid duplicates?
//
// A: Skip same i before loop, skip same left/right after match
//
// Q: Why O(n²) not O(n³)?
//
// A: Fix i with loop, replace inner two loops with two pointer

var nums = [-1, 0, 1, 2, -1, -4]

// MARK: - Brute Force
//
// check every triplet
//
// Time: O(n³) | Space: O(1)
//
// INTERVIEW: Start here, explain before coding

func bruteForceThreeSum(_ nums: [Int]) -> [[Int]] {

    var results = [[Int]]()
    let sorted = nums.sorted()

    for i in 0..<sorted.count {
        for j in i+1..<sorted.count {
            for k in j+1..<sorted.count {

                let sum = sorted[i] + sorted[j] + sorted[k]

                if sum == 0 {
                    let triplet = [sorted[i], sorted[j], sorted[k]]
                    if !results.contains(triplet) {
                        results.append(triplet)
                    }
                }
            }
        }
    }

    return results
}

// MARK: - Optimal ⭐️ BEST
//
// sort + fix i + two pointer
//
// Time: O(n²) | Space: O(1)
//
// INTERVIEW: Sort enables two pointer & easy duplicate skip
//
// INTERVIEW: Skip duplicate i before loop, skip duplicate left/right after match
//
// INTERVIEW: sum > 0 → right-- | sum < 0 → left++ | sum == 0 → append + move both

func optimisedThreeSum(_ nums: [Int]) -> [[Int]] {

    let sorted = nums.sorted()
    var result = [[Int]]()

    for i in 0..<sorted.count {

        // skip duplicate i
        if i > 0, sorted[i] == sorted[i - 1] { continue }

        var left = i + 1
        var right = sorted.count - 1

        while left < right {

            let sum = sorted[i] + sorted[left] + sorted[right]

            if sum > 0 {
                right -= 1
            } else if sum < 0 {
                left += 1
            } else {
                result.append([sorted[i], sorted[left], sorted[right]])
                left += 1
                right -= 1

                // skip duplicates after match
                while left < right && sorted[left] == sorted[left - 1] { left += 1 }
                while left < right && sorted[right] == sorted[right + 1] { right -= 1 }
            }
        }
    }

    return result
}

// MARK: - Tests

let testCases: [([Int], [[Int]])] = [
    ([-1, 0, 1, 2, -1, -4], [[-1, -1, 2], [-1, 0, 1]]),
    ([0, 1, 1],              []),
    ([0, 0, 0],              [[0, 0, 0]])
]

print("--- Brute Force ---")
for (i, t) in testCases.enumerated() {
    let r = bruteForceThreeSum(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in testCases.enumerated() {
    let r = optimisedThreeSum(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r)")
}
