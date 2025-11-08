# Skill: Quick Validate

**Purpose**: Lightweight validation for quick Epic captures (P0/P1 work)

**Phase**: After `add-work` for urgent items, before planning mode

**When to Use**: When Epic added via `add-work` needs immediate validation to start work

---

## What This Skill Does

Performs fast sanity check (2-3 minutes) to ensure new Epic is viable, without full validation overhead.

**Checks** (3 quick tests):
1. **Mission alignment**: Does Epic support mission goals?
2. **Tech stack compatibility**: Can we build this with current tech stack?
3. **Rough complexity**: Is estimate realistic?

**Skips** (deferred to full validation):
- PRD requirement traceability
- Detailed architecture compliance
- Comprehensive acceptance criteria review
- Full dependency analysis

**Result**: PASS/FAIL + quick recommendations

---

## When to Use This Skill

**Use when**:
- `add-work` creates P0/P1 Epic that needs immediate start
- Quick sanity check before switching to urgent work
- User wants to verify Epic viability before detailed planning
- Time-sensitive work can't wait for full validation

**Don't use when**:
- Epic moving from drafted → planning (use `validate-alignment` full validation)
- P2/P3 backlog items (defer validation until ready to start)
- Epic already full-validated
- Strategic documents (mission, PRD, architecture) need review

---

## Validation Checks

### Check 1: Mission Alignment (30 seconds)

**Question**: Does this Epic support our mission goals?

**Process**:
1. Read `mission.md` (1 page, quick read)
2. Read Epic description
3. Ask: Does Epic align with mission vision, values, objectives?

**Pass Criteria**:
- Epic clearly supports mission goal
- Doesn't contradict mission values
- Fits within mission scope

**Fail Criteria**:
- Epic contradicts mission direction
- Out of scope for product vision
- Conflicts with stated values

**Example - PASS**:
```
Mission: "Simplify project management for small teams"
Epic: "Add task kanban board"
✓ Aligns: Core project management feature, simplifies workflow
```

**Example - FAIL**:
```
Mission: "Simplify project management for small teams"
Epic: "Add enterprise SSO with SAML integration"
✗ Misaligned: Enterprise feature, mission targets small teams
```

**Output**:
```
Check 1: Mission Alignment
Status: PASS
Rationale: Epic supports mission goal of {specific mission objective}
```

---

### Check 2: Tech Stack Compatibility (1-2 minutes)

**Question**: Can we build this with our current tech stack?

**Process**:
1. Read `tech-stack.md` (1 page, quick scan)
2. Read Epic acceptance criteria and notes
3. Ask: Do we have the tools/libraries/frameworks needed?

**Pass Criteria**:
- Tech stack supports Epic requirements
- No new major technology needed
- Standard patterns available

**Concerns** (pass with note):
- Might need new library (minor addition)
- Unclear if current tech handles edge cases
- Worth verifying during planning

**Fail Criteria**:
- Tech stack fundamentally incompatible
- Requires major architecture change
- Need technology not in stack

**Example - PASS**:
```
Tech stack: SvelteKit + PostgreSQL + Better-Auth
Epic: "Add password reset via email"
✓ Compatible: Better-Auth supports password reset, have email service
```

**Example - CONCERNS**:
```
Tech stack: SvelteKit + PostgreSQL
Epic: "Real-time collaborative editing"
⚠ Concerns: Need WebSocket support; SvelteKit has it but untested
Recommendation: Verify WebSocket setup during planning
```

**Example - FAIL**:
```
Tech stack: SvelteKit + Better-Auth + Drizzle
Epic: "Add Firebase Authentication"
✗ Incompatible: Conflicts with Better-Auth; would need to replace
Recommendation: Use escalate-conflict to update tech-stack.md
```

**Output**:
```
Check 2: Tech Stack Compatibility
Status: PASS | CONCERNS | FAIL
Rationale: {why compatible/incompatible}
Notes: {any concerns or recommendations}
```

---

### Check 3: Rough Complexity (30 seconds)

**Question**: Is complexity estimate realistic?

**Process**:
1. Read Epic complexity estimate (1-9 scale)
2. Review acceptance criteria count
3. Ask: Does estimate match scope?

