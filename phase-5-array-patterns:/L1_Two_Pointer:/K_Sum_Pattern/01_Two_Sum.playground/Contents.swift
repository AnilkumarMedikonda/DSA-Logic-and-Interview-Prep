import Foundation
//: 01_Two_Sum

/*
==================================================
PROBLEM
==================================================

Find 2 numbers whose sum == target

nums = [2,7,11,15]
target = 9

==================================================
BRUTE FORCE
==================================================

IDEA:
Check every pair

TIME  : O(n²)
SPACE : O(1)

INTERVIEW:
Good for explaining basic logic
Not best optimized solution

==================================================
*/

var nums = [2,7,11,15]
var target = 9

for i in 0..<nums.count {

    for j in (i + 1)..<nums.count {
        if nums[i] + nums[j] == target {
            print(nums[i], nums[j])
        }
    }
}


/*
==================================================
TWO POINTER
==================================================

IMPORTANT:
Works best for sorted arrays

IDEA:
left  -> start
right -> end

sum < target
=> left++

sum > target
=> right--

TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Best for sorted arrays
Usually called:
Two Sum II

==================================================
*/

nums.sort()

var left = 0
var right = nums.count - 1

while left < right {

    let sum =
    nums[left] + nums[right]

    if sum == target {

        print(nums[left], nums[right])
        break
    }

    else if sum < target {

        left += 1
    }

    else {

        right -= 1
    }
}


/*
==================================================
HASHMAP
==================================================

IMPORTANT:
Best for normal unsorted Two Sum

IDEA:
target - currentValue

Store:
value -> seen before

TIME  : O(n)
SPACE : O(n)

INTERVIEW:
Most expected optimized solution
for normal Two Sum

==================================================
*/

var frequencyMap = [Int: Bool]()

for num in nums {

    let complement =
    target - num

    if frequencyMap[complement] != nil {

        print(num, complement)
    }

    frequencyMap[num] = true
}


/*
==================================================
INTERVIEW SUMMARY
==================================================

Brute Force
-> Easy
-> O(n²)

Two Pointer
-> Best for sorted arrays
-> O(n)

HashMap
-> Best for unsorted arrays
-> O(n)

==================================================
*/
