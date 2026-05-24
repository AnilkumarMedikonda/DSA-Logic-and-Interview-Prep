import Foundation

//: 23_Sliding_Window_Maximum
// Pattern: Sliding Window + Monotonic Deque

/*
==================================================
PROBLEM
==================================================

Given an array nums and window size k,
return the maximum value in every window.

==================================================
EXAMPLE
==================================================

nums = [1,3,-1,-3,5,3,6,7]
k = 3

Output:

[3,3,5,5,6,7]

==================================================
PATTERN
==================================================

Sliding Window
+
Monotonic Deque

==================================================
*/


// MARK: - Brute Force

func maxSlidingWindowBruteForce(_ nums: [Int], _ k: Int) -> [Int] {

    var result = [Int]()

    for i in 0...(nums.count - k) {

        var currentMax = Int.min

        for j in i..<(i + k) {

            if nums[j] > currentMax {
                currentMax = nums[j]
            }
        }

        result.append(currentMax)
    }

    return result
}

/*
 Time  : O(n * k)
 Space : O(1)
 */


// MARK: - Optimized (Interview Preferred)

func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {

    var result = [Int]()
    var deque = [Int]()      // Stores indices

    for i in 0..<nums.count {

        // Remove indices outside current window
        if !deque.isEmpty &&
            deque.first! <= i - k {

            deque.removeFirst()
        }

        // Remove smaller elements
        while !deque.isEmpty &&
                nums[deque.last!] < nums[i] {

            deque.removeLast()
        }

        // Add current index
        deque.append(i)

        // Window formed
        if i >= k - 1 {

            result.append(nums[deque.first!])
        }
    }

    return result
}

/*
 Time  : O(n)
 Space : O(k)
 */


// MARK: - Test

let nums = [1,3,-1,-3,5,3,6,7]
let k = 3

print(maxSlidingWindowBruteForce(nums, k))
print(maxSlidingWindow(nums, k))


/*
==================================================
DRY RUN
==================================================

nums = [1,3,-1,-3,5,3,6,7]
k = 3

--------------------------------------------------

i = 0

deque = [0]

values:

[1]

--------------------------------------------------

i = 1

nums[1] = 3

Remove smaller:

1

deque = [1]

values:

[3]

--------------------------------------------------

i = 2

nums[2] = -1

deque = [1,2]

Window formed

Maximum:

nums[1] = 3

result:

[3]

--------------------------------------------------

i = 3

nums[3] = -3

deque = [1,2,3]

Maximum:

3

result:

[3,3]

--------------------------------------------------

i = 4

Remove out of window:

index 1

Remove smaller:

-3
-1

deque = [4]

Maximum:

5

result:

[3,3,5]

--------------------------------------------------

Continue

Result:

[3,3,5,5,6,7]

==================================================
MAIN IDEA
==================================================

Deque stores indices.

Values inside deque
remain in decreasing order.

Front of deque
always contains
largest element.

==================================================
WHY REMOVE SMALLER ELEMENTS?
==================================================

Example:

deque values:

[5,3]

New value:

6

--------------------------------------------------

5 and 3 can never become
maximum again.

Remove them.

deque:

[6]

==================================================
WHY REMOVE OUTSIDE WINDOW?
==================================================

Window size = 3

Current index = 5

Valid window:

[3,4,5]

--------------------------------------------------

Any index less than:

5 - 3

is outside window.

Remove it.

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n * k)
Space : O(1)

--------------------------------------------------

Optimized

Time  : O(n)

Reason:

Every element:

Added once

Removed once

--------------------------------------------------

Space : O(k)

Deque stores
window indices.

==================================================
QUICK INTERVIEW NOTE
==================================================

Pattern:

Sliding Window Maximum

Use:

Monotonic Deque

--------------------------------------------------

Store:

Indices

--------------------------------------------------

Front:

Maximum Element

--------------------------------------------------

Remove:

Out Of Window Indices

--------------------------------------------------

Remove:

Smaller Elements

--------------------------------------------------

Append:

Current Index

--------------------------------------------------

Answer:

nums[deque.first!]

--------------------------------------------------

Time  : O(n)

Space : O(k)

==================================================
INTERVIEW IMPORTANCE
==================================================

23_Sliding_Window_Maximum

Difficulty : Hard

Priority   : ⭐⭐⭐⭐⭐

Very Frequently Asked

Must Practice 4-5 Times

==================================================
MEMORY TRICK
==================================================

Deque always stores:

Big → Small

Front = Maximum

Window moves:

Remove old indices

Remove smaller values

Insert new index

Front gives answer

==================================================
*/


