# Workflow Metrics Analysis

**Analysis Date**: {YYYY-MM-DD}
**Epics Analyzed**: {count} completed Epics
**Date Range**: {first Epic} to {last Epic}
**Framework Version**: 1.0

---

## Executive Summary

{2-3 paragraph summary of key findings:
- Overall estimation accuracy
- Main bottlenecks
- Recommendations for improvement}

---

## Time Estimation Accuracy

### Overall Performance

**Mean Accuracy**: {percentage}% (target: 90-110%)
**Epics Within ±10%**: {count}/{total} ({percentage}%)
**Epics Within ±20%**: {count}/{total} ({percentage}%)

**Status**: ✅ Good (>80% within ±20%) / ⚠️ Fair (60-80%) / ❌ Poor (<60%)

### Accuracy Distribution

| Epic | Estimated | Actual | Accuracy | Status |
|------|-----------|--------|----------|--------|
| user-authentication | 14h | 18h | 78% | ⚠️ Under-estimated |
| dashboard | 10h | 9h | 111% | ✅ Accurate |
| payment-processing | 30h | 45h | 67% | ❌ Severely under-estimated |

### Trends

**Improving**: ✅ Recent Epics (last 5) have {percentage}% accuracy vs {percentage}% in first 5
**Stable**: ➡️ Accuracy consistent across time
**Declining**: ⚠️ Accuracy worsening over time (investigate why)

---

## Complexity Estimation Accuracy

### Calibration Table

| Complexity | Count | Avg Estimated Time | Avg Actual Time | Accuracy | Variance |
|------------|-------|-------------------|----------------|----------|----------|
| 1-3 (Trivial) | 4 | 6h | 6.5h | 92% | ±2h |
| 4-6 (Moderate) | 8 | 16h | 19h | 84% | ±6h |
| 7-9 (Complex) | 3 | 32h | 38h | 84% | ±12h |

**Findings**:
- Trivial Epics: Well-calibrated ✅
- Moderate Epics: Slightly under-estimated ⚠️
- Complex Epics: Under-estimated, high variance ❌

### Complexity Reassessment

**Epics with Complexity Mismatch**:

| Epic | Estimated Complexity | Actual Complexity | Delta | Reason |
|------|---------------------|-------------------|-------|--------|
| user-authentication | 6 | 7 | +1 | OAuth integration harder than expected |
| payment-processing | 7 | 9 | +2 | Third-party API poorly documented |

**Recommendation**: Update complexity estimation guidelines based on patterns

---

## Phase-Level Analysis

### Time by Phase (Averages)

| Phase | Avg Estimated | Avg Actual | Accuracy | % of Total Time |
|-------|--------------|------------|----------|----------------|
| Planning | 2h | 2.5h | 80% | 12% |
| TDD Tests | 3.5h | 5h | 70% | 25% |
| TDD Implementation | 8h | 10h | 80% | 50% |
| TDD Refactor | 2h | 1.5h | 133% | 8% |
| Review | 1.5h | 2h | 75% | 10% |

