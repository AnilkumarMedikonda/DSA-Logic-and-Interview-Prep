import Foundation

class Solution {
    
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        
        print("====================================")
        print("STEP 1: Validate Input")
        print("====================================")
        
        let wordSet = Set(wordList)
        print("Begin: '\(beginWord)' | End: '\(endWord)' | Words: \(wordList.count)")
        
        guard wordSet.contains(endWord) else {
            print("❌ End word not found")
            return 0
        }
        
        print("✓ End word found")
        
        print()
        print("====================================")
        print("STEP 2: Build Neighbor Graph")
        print("====================================")
        
        var neighbors = [String: [String]]()
        let allWords = wordSet.contains(beginWord) ? Array(wordSet) : [beginWord] + Array(wordSet)
        
        for word in allWords {
            for pattern in generatePatterns(word) {
                if neighbors[pattern] == nil {
                    neighbors[pattern] = []
                }
                neighbors[pattern]!.append(word)
            }
        }
        
        print("Graph built with \(neighbors.count) patterns")
        
        print()
        print("====================================")
        print("STEP 3: BFS Traversal")
        print("====================================")
        
        var visited = Set<String>()
        var queue = [(word: String, level: Int)]()
        
        visited.insert(beginWord)
        queue.append((beginWord, 1))
        
        var head = 0
        
        while head < queue.count {
            let (currentWord, level) = queue[head]
            head += 1
            
            print("Processing: '\(currentWord)' (Level: \(level))")
            
            if currentWord == endWord {
                print()
                print("✅ Found end word!")
                print("Answer: \(level)")
                return level
            }
            
            var foundCount = 0
            for pattern in generatePatterns(currentWord) {
                for neighbor in neighbors[pattern] ?? [] {
                    guard neighbor != currentWord && !visited.contains(neighbor) else { continue }
                    
                    foundCount += 1
                    visited.insert(neighbor)
                    queue.append((neighbor, level + 1))
                }
            }
            
            if foundCount > 0 {
                print("  Added \(foundCount) neighbors")
            }
        }
        
        print()
        print("====================================")
        print("❌ No path found")
        print("====================================")
        
        return 0
    }
    
    private func generatePatterns(_ word: String) -> [String] {
        let chars = Array(word)
        var patterns = [String]()
        
        for i in 0..<chars.count {
            var pattern = chars
            pattern[i] = "*"
            patterns.append(String(pattern))
        }
        
        return patterns
    }
}

//==============================================================
// Test
//==============================================================
print("\n")
let solution = Solution()
let answer = solution.ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"])
print("\nFinal Answer: \(answer)")
print("Expected: 5")
