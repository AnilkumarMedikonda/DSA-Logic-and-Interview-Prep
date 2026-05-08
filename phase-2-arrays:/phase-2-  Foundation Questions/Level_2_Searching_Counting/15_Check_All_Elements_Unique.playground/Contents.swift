import UIKit

// MARK: - 15_Check_All_Elements_Unique

/*
 Problem:
 - Check whether all elements in array are unique
 - Return false if duplicate found

 Input:
 array = [1,2,3,2,5]

 Output:
 false
*/


// MARK: - Approach 1: Nested Loop (Brute Force)

/*
 Approach:
 - Compare every element with every other element
 - If duplicate found
   mark as not unique

 Time: O(n²)
 Space: O(1)
*/

// MARK: - Approach 1

var array1 = [1,2,3,2,5]

var isUnique1 = true

for i in 0..<array1.count {
    
    for j in 0..<array1.count {
        
        if i != j && array1[i] == array1[j] {
            isUnique1 = false
            break
        }
    }
    
    if !isUnique1 {
        break
    }
}

print(isUnique1)




// MARK: - Approach 2: Using Set (Optimized)
/*
 Approach:
 - Traverse array one by one
 - Store visited elements in Set
 - If element already exists in Set
   duplicate found

 Time: O(n)
 Space: O(n)
*/

// MARK: - Approach 2

var array2 = [1,2,3,2,5]

var set = Set<Int>()

var isUnique2 = true

for number in array2 {
    
    if set.contains(number) {
        isUnique2 = false
        break
    }
    
    set.insert(number)
}

print(isUnique2)
