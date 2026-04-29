import UIKit

// ==================================================
// Problem: Print all Pythagorean triplets (a, b, c)
// such that a² + b² = c² and a, b, c ≤ n
// ==================================================

// Time Complexity: O(n³)
// Space Complexity: O(1)

let n = 20

for a in 1...n {
    
    for b in 1...n {
        
        for c in 1...n {
            
            if a * a + b * b == c * c {
                print("(\(a), \(b), \(c))")
            }
        }
    }
}
