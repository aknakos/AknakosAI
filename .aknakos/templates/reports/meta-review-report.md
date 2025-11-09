# Meta-Review Report: {Epic Name}

**Final Decision**: {PASS / CONCERNS / FAIL}
**Date**: {YYYY-MM-DD}
**Reviewers Synthesized**: 5/5

---

## Executive Summary

{2-3 paragraph summary of overall Epic review status, key findings, and recommendation}

---

## Individual Reviewer Results

| Reviewer | Status | Critical Issues | Concerns | Strengths |
|----------|--------|----------------|----------|-----------|
| Test | ✅ PASS | 0 | 0 | {Brief strength} |
| Security | ⚠️ CONCERNS | 0 | 2 | {Brief strength} |
| Architecture | ✅ PASS | 0 | 1 | {Brief strength} |
| Quality | ✅ PASS | 0 | 0 | {Brief strength} |
| Requirements | ❌ FAIL | 1 | 3 | {Brief strength} |

**Overall**: 3 PASS, 1 CONCERNS, 1 FAIL

---

## Critical Issues (Must Fix)

Issues that block Epic completion:

### 1. {Critical Issue Title}

**Source**: {Reviewer that found it}
**Severity**: Critical
**Category**: {Security / Requirements / Architecture / Quality / Tests}

**Issue**:
{Detailed description of the problem}

**Impact**:
{Why this is critical, what could go wrong}

**Fix**:
{Specific steps to resolve}

**Priority**: P0 (block Epic completion)

---

## High-Priority Concerns

Issues that should be fixed before Epic completion:

### 1. {Concern Title}

**Source**: {Reviewer(s) that found it}
**Severity**: High
**Category**: {Category}

**Issue**:
{Description}

**Impact**:
{Why this matters}

**Fix**:
{How to address}

**Priority**: P1 (fix before completion)

---

## Medium-Priority Concerns

Issues to address but don't block Epic:

### 1. {Medium Concern}

**Source**: {Reviewer}
**Severity**: Medium
**Priority**: P2 (fix in follow-up Epic or document as tech debt)

{Brief description and recommended fix}

---

## Low-Priority Improvements

Nice-to-have improvements:

1. {Improvement 1} (Source: {Reviewer})
2. {Improvement 2} (Source: {Reviewer})

**Priority**: P3 (optional enhancements)

---

## Reviewer Conflicts

Contradictory recommendations between reviewers:

### Conflict 1: {Conflict Title}

**Reviewers**: {Reviewer A} vs {Reviewer B}

**Reviewer A Position**:
{What Reviewer A recommended}

**Reviewer B Position**:
{What Reviewer B recommended (contradicts A)}

**Analysis**:
{Why this conflict exists, which perspective is more relevant}

**Resolution**:
{Which recommendation to follow and why}

**Action**: {Specific decision}

---

### None Found

✅ All reviewer recommendations are consistent

---

## Synthesis Analysis

### Common Themes

**Strengths** (mentioned by multiple reviewers):
1. {Strength 1}: Noted by {Reviewer A, Reviewer B}
2. {Strength 2}: Noted by {Reviewer C, Reviewer D}

**Weaknesses** (mentioned by multiple reviewers):
1. {Weakness 1}: Noted by {Reviewer X, Reviewer Y}
2. {Weakness 2}: Noted by {Reviewer Z}

### Coverage Gaps

**Areas not thoroughly reviewed by any reviewer**:
- {Gap 1}: {Why this might be a blind spot}
- {Gap 2}: {Recommendation for manual review}

**None found**: ✅ All critical areas covered

### Reviewer Agreement

**Unanimous PASS**: {List aspects all reviewers approved}
**Unanimous CONCERNS**: {List aspects all reviewers flagged}
**Split Decision**: {Areas where reviewers disagreed}

---

## Prioritized Action Plan

### Phase 1: Critical Fixes (Required for Epic Completion)

**Est. Time**: {hours/days}
**Blockers**: {Number} critical issues

1. **{Critical Issue 1}** (P0)
   - Fix: {Specific action}
   - Verify: {How to verify fix}
   - Re-review: {Which reviewer(s) should re-review}

2. **{Critical Issue 2}** (P0)
   - Fix: {Specific action}
   - Verify: {How to verify fix}
   - Re-review: {Which reviewer(s) should re-review}

**Completion Criteria**: All P0 issues resolved

---

### Phase 2: High-Priority Fixes (Before Epic Completion)

**Est. Time**: {hours/days}
**Concerns**: {Number} high-priority issues

1. **{High Issue 1}** (P1)
   - Fix: {Action}
   - Verify: {Verification}

2. **{High Issue 2}** (P1)
   - Fix: {Action}
   - Verify: {Verification}

**Completion Criteria**: All P1 issues resolved or documented

---

### Phase 3: Medium-Priority Improvements (Optional/Follow-up)

**Est. Time**: {hours/days}
**Tech Debt**: {Number} medium issues

1. **{Medium Issue 1}** (P2)
   - Option A: Fix now
   - Option B: Create follow-up Epic
   - Option C: Document as tech debt

