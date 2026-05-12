import UIKit

// 11_Count_Vowels_And_Consonants

/*
 =====================================================
 Method 1:
 Using Predefined Functions
 =====================================================
 */


var str1 = "Swift"

var vowels = ["a", "e", "i", "o", "u"]

var vowelCount1 = 0

var consonantCount1 = 0


// Traverse string
for char in str1 {
    
    // Check vowel
    if char.isLetter,
       vowels.contains("\(char)".lowercased()) {
        
        vowelCount1 += 1
        
    } else {
        
        consonantCount1 += 1
    }
}

print("Vowels:", vowelCount1)

print("Consonants:", consonantCount1)

// Output:
// Vowels: 1
// Consonants: 4



/*
 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Interview Note
 =====================================================

 ✅ Easy to write
 ✅ Production-friendly

 ❌ Uses predefined functions
 */


// =====================================================
// Method 2:
// Manual ASCII Comparison
// (Best For DSA Interview)
// =====================================================

var str2 = "Swift"

var vowelCount2 = 0

var consonantCount2 = 0


// Traverse string
for char in str2 {
    
    let asciiValue = char.asciiValue!
    
    
    // Check alphabet
    if (asciiValue >= 65 && asciiValue <= 90) ||
       (asciiValue >= 97 && asciiValue <= 122) {
        
        
        // Check vowels
        if char == "a" || char == "e" ||
           char == "i" || char == "o" ||
           char == "u" || char == "A" ||
           char == "E" || char == "I" ||
           char == "O" || char == "U" {
            
            vowelCount2 += 1
            
        } else {
            
            consonantCount2 += 1
        }
    }
}

print("Vowels:", vowelCount2)

print("Consonants:", consonantCount2)

// Output:
// Vowels: 1
// Consonants: 4



/*
 =====================================================
 Dry Run
 =====================================================

 Swift


 S -> consonant = 1

 w -> consonant = 2

 i -> vowel = 1

 f -> consonant = 3

 t -> consonant = 4


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Manual traversal
 ✅ ASCII understanding
 ✅ No predefined helper functions
 ✅ Better DSA practice
 */
