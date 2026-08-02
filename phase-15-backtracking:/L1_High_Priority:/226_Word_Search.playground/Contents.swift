import Foundation

// 226_Word_Search

/*
====================================================
            226_Word_Search.swift
====================================================

Problem:
Given a 2D grid of characters and a word, return true
if the word exists in the grid.
- Move up/down/left/right (no diagonal)
- Same cell cannot be used twice in one word

Input:
board = [["A","B","C","E"],
         ["S","F","C","S"],
         ["A","D","E","E"]]

word = "ABCCED" → true
word = "SEE"    → true
word = "ABCB"   → false (B reused)

Key Idea:
- Try DFS from EVERY cell as a starting point
- dfs(row, col, index) = "can I match word[index...] from here?"
- Mark cell "#" (Choose) → explore 4 directions → restore (Undo)

====================================================
Time Complexity : O(m · n · 4^L)
====================================================
- m·n starting cells
- Each letter branches up to 4 directions
- L = word length → 4^L per start (≈3^L in practice,
  since we never go back to the cell we came from)

====================================================
Space Complexity : O(L)
====================================================
- Recursion depth = word length
- "#" trick → no extra visited array
- (board copy is O(m·n) but input-sized, usually not counted)
====================================================
*/

final class Solution {
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        
        var board = board
        let chars = Array(word)
        
        let rows = board.count
        let cols = board[0].count
        
        for row in 0..<rows {
            
            for col in 0..<cols {
                
                print("🔍 Try start at (\(row), \(col)) = \(board[row][col])")
                print()
                
                if dfs(&board, chars, row, col, 0) {
                    print("🎉 Word FOUND starting at (\(row), \(col))")
                    print()
                    return true
                }
            }
        }
        
        print("❌ Word NOT found in grid")
        print()
        return false
    }
    
    func dfs(_ board: inout [[Character]], _ word: [Character], _ row: Int, _ col: Int, _ index: Int) -> Bool {
        
        // Base Case 1 : matched every character
        if index == word.count {
            print("✅ Matched full word!")
            print()
            return true
        }
        
        // Base Case 2 : out of bounds
        if row < 0 || row >= board.count || col < 0 || col >= board[0].count {
            return false
        }
        
        // Base Case 3 : character mismatch (or visited "#")
        if board[row][col] != word[index] {
            print("⊘ (\(row), \(col)) = \(board[row][col]) ≠ \(word[index])")
            return false
        }
        
        // ------------------------
        // STEP 1 : Choose (mark visited)
        // ------------------------
        print("👉 Match \(word[index]) at (\(row), \(col)), index \(index)")
        let temp = board[row][col]
        board[row][col] = "#"
        
        // ------------------------
        // STEP 2 : Explore (4 directions)
        // ------------------------
        let found = dfs(&board, word, row - 1, col, index + 1) ||   // Up
                    dfs(&board, word, row + 1, col, index + 1) ||   // Down
                    dfs(&board, word, row, col - 1, index + 1) ||   // Left
                    dfs(&board, word, row, col + 1, index + 1)      // Right
        
        // ------------------------
        // STEP 3 : Undo (restore cell)
        // ------------------------
        board[row][col] = temp
        print("⬅️ Undo (\(row), \(col)) restored to \(temp)")
        print()
        
        return found
    }
}

// MARK: - Run
let board: [[Character]] = [
    ["A", "B", "C", "E"],
    ["S", "F", "C", "S"],
    ["A", "D", "E", "E"]
]

let solution = Solution()

print("========== Test 1: ABCCED ==========")
print()
print(solution.exist(board, "ABCCED"))   // true
print()

print("========== Test 2: SEE ==========")
print()
print(solution.exist(board, "SEE"))      // true
print()

print("========== Test 3: ABCB ==========")
print()
print(solution.exist(board, "ABCB"))     // false
