//
//  LC283_Move_Zeroes_R1.playground
//  Two Pointer (Same Direction) · Easy · O(n) / O(1)
//

import Foundation

// MARK: - Problem
/*
 Move all 0s to the end, keep relative order of non-zeros. IN-PLACE.

 [0,1,0,3,12] → [1,3,12,0,0]
 [0]          → [0]
*/

// MARK: - Brute Force · O(n) time / O(n) space
// Two passes into a new array. Rejected: not in-place.

func moveZeroesBruteForce(_ nums: [Int]) -> [Int] {

    var result = [Int]()

    for num in nums where num != 0 {
        result.append(num)
    }
    for num in nums where num == 0 {
        result.append(num)
    }
    return result
}

// MARK: - Optimised · Two Pointer · O(n) / O(1)
/*
 left  = where the next non-zero BELONGS
 right = scanner reading every element

 Order preserved: right only moves forward, so non-zeros land at left
 in the exact sequence they're read.
*/

// --- for-in version (preferred) ---
func moveZeroes(_ nums: inout [Int]) {

    var left = 0

    for right in 0..<nums.count {
        if nums[right] != 0 {
            nums.swapAt(left, right)
            left += 1
        }
    }
}

// --- while version (same logic, manual advance) ---
func moveZeroesWhile(_ nums: inout [Int]) {

    var left  = 0
    var right = 0

    while right < nums.count {
        if nums[right] != 0 {
            nums.swapAt(left, right)
            left += 1
        }
        right += 1          // easy to forget — for-in does it for you
    }
}

// MARK: - Fewer writes (the follow-up)
/*
 The versions above swap even when left == right (self-swap).
 On [1,2,3,4,5] that's 5 pointless swaps. One guard removes them.
*/

func moveZeroesFewerWrites(_ nums: inout [Int]) {

    var left = 0

    for right in 0..<nums.count {
        if nums[right] != 0 {
            if left != right {
                nums.swapAt(left, right)
            }
            left += 1
        }
    }
}

// MARK: - Dry Run  [0,1,0,3,12]
/*
 right val left action              array
   0    0    0   skip               [0,1,0,3,12]
   1    1    0   swap(0,1), left=1  [1,0,0,3,12]
   2    0    1   skip               [1,0,0,3,12]
   3    3    1   swap(1,3), left=2  [1,3,0,0,12]
   4   12    2   swap(2,4), left=3  [1,3,12,0,0]
*/

// MARK: - Traps
/*
 1. swapAt takes INDICES, not values
 2. Only advance left on a non-zero — advancing always breaks it
 3. inout means no return value
 4. while version: forgetting right += 1 → infinite loop
 5. Self-swap when left == right — correct, but wasted writes
*/

// MARK: - Tests

var a = [0,1,0,3,12];  moveZeroes(&a);  print(a)   // [1,3,12,0,0]
var b = [0];           moveZeroes(&b);  print(b)   // [0]
var c = [1,2,3];       moveZeroes(&c);  print(c)   // [1,2,3]  — no zeros
var d = [0,0,0];       moveZeroes(&d);  print(d)   // [0,0,0]  — all zeros
var e = [1,0];         moveZeroes(&e);  print(e)   // [1,0]
var f = [0,1];         moveZeroes(&f);  print(f)   // [1,0]

// both versions agree
var g = [0,1,0,3,12];  moveZeroesWhile(&g);        print(g)   // [1,3,12,0,0]
var h = [0,1,0,3,12];  moveZeroesFewerWrites(&h);  print(h)   // [1,3,12,0,0]

// MARK: - Q&A
/*
 Q: Why is order preserved?
 A: right scans forward once; non-zeros land at left in read order.

 Q: for-in or while?
 A: for-in. right advances every iteration unconditionally — bounded,
    count known up front. Only left is condition-driven, and it isn't
    the loop driver. Use while when BOTH pointers move conditionally or
    converge (LC 11: `while left < right`).
    Rule: iterations countable up front → for. Termination depends on
    what you find inside → while.

 Q: Can you reduce writes?
 A: Guard `left != right` to skip self-swaps — best case 0 writes.

 Q: Why not remove zeros and append?
 A: Removing from the middle of an array is O(n) each → O(n²).
*/
