import UIKit

// MARK: - 03. Array Delete Operations

/*
Topics Covered:
1. Delete at end
2. Delete at beginning
3. Delete at given index
4. Delete by value

+ Concepts:
- Left shifting
- Maintaining size
*/

// MARK: - Sample Array (extra space not required here)
var array = [10, 20, 30, 40, 50]
var size = 5

print("Initial Array:")
for i in 0..<size {
    print(array[i], terminator: " ")
}
print()


// MARK: - 1️⃣ Delete at End

// Time Complexity: O(1)
// Space Complexity: O(1)

size -= 1

print("\nAfter Delete at End:")
for i in 0..<size {
    print(array[i], terminator: " ")
}
print()


// MARK: - 2️⃣ Delete at Beginning

// Time Complexity: O(n)
// Space Complexity: O(1)

// Shift left
var i = 0
while i < size - 1 {
    array[i] = array[i + 1]
    i += 1
}

size -= 1

print("\nAfter Delete at Beginning:")
for i in 0..<size {
    print(array[i], terminator: " ")
}
print()


// MARK: - 3️⃣ Delete at Given Index

// Time Complexity: O(n)
// Space Complexity: O(1)

let index = 1

var j = index
while j < size - 1 {
    array[j] = array[j + 1]
    j += 1
}

size -= 1

print("\nAfter Delete at Index \(index):")
for i in 0..<size {
    print(array[i], terminator: " ")
}
print()


let value = 40

var foundeIndex = -1

for k in 0..<size {
    
    if array[k] == value {
        foundeIndex = k
        break
    }
}

if foundeIndex != -1 {
    var m = foundeIndex
    while m < size - 1 {
        array[m] = array[m+1]
    }
    size -= 1
}
