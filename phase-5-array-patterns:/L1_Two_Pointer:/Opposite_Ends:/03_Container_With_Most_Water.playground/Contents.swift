import Foundation


//: Playground - 03_Container_With_Most_Water


/*
============================================================
03_Container_With_Most_Water
============================================================

PROBLEM:
Given array of heights,
find maximum water container.

EXAMPLE:
height = [1,8,6,2,5,4,8,3,7]

PATTERN:
Two Pointer / Opposite Ends

============================================================
IMPORTANT FORMULA
============================================================

Area = width * minHeight

width = right - left

minHeight = min(leftHeight, rightHeight)

============================================================
MOST IMPORTANT UNDERSTANDING
============================================================

Water depends on:
smaller height

NOT larger height.

WHY?
Smaller wall limits water storage.

============================================================
*/

var heights = [1,8,6,2,5,4,8,3,7]


// MARK: ====================================================
// MARK: - BRUTE FORCE
// MARK: ====================================================

/*
BRUTE FORCE IDEA:
Check every possible pair.

For every:
i and j

Calculate:
1. width
2. minimum height
3. area

Track maximum area.

TIME  : O(n²)
SPACE : O(1)

WHY NOT BEST?
Repeated pair checking.
*/

print("===== BRUTE FORCE =====")

var maxArea = 0

for i in 0..<heights.count {

    for j in i + 1..<heights.count {

        let width = j - i

        let height = min(
            heights[i],
            heights[j]
        )

        let area = width * height

        print("""
        leftHeight  : \(heights[i])
        rightHeight : \(heights[j])
        width       : \(width)
        minHeight   : \(height)
        area        : \(area)
        """)

        maxArea = max(maxArea, area)
    }
}

print("Max Area:", maxArea)


// MARK: ====================================================
// MARK: - OPTIMIZED TWO POINTER
// MARK: ====================================================

/*
OPTIMIZED IDEA:

left  -> start
right -> end

Calculate area.

Move:
smaller height pointer

WHY?
Smaller height limits water.

Need possibility of:
larger minimum height.

TIME  : O(n)
SPACE : O(1)

WHY O(n)?
Each pointer moves at most once.
*/

print("\n===== OPTIMIZED =====")

maxArea = 0

var left = 0
var right = heights.count - 1

while left < right {

    let width = right - left

    let height = min(
        heights[left],
        heights[right]
    )

    let area = width * height

    print("""
    leftHeight  : \(heights[left])
    rightHeight : \(heights[right])
    width       : \(width)
    minHeight   : \(height)
    area        : \(area)
    """)

    maxArea = max(maxArea, area)

    /*
     Move smaller height pointer
     */

    if heights[left] > heights[right] {

        right -= 1
    }
    else {

        left += 1
    }
}

print("Max Area:", maxArea)


/*
============================================================
WHY POINTER MOVEMENT WORKS?
============================================================

Suppose:

leftHeight  = 2
rightHeight = 10

Water depends on:
2

Even if:
10 becomes 100

Water still limited by:
2

So:
moving larger height usually useless.

Need chance for:
larger minimum height.

============================================================
COMMON MISTAKES
============================================================

1. Moving larger height pointer

2. Forgetting width formula

3. Using max height instead of min

4. Wrong area calculation

============================================================
PATTERN SIGNALS
============================================================

- maximum area
- opposite ends
- shrinking window
- move smaller pointer

=> Two Pointer / Opposite Ends

============================================================
INTERVIEW SUMMARY
============================================================

BRUTE FORCE:
check every pair

OPTIMIZED:
move smaller height pointer

MOST IMPORTANT CONCEPT:
smaller wall limits water

============================================================
*/
