import UIKit

// 26_Print_Middle_Character

/*
 =====================================================
 Method 1:
 Odd Length String
 =====================================================
 */


var str = "Swift"

var middle = str.count / 2


// Middle index
let index = str.index(str.startIndex,
                      offsetBy: middle)

print(str[index])

// Output:
// i



/*
 =====================================================
 Dry Run
 =====================================================

 Swift


 Count:
 5


 Middle:
 5 / 2 = 2


 Index 2:
 i


 =====================================================
 Time Complexity
 =====================================================

 O(1)


 =====================================================
 Space Complexity
 =====================================================

 O(1)
 */


/*
 =====================================================
 Method 2:
 Handle Odd And Even Length
 (Best For Interview)
 =====================================================
 */


var str2 = "Code"

var length = str2.count


// Even length
if length % 2 == 0 {
    
    let firstMiddle =
    str2.index(str2.startIndex,
               offsetBy: (length / 2) - 1)
    
    let secondMiddle =
    str2.index(str2.startIndex,
               offsetBy: length / 2)
    
    
    print("\(str2[firstMiddle])\(str2[secondMiddle])")
}


// Odd length
else {
    
    let middleIndex =
    str2.index(str2.startIndex,
               offsetBy: length / 2)
    
    print(str2[middleIndex])
}


// Output:
// od



/*
 =====================================================
 Dry Run
 =====================================================

 Code


 Length:
 4


 Even length


 Middle indexes:
 (4 / 2) - 1 = 1
 (4 / 2) = 2


 Characters:
 o d


 Output:
 od


 =====================================================
 Time Complexity
 =====================================================

 O(1)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Handles odd/even cases
 ✅ Correct index calculation
 ✅ Complete solution
 */
