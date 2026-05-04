import UIKit
// ======================================================
// MARK: - COUNTING SORT (FULL NOTES + IMPLEMENTATION)
// ======================================================

/*
 Counting Sort is a NON-COMPARISON sorting algorithm.

 Instead of comparing elements, it counts how many times
 each value appears.

 ------------------------------------------------------

 WHEN TO USE:
 ✔ Integers only
 ✔ Small range (e.g., 0–100)

 ❌ Not suitable for large range (wastes memory)

 ------------------------------------------------------

 CORE IDEA:
 count[i] = frequency of number i

 Then rebuild array using counts.

 ------------------------------------------------------

 TIME COMPLEXITY:
 Best    → O(n + k)
 Average → O(n + k)
 Worst   → O(n + k)

 where:
 n = number of elements
 k = range (max value)

 ------------------------------------------------------

 SPACE COMPLEXITY:
 O(k) ❌ (extra count array)

 ------------------------------------------------------

 INTERVIEW LINE:
 "Counting Sort uses frequency counting to sort elements
 in linear time when the input range is limited."
*/

// ======================================================
// MARK: - COUNTING SORT (NO BUILT-INS)
// ======================================================

func countingSort(_ arr: [Int]) -> [Int] {
    
    // Step 1: Find max manually
    var maxVal = arr[0]
    for num in arr {
        if num > maxVal {
            maxVal = num
        }
    }
    
    // Step 2: Create count array
    var count = [Int]()
    for _ in 0...maxVal {
        count.append(0)
    }
    
    // Step 3: Count frequency
    for num in arr {
        count[num] += 1
    }
    
    // Step 4: Build sorted result
    var result = [Int]()
    
    for i in 0..<count.count {
        var freq = count[i]
        
        while freq > 0 {
            result.append(i)
            freq -= 1
        }
    }
    
    return result
}


// ======================================================
// MARK: - TEST CASES
// ======================================================

print("----- Counting Sort -----")

let arr1 = [4, 2, 2, 8, 3, 3, 1]
print(countingSort(arr1))   // [1, 2, 2, 3, 3, 4, 8]

let arr2 = [5, 1, 4, 2, 3]
print(countingSort(arr2))   // [1, 2, 3, 4, 5]

let arr3 = [1, 1, 1, 1]
print(countingSort(arr3))   // [1, 1, 1, 1]

let arr4 = [9]
print(countingSort(arr4))   // [9]


// ======================================================
// MARK: - DRY RUN EXAMPLE
// ======================================================

/*
 Input:
 [4, 2, 2, 8, 3, 3, 1]

 Step 1: Find max = 8

 Step 2: Count array size = 9 (0 to 8)

 Step 3: Count frequency
 count = [0,1,2,2,1,0,0,0,1]

 Step 4: Build result
 1 → once
 2 → twice
 3 → twice
 4 → once
 8 → once

 Output:
 [1, 2, 2, 3, 3, 4, 8]
*/


// ======================================================
// MARK: - FINAL SUMMARY
// ======================================================

/*
 PROS:
 ✔ Faster than O(n log n) when range is small
 ✔ Simple logic
 ✔ No comparisons

 CONS:
 ❌ Extra memory O(k)
 ❌ Not suitable for large numbers

 ------------------------------------------------------

 COMPARISON:

 Quick Sort → O(n log n), in-place
 Merge Sort → O(n log n), stable
 Counting Sort → O(n + k), fastest (if range small)

 ------------------------------------------------------

 FINAL VERDICT:

 Use Counting Sort when:
 ✔ Range is small
 ✔ Need linear time

 Otherwise:
 ✔ Use Quick Sort / Merge Sort
*/
