import Foundation

//: 29_Subarrays_With_K_Different_Integers
// Pattern: Sliding Window + HashMap + AtMost(K)

/*
==================================================
PROBLEM
==================================================
Given an integer array nums and an integer k,
return the number of good subarrays.

A good subarray contains exactly k distinct integers.

==================================================
EXAMPLE
==================================================
Input:
nums = [1,2,1,2,3]
k = 2

Output:
7

Valid Subarrays:
[1,2]
[1,2,1]
[1,2,1,2]
[2,1]
[2,1,2]
[1,2]
[2,3]

==================================================
KEY INSIGHT
==================================================
Directly counting EXACTLY K distinct is difficult.

Use:

Exactly(K)
=
AtMost(K)
-
AtMost(K-1)

Example:

AtMost(2)
=
1 distinct + 2 distinct

AtMost(1)
=
1 distinct

Subtract:

=
2 distinct only

==================================================
PATTERN
==================================================
Variable Size Sliding Window + HashMap

Exactly(K)
=
AtMost(K)
-
AtMost(K-1)

==================================================
*/

// MARK: - Brute Force O(n³)

var nums = [1,2,1,2,3]
var k = 2
var finalCount = 0

for i in 0..<nums.count {

    for j in i..<nums.count {

        var frequency = [Int:Int]()

        for index in i...j {

            let number = nums[index]

            if let count = frequency[number] {
                frequency[number] = count + 1
            } else {
                frequency[number] = 1
            }
        }

        if frequency.count == k {
            finalCount += 1
        }
    }
}

print(finalCount)

// Time  : O(n³)
// Space : O(n)


// MARK: - Optimized O(n)

func atMost(_ k: Int, _ nums: [Int]) -> Int {

    var left = 0
    var count = 0
    var frequency = [Int:Int]()

    for right in 0..<nums.count {

        let number = nums[right]

        if let value = frequency[number] {
            frequency[number] = value + 1
        } else {
            frequency[number] = 1
        }

        while frequency.count > k {

            let leftNumber = nums[left]

            if let value = frequency[leftNumber] {

                if value == 1 {
                    frequency.removeValue(forKey: leftNumber)
                } else {
                    frequency[leftNumber] = value - 1
                }
            }

            left += 1
        }

        count += right - left + 1
    }

    return count
}

let answer = atMost(k, nums) - atMost(k - 1, nums)

print(answer)

// Time  : O(n)
// Space : O(k)

/*
==================================================
DRY RUN
==================================================

nums = [1,2,1,2,3]
k = 2

--------------------------------
AtMost(2)
--------------------------------

right=0

window = [1]

frequency = {1:1}

count += 1

count = 1

--------------------------------

right=1

window = [1,2]

frequency = {1:1,2:1}

count += 2

count = 3

--------------------------------

right=2

window = [1,2,1]

frequency = {1:2,2:1}

count += 3

count = 6

--------------------------------

right=3

window = [1,2,1,2]

frequency = {1:2,2:2}

count += 4

count = 10

--------------------------------

right=4

window = [1,2,1,2,3]

frequency = {1:2,2:2,3:1}

distinct = 3 > 2

shrink

remove 1
remove 2
remove 1

window becomes

[2,3]

count += 2

count = 12

AtMost(2) = 12

--------------------------------
AtMost(1)
--------------------------------

Result = 5

--------------------------------

Exactly(2)

=
AtMost(2)
-
AtMost(1)

=
12
-
5

=
7

==================================================
MOST IMPORTANT FORMULA
==================================================

count += right - left + 1

Why?

After fixing right:

Valid Window:

[left ... right]

Every subarray ending at right
is valid.

Example:

left = 2
right = 5

Subarrays:

[5]
[4...5]
[3...5]
[2...5]

Total:

5 - 2 + 1

=
4

==================================================
MAIN IDEA
==================================================

Expand Window
→ Move Right

Invalid Window
→ frequency.count > k

Shrink Window
→ Move Left

Count Valid Subarrays
→ count += right - left + 1

Exactly K
→ AtMost(K) - AtMost(K-1)

==================================================
COMPLEXITY
==================================================

Brute Force

Time  : O(n³)
Space : O(n)

Optimized

Time  : O(n)
Space : O(k)

==================================================
MEMORY TRICK
==================================================

Exactly(K)

=
AtMost(K)
-
AtMost(K-1)

Valid Window

→ count += right - left + 1

distinct > k

→ shrink

distinct <= k

→ count

==================================================
INTERVIEW IMPORTANCE
==================================================

Difficulty : Hard
Priority   : ⭐⭐⭐⭐⭐

Must Practice 5-6 Times

Very Common
Sliding Window Pattern

Exactly K Distinct
AtMost K Distinct
HashMap Frequency
==================================================
*/
