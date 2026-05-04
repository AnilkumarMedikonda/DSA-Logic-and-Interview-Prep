import UIKit

// ======================================================
// MARK: - RADIX SORT (FULL NOTES + IMPLEMENTATION)
// ======================================================

/*
 Radix Sort is a NON-COMPARISON sorting algorithm.

 It sorts numbers digit by digit from:
 Least Significant Digit → Most Significant Digit

 ------------------------------------------------------

 CORE IDEA:

 1. Sort numbers based on units place
 2. Then tens place
 3. Then hundreds place
 4. Continue until max digit

 IMPORTANT:
 Each step must be STABLE sorting (order preserved)

 ------------------------------------------------------

 WHEN TO USE:

 ✔ Large number of elements
 ✔ Numbers with small digit length
 ✔ When you want better than O(n log n)

 ------------------------------------------------------

 TIME COMPLEXITY:

 O(n × k)

 n = number of elements
 k = number of digits

 ------------------------------------------------------

 SPACE COMPLEXITY:

 O(n + k)

 ------------------------------------------------------

 INTERVIEW LINE:

 "Radix Sort processes digits from least significant to most
 using a stable sorting method like counting sort."
*/


// ======================================================
// MARK: - RADIX SORT
// ======================================================

func radixSort(_ arr: inout [Int]) {
    
    // Step 1: find max manually
    var maxVal = arr[0]
    for num in arr {
        if num > maxVal {
            maxVal = num
        }
    }
    
    var exp = 1   // 1 → units, 10 → tens, 100 → hundreds
    
    while maxVal / exp > 0 {
        countingSortByDigit(&arr, exp)
        exp *= 10
    }
}


// ======================================================
// MARK: - COUNTING SORT BY DIGIT (STABLE)
// ======================================================

func countingSortByDigit(_ arr: inout [Int], _ exp: Int) {
    
    let n = arr.count
    
    var output = [Int](repeating: 0, count: n)
    var count = [Int](repeating: 0, count: 10) // digits 0–9
    
    // Step 1: Count digit frequency
    for i in 0..<n {
        let digit = (arr[i] / exp) % 10
        count[digit] += 1
    }
    
    // Step 2: Prefix sum (for positions)
    for i in 1..<10 {
        count[i] += count[i - 1]
    }
    
    // Step 3: Build output (RIGHT → LEFT for stability)
    var i = n - 1
    while i >= 0 {
        let digit = (arr[i] / exp) % 10
        output[count[digit] - 1] = arr[i]
        count[digit] -= 1
        i -= 1
    }
    
    // Step 4: Copy back
    for i in 0..<n {
        arr[i] = output[i]
    }
}


// ======================================================
// MARK: - TEST CASES
// ======================================================

print("----- Radix Sort -----")

var arr1 = [170, 45, 75, 90]
radixSort(&arr1)
print(arr1)   // [45, 75, 90, 170]

var arr2 = [802, 24, 2, 66]
radixSort(&arr2)
print(arr2)   // [2, 24, 66, 802]


// ======================================================
// MARK: - DRY RUN EXAMPLE
// ======================================================

/*
 Input:
 [170, 45, 75, 90]

 Step 1 (units):
 → [170, 90, 45, 75]

 Step 2 (tens):
 → [45, 170, 75, 90]

 Step 3 (hundreds):
 → [45, 75, 90, 170]

 Final:
 [45, 75, 90, 170]
*/


// ======================================================
// MARK: - FINAL SUMMARY
// ======================================================

/*
 PROS:
 ✔ Faster than comparison sorts for specific cases
 ✔ Linear time when k is small
 ✔ Stable sorting

 CONS:
 ❌ Uses extra space
 ❌ Works only for integers
 ❌ Complex compared to Quick Sort

 ------------------------------------------------------

 COMPARISON:

 Quick Sort → O(n log n), in-place
 Merge Sort → O(n log n), stable
 Counting Sort → O(n + k)
 Radix Sort → O(n × k)

 ------------------------------------------------------

 FINAL VERDICT:

 ✔ Learn concept
 ✔ Mention in interviews
 ❌ Rarely required to implement fully
*/
