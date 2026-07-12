import Foundation

// LC217_Contains_Duplicate_R1
// PROBLEM: Return true if ANY value appears more than once.
// Rules: single array · any int values · true on first duplicate found
// [1,2,3,1] → true · [1,2,3,4] → false · [1,1,1,3,3,4,3,2,4,2] → true
//
// SEED: seen-before question → Set answers membership in O(1)
//       → insert(_:).inserted is the check (no .contains needed)
//
// R1 RESULT: ✅ PASS · traps hit: dict-where-set, space O(1)→O(n) (REPEAT)
// R2 due: ~Aug 2

var nums = [1,2,3,1]
var nums2 = [1,2,3,4]
var nums3 = [1,1,1,3,3,4,3,2,4,2]

// Brute Force
// T: O(n²) · S: O(1)
// Nested pair compare — return true on first match.
// Interview: SPOKEN only — "wasted work: re-asking 'have I seen
// this?' by scanning, when a set remembers the answer"

func containsDuplicateBrute(_ nums: [Int]) -> Bool {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] == nums[j] {
                return true
            }
        }
    }
    return false
}

print("---- Brute Force ----")
print(containsDuplicateBrute(nums))     // true
print(containsDuplicateBrute(nums2))    // false
print(containsDuplicateBrute(nums3))    // true

// Optimised — HashMap
// T: O(n) · S: O(n) ← map grows to n entries; NOT O(1)
// if-let on subscript = existence check (no .contains)
// Note: Set is the tighter tool here — the count value is unused.
// Map earns its place only when position (LC1) or count (LC242)
// is the payload.

func containsDuplicateOptimised(_ nums: [Int]) -> Bool {

    var hashMap = [Int: Int]()

    for num in nums {
        if let _ = hashMap[num] {
            return true
        }
        hashMap[num] = 1
    }
    return false
}

print("---- Optimised ----")
print(containsDuplicateOptimised(nums))     // true
print(containsDuplicateOptimised(nums2))    // false
print(containsDuplicateOptimised(nums3))    // true
print(containsDuplicateOptimised([]))       // false (empty)
print(containsDuplicateOptimised([7]))      // false (single)
