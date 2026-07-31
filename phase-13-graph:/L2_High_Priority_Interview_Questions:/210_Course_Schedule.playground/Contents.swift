import Foundation

// 210. Course Schedule  (LC 207) ⭐Blind75
// Phase 13 · L2_High_Priority_Interview_Questions

// MARK: - Problem
// numCourses courses labelled 0..<numCourses. prerequisites[i] = [a, b] means
// "to take course a, you must first take course b". Return true if you can finish
// ALL courses — i.e. the dependency graph has NO cycle.
//
// A cycle (a needs b, b needs a) makes it impossible → return false.
// This is CYCLE DETECTION in a DIRECTED graph, solved here via Kahn's algorithm
// (BFS topological sort). The trick: you don't detect the cycle directly — you
// detect that some courses could NEVER be completed, which a cycle causes.

final class Solution {

    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {

        // STEP 1: adjacency list — edge points prereq → course it unlocks.
        // graph[b] = [a] means "finishing b unlocks a".
        var graph = Array(repeating: [Int](), count: numCourses)

        // STEP 2: in-degree = how many prerequisites each course still needs.
        var inDegree = Array(repeating: 0, count: numCourses)

        // STEP 3: build both from the prerequisite pairs.
        for prerequisite in prerequisites {
            let course    = prerequisite[0]   // a — the course
            let dependsOn = prerequisite[1]   // b — its prerequisite

            graph[dependsOn].append(course)   // b → a
            inDegree[course] += 1             // a needs one more prereq
        }

        print("Graph:     \(graph)")
        print("In-degree: \(inDegree)\n")

        // STEP 4: queue with head-index for O(1) dequeue (no removeFirst O(n)).
        var queue = [Int]()
        var head = 0

        // STEP 5: seed with every course that has NO prerequisites — the ones
        // you can take immediately (in-degree 0).
        for course in 0..<numCourses {
            if inDegree[course] == 0 {
                queue.append(course)
                print("start course \(course) (no prereqs)")
            }
        }

        // STEP 6: count how many courses we manage to complete.
        var completedCourses = 0

        // STEP 7: BFS — Kahn's algorithm.
        //   take a course → it's completed → for each course it unlocks,
        //   drop that course's in-degree by 1; if it hits 0, all ITS prereqs
        //   are now done → enqueue it.
        print("\n---- processing ----")
        while head < queue.count {
            let currentCourse = queue[head]   // dequeue (O(1) via head)
            head += 1
            completedCourses += 1
            print("complete \(currentCourse)  (total \(completedCourses))")

            for nextCourse in graph[currentCourse] {
                inDegree[nextCourse] -= 1
                print("   \(currentCourse) unlocks \(nextCourse) → in-degree now \(inDegree[nextCourse])")

                if inDegree[nextCourse] == 0 {
                    queue.append(nextCourse)
                    print("   → \(nextCourse) ready, enqueue")
                }
            }
        }

        // STEP 8: if every course got completed, no cycle. If a cycle exists,
        // its courses never reached in-degree 0, never enqueued, never counted.
        print("\ncompleted \(completedCourses) of \(numCourses)")
        return completedCourses == numCourses
    }
}

// MARK: - Test

let solution = Solution()

let numCourses = 4
let prerequisites = [
    [1, 0],   // 1 needs 0
    [2, 0],   // 2 needs 0
    [3, 1],   // 3 needs 1
    [3, 2]    // 3 needs 2
]

print("========== COURSE SCHEDULE ==========\n")
print(solution.canFinish(numCourses, prerequisites))   // true

// MARK: - Dry Run (why it's true)
// graph:     [[1,2], [3], [3], []]   in-degree: [0,1,1,2]
// seed: course 0 (in-degree 0) → queue [0]
// complete 0 → unlocks 1 (→0, enqueue), 2 (→0, enqueue)   queue [0,1,2]
// complete 1 → unlocks 3 (→1)
// complete 2 → unlocks 3 (→0, enqueue)                    queue [0,1,2,3]
// complete 3 → unlocks nothing
// completed 4 of 4 → true
//
// Cycle example: prerequisites = [[1,0],[0,1]]  in-degree [1,1]
// nothing has in-degree 0 → queue empty → completed 0 of 2 → false ✅

// MARK: - Complexity
// Time:  O(V + E) — build O(E); each course dequeued once (V), each edge relaxed once (E).
// Space: O(V + E) — adjacency list O(V+E), in-degree + queue O(V).

// MARK: - Traps
// 1. Edge direction: prereq → course-it-unlocks. Reversing it inverts the whole graph
//    and gives wrong in-degrees. Pin it down: [a,b] = "a needs b" = edge b→a.
// 2. in-degree counts INCOMING edges (prereqs a course needs), not outgoing.
// 3. Enqueue a course ONLY when its in-degree hits exactly 0 — not on every decrement.
// 4. Use head-index, not removeFirst(): removeFirst() is O(n), making the whole thing
//    O(V·E) worst case. head += 1 keeps each dequeue O(1).

// MARK: - Interview Q&A
// Q: How does this detect a cycle without explicitly looking for one?
// A: Courses in a cycle can never reach in-degree 0 (each depends on another in the
//    cycle), so they're never enqueued. completedCourses < numCourses ⇒ cycle exists.
// Q: DFS alternative?
// A: 3-state DFS — 0=unvisited, 1=visiting (on the current recursion stack),
//    2=done. Re-encountering a state-1 node = back edge = cycle. Mark 1 before
//    recursing, 2 after (same before/after discipline as 204).
// Q: What if they want the actual ORDER (course order II)?
// A: This IS that — collect currentCourse into a result array as you complete it.
//    That array is a valid topological order. If it ends shorter than numCourses,
//    there's a cycle →
