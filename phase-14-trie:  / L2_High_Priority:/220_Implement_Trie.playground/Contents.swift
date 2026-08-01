//
//  220_Implement_Trie.swift
//  LeetCode 208 — Implement Trie (Prefix Tree)
//  Pattern: Trie Fundamentals
//  Time:
//      insert()     -> O(L)
//      search()     -> O(L)
//      startsWith() -> O(L)
//  Space:
//      O(L) per new insert, O(total chars) overall
//

import Foundation

//==============================================================
// MARK: - TrieNode
//==============================================================

final class TrieNode {

    /// Next characters
    var children: [Character: TrieNode] = [:]

    /// Marks end of a complete word
    var isWord = false
}

//==============================================================
// MARK: - Trie
//==============================================================

final class Trie {

    private let root = TrieNode()

    init() {
        print("""
        ==========================================
                  TRIE CREATED
        ==========================================
        Root Node Created
        """)
    }

    //==========================================================
    // MARK: Insert
    //==========================================================

    func insert(_ word: String) {

        print("""

        ==========================================
        INSERT WORD : "\(word)"
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

            let existingChildren = current.children.keys
                .map(String.init)
                .sorted()

            print("Current Children  : \(existingChildren)")

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

        print("----------------------------------")
        print("Mark End Of Word")
        print("----------------------------------")

        current.isWord = true

        print("✅ '\(word)' Inserted Successfully")
    }

    //==========================================================
    // MARK: Search
    //==========================================================

    func search(_ word: String) -> Bool {

        print("""

        ==========================================
        SEARCH WORD : "\(word)"
        ==========================================
        """)

        var current = root
        var path: [Character] = []

        for (index, ch) in word.enumerated() {

            print("----------------------------------")
            print("Step \(index + 1)")
            print("----------------------------------")

            path.append(ch)

            print("Searching Character : '\(ch)'")
            print("Current Path        : \(path.map(String.init).joined())")

            guard let next = current.children[ch] else {

                print("❌ '\(ch)' NOT Found")
                print("❌ SEARCH FAILED")
                return false
            }

            print("✅ '\(ch)' Found")

            current = next

            print("➡️ Move Current → '\(ch)'")
            print("isWord : \(current.isWord)")

            print()
        }

        print("----------------------------------")
        print("Reached Last Character")
        print("Final isWord = \(current.isWord)")

        if current.isWord {
            print("✅ '\(word)' EXISTS As Complete Word")
        } else {
            print("⚠️ '\(word)' Is Only A PREFIX, Not A Word")
        }

        return current.isWord
    }

    //==========================================================
    // MARK: Starts With
    //==========================================================

    func startsWith(_ prefix: String) -> Bool {

        print("""

        ==========================================
        STARTS WITH : "\(prefix)"
        ==========================================
        """)

        var current = root
        var path: [Character] = []

        for (index, ch) in prefix.enumerated() {

            print("----------------------------------")
            print("Step \(index + 1)")
            print("----------------------------------")

            path.append(ch)

            print("Checking Character : '\(ch)'")
            print("Current Path       : \(path.map(String.init).joined())")

            guard let next = current.children[ch] else {

                print("❌ '\(ch)' NOT Found")
                print("❌ PREFIX FAILED")
                return false
            }

            print("✅ '\(ch)' Found")

            current = next

            print("➡️ Move Current → '\(ch)'")

            print()
        }

        print("----------------------------------")
        print("✅ Prefix '\(prefix)' Exists")
        print("Note: isWord NOT checked — prefix only")

        return true
    }

    //==========================================================
    // MARK: Print Trie
    //==========================================================

    func printTrie() {

        print("""

        ==========================================
        TRIE STRUCTURE
        ==========================================
        """)

        print("Root")

        printNode(root, prefix: "")
    }

    private func printNode(_ node: TrieNode, prefix: String) {

        let children = node.children.sorted { $0.key < $1.key }

        for (ch, child) in children {

            let symbol = child.isWord ? "*" : ""

            print(prefix + "└── \(ch)\(symbol)")

            printNode(child, prefix: prefix + "    ")
        }
    }
}

//==============================================================
// MARK: Main — LeetCode 208 Example
//==============================================================

let trie = Trie()

trie.insert("apple")

let r1 = trie.search("apple")     // true
let r2 = trie.search("app")       // false — prefix only
let r3 = trie.startsWith("app")   // true

trie.insert("app")

let r4 = trie.search("app")       // true — now a complete word

trie.printTrie()

print("""

==========================================
SUMMARY (LeetCode 208 Example)
==========================================
search("apple")     = \(r1)  (expected: true)
search("app")       = \(r2)  (expected: false — prefix only)
startsWith("app")   = \(r3)  (expected: true)
insert("app")
search("app")       = \(r4)  (expected: true — now marked isWord)
""")
