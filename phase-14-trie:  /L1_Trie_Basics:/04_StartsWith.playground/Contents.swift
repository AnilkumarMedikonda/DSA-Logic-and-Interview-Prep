import UIKit

//==============================================================
// 05_StartsWith.swift
// Goal:
// 1. Implement startsWith()
// 2. Understand search() vs startsWith() difference
// 3. Fix the current = root bug
//==============================================================

//==============================================================
// MARK: - TrieNode
//==============================================================

class TrieNode {

    var children: [Character: TrieNode] = [:]
    var isWord = false
}

//==============================================================
// MARK: - Trie
//==============================================================

class Trie {

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

            if current.children[ch] == nil {

                print("❌ '\(ch)' NOT Found")
                print("✅ Creating '\(ch)' Node")

                current.children[ch] = TrieNode()

            } else {

                print("♻️ Reusing Node : '\(ch)'")
            }

            current = current.children[ch]!

            print("➡️ Move Current → '\(ch)'")

            print()
        }

        current.isWord = true

        print("----------------------------------")
        print("✅ '\(word)' Inserted Successfully")
        print("Last Node isWord = \(current.isWord)")
    }

    //==========================================================
    // MARK: Search  (exact word — checks isWord)
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
    // MARK: StartsWith  (prefix only — ignores isWord)
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

            current = next   // ← THE FIX: follow the path (NOT current = root)

            let children = current.children.keys
                .map(String.init)
                .sorted()

            print("➡️ Move Current → '\(ch)'")
            print("Next Children : \(children)")

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
// MARK: Main
//==============================================================

let trie = Trie()

trie.insert("hello")
trie.insert("help")

trie.printTrie()

//==============================================================
// Test Cases
//==============================================================

print("\n==========================================")
print("TEST RESULTS")
print("==========================================")

let s1 = trie.search("hello")       // true  → complete word
let s2 = trie.search("hel")         // false → prefix only

let p1 = trie.startsWith("hel")     // true  → prefix exists
let p2 = trie.startsWith("he")      // true  → this was FALSE with the bug
let p3 = trie.startsWith("hello")   // true  → full word is also a valid prefix
let p4 = trie.startsWith("world")   // false → 'w' not found

print("""

==========================================
SUMMARY
==========================================
search("hello")      = \(s1)  (expected: true)
search("hel")        = \(s2)  (expected: false — prefix only)

startsWith("hel")    = \(p1)  (expected: true)
startsWith("he")     = \(p2)  (expected: true — bug made this false)
startsWith("hello")  = \(p3)  (expected: true)
startsWith("world")  = \(p4)  (expected: false)

==========================================
KEY DIFFERENCE
==========================================
search()     → path must exist AND isWord == true
startsWith() → path must exist (isWord ignored)
""")
