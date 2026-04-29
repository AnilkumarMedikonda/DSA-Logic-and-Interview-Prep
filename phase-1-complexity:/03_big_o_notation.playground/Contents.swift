import Foundation

// MARK: - Sample Inputs

let n = 10


// MARK: - Big-O Notation Notes (Clear Version)

/*
Definition:
Big-O notation describes how time or space grows as input size (n) increases.

It represents worst-case performance.
*/


// --------------------------------------------------
// MARK: - Why Big-O
// --------------------------------------------------

/*
Used to:
- Compare algorithms
- Measure performance
- Choose efficient solutions
*/


// --------------------------------------------------
// MARK: - Ignore Constants
// --------------------------------------------------

for i in 0..<2 * n {
    print(i)
}

// Time Complexity: O(n)
// NOT O(2n)


// --------------------------------------------------
// MARK: - Ignore Smaller Terms
// --------------------------------------------------

for i in 0..<n {
    print(i)
}

for i in 0..<n {
    for j in 0..<n {
        print(i, j)
    }
}

// O(n + n^2) → O(n^2)


// --------------------------------------------------
// MARK: - Common Big-O Values
// --------------------------------------------------

/*
O(1)       → Constant
O(log n)   → Logarithmic
O(n)       → Linear
O(n log n) → Efficient sorting
O(n^2)     → Nested loops
O(2^n)     → Exponential
*/


// --------------------------------------------------
// MARK: - Example: O(n)

for i in 0..<n {
    print(i)
}

// Time Complexity: O(n)


// --------------------------------------------------
// MARK: - Example: O(n^2)

for i in 0..<n {
    for j in 0..<n {
        print(i, j)
    }
}

// Time Complexity: O(n^2)


// --------------------------------------------------
// MARK: - Example: O(log n)

var i = n

while i > 1 {
    i /= 2
}

// Time Complexity: O(log n)


// --------------------------------------------------
// MARK: - Example: O(n log n)

for _ in 0..<n {
    var j = n
    while j > 1 {
        j /= 2
    }
}

// Time Complexity: O(n log n)


// --------------------------------------------------
// MARK: - Growth Order (Important)
// --------------------------------------------------

/*
Fast → Slow

O(1)
O(log n)
O(n)
O(n log n)
O(n^2)
O(2^n)
*/


// --------------------------------------------------
// MARK: - Simplification Rules
// --------------------------------------------------

/*
O(n + n) → O(n)
O(n^2 + n) → O(n^2)
O(2n) → O(n)
O(log n^2) → O(log n)
*/


// --------------------------------------------------
// MARK: - Key Notes
// --------------------------------------------------

/*
- Focus on growth, not exact time
- Worst case is considered
- Drop constants and smaller terms
*/


// --------------------------------------------------
// MARK: - Interview Habit
// --------------------------------------------------

/*
Always say:

Time Complexity: O(?)
Space Complexity: O(?)

Explain clearly why
*/
