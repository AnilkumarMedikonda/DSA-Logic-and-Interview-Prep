import Foundation

// 03_Directions

// MARK: - Grid (3x4)

let matrix = [
    [1,  2,  3,  4],
    [5,  6,  7,  8],
    [9, 10, 11, 12]
]

let rows = matrix.count

let columns: Int
if rows > 0 {
    columns = matrix[0].count
} else {
    columns = 0
}

// MARK: - 1. Four directions
// Offsets are (rowDelta, colDelta). Order fixed as: up, right, down, left —
// clockwise, which is the same order Spiral Matrix walks a layer.

let directions4: [(Int, Int)] = [
    (-1,  0),   // up    — row decreases
    ( 0,  1),   // right — column increases
    ( 1,  0),   // down  — row increases
    ( 0, -1)    // left  — column decreases
]

// MARK: - 2. Eight directions (four above + diagonals)

let directions8: [(Int, Int)] = [
    (-1,  0),   // up
    (-1,  1),   // up-right
    ( 0,  1),   // right
    ( 1,  1),   // down-right
    ( 1,  0),   // down
    ( 1, -1),   // down-left
    ( 0, -1),   // left
    (-1, -1)    // up-left
]

// MARK: - 3. Bounds check (guard BEFORE subscripting — matrix[-1][0] crashes)

func isValid(_ row: Int, _ col: Int, _ matrix: [[Int]]) -> Bool {
    if matrix.isEmpty {
        return false
    }
    if row < 0 || row >= matrix.count {
        return false
    }
    if col < 0 || col >= matrix[row].count {
        return false
    }
    return true
}

// MARK: - 4. Neighbours (4-directional)

func printNeighbours4(_ row: Int, _ col: Int, _ matrix: [[Int]]) {
    print("4-dir neighbours of (\(row), \(col)):", terminator: " ")
    for direction in directions4 {
        let newRow = row + direction.0
        let newCol = col + direction.1
        if isValid(newRow, newCol, matrix) {
            print(matrix[newRow][newCol], terminator: " ")
        }
    }
    print("")
}

printNeighbours4(0, 0, matrix)   // corner — 2 neighbours: 5, 2
printNeighbours4(1, 1, matrix)   // middle — 4 neighbours: 2, 7, 10, 5

// MARK: - 5. Neighbours (8-directional)

func printNeighbours8(_ row: Int, _ col: Int, _ matrix: [[Int]]) {
    print("8-dir neighbours of (\(row), \(col)):", terminator: " ")
    for direction in directions8 {
        let newRow = row + direction.0
        let newCol = col + direction.1
        if isValid(newRow, newCol, matrix) {
            print(matrix[newRow][newCol], terminator: " ")
        }
    }
    print("")
}

printNeighbours8(0, 0, matrix)   // corner — 3 neighbours
printNeighbours8(1, 1, matrix)   // middle — 8 neighbours

// MARK: - 6. Directional walk — step until you fall off the edge

func walk(from row: Int, _ col: Int, direction: (Int, Int), in matrix: [[Int]]) {
    print("Walk from (\(row), \(col)) by \(direction):", terminator: " ")

    var currentRow = row
    var currentCol = col

    while isValid(currentRow, currentCol, matrix) {
        print(matrix[currentRow][currentCol], terminator: " ")
        currentRow += direction.0
        currentCol += direction.1
    }
    print("")
}

walk(from: 0, 0, direction: (0, 1), in: matrix)   // right along top row: 1 2 3 4
walk(from: 0, 0, direction: (1, 0), in: matrix)   // down left column:    1 5 9
walk(from: 0, 0, direction: (1, 1), in: matrix)   // diagonal:            1 6 11
