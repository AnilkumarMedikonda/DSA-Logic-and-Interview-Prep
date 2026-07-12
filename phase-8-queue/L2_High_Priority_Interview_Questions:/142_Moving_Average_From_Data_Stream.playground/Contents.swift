import Foundation

// MARK: - 1. Problem
/*
 142. Moving Average from Data Stream (LC 346, Easy)

 Design a class that computes the moving average of the last `size`
 values in a stream.

 MovingAverage(3)
 next(1)  → 1.0        [1]
 next(10) → 5.5        [1, 10]
 next(3)  → 4.666…     [1, 10, 3]
 next(5)  → 6.0        [10, 3, 5]   ← 1 evicted from FRONT

 Pattern: fixed-size sliding window backed by a queue (FIFO).
 Newest enters at back, oldest leaves from front once window > size.
*/

// MARK: - 2. Brute Force — store entire stream, re-sum window every call
/*
 Idea: append every value forever. On each next(), find where the
 window starts and sum from there to the end.

 start = max(0, count - size)   // max(0,…) handles warm-up
 Elements before `start` are excluded; `start` itself is INCLUDED.

 Cost: next() is O(size) sum every call, and the stream array
 grows forever → O(n) space for n calls. Wasteful: only the last
 `size` values ever matter.
*/
struct MovingAverageBrute {

    private let size: Int
    private var stream: [Int] = []

    init(_ size: Int) {
        self.size = size
    }

    mutating func next(_ val: Int) -> Double {
        stream.append(val)

        let start = max(0, stream.count - size)
        var sum = 0
        for i in start..<stream.count {
            sum += stream[i]
        }

        return Double(sum) / Double(stream.count - start)
    }
}

// MARK: - 3. Optimised — queue + running sum
/*
 Idea: window changes by exactly one-in / one-out, so the sum
 doesn't need recomputing — adjust it incrementally.

 append(val), sum += val
 if count > size → sum -= removeFirst()   (evict oldest)
 return sum / count                        (count ≤ size always)

 Space drops to O(size): we store the window, not the stream.
 Note: Array.removeFirst() is O(size) — see Interview Q&A for
 the true O(1) circular-buffer follow-up.
*/
struct MovingAverage {

    private let size: Int
    private var queue: [Int] = []
    private var sum: Int = 0

    init(_ size: Int) {
        self.size = size
    }

    mutating func next(_ val: Int) -> Double {
        queue.append(val)
        sum += val

        if queue.count > size {
            sum -= queue.removeFirst()
        }

        return Double(sum) / Double(queue.count)
    }
}

// MARK: - 4. Dry Run (optimised, size = 3)
/*
 next(10): queue [10]          sum 10    count 1 → 10/1  = 10.0
 next(30): queue [10,30]       sum 40    count 2 → 40/2  = 20.0
 next(60): queue [10,30,60]    sum 100   count 3 → 100/3 = 33.33…
 next(50): append → [10,30,60,50], sum 150, count 4 > 3
           evict 10 → queue [30,60,50], sum 140 → 140/3 = 46.66…

 Warm-up divides by 1, then 2; once full, always by size.
*/

// MARK: - 5. Complexity
/*
 Brute Force:  next() O(size) time, O(n) space (n = total calls)
 Optimised:    next() O(1) amortised sum work, but removeFirst()
               is O(size) on Array → O(size) time, O(size) space
 Circular buf: O(1) time, O(size) space (see Q&A)
*/

// MARK: - 6. Traps
/*
 1. Evict from FRONT (removeFirst), not back — removing the newest
    keeps stale data: that's LIFO/stack behaviour, wrong for a stream.
 2. Divisor is queue.count, NOT size — warm-up phase divides by
    1, 2, … until the window fills.
 3. Convert to Double BEFORE dividing — Int / Int truncates.
 4. Brute force: clamp start with max(0, count - size) or you
    index negatively during warm-up.
*/

// MARK: - 7. Tests
func run(_ label: String, _ results: [Double], _ expected: [Double]) {
    let pass = zip(results, expected).allSatisfy { abs($0 - $1) < 1e-5 }
    print(pass ? "✅" : "❌", label, results)
}

// Standard: warm-up + eviction
var b1 = MovingAverageBrute(3)
var o1 = MovingAverage(3)
let vals1 = [10, 30, 60, 50]
let exp1  = [10.0, 20.0, 100.0/3, 140.0/3]
run("brute standard", vals1.map { b1.next($0) }, exp1)
run("opt   standard", vals1.map { o1.next($0) }, exp1)

// Window of 1: eviction on every call after the first
var o2 = MovingAverage(1)
run("opt   size=1", [5, 8, 2].map { o2.next($0) }, [5.0, 8.0, 2.0])

// Negatives in the window
var o3 = MovingAverage(3)
run("opt   negatives", [-1, -10, 3, 5].map { o3.next($0) },
    [-1.0, -5.5, -8.0/3, -2.0/3])

// Fewer values than size: never evicts
var o4 = MovingAverage(5)
run("opt   underfill", [4, 6].map { o4.next($0) }, [4.0, 5.0])

// MARK: - 8. Interview Q&A
/*
 Q: Array.removeFirst() is O(n). How do you make next() true O(1)?
 A: Circular buffer — fixed array of `size`, write at index % size,
    overwrite instead of remove. Nothing shifts. [→ rewrite debt]

 Q: Why not recompute the sum each call?
 A: The window changes by exactly one element in, one out — the sum
    delta is known, so recomputing is redundant O(size) work.

 Q: What if size = 0?
 A: Undefined per problem (size ≥ 1 guaranteed); defensively,
    precondition(size > 0) in init.

 Q: iOS bridge?
 A: Rolling averages for smoothing noisy streams — FPS counters,
    download-speed indicators, CoreMotion sensor readings. Same
    one-in/one-out window over live data.
*/
