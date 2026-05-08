import UIKit


// MARK: - 35_Find_Uncommon_Elements_Between_Two_Arrays

/*
 Problem:
 - Find elements present in one array
   but not in the other array

 Input:
 array1 = [1,2,3,4]
 array2 = [3,4,5,6]

 Output:
 [1,2,5,6]
*/

// MARK: - Approach 1: Nested Loop (Brute Force)

/*
 Approach:
 - Traverse first array
 - Check element exists in second array
 - If not found
   add to uncommon array

 - Repeat same for second array

 Time: O(n * m)
 Space: O(k)

 Interview:
 - Basic brute force solution
*/

var bruteArray1 = [1,2,3,4]
var bruteArray2 = [3,4,5,6]

var bruteUncommonArray = [Int]()


// Elements only in first array

for i in 0..<bruteArray1.count {
    
    var found = false
    
    for j in 0..<bruteArray2.count {
        
        if bruteArray1[i] == bruteArray2[j] {
            
            found = true
            break
        }
    }
    
    if !found {
        bruteUncommonArray.append(bruteArray1[i])
    }
}


// Elements only in second array

for i in 0..<bruteArray2.count {
    
    var found = false
    
    for j in 0..<bruteArray1.count {
        
        if bruteArray2[i] == bruteArray1[j] {
            
            found = true
            break
        }
    }
    
    if !found {
        bruteUncommonArray.append(bruteArray2[i])
    }
}

print(bruteUncommonArray)


// MARK: - Approach 2: Frequency Map ⭐ Interview Preferred

/*
 Approach:
 - Create frequency maps for both arrays
 - Traverse second array
   add elements not present in first array
 - Traverse first array
   add elements not present in second array

 Time: O(n + m)
 Space: O(n + m)

 Interview:
 - Best optimized solution
 - Preferred in interviews
*/

var frequencyArray1 = [1,2,3,4]
var frequencyArray2 = [3,4,5,6]

var frequencyUncommonArray = [Int]()


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


let frequencyMap1 = frequency(frequencyArray1)
let frequencyMap2 = frequency(frequencyArray2)


for number in frequencyArray2 {
    
    if frequencyMap1[number] == nil {
        
        frequencyUncommonArray.append(number)
    }
}


for number in frequencyArray1 {
    if frequencyMap2[number] == nil {
        frequencyUncommonArray.append(number)
    }
}

print(frequencyUncommonArray)
