/*
===========================================================
             140. Dota2 Senate (LC 649)
===========================================================

 Greedy + two queues.

 Greedy: always ban the NEXT opposing senator — the one who
 acts soonest is the biggest threat.

 Two queues hold INDICES (not 'R'/'D') — the index decides
 who acts first in each face-off. Characters alone can't.

 Winner re-enqueues as index + n → acts in the "next round"
 behind everyone still waiting, so ordering stays fair
 without simulating rounds.

 Complexity: O(n) time — each senator loses at most one
 face-off. Space O(n).
===========================================================
*/

struct Queue {
    private var items: [Int] = []
    private var head: Int = 0

    mutating func enqueue(_ item: Int) {
        items.append(item)
    }

    mutating func dequeue() -> Int? {
        guard !isEmpty() else { return nil }
        defer { head += 1 }
        return items[head]
    }

    func front() -> Int? {
        guard !isEmpty() else { return nil }
        return items[head]          // head-aware — items.first is a dead slot
    }

    func isEmpty() -> Bool {
        head >= items.count
    }
}

struct Solution {
    func predictPartyVictory(_ senate: String) -> String {

        var radiantQueue = Queue()
        var direQueue = Queue()

        let senators = Array(senate)
        let n = senators.count

        for i in 0..<n {
            if senators[i] == "R" {
                radiantQueue.enqueue(i)
            } else {
                direQueue.enqueue(i)
            }
        }

        while !radiantQueue.isEmpty() && !direQueue.isEmpty() {
            let rIndex = radiantQueue.dequeue()!
            let dIndex = direQueue.dequeue()!

            if rIndex < dIndex {
                radiantQueue.enqueue(rIndex + n)   // survives into next round
            } else {
                direQueue.enqueue(dIndex + n)
            }
        }

        return radiantQueue.isEmpty() ? "Dire" : "Radiant"
    }
}

// MARK: - Tests

print(Solution().predictPartyVictory("RD"))      // Radiant
print(Solution().predictPartyVictory("RDD"))     // Dire
print(Solution().predictPartyVictory("DDRRR"))   // Radiant
print(Solution().predictPartyVictory("R"))       // Radiant
print(Solution().predictPartyVictory("DRRDRDRD")) // Radiant
