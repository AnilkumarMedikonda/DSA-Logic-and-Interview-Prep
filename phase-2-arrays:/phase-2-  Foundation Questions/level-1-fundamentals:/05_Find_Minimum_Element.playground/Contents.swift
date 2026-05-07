import UIKit

var greeting = "Hello, playground"

var array = [8,3,5,1,9]

var min = Int.max


for number in array {
    if number < min {
        min = number
    }
}

print(min)

// t - o(n), s - 0(1)
