---
name: quick-validate
description: Lightweight validation (2-3 min) for quick Epic captures (P0/P1 work). Checks mission alignment, tech stack compatibility, rough complexity. Use before planning mode for urgent work. Defers full validation (PRD traceability, architecture compliance) to validate-alignment skill.
---

## Instructions

Fast sanity check (2-3 min) to ensure new Epic is viable before planning mode.

### When to Use

**Use**:
- `add-work` creates P0/P1 Epic needing immediate start
- Quick sanity check before switching to urgent work
- Verify Epic viability before detailed planning
- Time-sensitive work can't wait for full validation

**Don't Use**:
- Epic moving drafted → planning (use `validate-alignment` full validation)
- P2/P3 backlog items (defer until ready to start)
- Epic already full-validated
- Strategic documents need review

---

## Validation Checks

### Check 1: Mission Alignment (30 seconds)

**Question**: Does Epic support mission goals?

**Process**:
1. Read `mission.md` (1 page)
2. Read Epic description
3. Ask: Aligns with mission vision, values, objectives?

**Pass**: Epic supports mission goal, doesn't contradict mission values, fits scope

**Fail**: Epic contradicts mission direction, out of scope, conflicts with values

**Example** (PASS):
```
Mission: "Simplify project management for small teams"
Epic: "Add task kanban board"
✓ Aligns: Core PM feature, simplifies workflow
```

**Example** (FAIL):
```
Mission: "Simplify project management for small teams"
Epic: "Add enterprise SSO with SAML"
✗ Misaligned: Enterprise feature, mission targets small teams
```

See `.aknakos/examples/quick-validate/validation-examples.md` for more examples.

---

### Check 2: Tech Stack Compatibility (1-2 minutes)

**Question**: Can we build with current tech stack?

**Process**:
1. Read `tech-stack.md` (1 page)
2. Read Epic acceptance criteria
3. Ask: Have tools/libraries/frameworks needed?

**Pass**: Tech stack supports Epic, no new major technology, standard patterns available

**Concerns** (pass with note): Might need new library (minor addition), unclear if handles edge cases, verify during planning

**Fail**: Tech stack incompatible, requires major architecture change, need technology not in stack

**Example** (PASS):
```
Tech stack: SvelteKit + PostgreSQL + Better-Auth
Epic: "Add password reset via email"
✓ Compatible: Better-Auth supports password reset
```

**Example** (CONCERNS):
```
Tech stack: SvelteKit + PostgreSQL
Epic: "Real-time collaborative editing"
⚠ Concerns: Need WebSocket support; SvelteKit has it but untested
```

**Example** (FAIL):
```
Tech stack: SvelteKit + Better-Auth
Epic: "Add Firebase Authentication"
✗ Incompatible: Conflicts with Better-Auth
```

See examples file for more scenarios.

---

### Check 3: Rough Complexity (30 seconds)

**Question**: Is complexity estimate realistic?

**Process**:
1. Read Epic complexity estimate (1-9)
2. Review acceptance criteria count
3. Ask: Does estimate match scope?

**Pass**: Complexity matches criteria count, estimate reasonable, within 1-9 scale

**Concerns** (pass with note): Might be underestimated, scope seems larger, consider breaking into smaller Epics

**Fail**: Unrealistic (complexity 2 for massive Epic), scope too large (multiple Epics), estimate missing/invalid

**Heuristics**:
- 1-3 criteria → Complexity 1-3 (Trivial)
- 4-7 criteria → Complexity 4-6 (Moderate)
- 8+ criteria → Complexity 7-9 (Complex)
- 15+ criteria → Too large, split Epic

**Example** (PASS):
```
Epic: "Add password reset"
Acceptance criteria: 4 items
Complexity: 4
✓ Reasonable
```

**Example** (FAIL):
```
Epic: "Complete user management system"
Acceptance criteria: 25 items
✗ Too large: 3-4 Epics worth of work
```

See examples file for more scenarios.

---

## Validation Results

### Result: PASS

All 3 checks pass:

```
Quick Validation: PASS

✓ Mission alignment: Epic supports {mission goal}
✓ Tech stack compatibility: Can build with current stack
✓ Rough complexity: Estimate realistic

Epic ready for planning mode.
Next step: Enter planning mode (Shift+Tab×2)
```

