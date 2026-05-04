import UIKit

// MARK: - 02. Array Insert Operations

/*
Topics Covered:
1. Insert at end
2. Insert at beginning
3. Insert at given index

+ Concepts:
- Element shifting
- Edge cases
*/

// MARK: - Sample Array
var array = [10, 20, 30, 40]
print("Initial Array:", array)


// MARK: - 1️⃣ Insert at End
// Time Complexity: O(1) amortized
// Space Complexity: O(1)

array.append(50)
print("\nAfter append:", array)


// MARK: - 2️⃣ Insert at Beginning
// Time Complexity: O(n)
// Space Complexity: O(1)

array.insert(5, at: 0)
print("\nAfter inserting at beginning:", array)


// MARK: - 3️⃣ Insert at Given Index
// Time Complexity: O(n)
// Space Complexity: O(1)

array.insert(25, at: 3)
print("\nAfter inserting at index 3:", array)


// MARK: - 4️⃣ Manual Insert (DSA Logic)
// Time Complexity: O(n)
// Space Complexity: O(1)

var manualArray = [10, 20, 30, 40]
let newElement = 25
let insertIndex = 2

manualArray.append(0) // increase size

var i = manualArray.count - 1
while i > insertIndex {
    manualArray[i] = manualArray[i - 1]
    i -= 1
}

manualArray[insertIndex] = newElement

print("\nAfter manual insert:", manualArray)


// MARK: - Edge Cases

array.insert(99, at: 0)
array.insert(100, at: array.count)

print("\nAfter edge case inserts:", array)


// MARK: - Reverse Operation (Separate Section)

var newArray = [10, 20, 30, 40]
let lastIndex = newArray.count - 1
var r = 0

while r < newArray.count / 2 {
    let temp = newArray[lastIndex - r]
    newArray[lastIndex - r] = newArray[r]
    newArray[r] = temp
    r += 1
}

print("\nReversed Array:", newArray)