2. **{Medium Issue 2}** (P2)
   - Same options

**Decision**: {Fix now / Create follow-up Epic / Accept as tech debt}

---

### Phase 4: Low-Priority Enhancements (Nice-to-Have)

**Est. Time**: {hours/days}
**Enhancements**: {Number} suggestions

- {Enhancement 1}
- {Enhancement 2}

**Decision**: {Implement / Defer to future roadmap / Discard}

---

## Re-Review Requirements

**After fixes, re-review required for**:

- [ ] Test Reviewer: {If test changes or new tests added}
- [ ] Security Reviewer: {If security-related fixes made}
- [ ] Architecture Reviewer: {If architectural changes made}
- [ ] Quality Reviewer: {If code quality concerns addressed}
- [ ] Requirements Reviewer: {If requirements alignment fixed}

**Re-review Type**:
- **Full**: {Reviewers needing full re-review}
- **Targeted**: {Reviewers needing to check specific fixes only}

**Re-review Threshold**:
- If P0 fixes made → Full re-review required
- If only P1-P3 fixes → Targeted re-review sufficient

---

## Quality Metrics

### Review Coverage

- **Test Coverage**: {percentage}% (from test reviewer)
- **Security Checklist**: {X}/{Y} items checked
- **Architecture Compliance**: {status}
- **Code Quality Score**: {score if available}
- **Requirements Traceability**: {percentage}% (Mission → PRD → Epic → Code)

### Issue Distribution

| Severity | Count | Percentage |
|----------|-------|------------|
| Critical | {N} | {%} |
| High | {N} | {%} |
| Medium | {N} | {%} |
| Low | {N} | {%} |
| **Total** | **{N}** | **100%** |

### Review Confidence

**High Confidence Areas** (all reviewers passed):
- {Area 1}
- {Area 2}

**Low Confidence Areas** (multiple reviewers flagged):
- {Area 1}: {Why confidence is low}
- {Area 2}: {Why confidence is low}

---

## Decision Matrix

### PASS Criteria (All Must Be True)

- [ ] No critical issues (P0 = 0)
- [ ] No high-priority concerns OR all concerns documented and accepted
- [ ] All reviewers returned PASS or CONCERNS (no FAIL)
- [ ] Test coverage meets standards (≥ 80%)
- [ ] All PRD SHALL requirements implemented
- [ ] No reviewer conflicts unresolved

### CONCERNS Criteria (Any True)

- [ ] Some high-priority concerns (P1 > 0 but < 5)
- [ ] One reviewer returned FAIL but issue not critical
- [ ] Test coverage 70-80%
- [ ] Minor PRD deviations (documented)
- [ ] Reviewer conflicts exist but resolved

### FAIL Criteria (Any True)

- [ ] Critical issues exist (P0 > 0)
- [ ] Multiple reviewers returned FAIL (≥ 2)
- [ ] Test coverage < 70%
- [ ] PRD SHALL requirements violated
- [ ] Unresolved reviewer conflicts with high severity

---

## Final Decision

**Status**: {PASS / CONCERNS / FAIL}

### Rationale

{1-2 paragraphs explaining the decision based on:
- Number and severity of issues
- Reviewer consensus
- Critical blockers or lack thereof
- Overall Epic quality
- Risk assessment}

### Next Steps

**If PASS**:
1. ✅ Epic approved for completion
2. Update workflow.yaml: Epic status = "complete"
3. Run `epic-review` skill for retrospective
4. Proceed to next Epic or product milestone

**If CONCERNS**:
1. ⚠️ Address all P1 concerns (required)
2. Document any accepted P2 concerns as tech debt
3. Run targeted re-review for affected areas
4. Once concerns addressed → Update to PASS
5. Then mark Epic complete

**If FAIL**:
1. ❌ Block Epic completion
2. Fix all P0 critical issues (required)
3. Fix all P1 high-priority issues (required)
4. Run full re-review (all 5 reviewers)
5. Meta-reviewer synthesizes again
6. Only mark complete once PASS achieved

---

## Time & Effort Estimates

**Total Fix Effort**:
- P0 (critical): {hours/days}
- P1 (high): {hours/days}
- P2 (medium): {hours/days}
- P3 (low): {hours/days}

**Estimated Time to PASS**:
- If CONCERNS: {hours/days} (fix P1 issues)
- If FAIL: {hours/days} (fix P0 + P1 issues)

**Re-review Time**: {hours} (after fixes)

---

## References

**Review Reports Synthesized**:
- Test Review: `reviews/{epic}/YYYY-MM-DD-test-review.md`
- Security Review: `reviews/{epic}/YYYY-MM-DD-security-review.md`
- Architecture Review: `reviews/{epic}/YYYY-MM-DD-architecture-review.md`
- Quality Review: `reviews/{epic}/YYYY-MM-DD-quality-review.md`
- Requirements Review: `reviews/{epic}/YYYY-MM-DD-requirements-review.md`

**Epic**: `epics/{epic-name}.md`
**PRD**: `YYYY-MM-DD-prd.md`
