import UIKit

//
//  221_Design_Add_And_Search_Words.swift
//  LeetCode 211 — Design Add and Search Words Data Structure
//  Pattern: Trie + DFS (wildcard matching)
//  Time:
//      addWord() -> O(L)
//      search()  -> O(L) normal, O(26^L) worst case with '.'
//  Space:
//      O(total characters) for Trie
//

//==============================================================
// MARK: - TrieNode
//==============================================================

final class TrieNode {

    var children: [Character: TrieNode] = [:]
    var isWord = false
}

//==============================================================
// MARK: - WordDictionary
//==============================================================

final class WordDictionary {

    private let root = TrieNode()

    init() {
        print("""
        ==========================================
              WORD DICTIONARY CREATED
        ==========================================
        """)
    }

    //==========================================================
    // MARK: Add Word
    //==========================================================

    func addWord(_ word: String) {

        print("""

        ==========================================
        ADD WORD : "\(word)"
        ==========================================
        """)

        var current = root
        var path: [Character] = []

        for (index, ch) in word.enumerated() {

            print("----------------------------------")
            print("Step \(index + 1)")
            print("----------------------------------")

            path.append(ch)

            print("Current Character : '\(ch)'")
            print("Current Path      : \(path.map(String.init).joined())")

            if current.children[ch] == nil {

                print("❌ '\(ch)' NOT Found")
                print("✅ Creating '\(ch)' Node")

                current.children[ch] = TrieNode()

            } else {

                print("♻️ '\(ch)' Already Exists — Reusing")
            }

            current = current.children[ch]!

            print("➡️ Move Current → '\(ch)'")

            print()
        }

        current.isWord = true

        print("----------------------------------")
        print("✅ '\(word)' Added — End Of Word Marked")
    }

    //==========================================================
    // MARK: Search (supports '.' wildcard)
    //==========================================================

    func search(_ word: String) -> Bool {

        print("""

        ==========================================
        SEARCH : "\(word)"
        ==========================================
        """)

        let result = dfs(Array(word), 0, root, depth: 0)

        print("------------------------------------------")

        if result {
            print("✅ '\(word)' FOUND")
        } else {
            print("❌ '\(word)' NOT FOUND")
        }

        return result
    }

    //==========================================================
    // MARK: DFS Helper
    //==========================================================

    private func dfs(_ word: [Character], _ index: Int,_ node: TrieNode, depth: Int) -> Bool {

        let indent = String(repeating: "    ", count: depth)

        //------------------------------------------------------
        // Base Case : consumed all characters
        //------------------------------------------------------

        if index == word.count {

            print("\(indent)[BASE] End of pattern reached")
            print("\(indent)       isWord = \(node.isWord)")

            return node.isWord
        }

        let ch = word[index]

        print("\(indent)[DFS] index = \(index), char = '\(ch)'")

        //------------------------------------------------------
        // Case 1 : '.' wildcard → try EVERY child
        //------------------------------------------------------

        if ch == "." {

            let childKeys = node.children.keys
                .map(String.init)
                .sorted()

            print("\(indent)  '.' wildcard → exploring children: \(childKeys)")

            for (childChar, child) in node.children.sorted(by: { $0.key < $1.key }) {

                print("\(indent)  → Trying branch '\(childChar)'")

                if dfs(word, index + 1, child, depth: depth + 1) {

                    print("\(indent)  ✅ Branch '\(childChar)' SUCCEEDED")
                    return true
                }

                print("\(indent)  ↩️ Branch '\(childChar)' failed — backtrack")
            }

            print("\(indent)  ❌ ALL branches failed for '.'")
            return false
        }

        //------------------------------------------------------
        // Case 2 : normal character → exact match
        //------------------------------------------------------

        guard let next = node.children[ch] else {

            print("\(indent)  ❌ '\(ch)' not found → dead end")
            return false
        }

        print("\(indent)  ✅ '\(ch)' found — go deeper")

        return dfs(word, index + 1, next, depth: depth + 1)   // ← THE FIX: next, not node
    }
}

//==============================================================
// MARK: Main — LeetCode 211 Example
//==============================================================

let dictionary = WordDictionary()

dictionary.addWord("bad")
dictionary.addWord("dad")
dictionary.addWord("mad")

//==============================================================
// Test Cases
//==============================================================

let r1 = dictionary.search("pad")   // false → 'p' not in root
let r2 = dictionary.search("bad")   // true  → exact match
let r3 = dictionary.search(".ad")   // true  → '.' tries b, d, m
let r4 = dictionary.search("b..")   // true  → 'b' then any 2 chars

print("""

==========================================
SUMMARY
==========================================
search("pad") = \(r1)  (expected: false)
search("bad") = \(r2)  (expected: true)
search(".ad") = \(r3)  (expected: true)
search("b..") = \(r4)  (expected: true)

==========================================
THE BUG YOU HAD
==========================================
return dfs(word, index+1, node)  ❌ stayed at same node
return dfs(word, index+1, next)  ✅ moves to child

With the bug: 'bad' → 'b' found at root,
but then 'a' is checked against ROOT again → false

==========================================
KEY CONCEPTS
==========================================
1. Normal char → guard let + recurse into NEXT
2. '.' → loop all children, return true if ANY succeeds
3. Base case → index == count → return node.isWord
""")
