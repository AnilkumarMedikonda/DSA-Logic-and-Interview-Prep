import UIKit

var greeting = "Hello, playground"


//18_Alphabet_Increasing_Triangle


for i in 1...5 {
    
    for j in 1...i {
        let JValue = UnicodeScalar(64+j)!
        let char = Character(JValue)
        print(char, terminator: " ")
    }
    print()
}
