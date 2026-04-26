// ==================================================
// Problem: Print series of powers of two
// Series: 1 + 2 + 4 + 8 + ... + 2^n
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// Example:
// n = 5
// Output: 1 2 4 8 16 32

// ==================================================
// Logic
// ==================================================

// Start from 2^0 = 1
var value = 1
let n = 5

print("Powers of Two:")

for _ in 0...n {
    
    print(value, terminator: " ")
    
    value *= 2   // multiply by 2 each step
}

print()

