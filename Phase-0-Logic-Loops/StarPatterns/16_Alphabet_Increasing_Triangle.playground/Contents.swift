
// ==================================================
// 16_Alphabet_Triangle_Upper_Lower.swift
// Print increasing alphabet triangles (Uppercase & Lowercase)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Uppercase Triangle
// ==================================================

var current = 1   // 1 → 'A'

for i in 1...n {
    
    for _ in 1...i {
        let char = Character(UnicodeScalar(64 + current)!)
        print(char, terminator: " ")
        current += 1
    }
    
    print()
}

// ==================================================
// Separator
// ==================================================

print("-------")

// ==================================================
// Lowercase Triangle
// ==================================================

var current2 = 1   // 1 → 'a'

for i in 1...n {
    
    for _ in 1...i {
        let char = Character(UnicodeScalar(96 + current2)!)
        print(char, terminator: " ")
        current2 += 1
    }
    
    print()
}

// ==================================================
// Output (n = 5)
// ==================================================

// A
// B C
// D E F
// G H I J
// K L M N O
//
// -------
//
// a
// b c
// d e f
// g h i j
// k l m n o



