import Foundation

/*
 =========================================================
            111 - STACK BASICS & OPERATIONS
 =========================================================

 What is a Stack?
 ----------------
 A Stack is a linear data structure that follows the
 LIFO (Last In, First Out) principle.

 LIFO (Last In, First Out)
 -------------------------
 The last element inserted into the stack is the first
 element removed from the stack.

 Example

 Push(10)
 Push(20)
 Push(30)

 Stack (Top ↓)

 30
 20
 10

 Pop()

 Removed : 30

 Remaining Stack

 20
 10

 ---------------------------------------------------------

 Stack Operations

 1. Push
    • Adds an element to the top of the stack.
    • Swift : append()

 2. Pop
    • Removes the top element from the stack.
    • Swift : removeLast() — ⚠️ CRASHES on empty, always guard

 3. Peek (Top)
    • Returns the top element without removing it.

 4. isEmpty
    • Checks whether the stack is empty.

 5. Count (Size)
    • Returns the total number of elements.

 ---------------------------------------------------------

 Real Life Examples

 • Stack of Plates
 • Browser Back Button
 • Undo / Redo
 • Function Call Stack
 • UINavigationController's view controller stack
 • Balanced Parentheses

 ---------------------------------------------------------

 Time Complexity

 Push        O(1)   — append at the END of the array
 Pop         O(1)   — removeLast from the END
 Peek        O(1)
 isEmpty     O(1)
 Count       O(1)

 (The END of the array is the TOP of the stack — front-of-array
  operations would be O(n) because everything shifts.)

 ---------------------------------------------------------

 Traps

 1. removeLast() on an empty array -> RUNTIME CRASH.
    Guard with isEmpty first, or return Int? — this matters
    immediately in Valid Parentheses (input ")" pops empty).
 2. Struct methods that mutate storage need `mutating`
    (structs are value types).

 =========================================================
 */

//==========================================================
// MARK: - Part A: Array As Stack (raw operations)
//==========================================================

var stack = [Int]()

print("Initial Stack : \(stack)")

//==========================================================
// MARK: - Push (Add Elements)
//==========================================================

print("\n========== Push ==========")

stack.append(10)
print("Push 10 -> \(stack)")

stack.append(20)
print("Push 20 -> \(stack)")

stack.append(30)
print("Push 30 -> \(stack)")

stack.append(40)
print("Push 40 -> \(stack)")

stack.append(50)
print("Push 50 -> \(stack)")

//==========================================================
// MARK: - Peek (View Top Element)
//==========================================================

print("\n========== Peek ==========")

if let top = stack.last {
    print("Top Element : \(top)")
}

//==========================================================
// MARK: - Pop (Remove Top Element) — GUARDED
//==========================================================

print("\n========== Pop ==========")

if stack.isEmpty == false {
    let removedElement = stack.removeLast()
    print("Removed Element : \(removedElement)")
} else {
    print("Stack is empty — nothing to pop")
}

print("Current Stack : \(stack)")

//==========================================================
// MARK: - Count (Size)
//==========================================================

print("\n========== Count ==========")

print("Stack Size : \(stack.count)")

//==========================================================
// MARK: - isEmpty
//==========================================================

print("\n========== isEmpty ==========")

print("Is Stack Empty? : \(stack.isEmpty)")

//==========================================================
// MARK: - Remove Remaining Elements
//==========================================================

print("\n========== Remove Remaining ==========")

while stack.isEmpty == false {

    let removed = stack.removeLast()
    print("Removed : \(removed)")
}

print("Current Stack : \(stack)")

//==========================================================
// MARK: - Pop On Empty (THE crash case — guarded)
//==========================================================

print("\n========== Pop On Empty ==========")

if stack.isEmpty == false {
    let removed = stack.removeLast()
    print("Removed : \(removed)")
} else {
    print("Pop on empty : nil — guarded, no crash ✅")
}

//==========================================================
// MARK: - Final Check
//==========================================================

print("\n========== Final Check ==========")

print("Is Stack Empty? : \(stack.isEmpty)")
print("Stack Size : \(stack.count)")

//==========================================================
// MARK: - Part B: Stack Struct (the interview deliverable)
//==========================================================
/*
 "Implement a stack" in an interview means THE TYPE, not a raw
 array. Optional return on pop/peek IS the crash guard.
 */

struct Stack {

    private var elements = [Int]()

    mutating func push(_ value: Int) {
        elements.append(value)
    }

    mutating func pop() -> Int? {
        if elements.isEmpty {
            return nil
        }
        return elements.removeLast()
    }

    func peek() -> Int? {
        if elements.isEmpty {
            return nil
        }
        return elements[elements.count - 1]
    }

    func isEmpty() -> Bool {
        return elements.isEmpty
    }

    func count() -> Int {
        return elements.count
    }
}

//==========================================================
// MARK: - Struct Tests
//==========================================================

print("\n========== Stack Struct Tests ==========")

var s = Stack()

s.push(10)
s.push(20)
s.push(30)
print("Pushed 10, 20, 30 — count : \(s.count())")

if let top = s.peek() {
    print("Peek : \(top)")                    // 30, stack unchanged
}
print("Count after peek : \(s.count())")      // still 3

if let popped = s.pop() {
    print("Pop : \(popped)")                  // 30
}
if let popped = s.pop() {
    print("Pop : \(popped)")                  // 20
}

print("isEmpty : \(s.isEmpty())")             // false

if let popped = s.pop() {
    print("Pop : \(popped)")                  // 10
}

print("isEmpty : \(s.isEmpty())")             // true

// The crash case — pop on empty returns nil, no crash
if let popped = s.pop() {
    print("Pop : \(popped)")
} else {
    print("Pop on empty : nil — no crash ✅")
}

/*
 =========================================================
                    INTERVIEW Q&A
 =========================================================

 Q1: Why is the END of the array the top of the stack?
 A : append/removeLast are O(1); inserting or removing at
     index 0 shifts every element — O(n).

 Q2: What happens if you pop an empty stack?
 A : Raw removeLast() crashes. The struct returns Int? so
     callers handle emptiness with if let — no crash path.

 Q3: Why `mutating` on push/pop?
 A : Stack is a struct (value type); methods that modify
     stored properties must be marked mutating.

 Q4: Where do stacks appear in iOS?
 A : UINavigationController's viewControllers stack —
     push/pop screens, LIFO. Also the call stack itself,
     and undo managers.

 =========================================================
 */
