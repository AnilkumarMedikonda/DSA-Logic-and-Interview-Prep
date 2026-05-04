import UIKit

// MARK: - 01. Array Basic Operations

/*
Topics Covered:
1. Access element
2. Update element
3. Traverse array
4. Find length

+ Swift Helpers:
5. isEmpty
6. first / last
7. contains
8. firstIndex
9. append
10. removeLast
11. removeAll
12. enumerated
*/

// MARK: - Sample Array
var array = [10, 20, 30, 40, 30, 40]
print("Initial Array:", array)


// MARK: - DSA Basic Operations

// 1️⃣ Access element
// Time Complexity: O(1)
// Space Complexity: O(1)
print("\n1️⃣ Access Element:")
print("Element at index 2:", array[2])


// 2️⃣ Update element
// Time Complexity: O(1)
// Space Complexity: O(1)
print("\n2️⃣ Update Element:")
array[1] = 45
print("Updated Array:", array)


// 3️⃣ Traverse array
// Time Complexity: O(n)
// Space Complexity: O(1)
print("\n3️⃣ Traverse Array:")
for element in array {
    print(element)
}


// 4️⃣ Find length
// Time Complexity: O(1)
// Space Complexity: O(1)
print("\n4️⃣ Array Length:")
print("Count:", array.count)


// MARK: - Swift Built-in Operations

// 5️⃣ Check empty
// Time Complexity: O(1)
// Space Complexity: O(1)
print("\n5️⃣ Is Empty:")
print(array.isEmpty)


// 6️⃣ First / Last
// Time Complexity: O(1)
// Space Complexity: O(1)
print("\n6️⃣ First & Last:")
print("First:", array.first ?? "nil")
print("Last:", array.last ?? "nil")


// 7️⃣ Contains element
// Time Complexity: O(n) → Linear search
// Space Complexity: O(1)
print("\n7️⃣ Contains 30:")
print(array.contains(30))


// 8️⃣ Find index
// Time Complexity: O(n)
// Space Complexity: O(1)
print("\n8️⃣ Index of 40:")
if let index = array.firstIndex(of: 40) {
    print("Index:", index)
} else {
    print("Not found")
}


// 9️⃣ Append element
// Time Complexity: O(1) amortized
// Space Complexity: O(1)
print("\n9️⃣ Append:")
array.append(60)
print("After append:", array)


// 🔟 Remove last
// Time Complexity: O(1)
// Space Complexity: O(1)
print("\n🔟 Remove Last:")
array.removeLast()
print("After removeLast:", array)


// 1️⃣1️⃣ Remove all
// Time Complexity: O(n)
// Space Complexity: O(1)
print("\n1️⃣1️⃣ Remove All:")
array.removeAll()
print("After removeAll:", array)


// 1️⃣2️⃣ Enumerated loop
// Time Complexity: O(n)
// Space Complexity: O(1)
print("\n1️⃣2️⃣ Enumerated Loop:")
for (index, value) in array.enumerated() {
    print("Index \(index): \(value)")
}


// MARK: - Final Notes
/*
Key Points:
- Arrays provide O(1) random access
- Searching takes O(n)
- Append is O(1) amortized (due to resizing)
- removeAll() clears entire array → O(n)
*/
