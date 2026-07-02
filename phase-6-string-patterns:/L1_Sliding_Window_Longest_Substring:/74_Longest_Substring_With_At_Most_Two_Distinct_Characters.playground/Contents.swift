import UIKit

// ==========================================================
// MARK: - LC 159: Longest Substring With At Most Two Distinct Characters
// ==========================================================
// Pattern: Sliding Window (variable size, dictionary-tracked distinct count)
// Phase 6 - String Patterns

// MARK: - Problem Statement
/*
 Given a string `s`, find the length of the longest substring
 that contains at most 2 distinct characters.

 Example 1:
 Input: s = "eceba"
 Output: 3
 Explanation: substring "ece" has length 3 with 2 distinct chars ('e','c')

 Example 2:
 Input: s = "ccaabbb"
 Output: 5
 Explanation: substring "aabbb" has length 5 with 2 distinct chars ('a','b')
*/

var s = "eceba"

// ==========================================================
// MARK: - Brute Force
// ==========================================================
// Idea: For every starting index i, expand j forward, tracking
// distinct char count via a hash map. Only update maxLength
// when hash.count <= 2 (valid window).
//
// T - O(n²)   S - O(1) (hash bounded by alphabet size, but grows with i,j combos conceptually O(n) worst case per inner loop)

func bruteForce(_ s: String) -> Int {

    let words = Array(s)
    var maxLength = 0

    for i in 0..<words.count {

        var hash: [Character: Int] = [:]

        for j in i..<words.count {

            let char = words[j]

            if let count = hash[char] {
                hash[char] = count + 1
            } else {
                hash[char] = 1
            }

            if hash.count <= 2 {
                let length = j - i + 1
                maxLength = maxLength > length ? maxLength : length
            }
        }
    }

    return maxLength
}

print("Brute Force:", bruteForce(s))   // 3

// ==========================================================
// MARK: - Optimized (Sliding Window)
// ==========================================================
// Idea: Single pass with two pointers, left and right, both
// moving only forward (no restart like brute force's outer i).
// Expand right, add char to hash. If hash.count > 2, shrink
// from left until valid again. Track maxLength every iteration.
//
// T - O(n)   S - O(1) -> hash holds at most 3 keys at any time

func lengthOfLongestSubstringTwoDistinctOptimised(_ s: String) -> Int {

    let words = Array(s)
    var maxLength = 0
    var left = 0
    var hash = [Character: Int]()

    for right in 0..<words.count {

        let rightChar = words[right]

        if let count = hash[rightChar] {
            hash[rightChar] = count + 1
        } else {
            hash[rightChar] = 1
        }

        while hash.count > 2 {
            let leftChar = words[left]

            if let count = hash[leftChar] {
                hash[leftChar] = count - 1
            }

            if hash[leftChar] == 0 {
                hash.removeValue(forKey: leftChar)
            }

            left += 1
        }

        let length = right - left + 1
        maxLength = maxLength > length ? maxLength : length
    }

    return maxLength
}

print("Optimised:", lengthOfLongestSubstringTwoDistinctOptimised(s))   // 3

// ==========================================================
// MARK: - Dry Run Trace ("eceba")
// ==========================================================
/*
 right | char | hash after add        | hash.count | shrink?                                   | left | length | maxLength
 ------|------|------------------------|-----------|--------------------------------------------|------|--------|----------
   0   |  e   | {e:1}                  | 1         | no                                          | 0    | 1      | 1
   1   |  c   | {e:1,c:1}              | 2         | no                                          | 0    | 2      | 2
   2   |  e   | {e:2,c:1}              | 2         | no                                          | 0    | 3      | 3
   3   |  b   | {e:2,c:1,b:1}          | 3         | yes -> remove e(2->1), remove c(1->0,gone)  | 2    | 2      | 3
   4   |  a   | {e:1,b:1,a:1}          | 3         | yes -> remove e(1->0,gone)                  | 3    | 2      | 3

 Final answer: 3
*/

// ==========================================================
// MARK: - Complexity
// ==========================================================
/*
 Brute Force:
   Time  - O(n²)  -> outer i runs n times, inner j runs up to n times per i
   Space - O(1)   -> hash bounded by distinct chars seen (small in practice)

 Optimized (Sliding Window):
   Time  - O(n)   -> right moves forward n times total; left also moves
                      forward at most n times ACROSS the whole run (not
                      per right, unlike brute force's i reset). Combined
                      work is linear.
   Space - O(1)   -> hash holds at most 3 keys at any time (2 valid + 1
                      that triggers the shrink), so technically O(min(n, charset))
*/