Update workflow.yaml:
```yaml
epics:
  - name: "{epic-name}"
    quick_validated: true
    quick_validation_date: "{YYYY-MM-DD}"
    quick_validation_status: "pass"
```

---

### Result: CONCERNS

1-2 checks have concerns, none fail:

```
Quick Validation: PASS (with concerns)

✓ Mission alignment: Epic supports {mission goal}
⚠ Tech stack compatibility: {concern description}
✓ Rough complexity: Estimate realistic

Recommendations:
1. {Concern 1 recommendation}

Epic viable for planning mode, but address concerns during planning.
Proceed? [y/n]
```

If user proceeds: Mark `quick_validated: true`, document concerns in Epic notes

---

### Result: FAIL

Any check fails:

```
Quick Validation: FAIL

✓ Mission alignment: Epic supports {mission goal}
✗ Tech stack compatibility: {failure description}
✓ Rough complexity: Estimate realistic

Critical Issue: {description}

Recommendations:
- Option A: {Resolution 1}
- Option B: {Resolution 2}
- Option C: Use escalate-conflict to update {affected doc}

Cannot proceed to planning mode until issue resolved.
```

**Do NOT** mark Epic as `quick_validated`

**Next steps**: User chooses resolution, update affected docs, re-run quick-validate

---

## Quick vs Full Validation

**Quick Validation** (2-3 min, this skill):
- Mission alignment ✓
- Tech stack compatibility ✓
- Rough complexity ✓
- **Use for**: P0/P1 urgent work
- **Sufficient for**: Enter planning mode

**Full Validation** (`validate-alignment`, 10-15 min):
- Everything in quick validation ✓
- **PRD requirement traceability** ✓
- **Architecture compliance** ✓
- **Epic-PRD coverage** ✓
- **UX alignment** ✓
- **Dependency analysis** ✓
- **Use for**: P2/P3 work, drafted → planning
- **Required before**: Epic promotion from backlog

**When quick validation is enough**:
1. P0 Critical Work: Need immediate start, quick check prevents obvious mistakes
2. P1 Urgent Work: Time pressure, full validation deferred
3. Simple Epics: Clear scope, quick check confirms assumptions

**Always do full validation before Epic marked "complete"** - can defer to start quickly, must complete before Epic review.

---

## Integration with Workflow

**add-work flow with quick-validate**:
1. `add-work` creates Epic (priority: P0/P1)
2. `quick-validate` runs automatically
3. If PASS: Offer to enter planning mode
4. If CONCERNS: Show concerns, ask if proceed
5. If FAIL: Block, suggest resolutions

**Manual quick-validate**:
```
User: "Quick validate the {epic-name} Epic"
Claude: Running quick-validate on {epic-name}...
[3 checks run]
Result: {PASS/CONCERNS/FAIL}
```

---

## Tips

**DO**:
- ✅ Keep checks fast (under 3 minutes total)
- ✅ Read only essential docs (mission, tech-stack)
- ✅ Focus on showstoppers, not details
- ✅ Document concerns for later review
- ✅ Recommend full validation after urgent work

**DON'T**:
- ❌ Make quick-validate as thorough as full validation
- ❌ Skip mission alignment check (critical for direction)
- ❌ Ignore tech stack conflicts (leads to rework)
- ❌ Accept unrealistic complexity (affects planning)
- ❌ Forget to update quick_validated flag

---

## What's Next

**After quick validation**:

**PASS**: Enter planning mode (Shift+Tab×2), define Stories/Tasks/Test Specifications, proceed with TDD workflow

**CONCERNS**: Proceed with caution, address concerns during planning, may need to adjust Epic scope/approach

**FAIL**: Resolve critical issue first, update parent docs if needed (escalate-conflict), re-run quick-validate after resolution

---

## Related Skills

- `validate-alignment`: Full validation (more thorough)
- `escalate-conflict`: If validation reveals parent doc issues
- `promote-epic`: Runs full validation when promoting backlog → drafted
- `add-work`: Calls quick-validate for P0/P1 Epics
