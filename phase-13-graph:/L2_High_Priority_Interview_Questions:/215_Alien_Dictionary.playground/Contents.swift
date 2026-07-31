import Foundation

//==============================================================
// 215. Alien Dictionary
// Pattern : Topological Sort (Kahn's Algorithm)
// Time    : O(N * L + U + E) where N=words, L=word length, U=unique chars, E=edges
// Space   : O(U + E)
//==============================================================
// PROBLEM:
// Given a sorted list of words in an alien language, derive the order
// of characters in that language. Adjacent words reveal character order:
// if word[i] differs from word[i+1] at position j, then word[i][j] < word[i+1][j]
//==============================================================

class Solution {
    
    func alienOrder(_ words: [String]) -> String {
        
        //----------------------------------------------------
        // STEP 1: Build Graph from Adjacent Words
        //----------------------------------------------------
        
        print("====================================")
        print("STEP 1: Build Character Graph")
        print("====================================")
        
        var graph = [Character: [Character]]()
        var inDegree = [Character: Int]()
        
        // Initialize all characters
        for word in words {
            
            for char in word {
                
                if inDegree[char] == nil {
                    inDegree[char] = 0
                    graph[char] = []
                }
            }
        }
        
        print("All Characters: \(inDegree.keys.sorted())")
        
        // Compare adjacent words
        for i in 0..<words.count - 1 {
            
            let word1 = words[i]
            let word2 = words[i + 1]
            
            print()
            print("Comparing: '\(word1)' → '\(word2)'")
            
            let minLen = min(word1.count, word2.count)
            
            // Edge case: word1 is longer and word2 is prefix
            
            guard word1.count <= word2.count || word1.prefix(word2.count) != word2 else {
                
                print("❌ INVALID: '\(word1)' longer than '\(word2)' (should be sorted)")
                return ""
            }
            
            // Find first differing character
            for j in 0..<minLen {
                
                let char1 = Array(word1)[j]
                let char2 = Array(word2)[j]
                
                guard char1 != char2 else { continue }
                
                print("  Position \(j): '\(char1)' < '\(char2)'")
                
                // Add edge: char1 → char2
                if !graph[char1]!.contains(char2) {
                    
                    graph[char1]!.append(char2)
                    inDegree[char2]! += 1
                    print("    Edge added: '\(char1)' → '\(char2)'")
                    
                }
                
                break
            }
        }
        
        //----------------------------------------------------
        // STEP 2: Initialize Queue with In-Degree 0
        //----------------------------------------------------
        
        
        print()
        print("====================================")
        print("STEP 2: Initialize Queue")
        print("====================================")
        
        var queue = [Character]()
        
        for (char, degree) in inDegree {
            
            if degree == 0 {
                queue.append(char)
                print("Added '\(char)' to queue (in-degree: 0)")
            }
        }
        
        print("Initial Queue: \(queue.map(String.init))")
        
        //----------------------------------------------------
        // STEP 3: Topological Sort (Kahn's Algorithm)
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 3: Topological Sort (BFS)")
        print("====================================")
        
        var result = ""
        
        while !queue.isEmpty {
            let char = queue.removeFirst()
            result.append(char)
            
            print()
            print("Process '\(char)'")
            print("  Result so far: '\(result)'")
            
            // Process neighbors
            for neighbor in graph[char]! {
                inDegree[neighbor]! -= 1
                print("  '\(neighbor)' in-degree: \(inDegree[neighbor]!)")
                
                guard inDegree[neighbor] == 0 else { continue }
                
                queue.append(neighbor)
                print("    Added '\(neighbor)' to queue")
            }
        }
        
        //----------------------------------------------------
        // STEP 4: Cycle Detection
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 4: Cycle Detection")
        print("====================================")
        
        guard result.count == inDegree.count else {
            print("❌ CYCLE DETECTED: Only processed \(result.count) of \(inDegree.count) characters")
            return ""
        }
        
        print("✓ No cycles detected")
        print("Processed all \(result.count) characters")
        
        //----------------------------------------------------
        // STEP 5: Return Result
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 5: Final Result")
        print("====================================")
        print("Alien Dictionary Order: '\(result)'")
        
        return result
    }
}

//==============================================================
// MARK: Test Case 1 — Valid Alien Dictionary
//==============================================================
print("TEST CASE 1: Valid Alien Dictionary")
print("=========================\n")

let solution1 = Solution()
let words1 = ["wrt", "wrf", "er", "ett", "rftt"]
let result1 = solution1.alienOrder(words1)

print()
print("=========================")
print("Input: \(words1)")
print("Output: '\(result1)'")
print("Expected: 'wertf'")
print("=========================")

//==============================================================
// MARK: Test Case 2 — Simple Ordering
//==============================================================
print("\n\nTEST CASE 2: Simple Ordering")
print("=========================\n")

let solution2 = Solution()
let words2 = ["z", "x"]
let result2 = solution2.alienOrder(words2)

print()
print("=========================")
print("Input: \(words2)")
print("Output: '\(result2)'")
print("Expected: 'zx'")
print("=========================")

//==============================================================
// MARK: Test Case 3 — Multiple Characters Same Prefix
//==============================================================
print("\n\nTEST CASE 3: Multiple Characters Same Prefix")
print("=========================\n")

let solution3 = Solution()
let words3 = ["z", "zx"]
let result3 = solution3.alienOrder(words3)

print()
print("=========================")
print("Input: \(words3)")
print("Output: '\(result3)'")
print("Expected: 'zx'")
print("=========================")

//==============================================================
// MARK: Test Case 4 — Invalid Order (Word1 > Word2)
//==============================================================
print("\n\nTEST CASE 4: Invalid Order")
print("=========================\n")

let solution4 = Solution()
let words4 = ["zx", "z"]
let result4 = solution4.alienOrder(words4)

print()
print("=========================")
print("Input: \(words4)")
print("Output: '\(result4)'")
print("Expected: '' (invalid)")
print("=========================")

//==============================================================
// MARK: Test Case 5 — Complex Graph with Cycle
//==============================================================
print("\n\nTEST CASE 5: Cycle Detection")
print("=========================\n")

let solution5 = Solution()
let words5 = ["baa", "abab", "aba", "baa", "bab", "abb", "baa"]
let result5 = solution5.alienOrder(words5)

print()
print("=========================")
print("Input: \(words5)")
print("Output: '\(result5)'")
print("Expected: '' (cycle detected)")
print("=========================")

//==============================================================
// MARK: Test Case 6 — Single Word
//==============================================================
print("\n\nTEST CASE 6: Single Word")
print("=========================\n")

let solution6 = Solution()
let words6 = ["abc"]
let result6 = solution6.alienOrder(words6)

print()
print("=========================")
print("Input: \(words6)")
print("Output: '\(result6)'")
print("Expected: 'abc'")
print("=========================")
