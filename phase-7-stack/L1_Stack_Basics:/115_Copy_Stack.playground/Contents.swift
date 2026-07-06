import UIKit

/*
 =========================================================
                115 - COPY STACK
 =========================================================

 Problem
 -------
 Create a copy of a stack without modifying
 the original stack.

 Example

 Original Stack

 Top
  ↓
 40
 30
 20
 10

 Copied Stack

 Top
  ↓
 40
 30
 20
 10

 ---------------------------------------------------------

 Why Not Simply Write?

 var copy = original

 Because this problem is designed to practice
 Stack operations (Push & Pop).

 ---------------------------------------------------------

 Approach

 Step 1:
 Create a Temporary Stack.

 Step 2:
 Move all elements

 Original
      ↓
     Temp

 Step 3:
 Restore Original Stack

 Temp
   ↓
Original

 Step 4:
 While restoring Original,
 also push every element into Copy.

 Temp
   ↓
Original

 Temp
   ↓
 Copy

 ---------------------------------------------------------

 Dry Run

 Original

 [10, 20, 30, 40]

             ↓

 Temp

 [40, 30, 20, 10]

             ↓

 Restore

 Original

 [10, 20, 30, 40]

             ↓

 Copy

 [10, 20, 30, 40]

 ---------------------------------------------------------

 Time Complexity

 Original → Temp          O(n)

 Temp → Original + Copy   O(n)

 Total                    O(n)

 ---------------------------------------------------------

 Space Complexity

 Temp Stack               O(n)

 Copy Stack               O(n)

 =========================================================
 */

//==========================================================
// MARK: - Original Stack
//==========================================================

var originalStack = [10, 20, 30, 40]

print("Original Stack : \(originalStack)")

//==========================================================
// MARK: - Temporary & Copy Stack
//==========================================================

var tempStack = [Int]()
var copiedStack = [Int]()

//==========================================================
// MARK: - Move Original -> Temp
//==========================================================

print("\nMoving Original -> Temp")

while !originalStack.isEmpty {

    let value = originalStack.removeLast()

    print("Move : \(value)")

    tempStack.append(value)
}

print("\nOriginal Stack : \(originalStack)")
print("Temp Stack     : \(tempStack)")

//==========================================================
// MARK: - Restore Original & Create Copy
//==========================================================

print("\nRestoring Original & Creating Copy")

while !tempStack.isEmpty {

    let value = tempStack.removeLast()

    originalStack.append(value)

    copiedStack.append(value)
}

//==========================================================
// MARK: - Final Output
//==========================================================

print("\nOriginal Stack : \(originalStack)")
print("Copied Stack   : \(copiedStack)")

/*
 =========================================================
                    EXPECTED OUTPUT
 =========================================================

 Original Stack : [10, 20, 30, 40]

 Moving Original -> Temp

 Move : 40
 Move : 30
 Move : 20
 Move : 10

 Original Stack : []
 Temp Stack     : [40, 30, 20, 10]

 Restoring Original & Creating Copy

 Original Stack : [10, 20, 30, 40]
 Copied Stack   : [10, 20, 30, 40]

 =========================================================
 */
