import Foundation

// LC 1397 — Find All Good Strings (Hard) — READ-NOT-DERIVED reference
// Digit DP over [s1, s2] x KMP automaton tracking partial matches of `evil`.

func findGoodStrings(_ n: Int, _ s1: String, _ s2: String, _ evil: String) -> Int {

    let modulus = 1_000_000_007

    // Map everything to 0...25 Int arrays once
    func toValues(_ s: String) -> [Int] {
        var result = [Int]()
        for char in s {
            if let ascii = char.asciiValue {
                result.append(Int(ascii) - 97)
            }
        }
        return result
    }

    let low = toValues(s1)
    let high = toValues(s2)
    let evilValues = toValues(evil)
    let evilLength = evilValues.count

    // Standard LPS build on evil (same as #100 / #102 / #109)
    var lps = [Int](repeating: 0, count: evilLength)
    var length = 0
    var index = 1

    while index < evilLength {
        if evilValues[index] == evilValues[length] {
            length += 1
            lps[index] = length
            index += 1
        } else {
            if length > 0 {
                length = lps[length - 1]
            } else {
                lps[index] = 0
                index += 1
            }
        }
    }

    // KMP automaton: from match-state `state`, reading char value `c`,
    // what's the new state? Full fallback chain — a single lps step
    // is NOT enough (Trap 2 in the concept file).
    func transition(_ state: Int, _ c: Int) -> Int {
        var current = state
        while current > 0 && evilValues[current] != c {
            current = lps[current - 1]
        }
        if evilValues[current] == c {
            return current + 1
        }
        return 0
    }

    // Memo over (position, kmpState, tightLow, tightHigh)
    var memo: [Int: Int] = [:]

    func key(_ pos: Int, _ state: Int, _ tightLow: Bool, _ tightHigh: Bool) -> Int {
        var flags = 0
        if tightLow {
            flags += 1
        }
        if tightHigh {
            flags += 2
        }
        return (pos * (evilLength + 1) + state) * 4 + flags
    }

    func count(_ pos: Int, _ state: Int, _ tightLow: Bool, _ tightHigh: Bool) -> Int {

        if state == evilLength {
            return 0                    // evil fully matched — branch is dead
        }

        if pos == n {
            return 1                    // built a full good string
        }

        let memoKey = key(pos, state, tightLow, tightHigh)
        if let cached = memo[memoKey] {
            return cached
        }

        let lowChar: Int
        if tightLow {
            lowChar = low[pos]
        } else {
            lowChar = 0                 // 'a'
        }

        let highChar: Int
        if tightHigh {
            highChar = high[pos]
        } else {
            highChar = 25               // 'z'
        }

        var total = 0
        var c = lowChar

        while c <= highChar {
            let nextState = transition(state, c)
            let nextTightLow = tightLow && c == low[pos]
            let nextTightHigh = tightHigh && c == high[pos]
            total = (total + count(pos + 1, nextState, nextTightLow, nextTightHigh)) % modulus
            c += 1
        }

        memo[memoKey] = total
        return total
    }

    return count(0, 0, true, true)
}

// Tests (LeetCode's examples)
print(findGoodStrings(2, "aa", "da", "b"))        // 51
print(findGoodStrings(8, "leetcode", "leetgoes", "leet"))   // 0  (every string in range starts with "leet")
print(findGoodStrings(2, "gx", "gz", "x"))        // 2
