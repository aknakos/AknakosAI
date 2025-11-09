# Epic Validation Report

**Product**: {name}
**Date**: {YYYY-MM-DD}
**Validator**: {Who ran validation}
**Status**: PASS / CONCERNS / FAIL

---

## Summary

{1-2 paragraph summary of validation results}

---

## Requirements Coverage

**Status**: PASS / FAIL

- Total SHALL requirements: {count}
- Covered by Epics: {count} ({percentage}%)
- Missing coverage: {list}

**Findings**:
- {Finding 1}
- {Finding 2}

---

## Epic-to-PRD Traceability

**Status**: PASS / CONCERNS / FAIL

**Epics Reviewed**: {count}

**Issues Found**:
- {Epic name}: {Issue description}
- {Epic name}: {Issue description}

---

## Architecture Compliance

**Status**: PASS / CONCERNS / FAIL

**Issues Found**:
- {Epic name}: {Contradiction with architecture}

---

## Mission Alignment

**Status**: PASS / CONCERNS / FAIL

**Goal Mapping**:
- Goal 1: {Epics supporting this goal}
- Goal 2: {Epics supporting this goal}

**Issues**:
- {Epic name}: {Doesn't support any goal}

---

## Completeness Check

**Status**: PASS / CONCERNS / FAIL

**Issues**:
- {Epic name}: {Vague acceptance criteria}
- {Epic name}: {Missing non-functional requirements}

---

## Consistency Check

**Status**: PASS / CONCERNS / FAIL

**Conflicts**:
- {Epic A} vs {Epic B}: {Contradiction}

**Dependencies**:
- {Epic X} depends on {Epic Y}

---

## UX Alignment (if ux-flow.md exists)

**Status**: PASS / CONCERNS / FAIL / N/A

**UX Flow File**: {YYYY-MM-DD-ux-flow.md or "Not created"}

**Issues**:
- {Epic name}: {Contradiction with UX flow}
- {Epic name}: {Missing user flow support}

**User Flow Coverage**:
- Flow 1 ({name}): {Epics supporting this flow}
- Flow 2 ({name}): {Epics supporting this flow}

---

## Recommendations

### Must Fix (Blockers)
1. {Critical issue requiring Epic changes}
2. {Critical issue requiring Epic changes}

### Should Fix (Concerns)
1. {Important issue to address}
2. {Important issue to address}

### Nice to Have
1. {Minor improvement suggestion}

---

## Decision

**Overall Status**: PASS / CONCERNS / FAIL

**PASS**: Proceed to planning mode
**CONCERNS**: Address recommended fixes, then proceed
**FAIL**: Block progression, fix critical issues before planning mode

**Approval**: {Approved by / Pending fixes}
