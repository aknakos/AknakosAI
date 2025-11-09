---
name: add-work
description: Quick capture of new work mid-workflow without derailing current tasks Use when: **Use when**:
---


**Purpose**: Quick capture of new work mid-workflow without derailing current tasks

**Phase**: Any phase (Phase 3+ when Epics exist)

**When to Use**: When new work arises during active development that needs to be captured and triaged

---

## What This Skill Does

Provides lightweight mechanism to capture new Epics or requirements mid-stream, triage by priority, and decide whether to handle immediately or add to backlog.

**Key Features**:
- Quick Epic capture (30 seconds vs 15+ minutes)
- Automatic priority-based triage (P0-P3)
- Context switching support (park current work)
- Roadmap auto-updates
- No derailment of current work

---

## When to Use This Skill

**Use when**:
- New urgent feature request comes in mid-Epic
- Bug/issue discovered that needs separate Epic
- User requests completely different functionality
- Scope expansion beyond current Epic
- Multiple work streams need juggling

**Don't use when**:
- Adding to current Epic scope (use `escalate-conflict` for scope changes)
- Initial Epic breakdown from PRD (use `epic-breakdown`)
- Just note-taking (use Epic notes section)

---

## Process

### Step 1: Quick Capture

**Action**: Create minimal Epic draft with essential information only

**Required Information**:
- **Epic name**: Short, descriptive (e.g., "password-reset", "api-rate-limiting")
- **Description**: 1-2 sentences describing what needs to be done
- **Rough complexity**: Quick estimate 1-9 (can refine later)

**Optional Information** (defer to validation phase):
- Detailed acceptance criteria
- PRD requirement references
- Architecture considerations

---

### Step 2: Priority Triage

**Ask user for priority** using `AskUserQuestion` tool:

**Priority Levels**:

**P0 - Critical**:
- System broken/down
- Security vulnerability
- Blocker for other work
- **Action**: Auto-park current work, switch immediately

**P1 - Urgent**:
- Important feature needed soon
- User-facing bug
- Valuable quick win
- **Action**: Offer to park current work and switch

**P2 - Normal**:
- Standard feature work
- Nice-to-have improvement
- Can wait until current work complete
- **Action**: Add to drafted queue, continue current work

**P3 - Backlog**:
- Future enhancement
- Low-impact improvement
- Deferred for later
- **Action**: Add to backlog, continue current work

---

### Step 3: Triage Decision

**Based on priority, present options**:

#### For P0 (Critical):
```
P0 work detected: {Epic name}

Automatically parking current work: {current Epic name}
Context saved: {current phase, progress summary}

Creating Epic draft for {new Epic name}...
Running quick validation...
```

**Action**: Automatically park and switch

---

#### For P1 (Urgent):
```
P1 work detected: {Epic name}

You're currently working on: {current Epic name}
Current phase: {phase and progress}

Options:
1. Park current work and switch to {new Epic name} now
2. Add {new Epic name} to drafted queue, continue {current Epic}
3. Quick-validate and schedule for next session

Choose:
```

**Action**: User decides whether to switch now or defer

---

#### For P2/P3 (Normal/Backlog):
```
{P2/P3} work captured: {Epic name}

Added to {drafted/backlog} queue.
Updated roadmap.md

Current work continues: {current Epic name}

Use `list-work` to see all work items.
```

**Action**: Continue current work, track new work in queue

---

### Step 4: Create Epic File

**Location**: `.aknakos/products/{product-name}/epics/YYYY-MM-DD-epic-name.md`

**Minimal Epic Template** (for quick capture):
```markdown
# Epic: {Epic Name}

**Status**: Backlog | Drafted
**Priority**: {P0/P1/P2/P3}
**Complexity**: {1-9 rough estimate}
**Created**: {YYYY-MM-DD}
**Dependencies**: {None or TBD}
**Quick Validated**: {false}
**Full Validated**: {false}

---

## Description

{1-2 sentence description of what this Epic accomplishes}

---

## Acceptance Criteria

- [ ] {Minimal criterion 1 - will expand during validation}

---

## Notes

**Added via**: add-work skill (mid-workflow capture)
**Context**: {Why this was added - user request, bug discovered, etc.}
**Next step**: {Quick validation if P1, full validation before planning}
```

