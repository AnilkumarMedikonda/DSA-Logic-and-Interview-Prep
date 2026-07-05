import UIKit

// ===================================================================
// 75_Longest_Substring_With_At_Most_K_Distinct_Characters
// LeetCode 340
// ===================================================================

/*
 MARK: - Problem
 
 Given a string `s` and an integer `k`, find the length of the
 longest substring of `s` that contains at most `k` distinct characters.

 Input:  s = "eceba", k = 2
 Output: 3   → "ece"

 Input:  s = "aa", k = 1
 Output: 2   → "aa"

 Input:  s = "abcabcabc", k = 2
 Output: 2   → e.g. "ab", "bc"

 Input:  s = "", k = 3
 Output: 0   → empty string

 Constraints:
 1 <= s.length <= 5 * 10^4
 0 <= k <= 50
*/

// MARK: - Brute Force
// T - O(n²)   S - O(k)

func bruteForceLengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
    var maxLength = 0
    let words = Array(s)

    for i in 0..<words.count {

        var hashMap: [Character: Int] = [:]
        for j in i..<words.count {

            let char = words[j]

            if let count = hashMap[char] {
                hashMap[char] = count + 1
            } else {
                hashMap[char] = 1
            }

            if hashMap.count <= k {
                let length = j - i + 1
                maxLength = maxLength > length ? maxLength : length
            }
        }
    }

    return maxLength
}


// MARK: - Optimised (Sliding Window)
// T - O(n)   S - O(k)

func optimisedLengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {

    var maxLength = 0
    var left = 0
    var hashMap: [Character: Int] = [:]
    let words = Array(s)

    for right in 0..<words.count {
        let char = words[right]

        if let count = hashMap[char] {
            hashMap[char] = count + 1
        } else {
            hashMap[char] = 1
        }

        while hashMap.count > k {

            let leftChar = words[left]

            if let count = hashMap[leftChar] {
                hashMap[leftChar] = count - 1
            }

            if hashMap[leftChar] == 0 {
                hashMap.removeValue(forKey: leftChar)
            }
            left += 1
        }

        let length = right - left + 1
        maxLength = maxLength > length ? maxLength : length
    }

    return maxLength
}


// MARK: - Dry Run
/*
 s = "eceba", k = 2
 words = [e, c, e, b, a]

 right=0  char=e   map={e:1}                len=1   max=1
 right=1  char=c   map={e:1,c:1}            len=2   max=2
 right=2  char=e   map={e:2,c:1}            len=3   max=3
 right=3  char=b   map={e:2,c:1,b:1} → count=3 > 2
            shrink: left=0 char=e → map={e:1,c:1,b:1} count=3 still >2
            shrink: left=1 char=c → map={e:1,b:1} count=2, stop, left=2
            len = 3-2+1 = 2   max=3 (unchanged)
 right=4  char=a   map={e:1,b:1,a:1} → count=3 > 2
            shrink: left=2 char=e → map={b:1,a:1} count=2, stop, left=3
            len = 4-3+1 = 2   max=3 (unchanged)

 Final answer: 3  ("ece")
*/


// MARK: - Complexity

/*
 ┌─────────────┬───────────┬───────────┐
 │ Approach    │ Time      │ Space     │
 ├─────────────┼───────────┼───────────┤
 │ Brute Force │ O(n²)     │ O(k)      │
 │ Optimised   │ O(n)      │ O(k)      │
 └─────────────┴───────────┴───────────┘
*/


// MARK: - Traps

/*
 1. k = 0 → no characters allowed at all → answer must be 0.
    Window collapses correctly since `left` can equal/overtake `right`.

 2. Removing from hashMap only when count hits 0 — forgetting this means
    hashMap.count stays inflated and the window never shrinks correctly.

 3. Shrinking left must be a `while`, not an `if` — sometimes more than
    one character needs to leave the window to get back under k.

 4. Empty string input — loop simply doesn't execute, maxLength stays 0.
*/


// MARK: - Interview Q&A

/*
 Q1: Why dictionary instead of array/set for tracking characters?
 A1: Need both presence (distinct count) AND frequency (to know when
     to fully remove a character as left shrinks). A Set alone can't
     tell you when a character's last occurrence has left the window.

 Q2: Why is shrinking a `while` loop and not `if`?
 A2: Because removing one character from the left might still leave
     hashMap.count > k if more violating characters need to exit.
     One shrink step isn't guaranteed to be enough.

 Q3: How is this different from "Longest Substring With At Most 2
     Distinct Characters"?
 A3: Identical pattern — just hashMap.count <= k instead of <= 2.
     k is now a parameter instead of a hardcoded constant.

 Q4: What happens when k = 0?
 A4: No character can ever be added without violating the constraint,
     so left chases right every step, window length stays 0 throughout.

 Q5: Could a fixed-size array of 26/128 counts replace the dictionary?
 A5: Yes, if input is guaranteed lowercase English letters — gives
     O(1) lookups with less overhead. Dictionary is used here for
     generality across any Character set.
*/


// MARK: - Test Cases

print(optimisedLengthOfLongestSubstringKDistinct("eceba", 2))        // 3
print(optimisedLengthOfLongestSubstringKDistinct("aa", 1))           // 2
print(optimisedLengthOfLongestSubstringKDistinct("abcabcabc", 2))    // 2
print(optimisedLengthOfLongestSubstringKDistinct("", 3))             // 0
print(optimisedLengthOfLongestSubstringKDistinct("a", 0))            // 0
print(optimisedLengthOfLongestSubstringKDistinct("abaccc", 2))
// 4 ("accc" or "baccc"? → check: "accc"=4)
