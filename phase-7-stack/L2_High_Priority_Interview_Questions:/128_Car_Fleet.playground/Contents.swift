import UIKit

// MARK: - Problem
// 128. Car Fleet (LC 853) — Medium
// Cars drive toward mile `target` on one lane. position[i] = start mile
// (distinct), speed[i] = mph. A faster car catching a slower one CANNOT pass —
// it slows and forms a fleet. Catching exactly AT target still merges.
// Return number of fleets that arrive.
// Key: solo arrival time = (target - pos) / speed. Sort by position DESC;
// a car behind merges if its time <= time of the fleet ahead.
// t=12, pos=[10,8,0,5,3], spd=[2,4,1,1,3] → 3

// MARK: - Sort Helper
// Insertion sort on (position, speed) pairs, descending by position.
// .sorted() banned — hand-rolled.
func sortedByPositionDesc(_ position: [Int], _ speed: [Int]) -> [(Int, Int)] {
    var cars: [(Int, Int)] = []
    for i in 0..<position.count {
        cars.append((position[i], speed[i]))
    }

    var i = 1
    while i < cars.count {
        let current = cars[i]
        var j = i - 1
        while j >= 0 && cars[j].0 < current.0 {
            cars[j + 1] = cars[j]
            j -= 1
        }
        cars[j + 1] = current
        i += 1
    }

    return cars
}

// MARK: - Counter Version (O(1) extra space after sort)
// Walk front-to-back tracking slowest arrival time seen so far.
// New fleet only when a car's time is STRICTLY greater.
// T: O(n²) here (insertion sort; O(n log n) with merge sort)  S: O(n) for pairs
func carFleet(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
    let cars = sortedByPositionDesc(position, speed)

    var fleets = 0
    var lastTime = 0.0        // safe: LC guarantees position[i] < target → time > 0

    for car in cars {
        let time = Double(target - car.0) / Double(car.1)

        if time > lastTime {
            fleets += 1
            lastTime = time
        }
    }

    return fleets
}

// MARK: - Optimised (Stack Version — the pattern rep)
// Stack holds arrival times of fleet LEADERS, increasing bottom→top.
// Incoming time <= top → car merges into fleet ahead, don't push.
// Answer = stack.count.
func carFleetStack(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
    let cars = sortedByPositionDesc(position, speed)

    var stack = [Double]()

    for car in cars {
        let time = Double(target - car.0) / Double(car.1)

        if let top = stack.last {
            if time > top {
                stack.append(time)
            }
            // time <= top → merges, don't push
        } else {
            stack.append(time)
        }
    }

    return stack.count
}

// MARK: - Dry Run
// t=12, sorted desc: (10,2) (8,4) (5,1) (3,3) (0,1)
// (10,2): time 1.0  → push            [1.0]
// (8,4):  time 1.0  → 1.0 <= 1.0 merge [1.0]        (meets at target — counts)
// (5,1):  time 7.0  → push            [1.0, 7.0]
// (3,3):  time 3.0  → 3.0 <= 7.0 merge [1.0, 7.0]
// (0,1):  time 12.0 → push            [1.0, 7.0, 12.0]
// Fleets: 3 ✓

// MARK: - Complexity
// Sort O(n²) insertion (O(n log n) if swapped for merge sort) — dominates.
// Fleet walk O(n). Space O(n) for pairs + stack.

// MARK: - Traps
// 1. Sort DESCENDING by position — walk from the car nearest the target.
//    Ascending breaks the merge logic entirely (returns 1 on the main test).
// 2. Arrival time MUST be Double. Integer division truncates:
//    t=10, pos=[6,8], spd=[3,2] → 4/3 vs 1 → 2 fleets; int math says 1==1 → wrong.
// 3. Merge on <= (equality = caught exactly at target = same fleet);
//    strict > creates a new fleet.
// 4. INVERTED monotonic stack: unlike 126/127, a "violation" doesn't pop —
//    it skips the push. Stack only grows, increasing bottom→top.
// 5. Pair position+speed BEFORE sorting — sorting position alone desyncs speeds.

// MARK: - Tests
let cases: [(Int, [Int], [Int], Int)] = [
    (12, [10, 8, 0, 5, 3], [2, 4, 1, 1, 3], 3),
    (10, [3], [3], 1),
    (100, [0, 2, 4], [4, 2, 1], 1),        // all merge into one
    (10, [6, 8], [3, 2], 2),               // float trap
    (10, [0, 4, 2], [2, 1, 3], 1)
]

for (target, position, speed, expected) in cases {
    let counter = carFleet(target, position, speed)
    let stacked = carFleetStack(target, position, speed)
    print("target \(target), pos \(position), spd \(speed)")
    print("counter: \(counter)  stack: \(stacked)  expected: \(expected)")
    print("---")
}

// MARK: - Interview Q&A
// Q: Why sort by position descending?
// A: A car can only merge into a fleet AHEAD of it. Processing front-to-back
//    means the stack top is always the nearest fleet the current car could join.
//
// Q: Why can the stack be replaced by one variable?
// A: We only ever compare against the top and never pop — tracking the last
//    pushed time is equivalent. The stack version shows the pattern; the
//    counter is the O(1) simplification.
//
// Q: Why does a merged car's time not matter afterward?
// A: It adopts the leader's speed, so the fleet's arrival time stays the
//    leader's time — the merged car's solo time is irrelevant once absorbed.
