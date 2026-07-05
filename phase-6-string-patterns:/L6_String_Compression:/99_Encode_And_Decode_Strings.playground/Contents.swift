import Foundation

// MARK: - Problem
/*
 #99 — LC 271 Encode and Decode Strings (Medium; Meta, Google — Very High)

 Design two functions:
   encode: converts a LIST of strings into ONE single string
   decode: reconstructs the exact original list from that string

 Requirement: decode(encode(strs)) == strs for EVERY possible input.

   ["hello", "world"]  → encode → decode → ["hello", "world"]
   ["a,b", "c"]        → must come back as ["a,b", "c"], NOT ["a","b","c"]
   ["", "abc", ""]     → empty strings must survive
   []                  → empty list must survive
   ["12#ab"]           → digits and # inside content must survive

 Constraints:
   0 <= strs.count <= 200, 0 <= strs[i].count <= 200
   Strings may contain ANY character — no character is free to use
   as a separator. No shared state between encode and decode.

 The core insight the interviewer waits for: there is NO safe
 delimiter character. Joining with "," breaks on ["a,b"]; joining
 with any "rare" character breaks the moment input contains it.
 The fix is LENGTH-PREFIXING: <length>#<content> per string. The
 decoder never SEARCHES for a delimiter — it reads the length, then
 jumps exactly that many characters. Positions matter, not characters.
 (HTTP chunked transfer encoding works exactly like this.)
*/

// MARK: - Brute Force (delimiter join — shown to explain WHY it fails)
/*
 The naive idea: join with a separator, split on it to decode.
 Broken by design — kept here only to articulate the failure in
 an interview. Do NOT use.

   encodeNaive(["a,b", "c"]) → "a,b,c"
   decoding "a,b,c" → ["a", "b", "c"] ❌ — original list is lost.

 Escaping the delimiter (e.g. doubling it) can be made to work but
 turns into fiddly state-machine parsing. Length-prefixing is
 simpler AND O(N).
*/
func encodeNaive(_ strs: [String]) -> String {
    var result = ""
    var first = true

    for str in strs {
        if first {
            result += str
            first = false
        } else {
            result += "," + str
        }
    }

    return result
}

// MARK: - Optimised (length-prefixing: <length>#<content>)
/*
 encode: for each string append its count, "#", then the content.
   ["hello", "world"] → "5#hello5#world"
   [""]               → "0#"
   ["12#ab"]          → "5#12#ab"

 The "#" is NOT a separator between strings — it terminates the
 LENGTH DIGITS only. Without it, ["12abc"] → "512abc" and the
 decoder would read length 512.
*/
func encode(_ strs: [String]) -> String {
    var result = ""

    for str in strs {
        result += String(str.count) + "#" + str
    }

    return result
}

/*
 decode: repeat until the string is consumed —
   1. read the digit run, building the length manually
      (length = length * 10 + digit — multi-digit lengths like
      "15#" are normal, each digit shifts the total left one place)
   2. skip exactly one "#"
   3. take exactly `length` characters (bounded loop — never search
      for "#"; content may contain any number of them)
   4. append the piece — length 0 still appends ""
*/
func decode(_ s: String) -> [String] {
    let chars = Array(s)
    var result: [String] = []
    var i = 0

    while i < chars.count {
        // 1. Read digits → build the length manually
        var length = 0
        while i < chars.count && chars[i].isNumber {
            if let digit = chars[i].wholeNumberValue {
                length = length * 10 + digit
            }
            i += 1
        }

        // 2. Skip the "#"
        i += 1

        // 3. Take exactly `length` characters — never search for "#"
        var piece = ""
        var k = 0
        while k < length && i < chars.count {
            piece.append(chars[i])
            i += 1
            k += 1
        }

        // 4. Append — length 0 still appends ""
        result.append(piece)
    }

    return result
}

// MARK: - Dry Run (decode "5#12#ab" — the killer case, input ["12#ab"])
/*
 chars = ["5","#","1","2","#","a","b"], i = 0

 GROUP 1:
   Step 1 (digits): chars[0] = "5" isNumber ✅ → length = 0*10+5 = 5, i = 1
                    chars[1] = "#" not a number ❌ → digit loop stops
   Step 2 (skip #): i = 2
   Step 3 (take 5): "1","2","#","a","b" → piece = "12#ab", i = 7
                    ← the inner "#" at index 4 was consumed BLINDLY,
                      never inspected. That's the whole trick.
   Step 4: result = ["12#ab"]

 Outer check: i = 7, 7 < 7 false → return ["12#ab"] ✅

 Multi-digit length, decode "15#xxxxxxxxxxxxxxx":
   digits: "1" → length = 1; "5" → length = 1*10+5 = 15
   skip "#", take 15 chars → ["xxxxxxxxxxxxxxx"] ✅
   (length = digit alone would give 5 — half the payload lost)

 Empty strings, decode "0#0#":
   digits: "0" → length = 0; skip "#"; take-loop runs 0 times →
   piece = "" appended. Twice → ["", ""] ✅
*/

