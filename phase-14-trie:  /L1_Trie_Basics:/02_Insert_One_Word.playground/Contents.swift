import Foundation

//==============================================================
// 02_Insert_One_Word.swift
// Goal:
// 1. Create Trie
// 2. Implement insert()
// 3. Understand node creation and reuse
//==============================================================

//==============================================================
// MARK: - TrieNode
//==============================================================

class TrieNode {

    /// Stores next characters
    var children: [Character: TrieNode] = [:]

    /// Marks end of a complete word
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

            current = current.children[ch]!

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

trie.printTrie()
