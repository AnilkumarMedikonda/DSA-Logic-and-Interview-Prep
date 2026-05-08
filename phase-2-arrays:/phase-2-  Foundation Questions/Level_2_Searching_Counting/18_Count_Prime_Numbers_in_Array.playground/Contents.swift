import UIKit

// MARK: - 18_Count_Prime_Numbers_in_Array

/*
 Problem:
 - Count how many prime numbers exist in array

 Input:
 array = [1,2,3,4,5,6,7]

 Output:
 4
*/


// MARK: - Approach: Prime Checking

/*
 Approach:
 - Traverse array one by one
 - Check each number is prime
 - Increment count if prime

 Time: O(n²)
 Space: O(1)
*/

var array = [1,2,3,4,5,6,7]

var primeCount = 0

for number in array {
    
    if isPrimeNumber(number) {
        primeCount += 1
    }
}

print(primeCount)


func isPrimeNumber(_ number: Int) -> Bool {
    
    if number <= 1 {
        return false
    }
    
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}
