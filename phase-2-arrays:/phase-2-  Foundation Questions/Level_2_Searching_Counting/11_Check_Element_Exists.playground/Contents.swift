import UIKit




// MARK: - 11_Check_Element_Exists

/*
 Problem:
 - Check whether target element exists in array

 Input:
 array = [1,2,3,4,5]
 target = 3

 Output:
 true
*/


// Solution 1


/*
 Approach:
 - Traverse array one by one
 - Compare each element with target
 - If found → return true

 Best Use:
 - Unsorted arrays
 - Simple searching

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5]
let target = 3

var isContains = false

for number in array {
    
    if number == target {
        isContains = true
        break
    }
}

print(isContains)


// Works ONLY on sorted arrays
// Solution 2


/*
 Approach:
 - Find middle element
 - Compare target with middle
 - Recursively search left or right half

 Best Use:
 - Learning recursion
 - Sorted arrays

 Time: O(n)      // array slicing copies elements
 Space: O(n)
*/

func binarySearch(_ key: Int, _ elements: [Int]) -> Bool {
    
    if elements.isEmpty {
        return false
    }
    
    let midIndex = elements.count / 2
    let midValue = elements[midIndex]
    
    if midValue == key {
        return true
    }
    
    if elements.count == 1 {
        return false
    }
    
    if key < midValue {
        
        let sliceArray = Array(elements[0..<midIndex])
        return binarySearch(key, sliceArray)
    }
    
    else {
        
        let sliceArray = Array(elements[midIndex+1..<elements.count])
        return binarySearch(key, sliceArray)
    }
}

print(binarySearch(3, [1,2,3,4,5]))


// Works ONLY on sorted arrays


/*
 Approach:
 - Use firstIndex and lastIndex
 - Find middle element
 - Reduce search space iteratively

 Best Use:
 - Product company interviews
 - Optimized searching

 Time: O(log n)
 Space: O(1)
*/

func binarySearchIterative(_ num: Int, _ array: [Int]) -> Bool {
    
    var firstIndex = 0
    var lastIndex = array.count - 1
    
    while firstIndex <= lastIndex {
        
        let mid = (firstIndex + lastIndex) / 2
        
        if array[mid] == num {
            return true
        }
        
        if num < array[mid] {
            lastIndex = mid - 1
        }
        
        else {
            firstIndex = mid + 1
        }
    }
    
    return false
}

print(binarySearchIterative(3, [1,2,3,4,5]))

/*
🔥 Interview Comparison

| Approach                | Time       | Space  | Works on Unsorted? | Interview Value |
| ----------------------- | ---------- | ------ | ------------------ | --------------- |
| Linear Search           | O(n)       | O(1)   | ✅ Yes              | Basic           |
| Recursive Binary Search | O(n)*      | O(n)   | ❌ No               | Medium          |
| Iterative Binary Search | ✅ O(log n) | ✅ O(1) | ❌ No               | ⭐ Best          |

*/


/*
 1. Explain Linear Search first
 2. Then optimize using Binary Search
 3. Mention Binary Search requires sorted array
*/


/*
 Linear search works for any array.
 Binary search optimizes lookup for sorted arrays.
 Iterative Binary Search is the most interview-preferred approach.
*/
