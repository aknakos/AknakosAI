---
name: epic-review
description: Synthesize review reports and extract learnings after Epic completion. Use after all Epic reviews complete and concerns addressed. Generate retrospective document with patterns, recommendations, metrics, tech debt tracking.
---

## Instructions

Synthesize 5 parallel review reports into Epic-level retrospective document with learnings and recommendations.

### When to Use

**Trigger**: After Epic reviews complete (all 5 reports) and concerns addressed

**Inputs**: Test, security, architecture, quality, requirements review reports

**Output**: Epic review retrospective (`.aknakos/products/{name}/reviews/epic-reviews/YYYY-MM-DD-{epic}-review.md`)

**Time**: 15-30 min

**Phase**: 7 (Epic Completion)

---

## Process

### Step 1: Collect Review Reports

**Location**: `.aknakos/products/{product-name}/reviews/{epic-name}/`

Read all 5 reports:
- `YYYY-MM-DD-test-review.md`
- `YYYY-MM-DD-security-review.md`
- `YYYY-MM-DD-architecture-review.md`
- `YYYY-MM-DD-quality-review.md`
- `YYYY-MM-DD-requirements-review.md`

### Step 2: Identify Patterns

**Positive Patterns** (repeat):
- What went well? Successful approaches? Made reviews pass easily?

**Negative Patterns** (avoid):
- What caused concerns/failures? Repeated issues? Harder than expected?

**Cross-Review Patterns**:
- Multiple reviewers mention same issue? Systemic vs one-off? Architectural changes needed?

### Step 3: Extract Learnings

**Technical**: Architectural insights, better patterns discovered, tech debt created/resolved, performance considerations

**Process**: TDD effectiveness, planning accuracy, estimation accuracy, review process effectiveness

**Quality**: Test coverage insights, security practices, code quality patterns, documentation effectiveness

### Step 4: Create Recommendations

**For Future Epics**: Do more of, avoid, change in process, add to PRD/standards

**For Current Product**: Tech debt to address, refactoring opportunities, cross-Epic improvements, documentation needs

### Step 5: Generate Review Document

Use template: `.aknakos/templates/epic-review-template.md`

**Sections**:
- Summary (2-3 sentences of what was accomplished)
- Review Outcomes (PASS/CONCERNS/FAIL final status for each reviewer)
- What Went Well (Technical, Process, Quality)
- What Could Improve (Technical, Process, Quality)
- Key Learnings (3-5 major insights)
- Patterns Identified (Successful patterns to repeat, anti-patterns to avoid)
- Recommendations (For next Epics, for product architecture, for process)
- Metrics (planned vs actual complexity, estimation accuracy, test coverage, review iterations, concerns raised, time to resolution)
- Tech Debt Created (item, why created, when to address, effort estimate)
- Follow-up Actions (actionable checklist)
- Notes (additional context)

**Save to**: `.aknakos/products/{product-name}/reviews/epic-reviews/YYYY-MM-DD-{epic-name}-review.md`

**Example**: See `.aknakos/examples/epic-reviews/user-authentication-epic-review.md`

---

## Analysis Questions

When synthesizing, ask:

**Estimation**:
- Was complexity estimate accurate? What caused under/overestimation? What factors weren't considered?

**Quality**:
- Did TDD approach work well? Were test specifications accurate? Did reviews catch real issues?

**Process**:
- Was planning mode effective? Did parallel reviews save time? Were concerns addressed efficiently?

**Technical**:
- Were architecture decisions good? Is code maintainable? Is there tech debt?

**Learning**:
- What surprised us? What would we change? What should we keep?

---

## Update Workflow State

After epic review, update `.aknakos/state/workflow.yaml`:

```yaml
products:
  {product-name}:
    epics:
      - name: "{epic-name}"
        status: "complete"
        completion_date: "{YYYY-MM-DD}"
        epic_review:
          file: "reviews/epic-reviews/YYYY-MM-DD-{epic}-review.md"
          key_learnings:
            - "{Learning 1}"
            - "{Learning 2}"
            - "{Learning 3}"
```

---

## Benefits

**Short-term**: Capture learnings while fresh, identify immediate follow-up actions, celebrate successes, address concerns

**Long-term**: Improve estimation accuracy, refine processes, build knowledge base, inform future architecture decisions

---

## Tips

**DO**:
- ✅ Review while Epic is fresh in mind (within 1-2 days of completion)
- ✅ Be honest: document failures and successes equally
- ✅ Be specific: "Tests were good" → "Test coverage 92%, edge cases well covered"
- ✅ Extract patterns: One issue = note it; repeated issues = pattern
- ✅ Make it actionable: Every learning should inform future behavior
- ✅ Keep it concise: 1-2 pages maximum

**DON'T**:
- ❌ Skip epic reviews ("too busy") - make time (15-30 min)
- ❌ Only document successes (miss learning opportunities)
- ❌ Vague learnings ("do better next time") - be specific and actionable
- ❌ Not following up on recommendations
- ❌ Treat as blame exercise - focus on learning

---

## What's Next

After Epic review complete:
- Apply learnings to next Epic
- Update estimation approach if needed
- Improve process based on insights
- Address follow-up actions
- Start next Epic (use `whats-next` skill)

---

## Related Skills

- `whats-next`: Determines which Epic to do next
- `epic-breakdown`: Informed by previous Epic reviews
- Review agents: Provide the reports being synthesized
