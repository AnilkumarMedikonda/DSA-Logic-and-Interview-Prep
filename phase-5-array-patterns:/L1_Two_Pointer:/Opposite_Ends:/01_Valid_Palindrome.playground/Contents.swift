import Foundation

//: Playground - 01_Valid_Palindrome
/*
============================================================
01_Valid_Palindrome
============================================================

PROBLEM:
- Ignore uppercase/lowercase
- Ignore spaces/special characters
- Return true if palindrome

EXAMPLE:
"A man, a plan, a canal: Panama"

OUTPUT:
true

PATTERN:
Two Pointer / Opposite Ends

WHY TWO POINTER?
Palindrome means:
front == back
============================================================
*/

var str = "A man, a plan, a canal: Panama"


// MARK: ====================================================
// MARK: - BRUTE FORCE
// MARK: ====================================================

/*
BRUTE FORCE IDEA:
1. Create cleaned string
2. Reverse cleaned string
3. Compare both

TIME  : O(n)
SPACE : O(n)

WHY NOT BEST?
- Extra reverse string created
*/

print("===== BRUTE FORCE =====")

var cleaned = ""

for ch in str {

    if ch.isLetter || ch.isNumber {
        cleaned += String(ch).lowercased()
    }
}

print("Cleaned:", cleaned)

var reversedString = ""
var i = cleaned.count - 1

while i >= 0 {

    let index = cleaned.index(
        cleaned.startIndex,
        offsetBy: i
    )

    reversedString += String(cleaned[index])

    i -= 1
}

print("Reversed:", reversedString)

print(
    cleaned == reversedString
    ? "Palindrome"
    : "Not Palindrome"
)


// MARK: ====================================================
// MARK: - OPTIMIZED (Filtered Array)
// MARK: ====================================================

/*
OPTIMIZED IDEA:
Compare directly from both ends.

left  -> start
right -> end

TIME  : O(n)
SPACE : O(n)

WHY BETTER?
- No reverse traversal
- Better optimization thinking
*/

print("\n===== OPTIMIZED =====")

var array = [Character]()

for ch in str.lowercased() {

    if ch.isLetter || ch.isNumber {
        array.append(ch)
    }
}

print("Filtered:", array)

var left = 0
var right = array.count - 1

var isPalindrome = true

while left < right {

    print("\(array[left]) == \(array[right])")

    if array[left] != array[right] {

        isPalindrome = false
        break
    }

    left += 1
    right -= 1
}

print(
    isPalindrome
    ? "Palindrome"
    : "Not Palindrome"
)


// MARK: ====================================================
// MARK: - TRUE TWO POINTER / OPPOSITE ENDS
// MARK: ====================================================

/*
BEST INTERVIEW SOLUTION

IDEA:
- No cleaned string
- No filtered array
- Skip invalid chars dynamically

TIME  : O(n)
SPACE : O(1)

WHY BEST?
- No extra memory
- Real two pointer approach
- Most optimized solution
*/

print("\n===== TRUE TWO POINTER =====")

let chars = Array(str.lowercased())

left = 0
right = chars.count - 1

isPalindrome = true

while left < right {

    // Skip invalid left chars
    while left < right &&
        !chars[left].isLetter &&
        !chars[left].isNumber {

        left += 1
    }

    // Skip invalid right chars
    while left < right &&
        !chars[right].isLetter &&
        !chars[right].isNumber {

        right -= 1
    }

    print("\(chars[left]) == \(chars[right])")

    if chars[left] != chars[right] {

        isPalindrome = false
        break
    }

    left += 1
    right -= 1
}

print(
    isPalindrome
    ? "Palindrome"
    : "Not Palindrome"
)


/*
============================================================
INTERVIEW SUMMARY
============================================================

1. BRUTE FORCE
clean -> reverse -> compare

2. OPTIMIZED
filtered array + two pointers

3. TRUE TWO POINTER
skip invalid chars dynamically

============================================================
WHICH IS BEST?
============================================================

BEST INTERVIEW SOLUTION:
TRUE TWO POINTER

WHY?
- O(1) extra space
- No reverse string
- No filtered array
- Proper Opposite Ends pattern

============================================================
PATTERN SIGNALS
============================================================

- palindrome
- symmetry
- compare both ends

=> Two Pointer / Opposite Ends
============================================================
*/
