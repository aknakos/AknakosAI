# Requirements Review Report: {Epic Name}

**Overall**: {PASS / CONCERNS / FAIL}
**Date**: {YYYY-MM-DD}

---

## Alignment Status

### Epic Alignment

**Epic**: `{epic-name}.md`
**Acceptance Criteria**: {X}/{Y} met

**Status**: ✅ Aligned / ⚠️ Partial / ❌ Misaligned

### PRD Alignment

**PRD Requirements Traced**: {REQ-IDs covered by this Epic}

**Status**: ✅ All requirements met / ⚠️ Some missing / ❌ Requirements violated

### Mission Alignment

**Product Goals Supported**:
- Goal 1: {How implementation supports this goal}
- Goal 2: {How implementation supports this goal}

**Status**: ✅ Supports mission / ⚠️ Neutral / ❌ Conflicts with mission

### UX Alignment (if ux-flow.md exists)

**UX Flow**: `{YYYY-MM-DD-ux-flow.md or "Not created"}`

**User Flows Supported**:
- Flow 1 ({name}): {How implementation supports this flow} (✅/⚠️/❌)
- Flow 2 ({name}): {How implementation supports this flow} (✅/⚠️/❌)

**Interface Structure Compliance**:
- Navigation pattern: {Matches ux-flow.md spec} (✅/⚠️/❌)
- Component usage: {Uses specified components} (✅/⚠️/❌)
- Interaction patterns: {Follows UX specifications} (✅/⚠️/❌)

**Status**: ✅ Aligned with UX flow / ⚠️ Minor deviations / ❌ Contradicts UX / N/A (no UX flow)

**Violations** (if any):
- {Violation}: {What ux-flow.md specified vs what was implemented}

---

## Acceptance Criteria Check

| Criterion | Status | Evidence | Tests |
|-----------|--------|----------|-------|
| {Criterion 1} | ✅/⚠️/❌ | {How it's met} | {Test file covering it} |
| {Criterion 2} | ✅/⚠️/❌ | {How it's met} | {Test file covering it} |

**Summary**: {X}/{Y} criteria met ({percentage}%)

**Critical Failures** (if any):
- {Acceptance criterion}: {Why failed, impact}

---

## PRD Requirements Traceability

| PRD Requirement | Epic | Implementation | Tests | Status |
|-----------------|------|----------------|-------|--------|
| {REQ-ID} | {epic} | {code location} | {test file} | ✅/⚠️/❌ |

**Traceability Chain**:
```
PRD {REQ-ID} → Epic {acceptance criterion} → Implementation {file:line} → Test {test name}
```

**Broken Chains** (if any):
- {REQ-ID}: No implementation found
- {REQ-ID}: Implementation exists but no tests

---

## Alignment Violations

**Deviations from PRD**:
- **{Deviation}**: {What was in PRD vs what was implemented}
  - **Severity**: Critical / High / Medium / Low
  - **Justification**: {If documented, why deviation occurred}
  - **Action Required**: {Fix implementation / Update PRD / Acceptable deviation}

**Conflicts with Mission**:
- **{Conflict}**: {How implementation violates mission principle}
  - **Mission Principle**: "{Quote from mission.md}"
  - **Implementation**: {What was done}
  - **Recommendation**: {How to fix}

**UX Flow Violations** (if ux-flow.md exists):
- **{Violation}**: {What ux-flow.md specified vs what was implemented}
  - **User Flow Affected**: {Which flow}
  - **Impact**: {Effect on user experience}
  - **Action Required**: {Fix implementation / Update UX flow / Acceptable}

**None found**: ✅ No alignment violations detected

---

## Completeness

**Epic Scope Delivered**: {What was implemented}
**Epic Scope Missing**: {What's missing from Epic if any}

**Out of Scope** (properly excluded):
- {Feature}: Not in Epic, correctly excluded

**In Scope but Missing**:
- {Feature}: In Epic acceptance criteria but not implemented

---

## Edge Cases

**Handled**:
- {Edge case 1}: {How handled, where tested}
- {Edge case 2}: {How handled, where tested}

**Not Handled**:
- {Edge case}: {Why missing, should it be handled?}

---

## User Experience

**User Needs from PRD**: {What users need according to PRD}

**Implementation Assessment**:
- ✅ Meets user needs as specified
- ⚠️ Partially meets needs (gaps: {list})
- ❌ Doesn't meet needs ({critical gaps})

{Detailed assessment of whether implementation meets user needs from PRD}

---

## Recommendations

### Must Fix (Blockers)
1. {Critical requirement violation}: {How to fix}
2. {Critical acceptance criterion not met}: {How to fix}

### Should Fix (Concerns)
1. {Important gap}: {How to address}
2. {Alignment concern}: {How to improve}

### Nice to Have
1. {Enhancement suggestion}

---

## Decision

**Overall Status**: {PASS / CONCERNS / FAIL}

**Rationale**: {Brief explanation of decision}

**Approval**: {Approved / Requires Fixes / Blocked}

---

## References

**Documents Reviewed**:
- mission.md (mission alignment)
- prd.md: {Sections reviewed}
- epic: {epic-name}.md
- ux-flow.md: {Sections reviewed} (if exists)
- project-brief.md (user context) (if exists)

**Implementation Files**:
- {List of files reviewed}

**Test Files**:
- {List of test files reviewed}
