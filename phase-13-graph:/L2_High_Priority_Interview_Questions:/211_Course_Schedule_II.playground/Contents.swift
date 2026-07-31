import Foundation

//============================================================
// 210. Course Schedule II
// Pattern : Topological Sort (Kahn's Algorithm)
// Time    : O(V + E)
// Space   : O(V + E)
//============================================================

class Solution {

    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {

        //----------------------------------------------------
        // STEP 1: Create Graph
        //----------------------------------------------------

        var graph = Array(repeating: [Int](), count: numCourses)

        //----------------------------------------------------
        // STEP 2: Create In-Degree Array
        //----------------------------------------------------

        var inDegree = Array(repeating: 0, count: numCourses)

        print("===================================")
        print("Building Graph")
        print("===================================")

        //----------------------------------------------------
        // STEP 3: Build Graph & Calculate In-Degree
        //----------------------------------------------------

        for prerequisite in prerequisites {

            let course = prerequisite[0]
            let dependsOn = prerequisite[1]

            print("Course \(course) depends on Course \(dependsOn)")

            // Create Edge: dependsOn -> course
            graph[dependsOn].append(course)

            // Increase In-Degree for course
            inDegree[course] += 1
        }

        print()
        print("Graph:")
        print(graph)

        print()
        print("InDegree:")
        print(inDegree)

        //----------------------------------------------------
        // STEP 4: Initialize Queue
        //----------------------------------------------------

        var queue = [Int]()
        var head = 0

        //----------------------------------------------------
        // STEP 5: Add All Courses with In-Degree = 0
        //----------------------------------------------------

        print()
        print("Adding Courses with No Prerequisites:")

        for course in 0..<numCourses {

            if inDegree[course] == 0 {

                queue.append(course)

                print("  Added Course \(course)")
            }
        }

        print()
        print("Initial Queue: \(queue)")

        //----------------------------------------------------
        // STEP 6: Initialize Result Array
        //----------------------------------------------------

        var order = [Int]()

        //----------------------------------------------------
        // STEP 7: BFS - Topological Sort
        //----------------------------------------------------

        print()
        print("===================================")
        print("Start Topological Sort (BFS)")
        print("===================================")

        while head < queue.count {

            //------------------------------------------------
            // Remove Current Course from Queue
            //------------------------------------------------

            let currentCourse = queue[head]
            head += 1

            print()
            print("Processing Course \(currentCourse)")

            //------------------------------------------------
            // Add to Result
            //------------------------------------------------

            order.append(currentCourse)

            print("  Order: \(order)")

            //------------------------------------------------
            // Visit All Dependent Courses
            //------------------------------------------------

            for nextCourse in graph[currentCourse] {

                print("  Course \(nextCourse) loses one prerequisite")

                inDegree[nextCourse] -= 1

                print("    New InDegree[\(nextCourse)] = \(inDegree[nextCourse])")

                //------------------------------------------------
                // If All Prerequisites Met, Add to Queue
                //------------------------------------------------

                if inDegree[nextCourse] == 0 {

                    queue.append(nextCourse)

                    print("    Added Course \(nextCourse) to Queue")
                }
            }

            print("  Queue: \(queue)")
        }

        //----------------------------------------------------
        // STEP 8: Return Result or Empty (Cycle Detection)
        //----------------------------------------------------

        print()
        print("===================================")
        print("Final Result")
        print("===================================")

        print("Order: \(order)")
        print("Courses Processed: \(order.count)")
        print("Total Courses: \(numCourses)")

        if order.count == numCourses {

            print("✓ Valid Order Found - No Cycles")

            return order

        } else {

            print("✗ Cycle Detected - Impossible to Complete All Courses")

            return []
        }
    }
}

//============================================================
// MARK: Test Cases
//============================================================

print("TEST CASE 1: Valid Order Exists")
print("=========================================")

let solution1 = Solution()
let numCourses1 = 4
let prerequisites1 = [
    [1, 0],
    [2, 0],
    [3, 1],
    [3, 2]
]

let answer1 = solution1.findOrder(numCourses1, prerequisites1)

print()
print("ANSWER: \(answer1)")
print()

//=========================================

print("\n\nTEST CASE 2: Cycle Detected")
print("=========================================")

let solution2 = Solution()
let numCourses2 = 2
let prerequisites2 = [
    [1, 0],
    [0, 1]  // Cycle: 0 -> 1 -> 0
]

let answer2 = solution2.findOrder(numCourses2, prerequisites2)

print()
print("ANSWER: \(answer2)")
print()

//=========================================

print("\n\nTEST CASE 3: No Prerequisites")
print("=========================================")

let solution3 = Solution()
let numCourses3 = 3
let prerequisites3: [[Int]] = []

let answer3 = solution3.findOrder(numCourses3, prerequisites3)

print()
print("ANSWER: \(answer3)")
