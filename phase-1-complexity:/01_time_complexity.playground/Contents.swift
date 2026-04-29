import UIKit
// MARK: - Time Complexity Notes (Clear Version)

/*
Definition:
Time complexity = how operations grow with input size (n)
*/

// --------------------------------------------------
// MARK: - O(1) Constant Time
// --------------------------------------------------

let arr = [1, 2, 3, 4]
print(arr[0])

// Time Complexity: O(1)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n) Linear Time
// --------------------------------------------------

let n = 10

for i in 0..<n {
    print(i)
}

// Time Complexity: O(n)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n^2) Nested Loops
// --------------------------------------------------

for i in 0..<n {
    for j in 0..<n {
        print(i, j)
    }
}

// Time Complexity: O(n^2)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n^2) Triangular Loop
// --------------------------------------------------

for i in 0..<n {
    for j in i..<n {
        print(i, j)
    }
}

// Time Complexity: O(n^2)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(log n) Divide by 2
// --------------------------------------------------

var i = n

while i > 1 {
    i = i / 2
}

// Time Complexity: O(log n)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(log n) Multiply by 2
// --------------------------------------------------

var x = 1

while x < n {
    x = x * 2
}

// Time Complexity: O(log n)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n log n) Loop + Log
// --------------------------------------------------

for _ in 0..<n {
    var j = n
    while j > 1 {
        j = j / 2
    }
}

// Time Complexity: O(n log n)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n) Geometric Series
// --------------------------------------------------

var k = n

while k > 0 {
    for j in 0..<k {
        print(j)
    }
    k = k / 2
}

// Time Complexity: O(n)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n * m) Two Variables
// --------------------------------------------------

let m = 5

for i in 0..<n {
    for j in 0..<m {
        print(i, j)
    }
}

// Time Complexity: O(n * m)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - Recursion O(n)
// --------------------------------------------------

func linearRecursion(_ n: Int) {
    if n == 0 { return }
    linearRecursion(n - 1)
}

// Time Complexity: O(n)
// Space Complexity: O(n)


// --------------------------------------------------
// MARK: - Recursion O(log n)
// --------------------------------------------------

func logRecursion(_ n: Int) {
    if n <= 1 { return }
    logRecursion(n / 2)
}

// Time Complexity: O(log n)
// Space Complexity: O(log n)


// --------------------------------------------------
// MARK: - Recursion Tree O(n)
// --------------------------------------------------

func binaryRecursion(_ n: Int) {
    if n <= 1 { return }
    binaryRecursion(n / 2)
    binaryRecursion(n / 2)
}

// Time Complexity: O(n)
// Space Complexity: O(log n)


// --------------------------------------------------
// MARK: - Identification Rules (Important)
// --------------------------------------------------

/*
1 loop → O(n)
nested loops → O(n^2)
divide by 2 → O(log n)
loop + log → O(n log n)
n + n/2 + n/4 → O(n)
recursion → check calls + depth
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
// MARK: - Interview Habit
// --------------------------------------------------

/*
Always write:

Time Complexity: O(?)
Space Complexity: O(?)

Explain:
- loops
- recursion
- memory usage
*/
