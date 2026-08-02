import Foundation

/*
====================================================
            03_Sorting_Greedy.swift
====================================================

Sorting + Greedy = the most common greedy combo.

Step 0: SORT by the right key
Step 1: ONE greedy pass over the sorted order

The sort key IS the strategy:
- Sort by END   → Activity Selection / Non-Overlapping Intervals
- Sort by START → Merge Intervals (Phase 17!)
- Sort by VALUE → assign smallest-that-fits

Demo below: Assign Cookies (LC 455)
Each child has a greed factor, each cookie a size.
A child is content if cookie size >= greed factor.
Maximize content children.

Greedy choice: sort BOTH arrays → give the SMALLEST
cookie that satisfies the LEAST greedy child.
*/

final class SortingGreedy {
    
    func start() {
        
        var children = [3, 1, 2]    // greed factors
        var cookies = [1, 2, 1, 3]  // cookie sizes
        
        print("========== Sorting + Greedy ==========")
        print()
        print("Children (greed) -> \(children)")
        print("Cookies  (size)  -> \(cookies)")
        print()
        
        // Step 0 : SORT — this IS the strategy
        children.sort()
        cookies.sort()
        
        print("Sorted children -> \(children)")
        print("Sorted cookies  -> \(cookies)")
        print()
        
        assignCookies(children, cookies)
    }
    
    func assignCookies(_ children: [Int], _ cookies: [Int]) {
        
        var childIndex = 0
        var cookieIndex = 0
        var content = 0
        
        // Two pointers over two sorted arrays
        while childIndex < children.count && cookieIndex < cookies.count {
            
            let greed = children[childIndex]
            let size = cookies[cookieIndex]
            
            if size >= greed {
                // Greedy Choice: smallest cookie that satisfies
                // the least greedy child — never waste a big cookie
                print("👉 Cookie \(size) → Child(greed \(greed)) ✅")
                content += 1
                childIndex += 1
                cookieIndex += 1
            } else {
                // Cookie too small for even the least greedy child
                // → it's useless for EVERYONE ahead too. Discard.
                print("⊘ Cookie \(size) too small, discard")
                cookieIndex += 1
            }
        }
        
        print()
        print("✅ Content children -> \(content)")
    }
}

// MARK: - Run
let demo = SortingGreedy()
demo.start()

/*
====================================================
Output:
Sorted children -> [1, 2, 3]
Sorted cookies  -> [1, 1, 2, 3]

👉 Cookie 1 → Child(greed 1) ✅
⊘ Cookie 1 too small, discard
👉 Cookie 2 → Child(greed 2) ✅
👉 Cookie 3 → Child(greed 3) ✅

✅ Content children -> 3

====================================================
KEY POINTS
====================================================
1. The sort key IS the greedy strategy — picking the
   wrong key gives a wrong (or unprovable) greedy

2. After sorting, greedy is usually a TWO-POINTER
   pass — Phase 5 two-pointer skills come back here

3. Why safe (exchange argument): giving the least
   greedy child anything BIGGER than the smallest
   fitting cookie wastes size that a greedier child
   might need; swapping never improves the answer

4. Discard logic: if the smallest remaining cookie
   can't satisfy the least greedy remaining child,
   it can't satisfy anyone — safe to throw away

5. Complexity: O(n log n) sort dominates the O(n)
   pass — the standard sorting-greedy signature

6. This exact shape (sort → linear pass) is Phase 17
   Intervals: Merge, Insert, Non-Overlapping
====================================================
*/