**Pass Criteria**:
- Complexity matches acceptance criteria count
- Estimate seems reasonable for scope
- Within normal bounds (1-9 scale)

**Concerns** (pass with note):
- Complexity might be underestimated
- Scope seems larger than estimate
- Consider breaking into smaller Epics

**Fail Criteria**:
- Wildly unrealistic (complexity 2 for massive Epic)
- Scope too large (should be multiple Epics)
- Estimate missing or invalid

**Heuristics**:
- 1-3 criteria → Complexity 1-3 (Trivial)
- 4-7 criteria → Complexity 4-6 (Moderate)
- 8+ criteria → Complexity 7-9 (Complex)
- 15+ criteria → Too large, split Epic

**Example - PASS**:
```
Epic: "Add password reset"
Acceptance criteria: 4 items
Complexity: 4
✓ Reasonable: Moderate complexity matches scope
```

**Example - CONCERNS**:
```
Epic: "Build analytics dashboard"
Acceptance criteria: 12 items
Complexity: 5
⚠ Concerns: Seems underestimated; 12 criteria suggests complexity 7-8
Recommendation: Increase complexity estimate or split Epic
```

**Example - FAIL**:
```
Epic: "Complete user management system"
Acceptance criteria: 25 items
Complexity: 6
✗ Too large: This is 3-4 Epics worth of work
Recommendation: Break into smaller Epics (auth, profiles, permissions, etc.)
```

**Output**:
```
Check 3: Rough Complexity
Status: PASS | CONCERNS | FAIL
Rationale: {why estimate is/isn't realistic}
Suggestion: {adjust estimate or split Epic}
```

---

## Validation Results

### Result: PASS

**All 3 checks pass**:
```
Quick Validation: PASS

✓ Mission alignment: Epic supports {mission goal}
✓ Tech stack compatibility: Can build with current stack
✓ Rough complexity: Estimate realistic

Epic ready for planning mode.

Next step: Enter planning mode (Shift+Tab×2) to define Stories/Tasks/Tests
```

**Update workflow.yaml**:
```yaml
epics:
  - name: "{epic-name}"
    quick_validated: true
    quick_validation_date: "{YYYY-MM-DD}"
    quick_validation_status: "pass"
```

---

### Result: CONCERNS

**1-2 checks have concerns, none fail**:
```
Quick Validation: PASS (with concerns)

✓ Mission alignment: Epic supports {mission goal}
⚠ Tech stack compatibility: WebSocket support untested - verify during planning
✓ Rough complexity: Estimate realistic

Recommendations:
1. {Concern 1 recommendation}
2. {Concern 2 recommendation}

Epic viable for planning mode, but address concerns during planning.

Proceed? [y/n]
```

**If user proceeds**:
- Mark `quick_validated: true`
- Document concerns in Epic notes

---

### Result: FAIL

**Any check fails**:
```
Quick Validation: FAIL

✓ Mission alignment: Epic supports {mission goal}
✗ Tech stack compatibility: Requires Firebase Auth, conflicts with Better-Auth
✓ Rough complexity: Estimate realistic

Critical Issue: {description of failure}

Recommendations:
- Option A: {Resolution 1}
- Option B: {Resolution 2}
- Option C: Use escalate-conflict to update {affected doc}

Cannot proceed to planning mode until issue resolved.
```

**Do NOT update Epic to quick_validated**

**Next steps**:
- User chooses resolution option
- Update affected documents (tech-stack, mission, etc.)
- Re-run quick-validate

---

## Comparison: Quick vs Full Validation

**Quick Validation** (2-3 minutes):
- Mission alignment ✓
- Tech stack compatibility ✓
- Rough complexity ✓
- **Use for**: P0/P1 urgent work
- **Sufficient for**: Enter planning mode

**Full Validation** (`validate-alignment`, 10-15 minutes):
- Mission alignment ✓
- Tech stack compatibility ✓
- Detailed complexity ✓
- **PRD requirement traceability** ✓ (not in quick)
- **Architecture compliance** ✓ (not in quick)
- **Epic-PRD coverage** ✓ (not in quick)
- **UX alignment** ✓ (not in quick)
- **Dependency analysis** ✓ (not in quick)
- **Use for**: P2/P3 work, drafted → planning
- **Required before**: Epic promotion from backlog

---

## When Quick Validation is Enough

