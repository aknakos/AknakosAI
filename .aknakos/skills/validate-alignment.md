# Skill: Validate Alignment

Proactive alignment validation ensuring Epics align with PRD, Architecture, and Mission.

## Purpose

Run BMAD PO Master Validation Checklist to verify Epic-PRD-Architecture alignment **before** entering planning mode.

## When to Use

- **Required**: After Epic breakdown (Phase 3), before planning mode (Phase 4)
- **Checkpoint**: Phase 3.5 - Alignment Validation
- **Time**: 5-10 min per Epic set
- **Complexity**: All (especially 4-9)

## Role & Persona

You are **Product Owner Validator** conducting quality gate review.

**Responsibility**: Catch misalignment before implementation begins (proactive, not reactive).

**Philosophy**: Find problems early when they're cheap to fix.

---

## Validation Process (BMAD Pattern)

### Prerequisites

**Load all strategic documents**:
```
@products/{name}/mission.md
@products/{name}/tech-stack.md
@products/{name}/roadmap.md
@products/{name}/YYYY-MM-DD-prd.md
@products/{name}/YYYY-MM-DD-architecture.md (if exists)
@products/{name}/YYYY-MM-DD-ux-flow.md (if exists)
@products/{name}/epics/*.md (all Epic files)
```

---

### Validation Checklist

#### 1. Requirements Coverage

**Check**: All PRD SHALL/MUST requirements covered by Epics

**Process**:
1. Extract all SHALL/MUST requirements from PRD
2. For each requirement, identify which Epic addresses it
3. Flag any requirements with no corresponding Epic

**Pass Criteria**:
- 100% of SHALL requirements have Epic coverage
- 95%+ of MUST requirements have Epic coverage

**Failure Indicators**:
- Missing Epics for critical requirements
- Requirements split across too many Epics (complexity)
- Epic scope doesn't match requirement scope

---

#### 2. Epic-to-PRD Traceability

**Check**: Every Epic traces to PRD sections

**Process**:
1. For each Epic, verify:
   - Epic description references PRD requirements
   - Acceptance criteria align with PRD scenarios
   - Epic doesn't introduce new requirements not in PRD

**Pass Criteria**:
- Every Epic has clear PRD references
- No "scope creep" Epics (features not in PRD)

**Failure Indicators**:
- Epic introduces features not in PRD
- Epic acceptance criteria contradict PRD requirements
- Epic scope unclear or too broad

---

#### 3. Architecture Compliance

**Check**: Epics don't contradict architecture decisions

**Process**:
1. Review architecture.md and tech-stack.md decisions
2. For each Epic, verify:
   - Tech stack choices align with architecture.md
   - Patterns used match architecture patterns
   - No conflicting technology choices

**Pass Criteria**:
- Epics use tech stack from architecture.md/tech-stack.md
- No Epics proposing different frameworks/databases
- Patterns consistent with architecture doc

**Failure Indicators**:
- Epic proposes different database than architecture.md
- Epic uses pattern explicitly avoided in architecture
- Epic contradicts security architecture decisions

---

#### 4. Mission Alignment

**Check**: Epics support product mission and goals

**Process**:
1. Review mission.md goals and product principles
2. For each Epic, verify:
   - Epic supports at least one product goal
   - Epic aligns with product principles
   - Epic contributes to success metrics

**Pass Criteria**:
- Every Epic maps to product goal
- No Epics violate product principles

**Failure Indicators**:
- Epic doesn't support any product goal
- Epic violates product principle (e.g., "keep it simple" but Epic adds complexity)
- Epic doesn't contribute to success metrics

---

#### 5. Completeness Check

**Check**: No missing specifications

**Process**:
1. Review Epic acceptance criteria
2. Verify:
   - Acceptance criteria are testable
   - Edge cases considered
   - Error handling specified
   - Non-functional requirements included (performance, security)

**Pass Criteria**:
- All acceptance criteria are specific and testable
- Non-functional requirements present
- Edge cases identified

**Failure Indicators**:
- Vague acceptance criteria ("should work well")
- Missing non-functional requirements
- No error handling specified

---

#### 6. Consistency Check

**Check**: Epics don't contradict each other

**Process**:
1. Review all Epics together
2. Identify dependencies
3. Check for:
   - Conflicting assumptions
   - Duplicate functionality
   - Missing integration points

**Pass Criteria**:
- No conflicting Epics
- Dependencies clearly identified
- No duplication

**Failure Indicators**:
- Two Epics solve same problem differently
- Epic A assumes X, Epic B assumes not-X
- Missing integration Epic between major features

---

#### 7. UX Alignment (if ux-flow.md exists)

**Check**: Epics align with defined user flows and interface patterns

**Process**:
1. Review ux-flow.md user flows and interaction patterns
2. For each Epic with UI components, verify:
   - Epic supports defined user flows
   - Proposed UI matches interface structure from ux-flow.md
   - Interaction patterns follow UX flow specifications
   - Epic doesn't introduce conflicting UX patterns

**Pass Criteria**:
- UI Epics support user flows from ux-flow.md
- Interface structure consistent with UX flow
- Interaction patterns match UX specifications
- No conflicting UX approaches

