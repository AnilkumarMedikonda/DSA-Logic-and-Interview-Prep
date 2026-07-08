import UIKit

// MARK: - Problem
// 126. Asteroid Collision (LC 735) — Medium
// Array of asteroids: |value| = size, sign = direction (+right, -left), same speed.
// Smaller explodes on collision; equal → both explode; same direction never collide.
// Return final state.
// [5,10,-5] → [5,10]   [8,-8] → []   [10,2,-5] → [10]

// MARK: - Brute Force
// Repeated passes: collapse adjacent (+,-) pairs until no change.
// T: O(n²)  S: O(n)
func asteroidCollisionBrute(_ asteroids: [Int]) -> [Int] {
    var result = asteroids
    var changed = true

    while changed {
        changed = false
        var newResult = [Int]()
        var i = 0

        while i < result.count {
            if i < result.count - 1, result[i] > 0 && result[i + 1] < 0 {
                let a = abs(result[i])
                let b = abs(result[i + 1])

                if a > b {
                    newResult.append(result[i])
                } else if b > a {
                    newResult.append(result[i + 1])
                }
                // equal → both explode, append neither
                changed = true
                i += 2
            } else {
                newResult.append(result[i])
                i += 1
            }
        }
        result = newResult
    }

    return result
}

// MARK: - Optimised (Stack)
// Stack = survivors. Incoming left-mover fights right-moving tops until it
// dies or clears them. Each asteroid pushed/popped ≤ once.
// T: O(n)  S: O(n)
func asteroidCollisionOptimised(_ asteroids: [Int]) -> [Int] {
    var stack = [Int]()

    for asteroid in asteroids {
        let current = asteroid
        var destroyed = false

        while current < 0, let top = stack.last, top > 0 {
            if top < -current {
                stack.removeLast()          // top dies, keep fighting
            } else if top == -current {
                stack.removeLast()          // both die
                destroyed = true
                break
            } else {
                destroyed = true            // incoming dies
                break
            }
        }

        if !destroyed {
            stack.append(current)
        }
    }

    return stack
}

// MARK: - Dry Run
// [10, 2, -5]
// 10 → stack [10]
// 2  → stack [10, 2]
// -5 → fight top 2: 2 < 5 → pop → [10]
//      fight top 10: 10 > 5 → -5 destroyed
// Result: [10]

// MARK: - Complexity
// Brute: O(n²) time (each pass O(n), up to n passes), O(n) space.
// Stack: O(n) time (each asteroid pushed/popped at most once), O(n) space.

// MARK: - Traps
// 1. Equal size → BOTH explode. A plain if/else keeps one — [8,-8] must be [].
// 2. One incoming asteroid can destroy MULTIPLE survivors — needs while, not if.
//    [10,2,-5]: -5 fights twice.
// 3. Collision only when top > 0 AND current < 0. (-,+), (+,+), (-,-) → just push.
// 4. No force unwraps: `while let top = stack.last` replaces isEmpty + last!.

// MARK: - Tests
let tests: [[Int]] = [
    [5, 10, -5],       // [5, 10]
    [8, -8],           // []
    [10, 2, -5],       // [10]
    [-2, -1, 1, 2],    // [-2, -1, 1, 2]
    [1, -2, -2, -2]    // [-2, -2, -2]
]

for test in tests {
    print("input:", test)
    print("brute:    ", asteroidCollisionBrute(test))
    print("optimised:", asteroidCollisionOptimised(test))
    print("---")
}

// MARK: - Interview Q&A
// Q: Why a stack?
// A: Collisions only happen between the newest left-mover and the most recent
//    surviving right-movers — LIFO order, exactly what a stack models.
//
// Q: Why is the stack version O(n) despite the nested while?
// A: Amortised — every pop removes an asteroid permanently; total pops ≤ n.
//
// Q: What are the three fight outcomes?
// A: top smaller → pop, keep fighting; equal → pop, incoming dies too;
//    top bigger → incoming dies. The break + destroyed flag ends the fight.
