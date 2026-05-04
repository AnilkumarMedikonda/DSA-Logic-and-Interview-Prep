import UIKit

// ======================================================
// MARK: - MERGE SORT
// ======================================================

/*
 Merge Sort is a Divide & Conquer algorithm.

 Steps:
 1. Divide the array into two halves
 2. Recursively sort both halves
 3. Merge the sorted halves

 ------------------------------------------------------

 TIME COMPLEXITY:
 Best    → O(n log n)
 Average → O(n log n)
 Worst   → O(n log n)  ✅ (always same)

 ------------------------------------------------------

 SPACE COMPLEXITY:
 O(n) ❌ (extra arrays used for merging)

 ------------------------------------------------------

 KEY POINTS:
 - Stable sorting algorithm ✅
 - Always O(n log n)
 - Uses extra space
 - Preferred when stability is required

 ------------------------------------------------------

 INTERVIEW LINE:
 "Merge Sort divides the array recursively and merges
 sorted halves using two-pointer technique."
*/

// ======================================================
// MARK: - MERGE FUNCTION (CORE LOGIC)
// ======================================================

/*
 Merge two sorted arrays into one sorted array
 */

func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var result: [Int] = []
    var i = 0
    var j = 0
    // Compare elements from both arrays
    while i < left.count && j < right.count {
        if left[i] < right[j] {
            result.append(left[i])
            i += 1
        } else {
            result.append(right[j])
            j += 1
        }
    }
    // Remaining elements (left)
    while i < left.count {
        result.append(left[i])
        i += 1
    }
    // Remaining elements (right)
    while j < right.count {
        result.append(right[j])
        j += 1
    }
    return result
}


// ======================================================
// MARK: - MERGE SORT (RECURSION)
// ======================================================

/*
 Recursive divide + merge
 */

func mergeSort(_ array: [Int]) -> [Int] {
    // Base case
    if array.count <= 1 {
        return array
    }
    let mid = array.count / 2
    let left = mergeSort(Array(array[0..<mid]))
    let right = mergeSort(Array(array[mid..<array.count]))
    return merge(left, right)
}


// ======================================================
// MARK: - TEST CASES
// ======================================================

print("----- Merge Sort -----")

let arr1 = [8, 3, 5, 2]
print(mergeSort(arr1))  // [2, 3, 5, 8]

let arr2 = [5, 1, 4, 2, 3]
print(mergeSort(arr2))  // [1, 2, 3, 4, 5]

let arr3 = [1, 2, 3, 4]
print(mergeSort(arr3))  // [1, 2, 3, 4]

let arr4 = [4, 4, 2, 2, 1]
print(mergeSort(arr4))  // [1, 2, 2, 4, 4]

let arr5 = [7]
print(mergeSort(arr5))  // [7]


// ======================================================
// MARK: - DRY RUN EXAMPLE
// ======================================================

/*
 Input:
 [8, 3, 5, 2]

 Step 1: Split
 [8,3]     [5,2]

 Step 2: Split again
 [8] [3]   [5] [2]

 Step 3: Merge
 [8] + [3] → [3,8]
 [5] + [2] → [2,5]

 Step 4: Final Merge
 [3,8] + [2,5] → [2,3,5,8]
*/


// ======================================================
// MARK: - FINAL SUMMARY
// ======================================================

/*
 Quick Sort vs Merge Sort:

 Quick Sort:
 - In-place (O(log n) space)
 - Faster in practice
 - Worst case O(n²)

 Merge Sort:
 - Stable
 - Always O(n log n)
 - Uses extra space O(n)

 ------------------------------------------------------

 FINAL VERDICT:

 Quick Sort → Best for general use 🔥
 Merge Sort → Best for stability / guaranteed performance
*/
