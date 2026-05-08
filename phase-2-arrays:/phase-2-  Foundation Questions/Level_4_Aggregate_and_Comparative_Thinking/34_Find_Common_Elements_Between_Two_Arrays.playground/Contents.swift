import UIKit

/*
 Problem:
 - Find common elements present in both arrays
 - Store common elements in a new array

 Input:
 array1 = [1,2,3,4]
 array2 = [3,4,5,6]

 Output:
 [3,4]
*/



// MARK: - Approach 1: Nested Loop


/*
 Approach:
 - Compare every element from first array
   with every element from second array
 - If elements match
   add to result array

 Time: O(n * m)
 Space: O(k)
*/

var nestedArray1 = [1,2,3,4]
var nestedArray2 = [3,4,5,6]

var nestedCommonArray = [Int]()


for i in 0..<nestedArray1.count {
    
    for j in 0..<nestedArray2.count {
        
        if nestedArray1[i] == nestedArray2[j] {
            
            nestedCommonArray.append(nestedArray1[i])
        }
    }
}

print(nestedCommonArray)


// MARK: - Approach 2: Frequency Map

/*
 Approach:
 - Store elements of first array in dictionary
 - Traverse second array
 - If element exists in dictionary
   add to result array

 Time: O(n + m)
 Space: O(n)

 Interview:
 - Best optimized solution
 - Preferred in interviews
*/

var frequencyArray1Input = [1,2,3,4]
var frequencyArray2Input = [3,4,5,6]

var frequencyCommonArray = [Int]()


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


let frequencyArray = frequency(frequencyArray1Input)


for number in frequencyArray2Input {
    
    if frequencyArray[number] != nil {
        
        frequencyCommonArray.append(number)
    }
}

print(frequencyCommonArray)
