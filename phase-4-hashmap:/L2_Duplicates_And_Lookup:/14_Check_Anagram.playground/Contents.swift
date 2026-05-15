import UIKit

//: 14_Check_Anagram

import Foundation

// MARK: - Problem Statement
/*
 Given two strings,
 check whether they are anagrams.
 */

// MARK: - Example
/*
 Input  :
 "triangle"
 "integral"

 Output :
 true
 */

// MARK: - Brute Force Approach (Using Manual Frequency Count)
/*
 1. Check string lengths.
 2. Traverse each character in first string.
 3. Count frequency of current character
    in both strings manually.
 4. If frequency mismatch found:
    strings are not anagrams.
 */

// MARK: - Brute Force Solution

var str1 = "triangle"
var str2 = "integral"

var isAnagramBruteForce = true


if str1.count != str2.count {
    
    isAnagramBruteForce = false
    
} else {
    
    for ch1 in str1 {
        
        var count1 = 0
        var count2 = 0
        
        
        // Count Frequency In First String
        
        for ch in str1 {
            
            if ch == ch1 {
                count1 += 1
            }
        }
        
        
        // Count Frequency In Second String
        
        for ch in str2 {
            
            if ch == ch1 {
                count2 += 1
            }
        }
        
        
        // Compare Frequencies
        
        if count1 != count2 {
            isAnagramBruteForce = false
            break
        }
    }
}

print("Brute Force :", isAnagramBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Check string lengths.
 2. Create frequency map using first string.
 3. Store frequency count for each character.
 4. Traverse second string.
 5. Reduce frequency count.
 6. Finally:
    all frequencies must become zero.
 */

// MARK: - Optimized Solution

var frequencyMap = [Character: Int]()
var isAnagramOptimized = true


if str1.count != str2.count {
    
    isAnagramOptimized = false
    
} else {
    
    // Create Frequency Map
    
    for ch in str1 {
        
        if let count = frequencyMap[ch] {
            frequencyMap[ch] = count + 1
        } else {
            frequencyMap[ch] = 1
        }
    }
    
    
    // Reduce Frequencies
    
    for ch in str2 {
        
        if let count = frequencyMap[ch] {
            frequencyMap[ch] = count - 1
        } else {
            isAnagramOptimized = false
            break
        }
    }
    
    
    // Final Verification
    
    for (_, value) in frequencyMap {
        
        if value != 0 {
            isAnagramOptimized = false
            break
        }
    }
}

print("Optimized :", isAnagramOptimized)


// MARK: - Edge Cases
/*
 1. Empty Strings
    ""
    ""

 2. Different Lengths
    "abc"
    "ab"

 3. Different Frequencies
    "aab"
    "abb"

 4. Uppercase / Lowercase
    "Listen"
    "silent"

 5. Special Characters
    "a@b"
    "b@a"
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(1)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