---

### Step 5: Update Workflow State

**Add to workflow.yaml**:

```yaml
products:
  {product-name}:
    epics:
      # ... existing epics ...
      - name: "{new-epic-name}"
        file: "{YYYY-MM-DD-epic-name.md}"
        status: "backlog"  # or "drafted" for P1/P2
        priority: "{P0/P1/P2/P3}"
        implementation_complexity: {1-9}
        created_date: "{YYYY-MM-DD}"
        quick_validated: false
        full_validated: false
        added_via: "add-work"

epic_priorities:
  P0:
    - "{epic-name}" # if P0
  P1:
    - "{epic-name}" # if P1
  P2:
    - "{epic-name}" # if P2
  P3:
    - "{epic-name}" # if P3
```

**If current work parked**:
```yaml
parked_work:
  - epic: "{current-epic-name}"
    phase: "{current phase}"
    context: "{progress summary}"
    parked_at: "{YYYY-MM-DD}"
    reason: "Switched to P0/P1 work: {new-epic-name}"
```

---

### Step 6: Update Roadmap

**Add to roadmap.md** in appropriate section:

```markdown
## Phase {X}: {Phase Name}

**Timeline**: {dates}

### Epics
- [x] {Completed Epic}
- [ ] {Current Epic - IN PROGRESS}
- [ ] **{NEW Epic}** (Priority: P1, Added: YYYY-MM-DD) ← New entry
- [ ] {Upcoming Epic}
```

Or for backlog:

```markdown
## Backlog

### Future Enhancements
- [ ] **{NEW Epic}** (Priority: P3, Added: YYYY-MM-DD)
```

---

### Step 7: Validation Path

**Depends on priority**:

**P0 (Critical)**:
- Run `quick-validate` skill immediately
- If passes: Proceed to planning mode
- If fails: Escalate conflict or defer

**P1 (Urgent)**:
- If switching now: Run `quick-validate` skill
- If deferring: Run `quick-validate` when ready to start

**P2/P3 (Normal/Backlog)**:
- Defer validation until ready to promote to planning
- Use `promote-epic` skill to run validations when ready

---

## Context Switching

**If parking current work** (P0 or user chose to switch for P1):

### What Gets Saved:
- Current Epic name
- Current phase (planning, tdd_tests_written, implementation, etc.)
- Progress summary:
  - Tests: How many passing/failing
  - Tasks: What's complete, what's in progress
  - Blockers: Any issues encountered
- Location: workflow.yaml `parked_work` section

### How to Resume:
- Use `resume` skill to restore parked work
- Context includes: phase, progress, notes
- Workflow.yaml updated to mark Epic as "in_progress" again

---

## Integration with Validation

**Quick Validation** (for P0/P1):
- Mission alignment check (30 seconds)
- Tech stack compatibility (1 minute)
- Rough complexity estimate validation
- **Does NOT require**: PRD references, detailed acceptance criteria, full architecture review

**Full Validation** (before planning mode):
- Use `validate-alignment` skill
- PRD traceability required
- Architecture compliance required
- Detailed acceptance criteria required

---

## Example Usage

### Example 1: Critical Bug (P0)

```
User: "The authentication system is broken, users can't login"

Claude: I'll use the add-work skill to capture this critical issue.

[Creates Epic: fix-auth-login-bug]

P0 (Critical) work detected: fix-auth-login-bug

Automatically parking current work: dashboard-analytics
Context saved: Phase 5 (TDD Implementation), 5/8 tests passing

Creating Epic draft...
Running quick validation... PASS (aligns with mission, uses existing tech stack)

Epic ready for planning mode.
Enter planning mode (Shift+Tab×2) to define Stories and Tasks.
```

---

### Example 2: Urgent Feature Request (P1)

