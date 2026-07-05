import UIKit

// MARK: - Problem
// 85. K-Anagrams (GFG)
// true if: same length AND at most k character changes make them anagrams.
// "fodr"/"gork"/k=2 -> true (f->g, d->k). "geeks"/"eggkf"/k=1 -> false (needs 2).

// MARK: - Solution
// s1 map = inventory. s2 consumes stock. No stock -> changes += 1.
// T: O(n)   S: O(26) ~ O(1)

func isKAnagrams(_ s1: String, _ s2: String, _ k: Int) -> Bool {

    if s1.count != s2.count {
        return false
    }

    var s1Map = [Character: Int]()
    for char in s1 {
        if let count = s1Map[char] {
            s1Map[char] = count + 1
        } else {
            s1Map[char] = 1
        }
    }

    var changes = 0
    for char in s2 {
        if let count = s1Map[char] {
            if count == 1 {
                s1Map[char] = nil        // remove key, never leave 0
            } else {
                s1Map[char] = count - 1
            }
        } else {
            changes += 1
        }
    }

    return changes <= k
}

// MARK: - Dry Run
// s1 = "fodr" -> [f:1, o:1, d:1, r:1]
// s2 = "gork": g? no -> 1 | o -> consume | r -> consume | k? no -> 2
// changes 2 <= k 2 -> true. Leftover [f:1, d:1] NOT counted.

// MARK: - Traps
// 1. Count only s2's deficits — leftovers pair 1:1 with them (equal
//    lengths), one change fixes both. Counting both = double count.
// 2. Must consume (decrement), not just check presence — one b can't
//    pay for two b's. Test: "aab"/"abb"/k=0 -> false.
// 3. Length guard first — k-anagram is defined only for equal lengths.

// MARK: - Tests
print(isKAnagrams("fodr", "gork", 2))      // true
print(isKAnagrams("geeks", "eggkf", 1))    // false
print(isKAnagrams("geeks", "eggkf", 2))    // true
print(isKAnagrams("aab", "abb", 0))        // false — duplicate trap
print(isKAnagrams("ab", "abbb", 5))        // false — length mismatch
print(isKAnagrams("listen", "silent", 0))  // true — k=0 = Valid Anagram