**Scenarios where quick validation suffices**:

1. **P0 Critical Work**: Need to start immediately
   - Quick check prevents obvious mistakes
   - Full validation deferred until after crisis

2. **P1 Urgent Work with Time Pressure**: Customer request, deadline pressure
   - Quick check ensures viability
   - Full validation when promoting to drafted later

3. **Simple, Obvious Epics**: Clear scope, well-understood domain
   - Quick check confirms assumptions
   - Full validation would find nothing new

**Always do full validation before Epic marked "complete"**:
- Can defer full validation to start work quickly
- Must complete full validation before Epic review phase

---

## Example Usage

### Example 1: P0 Critical Bug (PASS)

```
User: "Production auth broken, users can't login"

Claude: [Using add-work skill]
Created Epic: fix-auth-login-bug
Priority: P0
Running quick-validate...

Quick Validation: PASS

✓ Mission alignment: User authentication is core product functionality
✓ Tech stack compatibility: Using Better-Auth, have tools to debug
✓ Rough complexity: 7 (reasonable for critical auth bug)

Epic ready for immediate work.
Entering planning mode...
```

---

### Example 2: P1 Feature Request (CONCERNS)

```
User: "Customer wants real-time notifications"

Claude: [Using add-work skill]
Created Epic: real-time-notifications
Priority: P1
Running quick-validate...

Quick Validation: PASS (with concerns)

✓ Mission alignment: Enhances user experience (mission goal)
⚠ Tech stack compatibility: Need WebSocket support
  Concern: SvelteKit supports WebSockets but we haven't used them yet
  Recommendation: Verify WebSocket setup during planning, may need server config
✓ Rough complexity: 6 (reasonable for real-time features)

Epic viable with noted concerns.

Proceed to planning mode? [y/n]
```

---

### Example 3: Misaligned Work (FAIL)

```
User: "Add enterprise SSO with SAML"

Claude: [Using add-work skill]
Created Epic: enterprise-sso-saml
Priority: P1
Running quick-validate...

Quick Validation: FAIL

✗ Mission alignment: Mission targets small teams, SAML is enterprise feature
  Mission states: "Simplify for small teams" (3-10 people)
  SAML/SSO: Enterprise feature (100+ users, IT requirements)
  Conflict: Out of scope for target market

✓ Tech stack compatibility: Better-Auth supports OAuth, but SAML would need plugin
✓ Rough complexity: 8 (realistic for SSO complexity)

Critical Issue: Epic contradicts mission scope

Recommendations:
A. Reject Epic: Not aligned with product vision
B. Pivot to simple OAuth: Google/GitHub login for small teams
C. Use escalate-conflict: Update mission if pivoting to enterprise market

Cannot proceed until mission alignment resolved.
```

---

## Integration with Workflow

**add-work flow with quick-validate**:

```
User: "Urgent bug in payment processing"

1. add-work creates Epic (priority: P1)
2. quick-validate runs automatically
3. If PASS: Offer to enter planning mode
4. If CONCERNS: Show concerns, ask if proceed
5. If FAIL: Block, suggest resolutions
```

**Manual quick-validate**:

```
User: "Quick validate the {epic-name} Epic"

Claude: Running quick-validate on {epic-name}...
[3 checks run]
Result: {PASS/CONCERNS/FAIL}
```

---

## Tips for Success

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

## Relationship to Other Skills

**Called by**:
- `add-work`: For P0/P1 Epics
- User request: Manual validation

**Related**:
- `validate-alignment`: Full validation (more thorough)
- `escalate-conflict`: If validation reveals parent doc issues
- `promote-epic`: Runs full validation when promoting backlog → drafted

**Output used by**:
- Planning mode: Proceeds if PASS/CONCERNS
- Epic file: Stores quick_validated flag
- Workflow.yaml: Tracks validation status

---

## What's Next

**After quick validation**:

**PASS**:
- Enter planning mode (Shift+Tab×2)
- Define Stories, Tasks, Test Specifications
- Proceed with TDD workflow

**CONCERNS**:
- Proceed with caution
- Address concerns during planning
- May need to adjust Epic scope/approach

**FAIL**:
- Resolve critical issue first
- Update parent docs if needed (escalate-conflict)
- Re-run quick-validate after resolution
