// LC001_Two_Sum_R1

// PROBLEM: Return INDICES of two numbers adding to target.
// Rules: exactly one answer · same index not reused · NOT sorted
// [2,7,11,15], t=9 → [0,1] · [3,2,4], t=6 → [1,2] · [3,3], t=6 → [0,1]

var nums = [2, 7, 11, 15]
var target = 9
var nums2 = [3, 2, 4]
var target2 = 6
var nums3 = [3, 3]
var target3 = 6

// Brute Force solution
// T: O(n²) · S: O(1)
// Two nested loops — check nums[i] + nums[j] == target, return [i, j]
// Interview: SPOKEN only, never coded

func bruteForce(_ nums: [Int], _ target: Int) -> [Int] {

    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }

    return []
}

print("---- Brute Force ----")
print(bruteForce(nums, target))       // [0, 1]
print(bruteForce(nums2, target2))     // [1, 2]
print(bruteForce(nums3, target3))     // [0, 1]

// Optimised — HashMap one pass
// Two pointer needs sorted input, and sorting destroys the indices
// we must return → HashMap is forced, not just preferred
// T: O(n) · S: O(n) — buying speed with memory (map holds up to n entries)
// TRAP: check complement BEFORE inserting — insert-first matches
// an element with itself on [3,3]

func twoSumOptimised(_ nums: [Int], _ target: Int) -> [Int] {

    var hashMap = [Int: Int]()

    for i in 0..<nums.count {

        let complement = target - nums[i]

        if let foundIndex = hashMap[complement] {
            return [foundIndex, i]
        }
        hashMap[nums[i]] = i
    }

    return []
}

print("---- Optimised ----")
print(twoSumOptimised(nums, target))      // [0, 1]
print(twoSumOptimised(nums2, target2))    // [1, 2]
print(twoSumOptimised(nums3, target3))    // [0, 1]