// ==========================================================
// MARK: - Bottleneck Identified (Brute Force -> Optimized)
// ==========================================================
/*
 For a fixed i, once hash.count exceeds 2, it can NEVER come back down
 to <= 2 for that same i, because characters are only ADDED as j grows,
 never removed. So every j iteration after that point is wasted work --
 you already know the window is invalid and will stay invalid.

 Sliding window fixes this by never restarting i. Instead, when the
 window becomes invalid, you shrink it from the LEFT (removing chars)
 until it's valid again, then keep expanding RIGHT. Both pointers only
 move forward across the ENTIRE string, giving O(n) total instead of O(n²).
*/

// ==========================================================
// MARK: - Interview Q&A
// ==========================================================
/*
 Q1: Why use a dictionary instead of a Set to track distinct characters?
 A1: A Set only tells you IF a char is in the window, not HOW MANY times.
     You need the count so that when you shrink from the left and remove
     one occurrence, you know whether to fully delete the key (count hits 0)
     or just decrement it (char still exists elsewhere in the window).

 Q2: Why does `left` never reset to 0 across the whole loop?
 A2: Because once a window starting before `left` was found invalid, no
     window starting at or before the old `left` value can ever become
     valid again going forward (it would still contain the same "extra"
     character). Resetting would redo work the algorithm already proved
     is invalid -- that's exactly the brute force bottleneck we removed.

 Q3: What does hash.count actually represent at any point in the loop?
 A3: The number of DISTINCT characters currently inside the window
     [left, right] (inclusive). It's recalculated implicitly every time
     you add/remove a key -- you never need a separate counter variable.

 Q4: Why check `hash[leftChar] == 0` after decrementing instead of
     checking `< 1` or using a guard before decrementing?
 A4: Because count can only decrease by 1 at a time and starts at >= 1,
     so 0 is the only possible "now empty" value to check for. It's the
     simplest sufficient condition; no need for <=0.

 Q5: How would this change for "at most K distinct characters" (LC 340)?
 A5: Identical pattern -- only change `hash.count > 2` to `hash.count > k`
     in the while-shrink condition. Everything else stays the same.

 Q6: What's the maximum size the hash dictionary can grow to?
 A6: At most 3 -- it grows to 3 only momentarily (right pointer just added
     a 3rd distinct char), immediately triggering the while loop to shrink
     back down to 2 before the next right iteration begins.
*/

// ==========================================================
// MARK: - Common Traps
// ==========================================================
/*
 1. Forgetting to insert into the dictionary on first sight of a character
    (only handling the `if let` branch, not the `else` branch).
 2. Checking a STALE variable (like a separately tracked uniqueCount) instead
    of the dictionary's live `.count` property after the most recent update.
 3. Using `if hash.count <= 2` without ever checking `> 2` and shrinking --
    this just records invalid windows without rejecting them (classic
    brute-force-disguised-as-optimized bug).
 4. Shadowing variable names (`char` used both in outer scope and inside the
    shrink-loop) -- not a bug here since scopes are separate, but reduces
    readability. Prefer `rightChar` / `leftChar` naming.
 5. Removing the key only when count goes negative instead of exactly 0 --
    since decrement happens one step at a time from a positive count, 0
    is the correct and only check needed.
*/

// ==========================================================
// MARK: - Test Cases
// ==========================================================
print(lengthOfLongestSubstringTwoDistinctOptimised("eceba"))      // 3
print(lengthOfLongestSubstringTwoDistinctOptimised("ccaabbb"))    // 5
print(lengthOfLongestSubstringTwoDistinctOptimised("a"))          // 1  (single char, edge case)
print(lengthOfLongestSubstringTwoDistinctOptimised(""))           // 0  (empty string, edge case)
print(lengthOfLongestSubstringTwoDistinctOptimised("aa"))         // 2  (all same char)
print(lengthOfLongestSubstringTwoDistinctOptimised("abcabcabc"))  // 2  (no 2 consecutive distinct chars repeat usefully)
print(lengthOfLongestSubstringTwoDistinctOptimised("aabbcc"))     // 4  (e.g. "aabb")
