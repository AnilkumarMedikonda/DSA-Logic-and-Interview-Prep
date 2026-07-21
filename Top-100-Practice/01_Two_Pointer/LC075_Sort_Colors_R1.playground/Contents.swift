// LC075_Sort_Colors_R1

import Foundation

// MARK: - Brute Force (counting)
// Pattern: counting sort on a fixed, tiny value domain {0,1,2}
// Step 1 — one pass, tally how many 0s, 1s, 2s
// Step 2 — overwrite nums in place: zeros block, ones block, twos block
// T — O(n)   S — O(1)
// Two passes. Correct, in place, but reads the array twice.

func sortColorsBruteForce(_ nums: inout [Int]) {
    var zeros = 0
    var ones = 0
    var twos = 0

    for num in nums {
        if num == 0 {
            zeros += 1
        } else if num == 1 {
            ones += 1
        } else {
            twos += 1
        }
    }

    var i = 0
    while i < zeros {
        nums[i] = 0
        i += 1
    }
    while i < zeros + ones {
        nums[i] = 1
        i += 1
    }
    while i < nums.count {
        nums[i] = 2
        i += 1
    }
}


// MARK: - Optimised (Dutch National Flag)
// Three pointers partition the array into four regions:
//   [0 ..< low]      settled 0s
//   [low ..< mid]    settled 1s
//   [mid ... high]   unexamined
//   [high+1 ..< n]   settled 2s
//
// Step 1 — low = 0, mid = 0, high = n - 1
// Step 2 — while mid <= high, inspect nums[mid]:
//            0 → swap(mid, low), advance both
//            1 → already in place, advance mid only
//            2 → swap(mid, high), shrink high, DO NOT advance mid
// Step 3 — loop ends when the unexamined region is empty
//
// T — O(n)   S — O(1)   single pass

func sortColors(_ nums: inout [Int]) {
    var low = 0
    var mid = 0
    var high = nums.count - 1

    while mid <= high {
        if nums[mid] == 0 {
            nums.swapAt(mid, low)
            low += 1
            mid += 1
        } else if nums[mid] == 1 {
            mid += 1
        } else {
            nums.swapAt(mid, high)
            high -= 1
            // mid stays: the value pulled in from high is unexamined
        }
    }
}


// MARK: - Tests

print("--- Brute Force ---")

var b1 = [2, 0, 2, 1, 1, 0]
sortColorsBruteForce(&b1)
print(b1)                       // [0, 0, 1, 1, 2, 2]

var b2 = [1, 2, 0]
sortColorsBruteForce(&b2)
print(b2)                       // [0, 1, 2]


print("--- Optimised ---")

var t1 = [2, 0, 2, 1, 1, 0]
sortColors(&t1)
print(t1)                       // [0, 0, 1, 1, 2, 2]

var t2 = [1, 2, 0]              // the case that broke both earlier attempts
sortColors(&t2)
print(t2)                       // [0, 1, 2]

var t3 = [2, 1, 0]
sortColors(&t3)
print(t3)                       // [0, 1, 2]

var t4 = [0, 2, 1, 2, 0]
sortColors(&t4)
print(t4)                       // [0, 0, 1, 2, 2]

var t5 = [2, 2, 2]
sortColors(&t5)
print(t5)                       // [2, 2, 2]

var t6 = [0, 0, 0]
sortColors(&t6)
print(t6)                       // [0, 0, 0]

var t7 = [1]
sortColors(&t7)
print(t7)                       // [1]
