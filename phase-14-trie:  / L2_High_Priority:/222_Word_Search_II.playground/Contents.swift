import Foundation

//
//  222_Word_Search_II.swift
//  LeetCode 212 — Word Search II
//  Pattern: Trie + Backtracking + 2D Grid DFS
//  Time:  O(M × N × 4^L)
//  Space: O(total chars in words) + O(L) recursion
//

//==============================================================
// MARK: - TrieNode
//==============================================================

final class TrieNode {
    var children: [Character: TrieNode] = [:]
    var word: String?
}

//==============================================================
// MARK: - Find Words
//==============================================================

func findWords(_ board: [[Character]], _ words: [String]) -> [String] {

    // Step 1: Build Trie
    let root = TrieNode()

    for word in words {
        var current = root
        for ch in word {
            if current.children[ch] == nil { current.children[ch] = TrieNode() }
            current = current.children[ch]!
        }
        current.word = word
    }

    print("✅ Trie built with \(words.count) words")

    // Step 2: DFS from every cell
    var board = board
    var result = [String]()

    for row in 0..<board.count {
        for col in 0..<board[0].count {
            dfs(&board, row, col, root, &result)
        }
    }

    return result
}

//==============================================================
// MARK: - DFS + Backtracking
//==============================================================

func dfs(_ board: inout [[Character]], _ row: Int, _ col: Int,
         _ node: TrieNode, _ result: inout [String]) {

    // Bounds check
    if row < 0 || col < 0 || row >= board.count || col >= board[0].count { return }

    let ch = board[row][col]

    // Visited check
    if ch == "#" { return }

    // Trie prune
    guard let next = node.children[ch] else { return }

    // Word found
    if let word = next.word {
        print("🎯 Found '\(word)' at (\(row),\(col))")
        result.append(word)
        next.word = nil                            // dedup
    }

    board[row][col] = "#"                          // mark visited

    dfs(&board, row + 1, col, next, &result)
    dfs(&board, row - 1, col, next, &result)
    dfs(&board, row, col + 1, next, &result)
    dfs(&board, row, col - 1, next, &result)

    board[row][col] = ch                           // backtrack
}

//==============================================================
// MARK: Main
//==============================================================

let board: [[Character]] = [
    ["o","a","a","n"],
    ["e","t","a","e"],
    ["i","h","k","r"],
    ["i","f","l","v"]
]

let words = ["oath","pea","eat","rain"]

let result = findWords(board, words)

print("Result   : \(result)")
print("Expected : [\"oath\", \"eat\"]")
