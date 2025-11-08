# Skill: Promote Epic

**Purpose**: Move Epic through validation stages from backlog → drafted → ready for planning

**Phase**: Workflow management (any phase)

**When to Use**: When ready to promote backlog item to active work, requires validation

---

## What This Skill Does

Moves Epics through validation and readiness stages with appropriate validation at each transition.

**Transitions**:
- **Backlog → Drafted**: Quick validation + basic requirements
- **Drafted → Planning**: Full validation + detailed acceptance criteria

**Ensures**:
- Proper validation before work starts
- Epics are complete enough for planning
- Alignment with strategic docs
- Dependencies resolved

---

## Epic Lifecycle

```
Backlog
  ↓ [promote-epic: quick validation]
Drafted
  ↓ [promote-epic: full validation]
Ready for Planning
  ↓ [enter planning mode]
Planning
  ↓
In Progress (TDD workflow)
  ↓
Complete
```

**Parked**: Can be parked from any active state, resumes to same state

---

## Promotion: Backlog → Drafted

### Purpose

Move Epic from "someday maybe" backlog to "ready soon" drafted queue.

### Requirements

**Epic must have**:
- Name and description
- Rough complexity estimate (1-9)
- Priority assignment (P0-P3)

**Epic may lack** (added during promotion):
- Detailed acceptance criteria
- PRD requirement references
- Full architecture considerations

### Process

#### Step 1: Select Epic

```
User: "Promote dark-mode-toggle from backlog"

Claude: Promoting Epic: dark-mode-toggle
Current status: Backlog
```

#### Step 2: Check Dependencies

**Read Epic dependencies field**:

```
Dependencies: user-authentication
```

**Check dependency status**:
- If dependency complete: ✓ Proceed
- If dependency in progress: ⚠ Warn, let user decide
- If dependency backlog/drafted: ✗ Block or force

**Example - Blocked**:
```
Dependency check: dark-mode-toggle depends on theme-system

theme-system status: Backlog (not started)

Cannot promote dark-mode-toggle until theme-system is complete or in progress.

Options:
1. Promote theme-system first
2. Remove dependency (if not actually needed)
3. Defer dark-mode-toggle promotion

Choose:
```

---

#### Step 3: Add Basic Details

**If Epic minimal (from quick add-work capture)**:

Ask user to fill in:
- **Full description** (if just 1 sentence)
- **At least 3 acceptance criteria** (minimal for drafted)
- **Priority confirmation** (is P2 still correct?)

**Use AskUserQuestion or conversational approach**:

```
Epic description is minimal. Let's expand it.

Current: "Add dark mode toggle"

Questions:
1. What should dark mode affect? (UI only, or includes charts/images?)
2. Where should toggle be located? (Settings, navbar, both?)
3. Should preference persist? (Saved to user profile or local?)
4. System preference detection? (Auto-detect OS dark mode?)

[Conversational expansion based on answers]

Updated description:
"Add dark mode toggle in user settings that applies dark theme to entire UI including charts. Toggle state saved to user profile and persists across sessions. Optionally detect and respect OS dark mode preference on first visit."

Looks good? [y/n]
```

---

#### Step 4: Run Quick Validation

**Call `quick-validate` skill**:

- Mission alignment ✓
- Tech stack compatibility ✓
- Rough complexity ✓

**Result: PASS/CONCERNS/FAIL**

**If FAIL**: Block promotion, resolve issues first

---

#### Step 5: Update Epic Status

**Update Epic file**:

```yaml
**Status**: Drafted
**Quick Validated**: true
**Full Validated**: false
**Promoted to Drafted**: {YYYY-MM-DD}
```

**Update workflow.yaml**:

```yaml
products:
  {product-name}:
    epics:
      - name: "dark-mode-toggle"
        status: "drafted"  # Changed from backlog
        priority: "P2"
        quick_validated: true
        full_validated: false
        promoted_to_drafted: "{YYYY-MM-DD}"
```

---

#### Step 6: Confirm

```
✓ Epic promoted: dark-mode-toggle

Status: Backlog → Drafted
Quick validation: PASS
Priority: P2

Epic ready for full validation and planning.

Use `promote-epic dark-mode-toggle` again to move to planning (requires full validation).
Use `list-work` to see all drafted items.
```

---

## Promotion: Drafted → Planning

### Purpose

Validate Epic is complete enough and aligned enough to enter planning mode.

### Requirements

