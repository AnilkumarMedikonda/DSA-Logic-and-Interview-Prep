import UIKit

/*
 =========================================================
        112 - IMPLEMENT STACK USING ARRAY
 =========================================================

 What is a Stack?
 ----------------
 A Stack is a linear data structure that follows the
 LIFO (Last In, First Out) principle.

 Instead of directly using an Array everywhere,
 we create our own Stack class.

 Why?
 ----
 • Better code readability
 • Hides implementation details
 • Easy to reuse
 • Common interview implementation

 ---------------------------------------------------------

 Stack Operations

 1. Push
    • Add an element to the top.

 2. Pop
    • Remove and return the top element.

 3. Peek
    • Return the top element without removing it.

 4. isEmpty
    • Check whether the stack is empty.

 5. Count
    • Return the number of elements.

 6. Display
    • Print all elements.

 ---------------------------------------------------------

 Example

 Push(10)
 Push(20)
 Push(30)

 Stack

 Top
  ↓
 30
 20
 10

 Pop()

 Removed : 30

 Stack

 Top
  ↓
 20
 10

 ---------------------------------------------------------

 Time Complexity

 Push        O(1)
 Pop         O(1)
 Peek        O(1)
 isEmpty     O(1)
 Count       O(1)

 ---------------------------------------------------------

 Space Complexity

 O(n)

 =========================================================
 */

//==========================================================
// MARK: - Stack Implementation
//==========================================================

class Stack {

    // Internal Storage
    private var items: [Int] = []

    //======================================================
    // Push
    //======================================================

    func push(_ item: Int) {
        items.append(item)
    }

    //======================================================
    // Pop
    //======================================================

    func pop() -> Int? {
        return items.popLast()
    }

    //======================================================
    // Peek
    //======================================================

    func peek() -> Int? {
        return items.last
    }

    //======================================================
    // Check Empty
    //======================================================

    func isEmpty() -> Bool {
        return items.isEmpty
    }

    //======================================================
    // Count
    //======================================================

    func count() -> Int {
        return items.count
    }

    //======================================================
    // Display
    //======================================================

    func display() {
        print(items)
    }
}

//==========================================================
// MARK: - Testing
//==========================================================

let stack = Stack()

print("========== Initial Stack ==========")
stack.display()

//==========================================================
// Push
//==========================================================

print("\n========== Push ==========")

stack.push(10)
stack.push(20)
stack.push(30)
stack.push(40)
stack.push(50)

stack.display()

//==========================================================
// Peek
//==========================================================

print("\n========== Peek ==========")

if let top = stack.peek() {
    print("Top Element : \(top)")
}

//==========================================================
// Pop
//==========================================================

print("\n========== Pop ==========")

if let removed = stack.pop() {
    print("Removed Element : \(removed)")
}

stack.display()

//==========================================================
// Count
//==========================================================

print("\n========== Count ==========")

print("Stack Size : \(stack.count())")

//==========================================================
// isEmpty
//==========================================================

print("\n========== isEmpty ==========")

print("Is Stack Empty? : \(stack.isEmpty())")

//==========================================================
// Remove Remaining Elements
//==========================================================

print("\n========== Remove Remaining ==========")

while !stack.isEmpty() {

    if let removed = stack.pop() {
        print("Removed : \(removed)")
    }
}

stack.display()

//==========================================================
// Final Check
//==========================================================

print("\n========== Final Check ==========")

print("Is Stack Empty? : \(stack.isEmpty())")
print("Stack Size : \(stack.count())")

/*
 =========================================================
                    EXPECTED OUTPUT
 =========================================================

 ========== Initial Stack ==========
 []

 ========== Push ==========
 [10, 20, 30, 40, 50]

 ========== Peek ==========
 Top Element : 50

 ========== Pop ==========
 Removed Element : 50
 [10, 20, 30, 40]

 ========== Count ==========
 Stack Size : 4

 ========== isEmpty ==========
 Is Stack Empty? : false

 ========== Remove Remaining ==========
 Removed : 40
 Removed : 30
 Removed : 20
 Removed : 10

 []

 ========== Final Check ==========
 Is Stack Empty? : true
 Stack Size : 0

 =========================================================
 */
