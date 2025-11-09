---
name: analyze-metrics
description: Analyze workflow performance metrics to improve Epic complexity estimation and identify bottlenecks. Use when: - **After Epic completion**: Capture actual metrics for completed Epic
---


Analyze workflow performance metrics to improve Epic complexity estimation and identify bottlenecks.

## Purpose

Track actual vs estimated time per phase, improve Epic complexity scoring from historical data, and optimize workflow efficiency.

## When to Use

- **After Epic completion**: Capture actual metrics for completed Epic
- **Periodic analysis**: Monthly or quarterly workflow review
- **Complexity calibration**: After every 5-10 Epics to improve estimates
- **Bottleneck detection**: When workflow feels slow
- **Time**: 3-5 min for single Epic, 10-15 min for full analysis

---

## What This Skill Does

Analyzes metrics tracked in workflow.yaml to:
- Compare estimated vs actual time per Epic phase
- Identify which complexity estimates were accurate vs off
- Find workflow bottlenecks (which phases take longest)
- Improve future complexity estimates using historical data
- Track review pass rates and common failure patterns
- Measure TDD adherence (tests changed during implementation)

---

## Process

### 1. Load Metrics Data

**Read**: `.aknakos/state/workflow.yaml`

**Extract for each completed Epic**:
```yaml
epics:
  - name: "user-authentication"
    metrics:
      estimated_time:
        planning: "2 hours"
        tdd_tests: "3 hours"
        tdd_implementation: "6 hours"
        tdd_refactor: "2 hours"
        review: "1 hour"
        total: "14 hours"
      actual_time:
        planning: "2.5 hours"
        tdd_tests: "4 hours"
        tdd_implementation: "8 hours"
        tdd_refactor: "1.5 hours"
        review: "2 hours"
        total: "18 hours"
      complexity_estimated: 6
      complexity_actual: 7  # Retroactive assessment
      started: "2025-11-08T09:00:00Z"
      completed: "2025-11-10T18:00:00Z"
```

### 2. Calculate Accuracy Metrics

**For each Epic**:

**Time Estimation Accuracy**:
```
accuracy = (estimated_time / actual_time) * 100
- 90-110%: Accurate
- 80-89% or 111-120%: Somewhat accurate
- <80% or >120%: Inaccurate
```

**Complexity Estimation Accuracy**:
```
complexity_delta = complexity_actual - complexity_estimated
- 0: Perfect
- ±1: Good
- ±2: Fair
- ±3+: Poor
```

**Phase-Level Breakdown**:
- Which phases are consistently over/under-estimated?
- Which phases have highest variance?

### 3. Aggregate Statistics

**Across all Epics**:

**Overall Accuracy**:
- Mean time estimation accuracy: {percentage}%
- Mean complexity estimation delta: {±value}
- Percentage of Epics within 10% of estimate: {percentage}%

**Trends**:
- Are estimates improving over time?
- Which Epic types (auth, UI, API) are harder to estimate?

**Bottlenecks**:
- Which phase takes longest on average?
- Which phase has most variance?
- Which phase most often exceeds estimates?

### 4. Analyze Patterns

**Complexity Calibration**:

**Pattern**: "Complexity 4 Epics consistently take 12-16 hours"
**Pattern**: "Complexity 7 Epics range from 20-40 hours (high variance)"

**Build calibration table**:
```
Complexity 1-3 (Trivial):
  - Estimated: 4-8 hours
  - Actual (avg): 6 hours
  - Variance: ±2 hours

Complexity 4-6 (Moderate):
  - Estimated: 10-20 hours
  - Actual (avg): 18 hours
  - Variance: ±6 hours

Complexity 7-9 (Complex):
  - Estimated: 24-40 hours
  - Actual (avg): 32 hours
  - Variance: ±12 hours
```

**Review Patterns**:
- Pass rate by complexity
- Common failure reasons
- Which reviewers most often return CONCERNS/FAIL?

**TDD Adherence**:
- Percentage of Epics where tests were changed during implementation
- Correlation with review failures?

### 5. Generate Analysis Report

**Output**: Metrics analysis with recommendations

---

## Metrics Analysis Report Format

