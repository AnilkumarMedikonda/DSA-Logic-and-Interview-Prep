import UIKit

// MARK: - 36_Count_Common_Elements

/*
 Problem:
 - Count how many common elements
   are present in both arrays

 Input:
 array1 = [1,2,3,4]
 array2 = [3,4,5,6]

 Output:
 2
*/


// MARK: - Approach 1: Nested Loop (Brute Force)

/*
 Approach:
 - Traverse first array
 - Compare each element with second array
 - If matching element found
   increment count

 Time: O(n * m)
 Space: O(1)

 Interview:
 - Basic brute force solution
*/

var bruteArray1 = [1,2,3,4]
var bruteArray2 = [3,4,5,6]

var bruteCount = 0


for i in 0..<bruteArray1.count {
    
    var isContains = false
    
    for j in 0..<bruteArray2.count {
        
        if bruteArray1[i] == bruteArray2[j] {
            
            isContains = true
            break
        }
    }
    
    if isContains {
        bruteCount += 1
    }
}

print(bruteCount)


// MARK: - Approach 2: Frequency Map ⭐ Interview Preferred

/*
 Approach:
 - Create frequency map for first array
 - Traverse second array
 - If element exists in frequency map
   increment count

 Time: O(n + m)
 Space: O(n)

 Interview:
 - Best optimized solution
 - Preferred in interviews
*/

var frequencyArray1 = [1,2,3,4]
var frequencyArray2 = [3,4,5,6]

var optimizedCount = 0


func frequency(_ arr: [Int]) -> [Int: Int] {
    
    var dict = [Int: Int]()
    
    for number in arr {
        
        if let value = dict[number] {
            
            dict[number] = value + 1
            
        } else {
            
            dict[number] = 1
        }
    }
    
    return dict
}


let frequencyMap = frequency(frequencyArray1)


for number in frequencyArray2 {
    
    if frequencyMap[number] != nil {
        
        optimizedCount += 1
    }
}

print(optimizedCount)
