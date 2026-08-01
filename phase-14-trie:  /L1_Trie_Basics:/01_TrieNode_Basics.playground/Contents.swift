//
//  01_TrieNode_Basics.swift
//  Phase-14-Trie
//
//  Goal:
//  1. Understand TrieNode
//  2. Create Root Node
//  3. Manually Insert One Word
//  4. Understand isWord
//

import Foundation

//==============================================================
// MARK: - TrieNode
//==============================================================

class TrieNode {

    /// Stores next possible characters
    var children: [Character: TrieNode] = [:]

    /// True if this node represents the end of a complete word
    var isWord: Bool = false
}

//==============================================================
// MARK: - Start
//==============================================================

print("""
====================================================
            01 - TrieNode Basics
====================================================
""")

//==============================================================
// MARK: - Step 1 : Create Root
//==============================================================

print("""
----------------------------------------------------
STEP 1 : Create Root Node
----------------------------------------------------
""")

let root = TrieNode()

print("✅ Root Node Created")
print("Children : \(root.children)")
print("isWord   : \(root.isWord)")

//==============================================================
// MARK: - Step 2 : Insert One Word
//==============================================================

let word = "hello"

print("""

----------------------------------------------------
STEP 2 : Insert '\(word)'
----------------------------------------------------
""")

var current = root

for (index, ch) in word.enumerated() {

    print("""
    
    ----------------------------------------
    Character \(index + 1) : '\(ch)'
    ----------------------------------------
    """)

    let currentChildren = current.children.keys
        .map(String.init)
        .sorted()

    print("Current Children : \(currentChildren)")

    if current.children[ch] == nil {

        print("❌ '\(ch)' not found")
        print("✅ Creating '\(ch)' node")

        current.children[ch] = TrieNode()

    } else {

        print("♻️ '\(ch)' already exists")
    }

    current = current.children[ch]!

    print("➡️ Move to '\(ch)'")
    print("Current Node isWord : \(current.isWord)")
}

print("""

----------------------------------------------------
STEP 3 : Mark End Of Word
----------------------------------------------------
""")

current.isWord = true

print("✅ '\(word)' inserted successfully")
print("Last Node isWord : \(current.isWord)")

//==============================================================
// MARK: - Step 4 : Search Manually
//==============================================================

print("""

----------------------------------------------------
STEP 4 : Verify Word
----------------------------------------------------
""")

var verify = root

for ch in word {

    print("Searching '\(ch)'")

    guard let next = verify.children[ch] else {

        print("❌ Character not found")
        break
    }

    verify = next

    print("✅ Found '\(ch)'")
}

print()

if verify.isWord {

    print("🎉 Word '\(word)' Found")

} else {

    print("❌ Word Not Found")
}

//==============================================================
// MARK: - Step 5 : Trie Structure
//==============================================================

print("""

----------------------------------------------------
STEP 5 : Trie Structure
----------------------------------------------------
""")

func printTrie(
    _ node: TrieNode,
    prefix: String = ""
) {

    let children = node.children.sorted {
        $0.key < $1.key
    }

    for (char, child) in children {

        let symbol = child.isWord ? "*" : ""

        print(prefix + "└── \(char)\(symbol)")

        printTrie(
            child,
            prefix: prefix + "    "
        )
    }
}

print("Root")

printTrie(root)

//==============================================================
// MARK: - Step 6 : Node Inspection
//==============================================================

print("""

----------------------------------------------------
STEP 6 : Node Inspection
----------------------------------------------------
""")

let h = root.children["h"]!
let e = h.children["e"]!
let l1 = e.children["l"]!
let l2 = l1.children["l"]!
let o = l2.children["o"]!

print("Root isWord : \(root.isWord)")
print("h    isWord : \(h.isWord)")
print("e    isWord : \(e.isWord)")
print("l1   isWord : \(l1.isWord)")
print("l2   isWord : \(l2.isWord)")
print("o    isWord : \(o.isWord)")

print()

if !h.isWord &&
    !e.isWord &&
    !l1.isWord &&
    !l2.isWord &&
    o.isWord {

    print("✅ All Checks Passed")

} else {

    print("❌ Validation Failed")
}

print("""

====================================================
Completed : 01_TrieNode_Basics
====================================================
""")