// MARK: - Complexity
/*
 N = total characters across all strings, M = number of strings.
 encode: O(N + M) time — each character written once, plus a length
         prefix per string. Space O(N + M) for the output.
 decode: O(N + M) time — every character of the encoded string is
         visited exactly once (digit loop, skip, or take loop).
         Space O(N + M) for the rebuilt list.
 Length prefixes add only ~O(M · log₁₀ 200) ≈ O(M) overhead.
*/

// MARK: - Traps
/*
 1. Any delimiter-join solution: breaks the moment content contains
    the delimiter (["a,b"] with ","). There is no safe character.
 2. Missing "#" terminator after the length: ["12abc"] → "512abc",
    decoder reads length 512 and swallows the payload. The "#" ends
    the DIGITS, not the string.
 3. Searching for "#" in decode instead of jumping by length:
    "5#12#ab" — searching finds the inner "#" and truncates to "12".
    Read length → jump exactly length characters. Never search.
 4. length = digit instead of length = length * 10 + digit: each
    digit overwrites the last, "15#" parses as 5. Multi-digit
    lengths are the norm for strings of 10+ characters.
 5. Empty strings vanishing: "0#" must append "", not skip. The
    take-loop naturally runs zero times; just make sure the append
    is unconditional.
 6. Empty LIST: encode([]) = "", decode("") — outer loop never runs,
    returns []. No special case needed.
*/

// MARK: - Tests
func runTests() {
    let cases: [[String]] = [
        ["hello", "world"],
        ["a,b", "c"],                            // delimiter inside content
        ["", "abc", ""],                          // empty strings survive
        [],                                       // empty list
        ["12#ab"],                                // digits + # inside content
        ["#", "##", "0#"],                        // pure-# and fake-prefix content
        [String(repeating: "x", count: 15)],      // multi-digit length "15#"
        [String(repeating: "y", count: 200)],     // max length "200#"
        ["hello world", " ", "\n\t"]              // whitespace preserved
    ]

    for input in cases {
        let encoded = encode(input)
        let back = decode(encoded)

        if back == input {
            print("✅ \(input) → \"\(encoded.prefix(30))\(encoded.count > 30 ? "…" : "")\"")
        } else {
            print("❌ \(input) → decoded \(back)")
        }
    }

    // Show the naive failure explicitly
    let tricky = ["a,b", "c"]
    let naive = encodeNaive(tricky)
    print("naive join of \(tricky) → \"\(naive)\" — split on \",\" gives 3 strings, original had 2 ❌")
}

runTests()

// MARK: - Interview Q&A
/*
 Q1. Why can't any delimiter character work?
 A1. Content is unrestricted — whatever character you pick can appear
     inside a string, making the split ambiguous. Escaping can fix it
     but costs a stateful parse; length-prefixing avoids the problem
     entirely because decoding is position-driven, not
     character-driven.

 Q2. Why is "#" safe here when it wasn't safe as a delimiter?
 A2. Different job. As a delimiter it must never occur in content
     (impossible to guarantee). As a length terminator it only needs
     to be a non-digit — the decoder reads it exactly once per group,
     at a position it computed, and never looks for it inside content.

 Q3. What if a string is longer than 9 characters?
 A3. Multi-digit length, handled by building the number digit-by-digit
     (length = length * 10 + digit). The digit loop stops at "#"
     because "#" isn't a digit.

 Q4. Real-world parallels?
 A4. HTTP/1.1 chunked transfer encoding (hex length, CRLF, chunk),
     Pascal strings, protobuf length-delimited fields, Redis protocol
     bulk strings ($<len>\r\n<data>). Length-prefixing is THE standard
     answer to framing untrusted content.

 Q5. Alternative encodings?
 A5. (a) Escape-based: double every delimiter in content, use a single
     one as separator — works, fiddlier to parse. (b) Non-ASCII
     sentinel — WRONG, content is unrestricted. (c) Fixed-width
     length header (e.g. always 3 digits, "005hello") — works within
     constraints, wastes bytes, breaks past 999. Length-prefix +
     terminator is the clean general answer.

 Q6. Follow-up: what about streaming — decoding as bytes arrive?
 A6. Length-prefixing shines: after reading a header you know exactly
     how many bytes to wait for. Delimiter-based framing must scan
     every byte. This is why network protocols prefer it.
*/
