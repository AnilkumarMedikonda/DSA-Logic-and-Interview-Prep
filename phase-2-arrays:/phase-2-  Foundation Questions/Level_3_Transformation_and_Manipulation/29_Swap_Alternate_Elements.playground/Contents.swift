// MARK: - 29_Swap_Alternate_Elements

/*
 Problem:
 - Swap every pair of alternate elements

 Input:
 array = [1,2,3,4,5,6]

 Output:
 [2,1,4,3,6,5]
*/


// MARK: - Approach: Alternate Swapping

/*
 Approach:
 - Traverse array by jumping 2 indices
 - Swap current element with next element
 - Continue until valid pair exists

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5,6]

var i = 0

while i < array.count - 1 {
    
    array.swapAt(i, i + 1)
    
    i += 2
}

print(array)
