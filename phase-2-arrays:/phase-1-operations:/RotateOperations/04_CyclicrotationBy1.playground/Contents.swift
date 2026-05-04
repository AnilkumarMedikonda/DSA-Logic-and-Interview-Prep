import UIKit


// MARK: - Cyclic Rotation by 1 (Left & Right)

/*
 RIGHT ROTATION (→)
 Move last element → to front

 Input:
 [1,2,3,4,5]

 Output:
 [5,1,2,3,4]
 */

/*
 LEFT ROTATION (←)
 Move first element → to end

 Input:
 [1,2,3,4,5]

 Output:
 [2,3,4,5,1]
 */

/*
 Time Complexity:
 O(n)

 Space Complexity:
 O(1)
 */

/*
 Edge Cases:
 n = 0 → return
 n = 1 → no change
 */

// MARK: - Right Rotate by 1

func rightRotateByOne(_ arr: inout [Int]) {
    let n = arr.count
    if n <= 1 { return }
    
    let last = arr[n - 1]
    
    var i = n - 1
    while i > 0 {
        arr[i] = arr[i - 1]
        i -= 1
    }
    
    arr[0] = last
}

// MARK: - Left Rotate by 1

func leftRotateByOne(_ arr: inout [Int]) {
    let n = arr.count
    if n <= 1 { return }
    
    let first = arr[0]
    
    for i in 0..<n - 1 {
        arr[i] = arr[i + 1]
    }
    
    arr[n - 1] = first
}

// MARK: - Testing

var arr1 = [1,2,3,4,5]
print("Original:", arr1)

rightRotateByOne(&arr1)
print("Right Rotate by 1:", arr1)   // [5,1,2,3,4]

var arr2 = [1,2,3,4,5]
leftRotateByOne(&arr2)
print("Left Rotate by 1 :", arr2)   // [2,3,4,5,1]
