import Foundation

// MARK: - Brute Force (spoken in an interview, not written)
// Copy both arrays into a buffer, sort it, write back into nums1.
// T — O((m + n) log(m + n))   S — O(m + n)
//
// Why it's wasteful: sorting discards the fact that both inputs
// are already sorted. That's the signal to reach for two pointers.

func mergeBruteForce(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var result = [Int]()
    result.reserveCapacity(m + n)

    for i in 0..<m {
        result.append(nums1[i])
    }
    for j in 0..<n {
        result.append(nums2[j])
    }

    // hand-rolled insertion sort — no .sort()
    var i = 1
    while i < result.count {
        let key = result[i]
        var j = i - 1
        while j >= 0 && result[j] > key {
            result[j + 1] = result[j]
            j -= 1
        }
        result[j + 1] = key
        i += 1
    }

    for idx in 0..<result.count {
        nums1[idx] = result[idx]
    }
}


// MARK: - Optimised (this is what you code)
// Fill nums1 from the back so we never overwrite an unread value.
// The tail of nums1 is padding, so the write pointer k is always
// at or ahead of the read pointer i.
// T — O(m + n)   S — O(1)

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var i = m - 1          // last real value in nums1
    var j = n - 1          // last value in nums2
    var k = m + n - 1      // write position

    while j >= 0 {
        if i >= 0 && nums1[i] >= nums2[j] {
            nums1[k] = nums1[i]
            i -= 1
        } else {
            nums1[k] = nums2[j]
            j -= 1
        }
        k -= 1
    }
    // No tail loop needed: if j exhausts first, the remaining
    // nums1[0...i] are already in their final positions.
}


// MARK: - Tests

var a1 = [1, 2, 3, 0, 0, 0]
merge(&a1, 3, [2, 5, 6], 3)
print(a1)                                   // [1, 2, 2, 3, 5, 6]

var a2 = [1]
merge(&a2, 1, [], 0)
print(a2)                                   // [1]

var a3 = [0]
merge(&a3, 0, [1], 1)
print(a3)                                   // [1]

var a4 = [4, 5, 6, 0, 0, 0]
merge(&a4, 3, [1, 2, 3], 3)
print(a4)                                   // [1, 2, 3, 4, 5, 6] — nums2 fully smaller

var a5 = [2, 2, 2, 0, 0, 0]
merge(&a5, 3, [2, 2, 2], 3)
print(a5)                                   // [2, 2, 2, 2, 2, 2] — all duplicates