```markdown
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
```

---

## Metrics Schema (workflow.yaml)

### Add to Each Epic

```yaml
epics:
  - name: "user-authentication"
    # ... existing fields ...

    # NEW: Metrics tracking
    metrics:
      # Estimated time (set during planning)
      estimated_time:
        planning: "2 hours"
        tdd_tests: "3 hours"
        tdd_implementation: "6 hours"
        tdd_refactor: "2 hours"
        review: "1 hour"
        total: "14 hours"

      # Actual time (captured as Epic progresses)
      actual_time:
        planning: null  # Will be filled during Epic
        tdd_tests: null
        tdd_implementation: null
        tdd_refactor: null
        review: null
        total: null

      # Complexity (for calibration)
      complexity_estimated: 6  # Initial estimate
      complexity_actual: null  # Retroactive assessment after completion

      # Timestamps
      started: null  # "2025-11-08T09:00:00Z"
      completed: null  # "2025-11-10T18:00:00Z"

      # Accuracy (calculated)
      time_accuracy: null  # Percentage
      complexity_delta: null  # ±value
```

---

## How to Capture Metrics

### During Epic Execution

**Phase Start**: Record start time
**Phase End**: Record end time, calculate duration

**Example**:
```
User: I'm starting TDD tests phase for user-authentication Epic

Claude: Starting TDD tests phase. I'll track the time.
[Records start time: 2025-11-08T10:00:00Z]

... work on tests ...

User: TDD tests phase complete

Claude: TDD tests phase took 4 hours (estimated: 3 hours, 133% of estimate).
[Records end time: 2025-11-08T14:00:00Z, duration: 4 hours]
[Updates workflow.yaml: actual_time.tdd_tests = "4 hours"]
```

### After Epic Completion

**Retroactive complexity assessment**:
```
User: Epic complete. What was the actual complexity?

Claude: Based on actual time (18 hours vs estimated 14 hours) and challenges faced:
- OAuth integration more complex than expected
- Edge cases discovered during implementation
- Security review found 2 issues requiring rework

Retroactive complexity assessment: 7 (was estimated as 6)

[Updates workflow.yaml: metrics.complexity_actual = 7]
```

---

## Integration with Workflow

### Automatic Tracking

**Phase transitions** (update workflow.yaml):
```yaml
# When entering planning mode
epics[X].metrics.started = NOW()

# When completing each phase
epics[X].metrics.actual_time[phase] = duration

# When Epic marked complete
epics[X].metrics.completed = NOW()
epics[X].metrics.total = sum(all phases)
```

### Periodic Analysis

**After every 5-10 Epics**:
1. Run analyze-metrics skill
2. Review calibration recommendations
3. Update time/complexity estimates
4. Improve bottleneck phases

**Use results to**:
- Improve Epic breakdown accuracy
- Set better time expectations
- Identify process improvements

---

## Tips for Success

- **Track diligently**: Capture start/end times for each phase
- **Retroactive assessment**: After Epic completion, assess actual complexity
- **Learn patterns**: Every 10 Epics, run analysis to improve estimates
- **Adjust estimates**: Use data to calibrate complexity guidelines
- **Address bottlenecks**: Focus on phases with high variance or long duration
- **Improve quality**: Use pre-review checklists to increase pass rates

---

## Example Usage

```
User: Run analyze-metrics skill to see how we're doing

Claude: I'll analyze metrics from the 15 completed Epics.

[Analyzes data]

Key findings:
- Time estimation: 84% accurate (target: 90-110%)
- We consistently under-estimate TDD tests phase by 30%
- TDD implementation is the bottleneck (50% of total time)
- Review pass rate: 75% (could be higher)

Recommendations:
1. Increase TDD tests estimates by +40%
2. Add pre-review security checklist (security pass rate only 67%)
3. Create test utility library to speed up test writing

Should I update the workflow with new time estimates based on this data?
```

---

## What's Next

After metrics analysis:
- Update complexity guidelines with calibrated estimates
- Implement recommendations to reduce bottlenecks
- Track metrics for next 10 Epics to verify improvements
- Repeat analysis periodically for continuous improvement
