// MARK: - Space Complexity Notes (Clear Version)

/*
Definition:
Space complexity = how much extra memory is used as input size (n) increases

Important:
- We count only auxiliary space (extra memory)
- Input space is NOT counted
*/


// --------------------------------------------------
// MARK: - O(1) Constant Space
// --------------------------------------------------

var sum = 0
sum += 10

// Time Complexity: O(1)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n) Extra Array
// --------------------------------------------------

let n = 10
var arr = [Int]()

for i in 0..<n {
    arr.append(i)
}

// Time Complexity: O(n)
// Space Complexity: O(n)


// --------------------------------------------------
// MARK: - O(n^2) Matrix Space
// --------------------------------------------------

let size = 3
var matrix = Array(repeating: Array(repeating: 0, count: size), count: size)

// Time Complexity: O(1)
// Space Complexity: O(n^2)


// --------------------------------------------------
// MARK: - O(1) In-Place Modification
// --------------------------------------------------

var numbers = [1, 2, 3, 4]
numbers[0] = 10

// Time Complexity: O(1)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - O(n) Copy Array (Extra Space)
// --------------------------------------------------

let original = [1, 2, 3]
let copy = original

// Time Complexity: O(n)
// Space Complexity: O(n)


// --------------------------------------------------
// MARK: - Recursion Space O(n)
// --------------------------------------------------

func recursionExample(_ n: Int) {
    if n == 0 { return }
    recursionExample(n - 1)
}

// Time Complexity: O(n)
// Space Complexity: O(n)   // call stack


// --------------------------------------------------
// MARK: - Recursion Space O(log n)
// --------------------------------------------------

func logRecursion(_ n: Int) {
    if n <= 1 { return }
    logRecursion(n / 2)
}

// Time Complexity: O(log n)
// Space Complexity: O(log n)


// --------------------------------------------------
// MARK: - Constant Variables Only
// --------------------------------------------------

var a = 10
var b = 20
var c = a + b

// Time Complexity: O(1)
// Space Complexity: O(1)


// --------------------------------------------------
// MARK: - Identification Rules
// --------------------------------------------------

/*
Only variables → O(1)
New array → O(n)
Matrix → O(n^2)
Recursion → depends on depth
*/


// --------------------------------------------------
// MARK: - In-Place vs Extra Space
// --------------------------------------------------

/*
In-place:
- No new memory
- Space → O(1)

Extra space:
- Uses new memory (array, dictionary)
- Space → O(n)
*/


// --------------------------------------------------
// MARK: - Common Mistakes
// --------------------------------------------------

/*
1. Counting input array ❌
   → Do NOT count input

2. Ignoring recursion stack ❌
   → Always include

3. Writing O(2) ❌
   → Always O(1)
*/


// --------------------------------------------------
// MARK: - Interview Habit
// --------------------------------------------------

/*
Always write:

Time Complexity: O(?)
Space Complexity: O(?)

Explain:
- extra memory used
- recursion depth
*/
