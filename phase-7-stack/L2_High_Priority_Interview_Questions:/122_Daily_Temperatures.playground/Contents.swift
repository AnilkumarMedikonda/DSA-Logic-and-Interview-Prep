import Foundation

/*
 =========================================================
   122 - DAILY TEMPERATURES  (LC 739)  🔴 Blind75/NeetCode
 =========================================================

 Problem
 -------
 answer[i] = how many DAYS after day i until a warmer
 temperature. Never warmer → 0.

 temps  = [73, 74, 75, 71, 69, 72, 76, 73]
 answer = [ 1,  1,  4,  2,  1,  1,  0,  0]

 Interview rate: 🔴 High — Amazon/Meta favorite, the
 monotonic stack pattern's flagship question.

 ---------------------------------------------------------

 Pattern: Monotonic Stack — knob 2 turned (see 121's
 pattern block for the full waiting-room model).

 Difference from 121: the answer is a DISTANCE, not a
 value — so the stack holds INDICES. A popped value (75)
 can't remember it lived on day 2; a popped index (2)
 tells you everything: temps[2] recovers the value,
 i - 2 IS the answer.

 Knob 3 too: no dictionary — the question is indexed by
 position, so a 0-filled result array IS the notebook,
 and "never warmer" days need no writes at all.

 =========================================================
 */

//==========================================================
// MARK: - Brute Force — scan right per day, O(n²)
//==========================================================

func dailyTemperaturesBrute(_ temperatures: [Int]) -> [Int] {

    var result = [Int]()

    for i in 0..<temperatures.count {

        var value = 0

        for j in (i + 1)..<temperatures.count {
            if temperatures[j] > temperatures[i] {
                value = j - i
                break
            }
        }
        result.append(value)
    }

    return result
}

//==========================================================
// MARK: - Optimised — Monotonic Stack (indices), O(n)
//==========================================================

func dailyTemperatures(_ temperatures: [Int]) -> [Int] {

    let n = temperatures.count

    var result = [Int](repeating: 0, count: n)   // 0s = "never warmer", free
    var stack = [Int]()                          // waiting room of DAY INDICES

    for i in 0..<n {

        // JOB 1: is anyone waiting for a day as warm as me?
        // Peek is an INDEX; the comparison goes THROUGH temps[...].
        // Guard-first && — NO force unwrap (stack.last! regressed
        // into my attempt; the index form is the house version)
        while stack.isEmpty == false && temperatures[stack[stack.count - 1]] < temperatures[i] {
            let waitingDay = stack.removeLast()
            result[waitingDay] = i - waitingDay  // the answer is DISTANCE
        }

        // JOB 2: now I wait
        stack.append(i)
    }

    // Leftovers on the stack: never answered → result already 0

    return result
}

//==========================================================
// MARK: - Dry Run (day 5 is the whole problem)
//==========================================================
/*
 temps = [73, 74, 75, 71, 69, 72, 76, 73]

 day 0 (73): empty → push 0.                        stack [0]
 day 1 (74): 73<74 → pop 0, result[0]=1. push.      stack [1]
 day 2 (75): 74<75 → pop 1, result[1]=1. push.      stack [2]
 day 3 (71): 75<71? NO → push.                      stack [2,3]
 day 4 (69): 71<69? NO → push.                      stack [2,3,4]

 day 5 (72): 69<72 → pop 4, result[4] = 5-4 = 1
             71<72 → pop 3, result[3] = 5-3 = 2
             75<72? NO → STOP. push 5.              stack [2,5]
             ← multi-pop WITH A SURVIVOR: 72 answered
               days 4 and 3, but day 2's 75 keeps waiting.

 day 6 (76): pop 5 (result[5]=1), pop 2 →
             result[2] = 6-2 = 4  ← waited through
             four arrivals; index arithmetic paid
             instantly when the answer came. push 6.  stack [6]
 day 7 (73): 76<73? NO → push.                      stack [6,7]
 END: days 6,7 never answered → 0s already there. ✅
 */

//==========================================================
// MARK: - Complexity
//==========================================================
/*
 Brute    : T O(n²) — scan right per day (NOT O(n³) — two
            loops, not three; my comment drift, twice now)
 Optimised: T O(n) amortized — each index pushed once,
            popped at most once
            S O(n) — stack worst case: strictly falling
            temps [60,50,40,30] park everyone forever
 */

//==========================================================
// MARK: - Traps
//==========================================================
/*
 1. stack.last! — force unwrap in the hot line. Safe only
    because the guard precedes it; one refactor = crash.
    House form: stack[stack.count - 1]. (My attempt —
    regression from 121, the read-not-derived signature.)
 2. Pushing VALUES — a popped 75 can't say it was day 2.
    Distance answers need indices.
 3. Comparing indices instead of temperatures — the stack
    holds days, but days aren't compared; temps[day] is.
 4. `if` instead of `while` — day 5 answers 4 AND 3.
 5. Writing -1 or n for never-answered days — the problem
    wants 0, and the pre-filled array gives it for free.
 6. Complexity comment drift: n² labeled n³ (121 and here).
 */

//==========================================================
// MARK: - Tests
//==========================================================

let testCases: [(input: [Int], expected: [Int])] = [
    ([73, 74, 75, 71, 69, 72, 76, 73], [1, 1, 4, 2, 1, 1, 0, 0]),
    ([30, 40, 50, 60], [1, 1, 1, 0]),          // everyone answered next day
    ([60, 50, 40, 30], [0, 0, 0, 0]),          // nobody ever answered — max stack
    ([50, 50, 50], [0, 0, 0]),                 // equal is NOT warmer (strict <)
    ([50], [0]),
    ([], [])
]

var testIndex = 1
for testCase in testCases {
    let bruteResult = dailyTemperaturesBrute(testCase.input)
    let stackResult = dailyTemperatures(testCase.input)

    let ok = bruteResult == testCase.expected && stackResult == testCase.expected
    print("Test \(testIndex): expected \(testCase.expected) | brute \(bruteResult) | stack \(stackResult) \(ok ? "✅" : "❌")")
    testIndex += 1
}

//==========================================================
// MARK: - Interview Q&A
//==========================================================
/*
 Q1: Why indices on the stack instead of temperatures?
 A : The answer is a distance — i minus the waiting day's
     index. A value can't remember its position; an index
     recovers both (temps[index] and the distance).

 Q2: Isn't the nested while O(n²)?
 A : Amortized O(n) — each index is pushed exactly once and
     popped at most once, so total pops ≤ n across the walk.

 Q3: Worst case for space?
 A : Strictly decreasing temperatures — nobody is ever
     answered, all n indices sit on the stack.

 Q4: What about equal temperatures?
 A : Strict < means equal is NOT warmer — [50,50,50] → all
     0s. Confirm the strictness with the interviewer; ties
     are the classic hidden requirement.

 Q5: Related problems?
 A : LC 496/503 Next Greater (values / circular), LC 901
     Stock Span (previous-greater with counts), LC 84
     Histogram (next SMALLER, area on pop). Same skeleton,
     different knobs.

 =========================================================
 */
