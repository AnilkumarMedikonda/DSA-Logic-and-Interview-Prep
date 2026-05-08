import UIKit
// MARK: - 47_Count_Pairs_With_Given_Sum

/*
 ====================================================
 Problem:
 ====================================================

 - Count pairs whose sum equals target

 Input:
 array = [1,2,3,4,5]
 target = 9

 Output:
 1

 Pair:
 (4,5)

 ====================================================
*/


// MARK: - Approach 1: Brute Force

/*
 ====================================================
 Approach:
 ====================================================

 - Use nested loops
 - Compare every pair
 - If sum == target
      → Count pair

 ----------------------------------------------------
 Time Complexity  : O(n²)
 Space Complexity : O(1)
 ----------------------------------------------------

 Interview:
 - Easy to understand
 - Good as initial solution
 - NOT best optimized approach

 ====================================================
*/

var array = [1,2,3,4,5]

var target = 9
var count = 0

for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        if array[i] + array[j] == target {
            
            print("(\(array[i]), \(array[j]))")
            count += 1
        }
    }
}

print(count)

// MARK: - Approach 2: HashMap / Dictionary (Best Interview Approach)

/*
 ====================================================
 Approach:
 ====================================================

 - Store visited elements in dictionary
 - Find complement:
      target - currentNumber
 - If complement exists
      → Pair found

 ----------------------------------------------------
 Time Complexity  : O(n)
 Space Complexity : O(n)
 ----------------------------------------------------

 Interview:
 - BEST optimized solution
 - Most asked interview approach
 - Preferred in Amazon / Google / Walmart

 ====================================================
*/

func twoSumDifferentApproach(_ array: [Int], target: Int) {
    
    var dict = [Int: Int]()
    var count = 0
    
    for (index, number) in array.enumerated() {
        
        let complement = target - number
        
        if let complementIndex = dict[complement] {
            
            print("(\(array[complementIndex]), \(number))")
            count += 1
        }
        
        dict[number] = index
    }
    
    print(count)
}

twoSumDifferentApproach(array, target: target)


// ----------------------------------------------------
// BEST INTERVIEW APPROACH
// T - O(n)
// S - O(n)
// ----------------------------------------------------
