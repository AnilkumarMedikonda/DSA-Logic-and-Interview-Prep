import UIKit
// ============================================
// 🔄 ARRAY ROTATION — LEFT & RIGHT BY 1
// ============================================


// ─────────────────────────────────────────
// 1️⃣ ROTATE LEFT BY 1
// Logic : Save first → Shift left → Place at end
// Time  : O(n)
// Space : O(1)
// ─────────────────────────────────────────

var arr1 = [1, 2, 3, 4, 5]

let first = arr1[0]                    // Save first element

for i in 0..<arr1.count - 1 {
    arr1[i] = arr1[i + 1]             // Shift every element left
}
arr1[arr1.count - 1] = first          // Place saved element at end

print("Left  by 1 :", arr1)           // [2, 3, 4, 5, 1] ✅

/*
 Dry Run:
 Input  → [1, 2, 3, 4, 5]
 Save 1 → first = 1
 Shift  → [2, 3, 4, 5, 5]
 Place  → [2, 3, 4, 5, 1] ✅
*/


// ─────────────────────────────────────────
// 2️⃣ ROTATE RIGHT BY 1
// Logic : Save last → Shift right → Place at front
// Time  : O(n)
// Space : O(1)
// ─────────────────────────────────────────

var arr2 = [1, 2, 3, 4, 5]

let last = arr2[arr2.count - 1]       // Save last element
var i = arr2.count - 1

while i > 0 {
    arr2[i] = arr2[i - 1]            // Shift every element right
    i -= 1
}
arr2[0] = last
print("Right by 1 :", arr2)   

/*
 Dry Run:
 Input  → [1, 2, 3, 4, 5]
 Save 5 → last = 5
 Shift  → [1, 1, 2, 3, 4]
 Place  → [5, 1, 2, 3, 4] ✅
*/

// ============================================
// 📊 OUTPUT
// ============================================

/*
 Left  by 1 : [2, 3, 4, 5, 1]
 Right by 1 : [5, 1, 2, 3, 4]
*/

// ============================================
// ⚡ COMPLEXITY
// ============================================

/*
 Operation       Time    Space   Method
 ────────────────────────────────────────
 Rotate Left 1   O(n)    O(1)   Save & Shift
 Rotate Right 1  O(n)    O(1)   Save & Shift
*/
// ===========
