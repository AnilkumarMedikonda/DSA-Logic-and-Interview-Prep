import UIKit

var greeting = "Hello, playground"


func mergeSort(_ array: [Int]) -> [Int] {
    
    // Base case
    if array.count <= 1 {
        return array
    }
    
    // Split
    let mid = array.count / 2
    let left = mergeSort(Array(array[0..<mid]))
    let right = mergeSort(Array(array[mid...]))
    
    // Merge
    return merge(left, right)
}

func mergeSort(_ left: [Int], _ right: [Int]) -> [Int] {
    
    var result = [Int]()
    
    var i = 0
    var j = 0
    
    
    
    return []
}


func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    
    var result: [Int] = []
    var i = 0
    var j = 0
    
    while i < left.count && j < right.count {
        if left[i] < right[j] {
            result.append(left[i])
            i += 1
        } else {
            result.append(right[j])
            j += 1
        }
    }
     
    // Remaining elements
    while i < left.count {
        result.append(left[i])
        i += 1
    }
    
    while j < right.count {
        result.append(right[j])
        j += 1
    }
    
    return result
}


// MARK: - Test

let array = [8, 3, 5, 2]
let sorted = mergeSort(array)

print("Sorted Array:", sorted)
