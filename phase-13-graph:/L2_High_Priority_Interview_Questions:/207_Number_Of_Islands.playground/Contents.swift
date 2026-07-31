import Foundation

// 207. Number of Islands  (LC 200) ⭐Blind75
// Phase 13 · L2_High_Priority_Interview_Questions

// MARK: - Problem
// Given a 2D grid of "1" (land) and "0" (water), count the islands. An island is a
// group of "1"s connected horizontally or vertically (NOT diagonally), surrounded by
// water or the grid edge.
//
// This is 206 Connected Components with the graph HIDDEN inside a grid:
//   - no adjacency list — each cell's neighbours are the 4 cells up/down/left/right
//   - "unvisited land" replaces "unvisited node"
//   - the count-how-many-times-you-start-a-fresh-DFS pattern is identical

// MARK: - Solution (DFS flood fill)

func numIslands(_ inputGrid: [[Character]]) -> Int {

    // STEP 1: mutable copy so we can mark visited in-place (O(1) extra space).
    // We overwrite visited land with "0", so "water" and "visited" become one check.
    var grid = inputGrid

    // STEP 2: dimensions
    let rows = grid.count
    guard rows > 0 else { return 0 }        // empty grid guard
    let cols = grid[0].count

    print("Grid \(rows)×\(cols)\n")

    var islandCount = 0

    // STEP 3: DFS — floods one entire island, turning its land to water.
    // Base cases (ORDER MATTERS — bounds first, or you crash on out-of-range access):
    //   a. off the grid  → return
    //   b. water/visited → return
    // Then: mark this cell water, recurse into all 4 neighbours.
    func dfs(_ r: Int, _ c: Int) {

        // base a: out of bounds
        if r < 0 || r >= rows || c < 0 || c >= cols {
            return
        }
        // base b: water or already-visited land
        if grid[r][c] == "0" {
            return
        }

        print("  flood (\(r),\(c)) → water")
        grid[r][c] = "0"                    // mark BEFORE recursing (204 Trap 1)

        // 4-directional recursion via direction vectors (reused in 209/212)
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]   // up, down, left, right
        for (dr, dc) in dirs {
            dfs(r + dr, c + dc)
        }
    }

    // STEP 4: scan every cell (this is 206's outer loop, in 2D).
    // Each unvisited "1" is a NEW island → count++ → flood the rest so it's skipped.
    for r in 0..<rows {
        for c in 0..<cols {
            if grid[r][c] == "1" {
                islandCount += 1
                print("🌴 new island #\(islandCount) starting at (\(r),\(c))")
                dfs(r, c)
            }
        }
    }

    print("\nTotal islands = \(islandCount)")
    return islandCount
}

// MARK: - Test

// 1 1 1 0 0
// 1 1 0 0 0
// 0 0 1 0 0
// 0 0 0 1 1
let grid: [[Character]] = [
    ["1","1","1","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
]

print("========== NUMBER OF ISLANDS ==========\n")
let answer = numIslands(grid)   // 3

// MARK: - Dry Run (why the count is 3)
// Scan hits (0,0)="1" → island #1 → floods the top-left blob:
//   (0,0)(0,1)(0,2)(1,0)(1,1) all → "0"
// Scan continues, all those now "0" → skipped.
// Hits (2,2)="1" → island #2 → floods just (2,2) (neighbours all water).
// Hits (3,3)="1" → island #3 → floods (3,3)(3,4).
// → 3

// MARK: - Complexity
// Time:  O(rows × cols) — each cell visited at most once (land turns to water on first
//        touch, then the "0" check skips it forever). The 4-way recursion doesn't
//        change this: an edge between two cells is walked O(1) times.
// Space: O(rows × cols) worst case — the recursion stack, when the grid is ALL land
//        and DFS snakes through every cell before returning.

// MARK: - Traps
// 1. Bounds check MUST come before the value check. If you test grid[r][c] first on an
//    out-of-range (r,c), it's an index-out-of-range crash.
// 2. Mark "0" BEFORE recursing, not after — same rule as 204: mark before you branch,
//    or a neighbour bounces straight back into the un-marked cell → infinite recursion.
// 3. 4-directional only. Adding diagonals ((-1,-1) etc.) is a DIFFERENT problem
//    (LC 200 is 4-dir; some variants like "max area / number of closed islands" differ).
// 4. Mutating the input: fine here (deep-copied via `var grid = inputGrid`, and the
//    caller's array is a value type so untouched). If the interviewer says "don't
//    modify the grid," use a separate visited 2D array instead (see Q&A).

// MARK: - Interview Q&A
// Q: DFS or BFS — does it matter?
// A: No for correctness — either floods a full island. DFS is shorter to write; BFS
//    avoids deep recursion on a huge all-land grid (use a queue of (r,c) then).
// Q: What if I can't modify the input?
// A: var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
//    and check/set visited[r][c] instead of overwriting the grid. Costs O(rows×cols)
//    extra space instead of O(1).
// Q: Union-Find alternative?
// A: Union adjacent land cells, then count distinct roots. Near-O(rows×cols) with path
//    compression — overkill here, but it's the tool that arrives at 213/214/216.
