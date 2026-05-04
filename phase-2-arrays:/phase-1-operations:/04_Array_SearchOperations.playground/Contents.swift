import UIKit

// MARK: - 04. Array Search Operations

/*
Topics Covered:
1. Linear Search (Unsorted Array)
2. Binary Search - Iterative (Sorted Array)
3. Binary Search - Recursive (Sorted Array)

-----------------------------------------
Time Complexity:
- Linear Search  → O(n)
- Binary Search  → O(log n)

Space Complexity:
- Iterative      → O(1)
- Recursive      → O(log n)
-----------------------------------------
*/


// MARK: - Linear Search

var array = [10, 20, 30, 40, 50]
let target = 30

print("Array:", array)
print("Target:", target)

// Time Complexity: O(n)
// Space Complexity: O(1)

var isContains = false

for number in array {
    if number == target {
        isContains = true
        break
    }
}

print("\nLinear Search:")
print(isContains ? "Array contains the target" : "Target not found")


// MARK: - Binary Search (Iterative)

// Time Complexity: O(log n)
// Space Complexity: O(1)

func binarySearchIterative(_ numbers: [Int], _ target: Int) -> Bool {
    
    var left = 0
    var right = numbers.count - 1
    
    while left <= right {
        
        let mid = (left + right) / 2
        
        if numbers[mid] == target {
            return true
        } else if numbers[mid] > target {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    
    return false
}

print("\nBinary Search (Iterative):")
print(binarySearchIterative(array, target) ? "Found" : "Not Found")


// MARK: - Binary Search (Recursive)

// Time Complexity: O(log n)
// Space Complexity: O(log n)

func binarySearchRecursive(_ numbers: [Int], _ target: Int, _ left: Int, _ right: Int) -> Bool {
    
    if left > right {
        return false
    }
    
    let mid = (left + right) / 2
    
    if numbers[mid] == target {
        return true
    } else if numbers[mid] > target {
        return binarySearchRecursive(numbers, target, left, mid - 1)
    } else {
        return binarySearchRecursive(numbers, target, mid + 1, right)
    }
}

print("\nBinary Search (Recursive):")
print(binarySearchRecursive(array, target, 0, array.count - 1) ? "Found" : "Not Found")


// MARK: - Final Notes

/*
Key Points:
- Linear Search works on unsorted arrays
- Binary Search requires sorted array
- Iterative Binary Search is preferred (O(1) space)
- Recursive Binary Search uses extra stack space

Interview Tip:
Always mention:
"Binary Search requires sorted array"
*/
