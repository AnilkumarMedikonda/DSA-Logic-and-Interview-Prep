import UIKit

//==============================================================
// 04_Search_Word.swift
// Goal:
// 1. Insert words
// 2. Implement search()
// 3. Understand word vs prefix difference
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

            let existingChildren = current.children.keys
                .map(String.init)
                .sorted()

            print("Current Children  : \(existingChildren)")

            if current.children[ch] == nil {

                print("❌ '\(ch)' NOT Found")
                print("✅ Creating '\(ch)' Node")

                current.children[ch] = TrieNode()

            } else {

                print("♻️ '\(ch)' Already Exists")
                print("♻️ Reusing Existing Node")
            }

            current = current.children[ch]!   // ← THE FIX: move forward

            print("➡️ Move Current → '\(ch)'")
            print("isWord : \(current.isWord)")

            print()
        }

        print("----------------------------------")
        print("Mark End Of Word")
        print("----------------------------------")

        current.isWord = true

        print("✅ '\(word)' Inserted Successfully")
        print("Last Node isWord = \(current.isWord)")
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

            let children = current.children.keys
                .map(String.init)
                .sorted()

            print("➡️ Move Current → '\(ch)'")
            print("Next Children : \(children)")
            print("isWord        : \(current.isWord)")

            print()
        }

        print("----------------------------------")
        print("Reached Last Character")
        print("----------------------------------")

        print("Final isWord = \(current.isWord)")

        if current.isWord {
            print("✅ '\(word)' EXISTS As Complete Word")
        } else {
            print("⚠️ '\(word)' Is Only A PREFIX, Not A Word")
        }

        return current.isWord
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

        let children = node.children.sorted {
            $0.key < $1.key
        }

        for (char, child) in children {

            let symbol = child.isWord ? "*" : ""

            print(prefix + "└── \(char)\(symbol)")

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

let r1 = trie.search("hello")   // true  → complete word
let r2 = trie.search("help")    // true  → complete word
let r3 = trie.search("hel")     // false → only a prefix
let r4 = trie.search("world")   // false → 'w' not found

print("""

==========================================
SUMMARY
==========================================
search("hello") = \(r1)  (expected: true)
search("help")  = \(r2)  (expected: true)
search("hel")   = \(r3)  (expected: false — prefix only)
search("world") = \(r4)  (expected: false — not in trie)
""")