```
User: "Can we add password reset? Customer is asking for it"

Claude: I'll use the add-work skill to capture this feature.

[Creates Epic: password-reset-flow]

P1 (Urgent) work detected: password-reset-flow

You're currently working on: user-profile-management
Current phase: Phase 5 (TDD Implementation), 3/5 tests passing

Options:
1. Park user-profile-management and switch to password-reset-flow now
2. Add password-reset-flow to drafted queue, finish user-profile-management first
3. Quick-validate and schedule for next session

User: "2 - let me finish current work first"

Claude: Added password-reset-flow to drafted queue.
Epic status: Drafted (ready for planning after current work)
Updated roadmap.md

Continuing user-profile-management...
```

---

### Example 3: Future Enhancement (P3)

```
User: "Eventually we should add dark mode"

Claude: I'll capture this as backlog item using add-work skill.

P3 (Backlog) work captured: dark-mode-toggle

Created Epic draft: products/my-app/epics/2025-11-08-dark-mode-toggle.md
Status: Backlog
Priority: P3

Added to roadmap.md backlog section.
Updated workflow.yaml

Current work continues: user-authentication (uninterrupted)

Use `list-work` to see all work items when ready.
```

---

## Relationship to Other Skills

**vs `epic-breakdown`**:
- `epic-breakdown`: Comprehensive PRD → Epics conversion (Phase 3)
- `add-work`: Quick mid-workflow Epic capture (any phase)

**vs `escalate-conflict`**:
- `escalate-conflict`: Current Epic reveals flawed requirements/architecture
- `add-work`: Completely new work outside current Epic scope

**Complementary Skills**:
- `park`: Save current work context (used by add-work for P0/P1)
- `resume`: Restore parked work
- `quick-validate`: Lightweight validation for quick adds
- `promote-epic`: Move Epic from backlog → drafted → planning
- `list-work`: View all work items and priorities

---

## Common Patterns

### Pattern 1: Bug Discovered During Development

```
1. Use add-work (P1 or P2 depending on severity)
2. Continue current Epic
3. Address bug Epic after current work complete
4. Use resume to return if needed
```

---

### Pattern 2: Urgent Customer Request

```
1. Use add-work (P1)
2. Choose to park current work
3. Quick-validate new Epic
4. Enter planning mode for new Epic
5. Complete new Epic
6. Use resume to return to parked work
```

---

### Pattern 3: Scope Creep Within Epic

```
1. Recognize new work is beyond current Epic scope
2. Use add-work to create separate Epic
3. Update current Epic to reference new Epic as dependency
4. Complete current Epic first (or park and switch)
```

---

## Tips for Success

**DO**:
- ✅ Capture work immediately (don't lose track)
- ✅ Triage honestly (not everything is P0)
- ✅ Use quick validation for urgent work
- ✅ Update roadmap automatically
- ✅ Save context when parking work

**DON'T**:
- ❌ Skip priority assessment
- ❌ Over-specify in initial capture (defer to validation)
- ❌ Mark everything as P0/P1
- ❌ Forget to update workflow.yaml
- ❌ Lose context when switching work

---

## What's Next

**After using add-work**:

**P0/P1 with switch**:
- Enter planning mode for new Epic
- Use TDD workflow
- Complete or park

**P2/P3 deferred**:
- Use `list-work` to review backlog
- Use `promote-epic` when ready to start
- Use `resume` to return to parked work if applicable

---

## Validation States

Epic validation has two levels:

**Quick Validated**:
- Mission alignment ✓
- Tech stack compatibility ✓
- Rough complexity ✓
- **Time**: 2-3 minutes
- **Sufficient for**: P0/P1 work to enter planning mode

**Full Validated**:
- PRD traceability ✓
- Architecture compliance ✓
- Detailed acceptance criteria ✓
- **Time**: 10-15 minutes
- **Required before**: Epic promotion to planning (for P2/P3)

**add-work creates**: Quick validated (P0/P1) or unvalidated (P2/P3)
**promote-epic requires**: Full validation