**Failure Indicators**:
- Epic proposes different navigation pattern than ux-flow.md
- Epic contradicts user flow steps
- Epic uses interaction pattern explicitly avoided in UX flow
- Epic doesn't reference relevant user flows

**Note**: Skip this check if ux-flow.md doesn't exist (UX flow is optional)

---

## Validation Output

### Format

Create validation report at:
`products/{name}/reviews/validation/YYYY-MM-DD-epic-validation.md`

### Report Structure

```markdown
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
```

---

## Decision Criteria

### PASS

- Requirements coverage ≥ 95%
- All Epics have PRD traceability
- No architecture contradictions
- All Epics align with mission
- Acceptance criteria are testable
- No Epic conflicts

**Action**: Proceed to planning mode (Phase 4)

---

### CONCERNS

- Requirements coverage 85-95%
- Minor traceability gaps
- Potential architecture concerns (not contradictions)
- Some acceptance criteria could be more specific
- Minor Epic overlaps

**Action**: Address concerns, then proceed. Document concerns in validation report for review during implementation.

---

### FAIL

- Requirements coverage < 85%
- Missing Epics for critical SHALL requirements
- Clear architecture contradictions
- Epics violate product principles
- Vague or untestable acceptance criteria
- Major Epic conflicts

**Action**: **BLOCK progression**. Fix Epics before planning mode.

Use `escalate-conflict` skill if architecture/PRD changes needed.

---

## After Validation

### If PASS or CONCERNS

Update `.aknakos/state/workflow.yaml`:
```yaml
products:
  - name: {product-name}
    current_phase: validation_complete
    validation_status: PASS / CONCERNS
    validation_file: "products/{name}/reviews/validation/YYYY-MM-DD-epic-validation.md"
    validation_date: "{YYYY-MM-DD}"
```

Suggest: Enter planning mode (Phase 4)

---

### If FAIL

Update workflow.yaml:
```yaml
validation_status: FAIL
validation_blockers:
  - {Blocker 1}
  - {Blocker 2}
```

**Required Actions**:
1. Fix critical issues in Epics
2. Re-run validation
3. Achieve PASS or CONCERNS before proceeding

**If fixes require PRD/architecture changes**:
→ Use `escalate-conflict` skill

---

## Examples

### Example 1: Missing Requirements Coverage

**Finding**:
```
PRD REQ-AUTH-002: System SHALL support OAuth 2.0 authentication

No Epic addresses OAuth implementation.
```

**Recommendation**:
```
MUST FIX: Create Epic "User Authentication" with OAuth 2.0 support
Or: Modify existing "User Management" Epic to include OAuth
```

**Status**: FAIL (critical requirement missing)

---

### Example 2: Architecture Contradiction

**Finding**:
```
architecture.md specifies PostgreSQL database
Epic "Data Storage" proposes MongoDB for flexibility
```

**Recommendation**:
```
MUST FIX:
Option 1: Modify Epic to use PostgreSQL
Option 2: Update architecture.md with justification for MongoDB change
  → Use escalate-conflict skill if changing architecture
```

**Status**: FAIL (architecture contradiction)

---

### Example 3: Vague Acceptance Criteria

**Finding**:
```
Epic "User Dashboard" acceptance criteria:
"Dashboard should load quickly"
```

**Recommendation**:
```
SHOULD FIX: Make acceptance criteria specific:
"Dashboard SHALL load within 2 seconds for 95th percentile"
```

**Status**: CONCERNS (not testable)

---

## Integration with Workflow

**Before**:
- Phase 3: Epic breakdown complete

**During**:
- Phase 3.5: Run this validation

**After**:
- Phase 4: Planning mode (if PASS/CONCERNS)
- OR: Fix Epics (if FAIL)

---

## Common Issues

### Issue: "Epic introduces scope creep"

**Symptom**: Epic includes features not in PRD

**Fix**: Remove features OR add to PRD first (requires PRD update)

---

### Issue: "Epic too broad"

**Symptom**: Epic covers multiple unrelated PRD requirements

**Fix**: Split into multiple focused Epics

---

### Issue: "Acceptance criteria vague"

**Symptom**: Criteria like "should work well", "user-friendly"

**Fix**: Make specific and measurable:
- "should work well" → "SHALL respond within 200ms"
- "user-friendly" → "SHALL require ≤ 3 clicks to complete task"

---

## Related Skills

- `epic-breakdown`: Creates Epics (runs before this validation)
- `escalate-conflict`: Handles cases where PRD/architecture need changes
- `whats-next`: Shows next action after validation

---

## Validation Checklist Summary

Run through this checklist:

- [ ] All PRD SHALL/MUST requirements have Epic coverage
- [ ] Every Epic traces to PRD sections
- [ ] No Epics contradict architecture decisions
- [ ] All Epics support product mission goals
- [ ] Acceptance criteria are specific and testable
- [ ] No Epic conflicts or duplications
- [ ] Dependencies identified
- [ ] Non-functional requirements included
- [ ] UI Epics align with UX flows (if ux-flow.md exists)
- [ ] Interaction patterns match UX specifications (if ux-flow.md exists)

If all checked → PASS
If 1-2 concerns → CONCERNS
If 3+ or critical issue → FAIL
