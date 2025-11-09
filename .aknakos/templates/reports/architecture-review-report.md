# Architecture Review Report: {Epic Name}

**Overall**: {PASS / CONCERNS / FAIL}
**Date**: {YYYY-MM-DD}

---

## Alignment Status

### Architecture Document Compliance

**Architecture Doc**: `YYYY-MM-DD-architecture.md`

**Status**: ✅ Compliant / ⚠️ Minor Deviations / ❌ Major Violations

**Decisions Followed**:
- {Decision 1 from architecture.md}: ✅ Followed
- {Decision 2 from architecture.md}: ✅ Followed

**Deviations** (if any):
- **{Decision violated}**: {What architecture.md specified vs what was implemented}
  - **Severity**: Critical / High / Medium / Low
  - **Justification**: {If documented}
  - **Action**: {Fix implementation / Update architecture.md / Escalate}

### Tech Stack Compliance

**Tech Stack Doc**: `tech-stack.md`

**Status**: ✅ Compliant / ⚠️ Minor Deviations / ❌ Violations

**Tech Choices Verified**:
- **Frontend**: {Expected from tech-stack.md} → {Actually used} (✅/❌)
- **Backend**: {Expected from tech-stack.md} → {Actually used} (✅/❌)
- **Database**: {Expected from tech-stack.md} → {Actually used} (✅/❌)
- **Libraries**: {Key libraries from tech-stack.md} → {Actually used} (✅/❌)

**Violations** (if any):
- **{Tech choice violation}**: Used {X} instead of {Y from tech-stack.md}
  - **Rationale**: {Why different choice made}
  - **Impact**: {Lock-in risk, migration cost, team expertise}
  - **Action**: {Revert to tech-stack choice / Update tech-stack.md / Escalate conflict}

---

## Pattern Compliance

**Patterns from architecture.md**:

| Pattern | Expected | Actual | Status | Notes |
|---------|----------|--------|--------|-------|
| {Pattern 1} | {What architecture.md specifies} | {What was implemented} | ✅/⚠️/❌ | {Compliance notes} |
| {Pattern 2} | {What architecture.md specifies} | {What was implemented} | ✅/⚠️/❌ | {Compliance notes} |

**Standards Compliance** (from .aknakos/standards/):

| Standard | Status | Notes |
|----------|--------|-------|
| architecture-patterns.yaml | ✅/⚠️/❌ | {Compliance with org standards} |
| coding-conventions.yaml | ✅/⚠️/❌ | {Compliance with code style} |

---

## Design Quality

**Strengths**:
- {Good design decision 1}
- {Good design decision 2}

**Concerns**:
- **Issue**: {Description}
  - **Location**: {File:line}
  - **Impact**: {Why this matters}
  - **Severity**: Critical / High / Medium / Low
  - **Recommendation**: {How to improve}

**SOLID Principles**:
- Single Responsibility: ✅/⚠️/❌ {Assessment}
- Open/Closed: ✅/⚠️/❌ {Assessment}
- Liskov Substitution: ✅/⚠️/❌ {Assessment}
- Interface Segregation: ✅/⚠️/❌ {Assessment}
- Dependency Inversion: ✅/⚠️/❌ {Assessment}

---

## Tech Debt Created

**New Tech Debt**:
- **{Debt item}**: {Description}
  - **Why Created**: {Rationale}
  - **When to Address**: {Timeline}
  - **Effort Estimate**: {Hours/days}
  - **Impact if Not Addressed**: {Risk}

**Debt Score**: {0-10, where 10 is high debt}

---

## Integration Assessment

**Integration Points**:
- {Component A} ↔ {Component B}: ✅ Clean / ⚠️ Coupling concerns / ❌ Tight coupling

**How Implementation Integrates**:
{Assessment of how code integrates with existing codebase}

**Dependencies Introduced**:
- {Dependency 1}: {Why needed, version, risk}
- {Dependency 2}: {Why needed, version, risk}

---

## Scalability Assessment

**Performance Considerations**:
- {Consideration 1}: ✅ Scalable / ⚠️ May have issues at scale / ❌ Not scalable

**Future Maintainability**:
- Modularity: ✅/⚠️/❌
- Testability: ✅/⚠️/❌
- Documentation: ✅/⚠️/❌

---

## Recommendations

### Must Fix (Blockers)
1. {Critical architecture violation}: {How to fix}
2. {Critical tech stack deviation}: {How to fix}

### Should Fix (Concerns)
1. {Design quality issue}: {How to improve}
2. {Pattern inconsistency}: {How to align}

### Nice to Have
1. {Enhancement suggestion}
2. {Refactoring opportunity}

---

## Decision

**Overall Status**: {PASS / CONCERNS / FAIL}

**Rationale**: {Brief explanation}

**Approval**: {Approved / Requires Fixes / Blocked}

---

## References

**Documents Reviewed**:
- tech-stack.md
- architecture.md: {Sections reviewed}
- .aknakos/standards/architecture-patterns.yaml
- .aknakos/standards/coding-conventions.yaml

**Implementation Files**:
- {List of files reviewed}