**Epic must have**:
- Full description (2-3 sentences)
- Detailed acceptance criteria (5+ items typically)
- Priority assignment
- Dependencies resolved or documented
- Quick validation: PASS

**Epic should have** (or add now):
- PRD requirement references
- Architecture pattern notes
- Testing considerations

### Process

#### Step 1: Check Quick Validation

```
Epic: dark-mode-toggle
Quick validated: true
Full validated: false

Proceeding to full validation...
```

**If not quick validated**:
```
Epic not quick validated.
Running quick-validate first...
[quick-validate runs]
```

---

#### Step 2: Completeness Check

**Verify Epic has sufficient detail**:

**Acceptance criteria**: At least 3-5 criteria (more for complex Epics)

```
Acceptance criteria: 2 items

Not enough for planning. Add more acceptance criteria.

Current:
- [ ] User can toggle dark mode
- [ ] Dark theme applied to UI

Missing details:
- [ ] What about charts/visualizations?
- [ ] Does preference persist?
- [ ] Settings page design?
- [ ] Mobile support?
- [ ] Accessibility contrast ratios?

Add at least 3 more criteria to proceed.
```

**Description**: Full description, not just title

**Notes**: Any important technical considerations

---

#### Step 3: Run Full Validation

**Call `validate-alignment` skill**:

Checks:
- Mission alignment ✓
- PRD traceability ✓ (new)
- Architecture compliance ✓ (new)
- UX alignment ✓ (if ux-flow.md exists)
- Tech stack compatibility ✓
- Complexity realistic ✓
- Dependencies valid ✓

**Takes 10-15 minutes** (more thorough than quick-validate)

**Result**: PASS/CONCERNS/FAIL

**If FAIL**: Block promotion, address issues

**If CONCERNS**: Let user decide if acceptable

---

#### Step 4: PRD Linkage (If Applicable)

**For formal products with PRDs**:

```
This Epic should link to PRD requirements.

Checking PRD: products/my-product/2025-11-08-prd.md

Potential matches:
- REQ-UI-003: Theme customization
- REQ-UI-007: Dark mode support
- REQ-ACC-002: WCAG contrast compliance

Link to these requirements? [y/n]
```

**Update Epic file**:

```markdown
## Related PRD Requirements

- **REQ-UI-007**: Dark mode support
- **REQ-ACC-002**: WCAG contrast ratios in dark theme
```

**If no PRD or informal product**: Skip this step

---

#### Step 5: Update Epic Status

**Update Epic file**:

```yaml
**Status**: Ready for Planning (or just "Planning")
**Quick Validated**: true
**Full Validated**: true
**Validated On**: {YYYY-MM-DD}
**Ready for Planning**: {YYYY-MM-DD}
```

**Update workflow.yaml**:

```yaml
epics:
  - name: "dark-mode-toggle"
    status: "planning"  # Changed from drafted
    full_validated: true
    validation_date: "{YYYY-MM-DD}"
```

---

#### Step 6: Ready for Planning Mode

```
✓ Epic promoted: dark-mode-toggle

Status: Drafted → Ready for Planning
Full validation: PASS
PRD linkage: Complete

Epic ready for planning mode.

Next steps:
1. Enter planning mode: Shift+Tab×2
2. Load Epic file as context
3. Define Stories, Tasks, and Test Specifications
4. Begin TDD workflow

Start planning mode now? [y/n]
```

---

## Batch Promotion

**Promote multiple Epics at once**:

```
User: "Promote all P1 backlog items"

Claude:
Found 3 P1 backlog items:
1. password-reset-flow
2. user-profile-edit
3. notification-preferences

Promote all to drafted? [y/n]

[If yes, run quick-validate on each, summarize results]

Results:
✓ password-reset-flow: PASS
✓ user-profile-edit: PASS
⚠ notification-preferences: CONCERNS (needs email service)

2 promoted to drafted
1 has concerns - review before promoting
```

---

## Demotion (Optional)

**Demote Epic back to earlier stage**:

```
User: "Demote dashboard-analytics back to backlog"

Claude:
Epic: dashboard-analytics
Current status: Drafted

Reason for demotion: [ask user]
User: "Blocked on API design"

Demoting...

✓ Status: Drafted → Backlog
✓ Reason documented: Blocked on API design
✓ Priority maintained: P2

Epic moved back to backlog.
Use `promote-epic dashboard-analytics` when blocker resolved.
```

---

## Example Usage

