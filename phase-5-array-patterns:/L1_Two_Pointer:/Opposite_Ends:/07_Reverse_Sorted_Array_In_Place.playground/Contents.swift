import Foundation


//: 07_Reverse_Sorted_Array_In_Place


/*
==================================================
PROBLEM
==================================================

Reverse array in-place.

IMPORTANT:
Modify same array.

Do NOT create another array.

==================================================
EXAMPLE
==================================================

Input:
[1,2,3,4,5]

Output:
[5,4,3,2,1]

==================================================
BRUTE FORCE
==================================================

IDEA:
Create another reversed array.

NOT in-place.

TIME  : O(n)
SPACE : O(n)

INTERVIEW:
Not preferred
because extra space used.

==================================================
*/

var nums = [1,2,3,4,5]

var reverseNum = [Int]()

var i = nums.count - 1

while i >= 0 {

    reverseNum.append(nums[i])

    i -= 1
}

print(reverseNum)


/*
==================================================
OPTIMIZED - TWO POINTER
==================================================

MAIN IDEA:
Swap opposite ends.

left  -> start
right -> end

==================================================
POINTER MOVEMENT
==================================================

After swap:

left++
right--

Because:
current positions already fixed.

==================================================
TIME  : O(n)
SPACE : O(1)

INTERVIEW:
Preferred solution

==================================================
*/

nums = [1,2,3,4,5]

var left = 0
var right = nums.count - 1

while left < right {

    /*
     Manual swap
     */

    let temp = nums[right]

    nums[right] = nums[left]

    nums[left] = temp

    /*
     Move pointers
     */

    left += 1
    right -= 1
}

print(nums)


/*
==================================================
MOST IMPORTANT LEARNING
==================================================

Swap opposite ends.

Basic Opposite Ends
Two Pointer pattern.

==================================================
COMMON MISTAKES
==================================================

1. Forget pointer movement

2. Wrong loop condition

Correct:
while left < right

3. Creating extra array
when question asks in-place

==================================================
*/
