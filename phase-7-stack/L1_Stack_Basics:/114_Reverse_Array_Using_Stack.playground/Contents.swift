import UIKit

/*
 =========================================================
         114 - REVERSE ARRAY USING STACK
 =========================================================

 Problem
 -------
 Reverse an array using a Stack.

 Example

 Input

 [10, 20, 30, 40, 50]

 Output

 [50, 40, 30, 20, 10]

 ---------------------------------------------------------

 What is the Idea?

 A Stack follows the LIFO principle.

 LIFO = Last In, First Out

 Push Order

 10
 20
 30
 40
 50

 Stack (Top ↓)

 50
 40
 30
 20
 10

 Pop Order

 50
 40
 30
 20
 10

 Result

 [50, 40, 30, 20, 10]

 ---------------------------------------------------------

 Algorithm

 Step 1:
 Create an empty stack.

 Step 2:
 Push every array element into the stack.

 Step 3:
 Create an empty result array.

 Step 4:
 Pop every element from the stack.

 Step 5:
 Append each popped element to the result array.

 Step 6:
 Return the reversed array.

 ---------------------------------------------------------

 Dry Run

 Input

 [10, 20, 30, 40, 50]

 Push

 Stack

 [10, 20, 30, 40, 50]

 Pop

 50
 40
 30
 20
 10

 Result

 [50, 40, 30, 20, 10]

 ---------------------------------------------------------

 Time Complexity

 Push Elements      O(n)

 Pop Elements       O(n)

 Total              O(n)

 ---------------------------------------------------------

 Space Complexity

 Stack              O(n)

 =========================================================
 */

//==========================================================
// MARK: - Reverse Array Using Stack
//==========================================================

func reverseArray(_ numbers: [Int]) -> [Int] {

    // Step 1: Create Empty Stack
    var stack = [Int]()

    // Step 2: Push Every Element
    for number in numbers {
        stack.append(number)
    }

    print("Stack After Push : \(stack)")

    // Step 3: Create Result Array
    var result = [Int]()

    // Step 4: Pop Every Element
    while !stack.isEmpty {

        let removedNumber = stack.removeLast()

        print("Removed : \(removedNumber)")

        result.append(removedNumber)
    }

    // Step 5: Return Result
    return result
}

//==========================================================
// MARK: - Testing
//==========================================================

let input = [10, 20, 30, 40, 50]

print("Input Array : \(input)")
print("--------------------------------")

let output = reverseArray(input)

print("--------------------------------")
print("Reversed Array : \(output)")

/*
 =========================================================
                    EXPECTED OUTPUT
 =========================================================

 Input Array : [10, 20, 30, 40, 50]

 --------------------------------

 Stack After Push : [10, 20, 30, 40, 50]

 Removed : 50
 Removed : 40
 Removed : 30
 Removed : 20
 Removed : 10

 --------------------------------

 Reversed Array : [50, 40, 30, 20, 10]

 =========================================================
 */