### Example 1: Backlog → Drafted

```
User: "Promote dark-mode-toggle"

Claude:
Promoting: dark-mode-toggle
Current status: Backlog → Drafted

Checking dependencies... None (✓)

Epic details look minimal. Let's expand.
[Conversational expansion of description and acceptance criteria]

Running quick-validate...
✓ Mission alignment: PASS
✓ Tech stack compatibility: PASS
✓ Rough complexity: PASS

✓ Epic promoted to Drafted

Ready for full validation when you want to start work.
Use `promote-epic dark-mode-toggle` again for full validation.
```

---

### Example 2: Drafted → Planning

```
User: "Promote password-reset-flow to planning"

Claude:
Promoting: password-reset-flow
Current status: Drafted → Planning

Quick validation: PASS (already validated)

Running full validation...
✓ Mission alignment: Supports core auth functionality
✓ PRD traceability: Links to REQ-AUTH-006
✓ Architecture compliance: Uses Better-Auth password reset flow
✓ Tech stack compatibility: Email service configured
✓ Complexity: 4 (realistic for password reset)

Full validation: PASS

✓ Epic promoted to Ready for Planning

Next: Enter planning mode (Shift+Tab×2) to define implementation

Start planning mode? [y/n]
```

---

### Example 3: Blocked by Dependency

```
User: "Promote export-to-csv"

Claude:
Promoting: export-to-csv
Current status: Backlog

Checking dependencies...
✗ Dependency: dashboard-analytics (status: Parked)

export-to-csv requires dashboard-analytics to be complete.
dashboard-analytics is currently parked.

Options:
1. Resume and complete dashboard-analytics first
2. Remove dependency (if export can work independently)
3. Defer export-to-csv promotion

Choose:
```

---

## Validation Failure Handling

**If full validation fails**:

```
Running full validation on: user-notifications

✓ Mission alignment: PASS
✗ Architecture compliance: FAIL
  Issue: Epic requires WebSocket server; architecture.md specifies serverless
  Conflict: WebSocket needs persistent connections, incompatible with serverless

✓ Tech stack compatibility: PASS (with server)

Full validation: FAIL

Cannot promote to planning.

Recommendations:
1. Use escalate-conflict to update architecture.md (add WebSocket server)
2. Change Epic to use polling instead of WebSocket (fits serverless)
3. Defer Epic until architecture updated

Choose resolution approach:
```

---

## Relationship to Other Skills

**Calls**:
- `quick-validate`: For backlog → drafted
- `validate-alignment`: For drafted → planning
- `escalate-conflict`: If validation reveals parent doc issues

**Called by**:
- User request ("promote {epic-name}")
- Workflow progression (when ready to start Epic)

**Related**:
- `add-work`: Creates backlog items (promote later)
- `list-work`: Shows promotable Epics
- Planning mode: Destination after promotion

---

## Tips for Success

**DO**:
- ✅ Run appropriate validation for each transition
- ✅ Check and resolve dependencies before promoting
- ✅ Expand minimal Epics during promotion
- ✅ Link to PRD requirements when promoting to planning
- ✅ Batch promote when appropriate

**DON'T**:
- ❌ Skip validation steps
- ❌ Promote Epics with unresolved blockers
- ❌ Accept incomplete acceptance criteria
- ❌ Ignore dependency conflicts
- ❌ Promote without checking current work (might need to park)

---

## What's Next

**After promotion to drafted**:
- Epic ready for prioritization
- Can promote to planning when ready to start
- Appears in `list-work` drafted section

**After promotion to planning**:
- Enter planning mode (Shift+Tab×2)
- Load Epic file
- Define Stories, Tasks, Test Specifications
- Begin TDD workflow

**If promotion blocked**:
- Resolve validation failures
- Address dependency issues
- Use `escalate-conflict` if parent docs need updates
- Re-run `promote-epic` after resolution

---

## Workflow Integration

**Typical flow**:

1. **add-work** creates Epic in backlog (P0/P1) or drafted (quick-validated)
2. **promote-epic** moves backlog → drafted (adds details, quick-validate)
3. **promote-epic** moves drafted → planning (full validate)
4. **Planning mode** creates implementation plan
5. **TDD workflow** implements Epic
6. **Review** validates completion

**State transitions**:
```
Backlog (quick-validate) → Drafted (full validate) → Planning → In Progress → Review → Complete
                                                                       ↓
                                                                    Parked (resume later)
```
