import Foundation

//==============================================================
// 417. Pacific Atlantic Water Flow
// Pattern : Reverse DFS
// Time    : O(rows × cols)
// Space   : O(rows × cols)
//==============================================================

class Solution {

    func pacificAtlantic(_ heights: [[Int]]) -> [[Int]] {

        //------------------------------------------------------
        // STEP 1: Empty Grid Check
        //------------------------------------------------------
        if heights.isEmpty { return [] }

        //------------------------------------------------------
        // STEP 2: Rows & Columns
        //------------------------------------------------------
        let rows = heights.count
        let cols = heights[0].count

        print("====================================")
        print("INPUT MATRIX")
        print("====================================")

        for row in heights {
            print(row)
        }
        print()

        //------------------------------------------------------
        // STEP 3: Pacific Visited
        //------------------------------------------------------
        var pacific = Array(repeating: Array(repeating: false, count: cols), count: rows)

        //------------------------------------------------------
        // STEP 4: Atlantic Visited
        //------------------------------------------------------
        var atlantic = Array(repeating: Array(repeating: false, count: cols), count: rows)

        //------------------------------------------------------
        // STEP 5: Directions
        //------------------------------------------------------
        let directions = [
            (-1, 0),     // Up
            (1, 0),      // Down
            (0, -1),     // Left
            (0, 1)       // Right
        ]

        //------------------------------------------------------
        // STEP 6: DFS
        //------------------------------------------------------
        func dfs(_ row: Int, _ col: Int, _ visited: inout [[Bool]], _ ocean: String) {
            if visited[row][col] {
                print("Already Visited (\(row),\(col))")
                return
            }

            visited[row][col] = true

            print()
            print("----------------------------------")
            print("\(ocean)")
            print("Visit Cell (\(row),\(col))")
            print("Height = \(heights[row][col])")
            print("----------------------------------")

            for (dr, dc) in directions {
                let newRow = row + dr
                let newCol = col + dc

                print()
                print("Checking (\(newRow),\(newCol))")

                if newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols {
                    print("Outside Grid")
                    continue
                }

                if visited[newRow][newCol] {
                    print("Already Visited")
                    continue
                }

                print("Current Height = \(heights[row][col])")
                print("Next Height    = \(heights[newRow][newCol])")

                if heights[newRow][newCol] < heights[row][col] {
                    print("Cannot Move")
                    print("Reason : Next Height is Smaller")
                    continue
                }
                print("Move to (\(newRow),\(newCol))")
                dfs(newRow, newCol, &visited, ocean)
            }
        }

        //------------------------------------------------------
        // STEP 7: Start DFS From Pacific Ocean
        // Pacific = Top Row + Left Column
        //------------------------------------------------------
        print()
        print("====================================")
        print("PACIFIC DFS")
        print("====================================")

        // Top Row
        for col in 0..<cols {
            print()
            print("Start Pacific DFS From (0,\(col))")
            dfs(0, col, &pacific, "Pacific")
        }

        // Left Column
        for row in 0..<rows {
            print()
            print("Start Pacific DFS From (\(row),0)")
            dfs(row, 0, &pacific, "Pacific")
        }

        //------------------------------------------------------
        // STEP 8: Start DFS From Atlantic Ocean
        // Atlantic = Bottom Row + Right Column
        //------------------------------------------------------
        print()
        print("====================================")
        print("ATLANTIC DFS")
        print("====================================")

        // Bottom Row
        for col in 0..<cols {
            print()
            print("Start Atlantic DFS From (\(rows - 1),\(col))")
            dfs(rows - 1, col, &atlantic, "Atlantic")
        }

        // Right Column
        for row in 0..<rows {
            print()
            print("Start Atlantic DFS From (\(row),\(cols - 1))")
            dfs(row, cols - 1, &atlantic, "Atlantic")
        }

        //------------------------------------------------------
        // STEP 9: Print Pacific Visited Matrix
        //------------------------------------------------------
        print()
        print("====================================")
        print("PACIFIC VISITED")
        print("====================================")

        for row in pacific {
            print(row)
        }

        //------------------------------------------------------
        // STEP 10: Print Atlantic Visited Matrix
        //------------------------------------------------------
        print()
        print("====================================")
        print("ATLANTIC VISITED")
        print("====================================")

        for row in atlantic {
            print(row)
        }

        //------------------------------------------------------
        // STEP 11: Find Common Cells
        //------------------------------------------------------
        print()
        print("====================================")
        print("COMMON CELLS")
        print("====================================")

        var answer = [[Int]]()

        for row in 0..<rows {
            for col in 0..<cols {
                if pacific[row][col] && atlantic[row][col] {
                    print("Cell (\(row),\(col)) can reach BOTH oceans")
                    answer.append([row, col])
                }
            }
        }

        //------------------------------------------------------
        // STEP 12: Print Final Answer
        //------------------------------------------------------
        print()
        print("====================================")
        print("FINAL ANSWER")
        print("====================================")
        print(answer)

        return answer
    }
}

//==============================================================
// MARK: Test Case 1
//==============================================================
print("TEST CASE 1: 5×5 Grid")
print("=========================")

let solution1 = Solution()

let heights1 = [
    [1, 2, 2, 3, 5],
    [3, 2, 3, 4, 4],
    [2, 4, 5, 3, 1],
    [6, 7, 1, 4, 5],
    [5, 1, 1, 2, 4]
]

let answer1 = solution1.pacificAtlantic(heights1)

print()
print("=========================")
print("Returned Answer")
print("=========================")
print(answer1)

//==============================================================
// MARK: Test Case 2
//==============================================================
print("\n\nTEST CASE 2: 1×2 Grid")
print("=========================")

let solution2 = Solution()

let heights2 = [
    [1, 1],
    [1, 1]
]

let answer2 = solution2.pacificAtlantic(heights2)

print()
print("=========================")
print("Returned Answer")
print("=========================")
print(answer2)

//==============================================================
// MARK: Test Case 3
//==============================================================
print("\n\nTEST CASE 3: Single Cell")
print("=========================")

let solution3 = Solution()

let heights3 = [
    [1]
]

let answer3 = solution3.pacificAtlantic(heights3)

print()
print("=========================")
print("Returned Answer")
print("=========================")
print(answer3)

//==============================================================
// MARK: Test Case 4
//==============================================================
print("\n\nTEST CASE 4: 3×3 Increasing Heights")
print("=========================")

let solution4 = Solution()

let heights4 = [
    [1, 2, 3],
    [8, 9, 4],
    [7, 6, 5]
]

let answer4 = solution4.pacificAtlantic(heights4)

print()
print("=========================")
print("Returned Answer")
print("=========================")
print(answer4)
