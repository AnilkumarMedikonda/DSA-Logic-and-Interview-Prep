import Foundation

//==============================================================
// 994. Rotting Oranges
// Pattern: Multi-Source BFS
// Time  : O(rows × cols)
// Space : O(rows × cols)
//==============================================================

// MARK: - Sample Input

let grid = [
    [2,1,1],
    [1,1,0],
    [0,1,1]
]

/*

0 = Empty Cell

1 = Fresh Orange

2 = Rotten Orange


Input

2 1 1
1 1 0
0 1 1


Minute 0

2 1 1
1 1 0
0 1 1

Minute 1

2 2 1
2 1 0
0 1 1

Minute 2

2 2 2
2 2 0
0 1 1

Minute 3

2 2 2
2 2 0
0 2 1

Minute 4

2 2 2
2 2 0
0 2 2

Answer = 4

*/


class Solution {

    func orangesRotting(_ grid: [[Int]]) -> Int {

        //------------------------------------------------------
        // STEP 1
        // Make Grid Mutable
        //------------------------------------------------------

        var grid = grid

        //------------------------------------------------------
        // STEP 2
        // Find Rows & Columns
        //------------------------------------------------------

        let rows = grid.count
        let cols = grid[0].count

        //------------------------------------------------------
        // STEP 3
        // Queue
        //------------------------------------------------------

        var queue = [(Int, Int)]()

        // Queue Head
        var head = 0

        //------------------------------------------------------
        // STEP 4
        // Count Fresh Orange
        //------------------------------------------------------

        var freshOrange = 0

        //------------------------------------------------------
        // STEP 5
        // Total Minutes
        //------------------------------------------------------

        var minutes = 0

        print("====================================")
        print("Initial Grid")
        print("====================================")

        for row in grid {
            print(row)
        }

        print()

        //------------------------------------------------------
        // STEP 6
        // Find Rotten & Fresh Orange
        //------------------------------------------------------

        for row in 0..<rows {

            for col in 0..<cols {

                //--------------------------------------------------
                // Rotten Orange
                //--------------------------------------------------

                if grid[row][col] == 2 {

                    queue.append((row,col))

                    print("Found Rotten Orange -> (\(row),\(col))")
                }

                //--------------------------------------------------
                // Fresh Orange
                //--------------------------------------------------

                if grid[row][col] == 1 {

                    freshOrange += 1
                }
            }
        }

        print()

        print("Fresh Orange Count = \(freshOrange)")
        print("Queue = \(queue)")
        print()

        //------------------------------------------------------
        // STEP 7
        // No Fresh Orange
        //------------------------------------------------------

        if freshOrange == 0 {

            return 0
        }

        //------------------------------------------------------
        // STEP 8
        // Four Directions
        //------------------------------------------------------

        let directions = [

            (-1,0),   // UP

            (1,0),    // DOWN

            (0,-1),   // LEFT

            (0,1)     // RIGHT
        ]

        //------------------------------------------------------
        // STEP 9
        // Multi Source BFS
        //------------------------------------------------------

        while head < queue.count && freshOrange > 0 {

            //--------------------------------------------------
            // Current Level Size
            //--------------------------------------------------

            let levelSize = queue.count - head

            print("====================================")
            print("Minute = \(minutes)")
            print("====================================")

            //--------------------------------------------------
            // Process Current Minute
            //--------------------------------------------------

            for _ in 0..<levelSize {

                let (row,col) = queue[head]

                head += 1

                print("Processing (\(row),\(col))")

                //--------------------------------------------------
                // Visit 4 Directions
                //--------------------------------------------------

                for direction in directions {

                    let newRow = row + direction.0

                    let newCol = col + direction.1

                    //--------------------------------------------------
                    // Boundary Check
                    //--------------------------------------------------

                    if newRow < 0 ||
                        newRow >= rows ||
                        newCol < 0 ||
                        newCol >= cols {

                        continue
                    }

                    //--------------------------------------------------
                    // Empty Cell
                    //--------------------------------------------------

                    if grid[newRow][newCol] == 0 {

                        continue
                    }

                    //--------------------------------------------------
                    // Already Rotten
                    //--------------------------------------------------

                    if grid[newRow][newCol] == 2 {

                        continue
                    }

                    //--------------------------------------------------
                    // Fresh -> Rotten
                    //--------------------------------------------------

                    print("Fresh Orange Found at (\(newRow),\(newCol))")

                    grid[newRow][newCol] = 2

                    freshOrange -= 1

                    queue.append((newRow,newCol))

                    print("Orange became Rotten")
                    print("Fresh Remaining = \(freshOrange)")
                }
            }

            //--------------------------------------------------
            // One Minute Completed
            //--------------------------------------------------

            minutes += 1

            print()

            print("Grid After Minute \(minutes)")

            for row in grid {

                print(row)
            }

            print()

            print("Queue = \(queue)")
            print()
        }

        //------------------------------------------------------
        // STEP 10
        // Answer
        //------------------------------------------------------

        if freshOrange == 0 {

            return minutes
        }

        return -1
    }
}

//==============================================================
// MARK: Test
//==============================================================

let solution = Solution()

let answer = solution.orangesRotting(grid)

print("====================================")
print("Final Answer")
print("====================================")

print(answer)
