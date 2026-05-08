import UIKit

// MARK: - 20_Count_Perfect_Squares

/*
 Problem:
 - Count how many perfect squares exist in array

 Input:
 array = [1,4,7,9,10,16]

 Output:
 4
*/


// MARK: - Approach 1: Manual Multiplication Check

/*
 Approach:
 - Traverse array one by one
 - Check whether any number multiplied by itself
   equals current number
 - If yes, it is a perfect square

 Time: O(n²)
 Space: O(1)
*/

var array1 = [1,4,7,9,10,16]

var count1 = 0


func isSquare(_ number: Int) -> Bool {
    
    if number < 1 {
        return false
    }
    
    for i in 1...number {
        if i * i == number {
            return true
        }
    }
    return false
}


for number in array1 {
    
    if isSquare(number) {
        count1 += 1
    }
}

print(count1)


// MARK: - Approach 2: Using squareRoot()

/*
 Approach:
 - Find square root of number
 - Multiply root by itself
 - If result equals original number
   then it is a perfect square

 Time: O(n)
 Space: O(1)
*/

import Foundation

var array2 = [1,4,7,9,10,16]

var count2 = 0


func isPerfectSquare(_ number: Int) -> Bool {
    
    let root = Int(Double(number).squareRoot())
    
    return root * root == number
}


for number in array2 {
    
    if isPerfectSquare(number) {
        count2 += 1
    }
}

print(count2)
