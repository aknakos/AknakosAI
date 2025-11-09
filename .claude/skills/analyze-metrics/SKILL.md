---
name: analyze-metrics
description: Analyze workflow performance metrics to improve Epic complexity estimation and identify bottlenecks. Tracks actual vs estimated time per phase, improves Epic complexity scoring from historical data, optimizes workflow efficiency. Use after Epic completion or every 5-10 Epics for calibration.
---

## Instructions

Analyze workflow metrics to improve time/complexity estimation accuracy and identify process bottlenecks.

### When to Use

**Use**: After Epic completion (capture metrics), periodic workflow review (monthly/quarterly), complexity calibration (every 5-10 Epics), bottleneck detection

**Don't Use**: No completed Epics with metrics data, workflow.yaml doesn't track metrics

**Time**: 3-5 min (single Epic), 10-15 min (full analysis across multiple Epics)

### Process

**Step 1: Load Metrics Data**

Read `.aknakos/state/workflow.yaml` for completed Epics.

**Extract per Epic**:
- Estimated time (planning, TDD tests, TDD implementation, TDD refactor, review)
- Actual time (same phases)
- Complexity estimated vs actual
- Started/completed timestamps
- Review outcomes
- TDD adherence (tests changed during implementation)

**Step 2: Calculate Accuracy Metrics**

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

**Phase-Level Breakdown**: Which phases consistently over/under-estimated? Which have highest variance?

**Step 3: Aggregate Statistics**

**Overall Accuracy**:
- Mean time estimation accuracy
- Mean complexity estimation delta
- Percentage of Epics within 10% of estimate

**Trends**:
- Are estimates improving over time?
- Which Epic types (auth, UI, API) harder to estimate?

**Bottlenecks**:
- Which phase takes longest on average?
- Which phase has most variance?
- Which phase most often exceeds estimates?

**Step 4: Analyze Patterns**

**Complexity Calibration**:
Build calibration table showing actual time ranges per complexity level (1-3, 4-6, 7-9).

**Pattern examples**:
- "Complexity 4 Epics consistently take 12-16 hours"
- "Complexity 7 Epics range from 20-40 hours (high variance)"

**Review Patterns**:
- Pass rate by complexity
- Common failure reasons
- Which reviewers most often return CONCERNS/FAIL?

**TDD Adherence**:
- Percentage of Epics where tests changed during implementation
- Correlation with review failures?

**Step 5: Generate Analysis Report**

Use template: `.aknakos/templates/reports/metrics-analysis-report.md`

**Sections**:
- Executive Summary (key findings, main bottlenecks, recommendations)
- Time Estimation Accuracy (overall performance, distribution, trends)
- Complexity Estimation Accuracy (calibration table, reassessment)
- Phase-Level Analysis (time by phase, variance, bottlenecks)
- Review Metrics (pass rates, common failures)
- TDD Adherence (tests changed, correlation with reviews)
- Bottleneck Analysis (top 3 bottlenecks with recommendations)
- Recommendations (improve time estimates, complexity estimates, reduce bottlenecks, improve review pass rates)
- Trend Analysis (over time improvements)
- Next Steps (calibrate workflow, improve process, track going forward)
- Metrics Dashboard (summary table)

**Save to**: `.aknakos/products/{product-name}/reviews/metrics/YYYY-MM-DD-metrics-analysis.md`

### Metrics Schema (workflow.yaml)

**Add to each Epic**:

```yaml
epics:
  - name: "user-authentication"
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
        planning: "2.5 hours"
        tdd_tests: "4 hours"
        tdd_implementation: "8 hours"
        tdd_refactor: "1.5 hours"
        review: "2 hours"
        total: "18 hours"

      # Complexity (for calibration)
      complexity_estimated: 6  # Initial estimate
      complexity_actual: 7     # Retroactive assessment after completion

      # Timestamps
      started: "2025-11-08T09:00:00Z"
      completed: "2025-11-10T18:00:00Z"

      # Accuracy (calculated)
      time_accuracy: 78  # Percentage
      complexity_delta: +1
```

### Capturing Metrics

**During Epic Execution**:

**Phase Start**: Record start time
**Phase End**: Record end time, calculate duration, update `actual_time[phase]`

**Example**:
```
Phase: TDD tests
Start: 2025-11-08T10:00:00Z
End: 2025-11-08T14:00:00Z
Duration: 4 hours (estimated: 3 hours, 133% of estimate)
Update workflow.yaml: actual_time.tdd_tests = "4 hours"
```

**After Epic Completion**:

**Retroactive complexity assessment**:
```
Based on actual time (18h vs estimated 14h) and challenges:
- OAuth integration more complex than expected
- Edge cases discovered during implementation
- Security review found 2 issues requiring rework

Retroactive complexity: 7 (was estimated as 6)
Update workflow.yaml: metrics.complexity_actual = 7
```

### Automatic Tracking

**Phase transitions** (update workflow.yaml):
```yaml
# When entering planning mode
epics[X].metrics.started = NOW()

# When completing each phase
epics[X].metrics.actual_time[phase] = duration

# When Epic marked complete
epics[X].metrics.completed = NOW()
epics[X].metrics.actual_time.total = sum(all phases)
```

### Periodic Analysis

**After every 5-10 Epics**:
1. Run analyze-metrics skill
2. Review calibration recommendations
3. Update time/complexity estimates in workflow.yaml
4. Improve bottleneck phases

**Use results to**:
- Improve Epic breakdown accuracy
- Set better time expectations
- Identify process improvements
- Calibrate complexity guidelines

### Recommendations Format

**Time Estimates**:
```yaml
# Example output
Planning: Keep current (accurate)
TDD Tests: Increase by +40% (currently 70% accurate)
TDD Implementation: Increase by +25% (currently 80% accurate)
TDD Refactor: Decrease by -25% (over-estimated)
Review: Increase by +30% (accounting for re-review)
```

**Complexity Adjustments**:
```
Increase complexity if:
- Third-party API integration (+1)
- Novel architecture pattern (+1)
- Multiple external dependencies (+1)
- Security-critical feature (+1)

Decrease complexity if:
- Similar to previous Epic (-1)
- Well-defined requirements (-1)
- Reusing existing patterns (-1)
```

**Bottleneck Fixes**:
- TDD Implementation: Better planning, buffer time for complex Epics (+20%)
- TDD Tests: Test utility library, reusable patterns
- Review: Pre-review validation checklist

### Integration

**Workflow**:
1. Track metrics during Epic execution (automatic phase timing)
2. Capture retroactive complexity after completion
3. Run analyze-metrics every 5-10 Epics
4. Update workflow.yaml with calibrated estimates
5. Apply recommendations to improve process

**Output Location**: `.aknakos/products/{product-name}/reviews/metrics/YYYY-MM-DD-metrics-analysis.md`

**Related Skills**: epic-review (synthesize learnings), validate-state (verify workflow.yaml consistency)
