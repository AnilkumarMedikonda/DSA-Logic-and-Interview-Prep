import UIKit
// MARK: - 04_Find_Product

/*
 Approach:
 - Initialize product = 1
 - Multiply all elements (including zero & negative)

 Time: O(n)
 Space: O(1)
*/

var array = [1, 2, 3, 4]
var product = 1

for number in array {
    product *= number
}
print(product)
