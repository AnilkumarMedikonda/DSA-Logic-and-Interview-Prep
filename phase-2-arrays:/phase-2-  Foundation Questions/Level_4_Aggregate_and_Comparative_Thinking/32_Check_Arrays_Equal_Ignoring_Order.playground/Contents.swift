import UIKit

/*
 Problem:
 - Check whether two arrays contain same elements
 - Order does not matter
 - Frequencies must also match

 Input:
 array1 = [1,2,3]
 array2 = [3,2,1]

 Output:
 true
*/


// MARK: - Approach 1: Sort And Compare

/*
 Approach:
 - First compare array sizes
 - Sort both arrays
 - Compare elements index by index

 Time: O(n log n)
 Space: O(n)
*/

var array1 = [1,2,3]
var array2 = [3,2,1]


func equalArray(_ arr1: [Int], _ arr2: [Int]) -> Bool {
    
    if arr1.count != arr2.count {
        return false
    }
    
    let sorted1 = arr1.sorted()
    let sorted2 = arr2.sorted()
    
    for i in 0..<sorted1.count {
        
        if sorted1[i] != sorted2[i] {
            return false
        }
    }
    
    return true
}

print(equalArray(array1, array2))



// MARK: - Approach 1: Sort And Compare

/*
 Approach:
 - First compare array sizes
 - Sort both arrays
 - Compare elements index by index

 Time: O(n log n)
 Space: O(n)
*/

// MARK: - Approach 2: Frequency Map ⭐ Interview Preferred

/*
 Approach:
 - Create frequency map for both arrays
 - Compare frequencies of each element
 - If any mismatch occurs
   arrays are not equal

 Time: O(n)
 Space: O(n)

 Interview:
 - Best optimized solution
 - Preferred in interviews
*/

var frequencyArray1 = [1,2,3]
var frequencyArray2 = [3,2,1]


func frequencyMap(_ arr: [Int]) -> [Int: Int] {
    
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


func equalArrayUsingFrequency(_ arr1: [Int], _ arr2: [Int]) -> Bool {
    
    if arr1.count != arr2.count {
        return false
    }
    
    let map1 = frequencyMap(arr1)
    let map2 = frequencyMap(arr2)
    
    
    for key in map1.keys {
        
        if map2[key] == nil {
            return false
        }
        
        if map1[key] != map2[key] {
            return false
        }
    }
    
    return true
}

print(equalArrayUsingFrequency(frequencyArray1, frequencyArray2))


/*
 Interview Notes:

 Approach 1: Sort + Compare
 - Easy to understand
 - Simple implementation
 - Uses predefined sorting
 - Time: O(n log n)

 Approach 2: Frequency Map ⭐
 - Best optimized interview solution
 - Uses hashing / dictionary concept
 - Faster lookup and comparison
 - Time: O(n)

 Interview Preference:
 - Start by explaining Sort + Compare
 - Then optimize using Frequency Map
 - This shows problem-solving growth

 Most interviewers prefer:
 ⭐ Frequency Map Solution
*/