**Bottleneck**: TDD Implementation (50% of total time)
**Most Underestimated**: TDD Tests (70% accuracy)
**Most Overestimated**: TDD Refactor (133% accuracy - we're estimating too high)

### Phase Variance

| Phase | Variance | Status |
|-------|----------|--------|
| Planning | ±30 min | ✅ Low (predictable) |
| TDD Tests | ±2h | ⚠️ Medium (somewhat unpredictable) |
| TDD Implementation | ±4h | ❌ High (very unpredictable) |
| TDD Refactor | ±45 min | ✅ Low (predictable) |
| Review | ±1h | ⚠️ Medium |

**Finding**: TDD Implementation has highest variance (±4h). Investigate why.

---

## Review Metrics

### Review Pass Rates

| Reviewer | PASS | CONCERNS | FAIL | Pass Rate |
|----------|------|----------|------|-----------|
| Test | 12 | 2 | 1 | 80% |
| Security | 10 | 4 | 1 | 67% |
| Architecture | 13 | 2 | 0 | 87% |
| Quality | 14 | 1 | 0 | 93% |
| Requirements | 11 | 3 | 1 | 73% |

**Findings**:
- Quality reviewer has highest pass rate (93%)
- Security reviewer has lowest pass rate (67%)
- Requirements reviewer flags concerns frequently

### Common Review Failures

**Test Reviewer**:
1. Tests changed during implementation (3 cases)
2. Missing edge case tests (2 cases)

**Security Reviewer**:
1. Hardcoded secrets (2 cases)
2. Missing input validation (3 cases)

**Requirements Reviewer**:
1. Acceptance criteria not fully met (4 cases)
2. PRD alignment issues (2 cases)

**Recommendation**: Add pre-review checklist for common failures

---

## TDD Adherence

### Tests Changed During Implementation

**Total Epics**: 15
**Tests Changed**: 2 (13%)
**Tests NOT Changed**: 13 (87%)

**Status**: ✅ Good (target: <20% test changes)

**Cases Where Tests Changed**:
1. **dashboard Epic**: Tests needed update due to API contract change
   - **Reason**: External API changed during implementation
   - **Justified**: Yes (documented in plan)

2. **payment-processing Epic**: Tests needed update due to edge case discovered
   - **Reason**: Stripe webhook had undocumented behavior
   - **Justified**: Yes (updated plan, then updated tests)

**Correlation with Reviews**:
- Epics with test changes: 50% had CONCERNS/FAIL in review (1/2)
- Epics without test changes: 23% had CONCERNS/FAIL in review (3/13)
- **Weak correlation** (small sample size)

---

## Bottleneck Analysis

### Top 3 Bottlenecks

#### 1. TDD Implementation Phase

**Time**: 50% of total Epic time
**Variance**: ±4 hours (high)
**Accuracy**: 80% (under-estimated)

**Contributing Factors**:
- Complexity of business logic
- Third-party API integration challenges
- Unexpected edge cases

**Recommendations**:
- Increase TDD implementation estimates by 25%
- Add buffer time for API integration Epics (+2-4h)
- Improve planning phase to identify edge cases earlier

#### 2. TDD Tests Phase

**Time**: 25% of total Epic time
**Accuracy**: 70% (most under-estimated phase)

**Contributing Factors**:
- Tests more complex than expected
- Writing comprehensive tests takes longer

**Recommendations**:
- Increase test writing estimates by 40%
- Use test-reviewer agent proactively (before implementation)
- Create reusable test utilities to speed up test writing

#### 3. Review Phase

**Time**: 10% of total Epic time
**Variance**: ±1 hour (medium)

**Contributing Factors**:
- Reviews finding issues requiring fixes
- Re-review cycles

**Recommendations**:
- Run quick validation before triggering full review
- Use pre-review checklist (security, requirements)
- Front-load quality (catch issues in planning/TDD phases)

---

## Recommendations

### Improve Time Estimates

**Immediate Actions**:
1. **Planning**: Keep current estimates (accurate)
2. **TDD Tests**: Increase estimates by +40% (currently 70% accurate)
3. **TDD Implementation**: Increase estimates by +25% (currently 80% accurate)
4. **TDD Refactor**: Decrease estimates by -25% (currently over-estimated at 133%)
5. **Review**: Increase estimates by +30% (accounting for re-review)

**Updated Complexity Time Estimates**:
```yaml
# Old estimates
complexity_1-3: 4-8 hours
complexity_4-6: 10-20 hours
complexity_7-9: 24-40 hours

# New estimates (based on actual data)
complexity_1-3: 6-10 hours
complexity_4-6: 14-26 hours
complexity_7-9: 32-50 hours
```

### Improve Complexity Estimates

**Complexity Scoring Adjustments**:

**Increase complexity if**:
- Third-party API integration (+1)
- Novel architecture pattern (+1)
- Multiple external dependencies (+1)
- Security-critical feature (+1)

**Decrease complexity if**:
- Similar to previous Epic (-1)
- Well-defined requirements (-1)
- Reusing existing patterns (-1)

### Reduce Bottlenecks

**TDD Implementation**:
- Better planning to surface edge cases early
- Allocate buffer time for complex Epics (+20%)
- Use pair programming for complex sections

**TDD Tests**:
- Create test utility library
- Reuse test patterns across Epics
- Consider test template generators

**Review Phase**:
- Pre-review validation checklist
- Catch common issues before formal review
- Use meta-reviewer to prioritize fixes efficiently

### Improve Review Pass Rates

**Security Reviewer** (67% pass rate):
- Add security checklist to planning phase
- Run security-reviewer proactively (before final implementation)
- Create security code snippets library (validated patterns)

**Requirements Reviewer** (73% pass rate):
- Improve Epic acceptance criteria clarity
- Use validate-alignment skill before planning mode
- Check PRD alignment during TDD implementation (not just at review)

---

## Trend Analysis

### Over Time (Last 15 Epics)

**Time Estimation Accuracy**:
- First 5 Epics: 72% average accuracy
- Middle 5 Epics: 81% average accuracy
- Last 5 Epics: 88% average accuracy

**Status**: ✅ Improving (learning curve visible)

**Complexity Estimation Accuracy**:
- Complexity delta reducing over time
- Better at estimating moderate Epics (4-6) now
- Still struggle with complex Epics (7-9)

**Review Pass Rate**:
- Stable across time (~75% pass rate)
- Security pass rate improving (50% → 75% in recent Epics)

---

## Next Steps

### Calibrate Workflow

1. **Update workflow.yaml** with new time estimates
2. **Update complexity guidelines** in Epic breakdown process
3. **Add buffer percentages** for specific Epic types

### Improve Process

1. **Create pre-review checklist** (security, requirements)
2. **Build test utility library** to speed up test writing
3. **Add planning validation** to catch issues early

### Track Going Forward

**For each Epic**, track:
- Estimated time per phase
- Actual time per phase
- Complexity estimated vs actual
- Review outcomes
- TDD adherence

**After every 10 Epics**:
- Run analyze-metrics skill
- Calibrate estimates
- Update complexity guidelines

---

## Metrics Dashboard (Summary)

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Time Estimation Accuracy | 84% | 90-110% | ⚠️ Improving |
| Complexity Estimation Delta | ±1.2 | ±1 | ⚠️ Good |
| Review Pass Rate | 75% | 80% | ⚠️ Fair |
| TDD Adherence (Tests Unchanged) | 87% | >80% | ✅ Good |
| Epic Completion Rate | 100% | 100% | ✅ Excellent |
| Bottleneck Phase | Implementation (50%) | <40% | ⚠️ Needs work |

**Overall Health**: ⚠️ Good with room for improvement

---

## References

**Data Source**: `.aknakos/state/workflow.yaml`
**Epics Analyzed**: {List of Epic names}
**Date Range**: {start} to {end}
