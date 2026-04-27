import UIKit

// ==================================================
// Problem: Print first n terms of an Arithmetic Progression
// Given first term (a) and common difference (d)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// ----------- Test Case 1 -----------

var a = 3
var d = 4
var n = 5

var value = a

print("AP Series:")

for _ in 1...n {
    print(value, terminator: " ")
    value += d
}

print("\n")

// ----------- Test Case 2 -----------

a = 1
d = 5
n = 5

value = a

print("AP Series:")

for _ in 1...n {
    print(value, terminator: " ")
    value += d
}
