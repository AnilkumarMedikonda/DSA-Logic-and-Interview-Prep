
import UIKit

// ======================================================
// MARK: - QUICK SORT (FULL NOTES + IMPLEMENTATION)
// ======================================================

/*
 Quick Sort is a Divide & Conquer algorithm.

 Steps:
 1. Pick a pivot
 2. Partition the array (place pivot in correct position)
 3. Recursively sort left and right subarrays

 ------------------------------------------------------

 TIME COMPLEXITY:
 Best    → O(n log n)
 Average → O(n log n)
 Worst   → O(n²)  (when array is already sorted and bad pivot chosen)

 SPACE COMPLEXITY:
 Concept Version → O(n) ❌ (extra arrays)
 In-place Version → O(log n) ✅ (recursion stack)

 ------------------------------------------------------

 INTERVIEW ANSWER:
 "In-place partition-based Quick Sort is preferred because it reduces space complexity
 and avoids extra memory usage."
*/

// ======================================================
// MARK: - 1. Concept Version (Extra Arrays)
// ======================================================

/*
 Easy to understand but NOT optimal for interviews
 */

func quickSortConcept(_ numbers: [Int]) -> [Int] {
    
    // Base case
    if numbers.count <= 1 {
        return numbers
    }
    
    let pivot = numbers[0]
    
    var less: [Int] = []
    var equal: [Int] = []
    var greater: [Int] = []
    
    for number in numbers {
        if number < pivot {
            less.append(number)
        } else if number > pivot {
            greater.append(number)
        } else {
            equal.append(number)
        }
    }
    
    return quickSortConcept(less) + equal + quickSortConcept(greater)
}


// ======================================================
// MARK: - 2. Partition (Lomuto Technique)
// ======================================================

/*
 Partition Logic:
 - pivot = last element
 - i = boundary for smaller elements
 - j = scanning pointer

 After partition:
 [ smaller | pivot | greater ]
*/

func partition(_ arr: inout [Int], _ low: Int, _ high: Int) -> Int {
    
    let pivot = arr[high]
    var i = low
    
    for j in low..<high {
        if arr[j] < pivot {
            // swap(arr[i], arr[j])
            let temp = arr[i]
            arr[i] = arr[j]
            arr[j] = temp
            
            i += 1
        }
    }
    
    // place pivot at correct position
    let temp = arr[i]
    arr[i] = arr[high]
    arr[high] = temp
    
    return i
}


// ======================================================
// MARK: - 3. Quick Sort (In-place - Interview Version)
// ======================================================

/*
 Recursive Logic:
 - Sort left side (low → pivotIndex - 1)
 - Sort right side (pivotIndex + 1 → high)
*/

func quickSort(_ arr: inout [Int], _ low: Int, _ high: Int) {
    
    if low < high {
        
        let pivotIndex = partition(&arr, low, high)
        
        // Left side
        quickSort(&arr, low, pivotIndex - 1)
        
        // Right side
        quickSort(&arr, pivotIndex + 1, high)
    }
}


// ======================================================
// MARK: - TEST CASES
// ======================================================

print("----- Concept Version -----")
print(quickSortConcept([5, 3, 8, 4, 2]))
print(quickSortConcept([1, 2, 3, 4, 5]))

print("\n----- In-place Version -----")

var arr1 = [5, 3, 8, 4, 2]
quickSort(&arr1, 0, arr1.count - 1)
print(arr1)

var arr2 = [1, 2, 3, 4, 5]
quickSort(&arr2, 0, arr2.count - 1)
print(arr2)

var arr3 = [5, 4, 3, 2, 1]
quickSort(&arr3, 0, arr3.count - 1)
print(arr3)

var arr4 = [4, 2, 5, 2, 3]
quickSort(&arr4, 0, arr4.count - 1)
print(arr4)

var arr5 = [2, 2, 2, 2]
quickSort(&arr5, 0, arr5.count - 1)
print(arr5)


// ======================================================
// MARK: - FINAL SUMMARY
// ======================================================

/*
 Concept Version:
 - Easy to understand
 - Uses extra memory (O(n))

 Partition Version:
 - In-place (O(log n))
 - Interview standard
 - Better performance in real-world

 FINAL VERDICT:
 Learn → Concept
 Use   → Partition 🔥
*/
