import UIKit

var greeting = "Hello, playground"

// 27_Split_Into_Characters

/*
 =====================================================
 Approach:
 String Traversal + Array Building
 =====================================================

 1. Traverse string
 2. Convert character into string
 3. Append into array
 */


var str = "Swift"

var result = [String]()


// Traverse string
for char in str {
    
    result.append(String(char))
}

print(result)

// Output:
// ["S", "w", "i", "f", "t"]


/*
 =====================================================
 Dry Run
 =====================================================

 Swift

 S -> append
 ["S"]

 w -> append
 ["S", "w"]

 i -> append
 ["S", "w", "i"]

 f -> append
 ["S", "w", "i", "f"]

 t -> append
 ["S", "w", "i", "f", "t"]


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because character array created


 =====================================================
 Why This Is Good For Interview
 =====================================================

 ✅ Simple traversal
 ✅ Character extraction
 ✅ Array building
 ✅ Easy explanation
 */
