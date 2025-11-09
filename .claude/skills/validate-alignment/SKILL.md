---
name: validate-alignment
description: BMAD PO Master Validation Checklist - verify Epic-PRD-Architecture-Mission-UX alignment before planning mode. REQUIRED at Phase 3.5 (after Epic breakdown, before planning). Checks requirements coverage, traceability, completeness. 5-10 min per Epic set.
---

## Instructions

Run quality gate validation before planning mode. Catch misalignment early when cheap to fix.

### Prerequisites

Load all strategic documents:
- `.aknakos/products/{name}/mission.md`
- `.aknakos/products/{name}/tech-stack.md`
- `.aknakos/products/{name}/roadmap.md`
- `.aknakos/products/{name}/YYYY-MM-DD-prd.md`
- `.aknakos/products/{name}/YYYY-MM-DD-architecture.md` (if exists)
- `.aknakos/products/{name}/YYYY-MM-DD-ux-flow.md` (if exists)
- `.aknakos/products/{name}/epics/*.md` (all Epics)

### Validation Checklist (7 Checks)

**1. Requirements Coverage**:
- Extract all SHALL/MUST requirements from PRD
- For each requirement, identify which Epic addresses it
- Flag any requirements with no Epic coverage
- **Pass**: 100% SHALL + 95%+ MUST coverage
- **Fail**: < 85% coverage or missing critical SHALL

**2. Epic-to-PRD Traceability**:
- Verify Epic description references PRD sections
- Check acceptance criteria align with PRD scenarios
- Flag Epics introducing features not in PRD (scope creep)
- **Pass**: Every Epic has clear PRD references, no scope creep
- **Fail**: Epics contradict PRD or introduce unauthorized features

**3. Architecture Compliance**:
- Review architecture.md and tech-stack.md decisions
- Verify Epics use specified tech stack
- Check patterns match architecture patterns
- Flag conflicting technology choices
- **Pass**: Epics align with architecture/tech-stack
- **Fail**: Epics contradict architecture decisions (different DB/framework)

**4. Mission Alignment**:
- Review mission.md goals and principles
- Verify each Epic supports ≥1 product goal
- Check Epics don't violate product principles
- **Pass**: All Epics map to goals, no principle violations
- **Fail**: Epic doesn't support any goal OR violates mission principle

**5. Completeness Check**:
- Review Epic acceptance criteria for testability
- Verify non-functional requirements included (performance, security)
- Check edge cases considered, error handling specified
- **Pass**: All criteria specific, testable, non-functional reqs present
- **Fail**: Vague criteria ("should work well"), missing non-functionals

**6. Consistency Check**:
- Review all Epics together
- Identify dependencies, check for conflicts
- Flag duplicate functionality, missing integrations
- **Pass**: No conflicts, dependencies clear, no duplication
- **Fail**: Epics contradict each other, major duplication, missing integration

**7. UX Alignment** (if ux-flow.md exists):
- Review ux-flow.md user flows and patterns
- Verify UI Epics support defined user flows
- Check interface structure matches UX flow spec
- Flag Epics contradicting UX flow patterns
- **Pass**: UI Epics align with user flows and patterns
- **Fail**: Epics contradict UX flow navigation/interaction patterns
- **Skip**: If ux-flow.md doesn't exist

### Output

Generate report using template: `.aknakos/templates/validation-report.md`

Save to: `.aknakos/products/{name}/reviews/validation/YYYY-MM-DD-epic-validation.md`

Update workflow.yaml:
```yaml
validation_status: PASS / CONCERNS / FAIL
validation_file: "..."
validation_date: "YYYY-MM-DD"
```

### Decision Criteria

**PASS**:
- Requirements coverage ≥ 95%
- All Epics have PRD traceability
- No architecture contradictions
- All Epics align with mission
- Acceptance criteria testable
- No Epic conflicts
→ **Action**: Proceed to planning mode

**CONCERNS**:
- Requirements coverage 85-95%
- Minor traceability gaps
- Potential architecture concerns (not contradictions)
- Some criteria could be more specific
- Minor Epic overlaps
→ **Action**: Address concerns, document in report, then proceed

**FAIL**:
- Requirements coverage < 85%
- Missing Epics for SHALL requirements
- Architecture contradictions
- Mission principle violations
- Vague/untestable criteria
- Major Epic conflicts
→ **Action**: BLOCK progression, fix Epics, re-validate

### If FAIL - Escalation

**When to use escalate-conflict**:
- Epic reveals PRD requirement was wrong
- Architecture decision blocks better implementation
- Mission constraint prevents optimal solution

**Process**:
1. Stop validation
2. Document conflict
3. Use `escalate-conflict` skill to update parent doc
4. Re-run validation after update

### Common Issues & Fixes

**Issue**: Epic introduces scope creep
- **Symptom**: Features not in PRD
- **Fix**: Remove features OR add to PRD first (escalate-conflict)

**Issue**: Epic too broad
- **Symptom**: Covers multiple unrelated PRD requirements
- **Fix**: Split into focused Epics

**Issue**: Vague acceptance criteria
- **Symptom**: "should work well", "user-friendly"
- **Fix**: Make specific:
  - "should work well" → "SHALL respond within 200ms"
  - "user-friendly" → "SHALL require ≤ 3 clicks to complete"

**Issue**: Architecture contradiction
- **Symptom**: Epic proposes MongoDB, architecture.md specifies PostgreSQL
- **Fix**: Change Epic to match architecture OR escalate to update architecture.md

**Issue**: Missing requirements
- **Symptom**: SHALL requirement has no Epic
- **Fix**: Create Epic OR modify existing Epic to cover requirement

### Examples

See `.aknakos/examples/validation/` for detailed examples:
- `epic-validation-pass.md`: 100% coverage, all checks PASS
- `epic-validation-concerns.md`: 92% coverage, minor issues, CONCERNS
- `epic-validation-fail.md`: 68% coverage, architecture contradiction, mission violation, FAIL

### Integration with Workflow

**Before**: Phase 3 (Epic breakdown complete)
**During**: Phase 3.5 (Run this validation)
**After**: Phase 4 (Planning mode if PASS/CONCERNS) OR Fix Epics (if FAIL)

**Critical**: This is REQUIRED checkpoint before planning mode. Do not skip.

### Related Skills

- `epic-breakdown`: Creates Epics (runs before validation)
- `escalate-conflict`: Updates parent docs when needed
- `whats-next`: Shows next action after validation
