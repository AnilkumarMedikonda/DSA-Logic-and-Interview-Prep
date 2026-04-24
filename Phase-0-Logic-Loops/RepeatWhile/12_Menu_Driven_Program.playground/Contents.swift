import UIKit

// ==================================================
// Problem: Menu Driven Program
// Perform operations based on user choice
// ==================================================

// NOTE:
// Playground → using simulated input (array)

var inputs = [1, 2, 3, 4]   // simulate user choices
var index = 0

var choice = 0

repeat {
    
    print("""
    
    1. Check Even/Odd
    2. Factorial
    3. Reverse Number
    4. Exit
    
    """)
    
    choice = inputs[index]
    print("Selected: \(choice)")
    
    switch choice {
        
    case 1:
        let num = 5
        print(num % 2 == 0 ? "Even" : "Odd")
        
    case 2:
        var n = 5
        var fact = 1
        
        repeat {
            fact *= n
            n -= 1
        } while n > 0
        
        print("Factorial ---> \(fact)")
        
    case 3:
        var num = 123
        var rev = 0
        
        repeat {
            rev = rev * 10 + num % 10
            num /= 10
        } while num > 0
        
        print("Reverse ---> \(rev)")
        
    case 4:
        print("Exiting Program...")
        
    default:
        print("Invalid choice")
    }
    
    index += 1
    
} while choice != 4 && index < inputs.count
