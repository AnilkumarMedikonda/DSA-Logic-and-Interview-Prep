import UIKit

//  43_Find_Second_Largest_Element

var array = [45, 20, 40, 30, 50]

var max = Int.min
var secondMax = max

for number in array {
    
    if number > max {
        secondMax = max
        max = number
    } else if number > secondMax , number != max {
        secondMax = number
    }
}
print(secondMax)
print(max)

// T - O(n)
// S - O(1)
