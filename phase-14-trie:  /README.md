# Phase 14 — Trie (Problems 220–222)

Swift solutions for the Trie phase of my DSA roadmap. Every problem includes
step-by-step comments, debug logs, traps, and tests. Covers Trie fundamentals,
wildcard search with DFS, and the Trie + backtracking grid combination.


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 220 | Implement Trie (Prefix Tree) ⭐ | LC 208 | Children dictionary + isWord flag; walk, create, mark | O(L) all ops |
| 221 | Design Add and Search Words ⭐ | LC 211 | Trie + DFS; `.` wildcard branches into all children | O(L) / O(26^L) wildcard |
| 222 | Word Search II ⭐ | LC 212 | One Trie from words + grid DFS backtracking, "#" visited trick | O(M × N × 4^L) |

## Core Patterns

- **Trie node structure** — `[Character: TrieNode]` children dictionary +
  end-of-word marker; words sharing a prefix share the same path, making
  lookups O(L) regardless of dictionary size (220)
- **Walk-create-mark insertion** — traverse character by character, create
  missing nodes, move `current` forward, mark `isWord` only on the final
  node; intermediate nodes stay `false` (220)
- **Search vs startsWith** — identical traversal, different return:
  `search` returns `current.isWord`, `startsWith` returns `true` on path
  completion; "hel" exists as a path but is not a word (220)
- **Wildcard DFS branching** — `.` forces exploring ALL children; return
  true if ANY branch succeeds, false only after all fail; recursion is
  required because a loop cannot backtrack to sibling branches (221)
- **Base case on index exhaustion** — `index == word.count` →
  `return node.isWord`; the recursion consumes the pattern, not the Trie (221)
- **Store the word in the end node** — `var word: String?` instead of
  `isWord` avoids rebuilding the path when DFS finds a match deep in the
  grid (222)
- **Trie as DFS pruner** — `guard let next = node.children[ch]` kills any
  grid path that is not a prefix of some word; this single line is why
  Trie beats running Word Search per word (222)
- **"#" visited trick** — mutate `board[r][c] = "#"` before exploring,
  restore after; O(1) visited tracking with no extra Set, and "#" can
  never match a Trie child so visited cells auto-prune (222)
- **nil-out for dedup** — `node.word = nil` after appending to results;
  the same word reachable via multiple grid paths is recorded once,
  no Set needed (222)
- **Interview ladder** — Trie template → wildcard DFS → Trie + grid
  backtracking; 222 combines 220's structure, 221's branching, and the
  Graph phase's flood-fill visited pattern

## Traps Logged This Phase

- Forgetting `current = current.children[ch]!` in insert leaves every
  character as a direct child of root — isWord lands on the wrong node
  and every search fails (220)
- `current = root` instead of `current = next` inside startsWith resets
  to root each iteration — only checks root-level children, so
  `startsWith("he")` fails while `startsWith("h")` passes by accident (220)
- Recursing with `node` instead of `next` after a successful `guard let` —
  the index advances but the Trie position never moves, so every character
  gets checked against the same level; `search("bad")` returns false (221)
- Building the Trie but never calling `dfs` from the grid loop — output is
  always `[]`; the traversal loop is part of the solution, not boilerplate (222)
- Common thread across all four bugs: **not moving forward correctly** —
  Trie traversal is always check → move → repeat
- Accessing `root.children["a"]` for a nested node — Trie paths are
  hierarchical; "a" is a child of "c" in "cat", not of root (basics)
- Empty `if current.isWord { } else { }` branches — either fill with
  debug output or delete; dead branches hide intent (basics)

## House Rules

- No force unwraps except the safe post-nil-check insert pattern
- No `?? 0` nil-coalescing — explicit `if let / guard let` everywhere
- `final class` for reference types
- Guard statements for early exits and pruning
- `let` over `var` where mutation is absent
- Debug prints at key decision points, not every line
- Step-by-step structure with clear section headers

**Status:** ✅ Complete — closed Aug 1, 2026
