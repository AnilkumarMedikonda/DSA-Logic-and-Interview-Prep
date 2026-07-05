import Foundation

// MARK: - Problem
/*
 #96 — LC 443: String Compression (Medium)

 Compress a char array IN PLACE: each run of a repeating char becomes
 the char + run length — count written ONLY if run >= 2, multi-digit
 counts as SEPARATE characters. Return the new logical length; the
 result must occupy the first k slots of the input.

   ["a","a","b","b","c","c","c"]      -> 6, ["a","2","b","2","c","3"]
   ["a"]                              -> 1, ["a"]         (no count)
   ["a","b"x12]                       -> 4, ["a","b","1","2"]

 Constraints: 1 <= chars.count <= 2000. MUST be O(1) extra space.
 Signature: func compress(_ chars: inout [Character]) -> Int

 Pattern: read/write pointers on one array — #93's compress pass
 promoted to a full problem.
*/

// MARK: - Brute Force
// New output array; same run-scan, append instead of write-in-place.
// Correct baseline, but violates the O(1)-space contract — and returns
// the array instead of LC's (inout, Int) shape.

func compressBruteForce(_ chars: [Character]) -> [Character] {
    var result: [Character] = []
    var i = 0

    while i < chars.count {
        let currentChar = chars[i]
        var count = 0

        while i < chars.count && chars[i] == currentChar {
            count += 1
            i += 1
        }

        result.append(currentChar)
        if count > 1 {
            for digit in String(count) {
                result.append(digit)
            }
        }
    }

    return result
}

// MARK: - Optimised
/*
 Identical run-scan; result.append becomes chars[write] = ...; write += 1.

 Why write never tramples read (the invariant an interviewer probes):
 when a run of length L is emitted, read has already advanced PAST all
 L chars, and the emission is 1 + digits(L) chars — which is <= L for
 every L >= 1 (L=1: 1 char; L=2..9: 2; L=10..99: 3 <= 10...). So
 write <= read at every step; reads always see original data.

 String(count) iteration is an initializer (house-legal). Manual
 alternative: extract digits with % 10 / 10 into a temp, emit reversed.
*/

func compress(_ chars: inout [Character]) -> Int {
    var read = 0
    var write = 0

    while read < chars.count {
        let currentChar = chars[read]
        var count = 0

        while read < chars.count && chars[read] == currentChar {
            count += 1
            read += 1
        }

        chars[write] = currentChar
        write += 1

        if count > 1 {
            for digit in String(count) {
                chars[write] = digit
                write += 1
            }
        }
    }

    return write
}

// MARK: - Dry Run
/*
 compress(["a","a","b","b","c","c","c"])

   read scans run "aa"  (count 2, read->2): write 'a','2'  -> write=2
   read scans run "bb"  (count 2, read->4): write 'b','2'  -> write=4
   read scans run "ccc" (count 3, read->7): write 'c','3'  -> write=6
   return 6; chars prefix = a,2,b,2,c,3 ✓

 Edge checks:
   ["a"]        -> run count 1, no count written -> return 1, ["a"] ✓
   12-run of b  -> String(12) emits '1','2' separately -> "b","1","2" ✓
   ["a","a"]    -> 'a','2' -> write=2 == read=2 (tightest case, no clash)
*/

// MARK: - Complexity
/*
 Brute:     O(n) time, O(n) space (result array)
 Optimised: O(n) time — each index read once, written at most once.
            O(1) AUXILIARY — pointers + count; mutates the one buffer.
            (String(count) allocates O(digits) = O(log n) transiently;
             say "O(1) aux, modulo digit conversion" if pressed.)
*/

// MARK: - Traps
/*
 1. Writing a count for single chars — "a" must stay "a", not "a1".
    The count > 1 guard is the spec, not an optimization.
 2. Multi-digit counts as ONE character ("12") — digits are separate
    slots; the for-digit loop handles any magnitude.
 3. Returning chars.count instead of write — the array still holds
    stale garbage past write; the return value IS the answer.
 4. The invariant write <= read is what makes in-place safe; if asked
    "why doesn't writing corrupt unread data", the L >= 1 + digits(L)
    argument is the expected proof.
 5. Same-shape reminder from #93: everything after the loop respects
    the logical length; chars[write...] is meaningless.
*/

// MARK: - Tests
var t1: [Character] = ["a","a","b","b","c","c","c"]
print(compress(&t1), t1[0..<6])   // 6 ["a","2","b","2","c","3"]

var t2: [Character] = ["a"]
print(compress(&t2), t2[0..<1])   // 1 ["a"]

var t3: [Character] = ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
print(compress(&t3), t3[0..<4])   // 4 ["a","b","1","2"]

var t4: [Character] = ["a","a"]
print(compress(&t4), t4[0..<2])   // 2 ["a","2"]

print(compressBruteForce(["a","a","b","b","c","c","c"]))  // baseline check

// MARK: - Interview Q&A
/*
 Q1. Why is in-place safe — won't writes corrupt unread input?
 A1. write <= read always: a length-L run is consumed (read moves L)
     before emitting 1 + digits(L) <= L chars. Reads see originals.

 Q2. Why return an Int instead of truncating the array?
 A2. The classic C-style contract: caller reads chars[0..<k]. Truncating
     (removeSubrange) would be O(n) extra work and is a predefined
     method anyway; logical length is the idiom.

 Q3. Where does the digit order come from in the manual (% / 10) route?
 A3. Extraction yields digits least-significant first — collect then
     emit reversed. String(count) sidesteps this; know both.

 Q4. Follow-up: decompress?
 A4. Reverse pass — parse char + optional digit-run into (char, count),
     expand. Can't be done in place (output grows); that asymmetry
     (compress shrinks => in-place OK; decompress grows => can't) is
     a good thing to volunteer.

 Q5. Kin problems?
 A5. #93 LC 151 (same read/write compress pass), LC 38 Count and Say
     (run-length encoding as generation), LC 604 Design Compressed
     String Iterator (decompression as an iterator).
*/
