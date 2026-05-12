import UIKit


// 20_Count_Words_End_With_S
var str = "Apples mangoes bus car"
var result = ""
var count = 0


// Traverse string
for i in 0..<str.count {
    
    let index = str.index(str.startIndex,
                          offsetBy: i)
    // Word end
    if str[index] == " " {
        let lastChar = result.last
        // Check ending character
        if lastChar == "s" ||
           lastChar == "S" {
            count += 1
        }
        result = ""
    } else {
        result += String(str[index])
    }
}


// Check last word
let lastChar = result.last

if lastChar == "s" ||
   lastChar == "S" {
   count += 1
}
print(count)

// Output:
// 3



/*
 =====================================================
 Dry Run
 =====================================================

 Apples mangoes bus car
 Apples -> ends with s -> 1
 mangoes -> ends with s -> 2
 bus -> ends with s -> 3
 car -> no match

 Final Output:
 3


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because temporary word string used


 =====================================================
 Approach
 =====================================================

 Build words manually.

 When space found:
 check last character.

 Also check final word separately.
 */
