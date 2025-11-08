# Skill: Park Work

**Purpose**: Save current work context and code state for later resumption

**Phase**: Any phase during active Epic work

**When to Use**: When switching to different work mid-Epic and need to preserve progress

---

## What This Skill Does

Saves both **code state** (via git stash) and **conceptual progress** (via workflow.yaml) so you can seamlessly return to work later.

**Captures**:
- Git stash of uncommitted changes (optional, if WIP code exists)
- Current Epic and phase
- Progress summary (tests passing, tasks complete)
- Blockers or notes
- Timestamp

**Enables**:
- Context switching without losing place
- Multiple concurrent work streams
- Safe interruption handling
- Mental state preservation

---

## When to Use This Skill

**Use when**:
- Switching to P0/P1 urgent work (called automatically by `add-work`)
- User requests explicit park ("park this work for now")
- End of session with incomplete Epic
- Need to work on different Epic temporarily

**Don't use when**:
- Epic is complete (just mark complete)
- Just taking a short break (no context switch needed)
- Abandoning work (use Epic status: "cancelled" instead)

---

## Process

### Step 1: Identify Current Work State

**Determine**:
- Current Epic name
- Current phase (planning, tdd_tests_written, tdd_implementation, review, etc.)
- Progress within phase:
  - Planning: Stories/Tasks defined
  - TDD: Tests written/passing, implementation progress
  - Review: Review status
- Any blockers or important notes

**Example States**:
```
Epic: user-authentication
Phase: tdd_implementation
Progress: 5/8 tests passing, working on password complexity validation
Blockers: None
```

---

### Step 2: Check Git State

**Action**: Check for uncommitted changes

```bash
git status --porcelain
```

**If uncommitted changes exist**:
- Offer to create git stash
- Stash with descriptive message

**If no uncommitted changes**:
- Skip git stash (code state is clean)

---

### Step 3: Create Git Stash (If Needed)

**Process**:

```bash
# Create stash with descriptive message
git stash push -u -m "PARK: {epic-name} - {phase} - {YYYY-MM-DD}"

# Examples:
git stash push -u -m "PARK: user-authentication - tdd_implementation - 2025-11-08"
git stash push -u -m "PARK: dashboard-analytics - planning - 2025-11-08"
```

**Flags**:
- `-u`: Include untracked files
- `-m`: Descriptive message for later identification

**Record stash reference**:
```bash
git stash list | head -n 1
# Output: stash@{0}: On main: PARK: user-authentication - tdd_implementation - 2025-11-08
```

**Save stash ref**: `stash@{0}` (will be stored in workflow.yaml)

---

### Step 4: Capture Conceptual Progress

**Document current state**:

**For Planning Phase**:
- Stories defined: {count}
- Tasks defined: {count}
- Test specifications: {count}
- Last working on: {specific story/task}

**For TDD Phase**:
- Tests written: {count}
- Tests passing: {X/Y}
- Implementation progress: {description}
- Last working on: {specific test/feature}

**For Review Phase**:
- Reviews complete: {which ones}
- Issues found: {count}
- Fixes applied: {count}
- Status: {pass/concerns/fail}

---

### Step 5: Update Workflow State

**Add to workflow.yaml** under `parked_work`:

```yaml
parked_work:
  - epic: "{epic-name}"
    phase: "{current-phase}"
    progress:
      summary: "{progress description}"
      details:
        tests_passing: "{X/Y}"  # if TDD phase
        tasks_complete: "{count}"
        last_working_on: "{specific item}"
    blockers: "{any blockers or notes}"
    git_stash: "{stash@{N}}"  # if stash created
    parked_at: "{YYYY-MM-DD HH:MM}"
    parked_by: "park skill"
    reason: "{why parked - e.g., 'Switching to P1 work'}"
```

**Update Epic status**:
```yaml
products:
  {product-name}:
    epics:
      - name: "{epic-name}"
        status: "parked"  # Changed from in_progress
        # ... other fields ...
```

---

### Step 6: Confirm and Document

**Output to user**:
```
✓ Work parked: {epic-name}

Code state: Git stash created (stash@{0})
Progress: {phase} - {progress summary}
Context saved to: .aknakos/state/workflow.yaml

Use `resume` skill to restore this work later.
Use `list-work` to see all parked and active work.
```

---

## Git Stash Strategy

### When to Stash:

**YES - Create stash when**:
- Uncommitted code changes
- Untracked new files
- Modified test files
- WIP implementation

**NO - Skip stash when**:
- Working directory clean
- All changes committed
- Just planning phase (no code yet)

### Stash Naming Convention:

**Format**: `PARK: {epic-name} - {phase} - {YYYY-MM-DD}`

**Examples**:
- `PARK: user-authentication - tdd_implementation - 2025-11-08`
- `PARK: dashboard-analytics - planning - 2025-11-08`
- `PARK: password-reset - tdd_tests_written - 2025-11-08`

**Why this format**:
- `PARK:` prefix identifies as parked work (vs other stashes)
- Epic name for quick identification
- Phase shows where you were
- Date for chronological tracking

### Stash Management:

**List parked stashes**:
```bash
git stash list | grep "PARK:"
```

**Apply specific stash** (done by `resume` skill):
```bash
git stash apply stash@{N}
```

**Clear old stashes** (manual cleanup):
```bash
git stash drop stash@{N}
```

---

## Parked Work States

### Workflow.yaml Tracking:

**Multiple parked works supported**:
```yaml
parked_work:
  - epic: "user-authentication"
    phase: "tdd_implementation"
    progress:
      summary: "5/8 tests passing"
      details:
        tests_passing: "5/8"
        last_working_on: "password complexity validation"
    git_stash: "stash@{0}"
    parked_at: "2025-11-08 14:30"
    reason: "Switched to P0 work: fix-auth-bug"

  - epic: "dashboard-analytics"
    phase: "planning"
    progress:
      summary: "Stories defined, working on Tasks"
      details:
        stories_defined: 4
        tasks_defined: 8
        last_working_on: "Data fetching task breakdown"
    git_stash: null  # No code changes yet
    parked_at: "2025-11-07 16:45"
    reason: "End of session, incomplete planning"
```

---

## Integration with add-work

**Automatic parking** when `add-work` detects P0 or user chooses to switch for P1:

```
User: "Critical bug in auth system"

Claude [using add-work skill]:
  P0 detected. Automatically parking current work...

  [Calls park skill internally]
  ✓ Parked: dashboard-analytics
  ✓ Git stash: stash@{0}
  ✓ Context saved

  Switching to: fix-auth-bug
```

**Manual parking** when user explicitly requests:

```
User: "Park this work, I need to work on something else"

Claude [using park skill directly]:
  ✓ Parked: user-authentication
  ✓ Git stash: stash@{0}
  ✓ Context saved

  What would you like to work on?
  - Use `resume` to restore different parked work
  - Use `add-work` to create new Epic
  - Use `list-work` to see options
```

---

## Example Usage

### Example 1: Automatic Park (P0 Work)

```
[User working on dashboard-analytics, TDD phase, 3/7 tests passing]

User: "Production is down! Auth service failing"

Claude: Using add-work skill for critical issue...

P0 (Critical) work detected: fix-auth-service

Automatically parking current work...
[Using park skill]

Checking git state... uncommitted changes detected
Creating git stash: PARK: dashboard-analytics - tdd_implementation - 2025-11-08
✓ Stash created: stash@{0}

Saving progress:
- Epic: dashboard-analytics
- Phase: TDD Implementation
- Tests: 3/7 passing
- Last working on: Chart rendering logic

✓ Work parked
✓ Context saved to workflow.yaml

Switching to: fix-auth-service
Ready for planning mode (Shift+Tab×2)
```

---

### Example 2: Manual Park (End of Session)

```
User: "I need to stop for today, park this work"

Claude: Using park skill...

Current work: user-authentication
Phase: Planning mode
Progress: 4 stories defined, 12 tasks defined, working on test specifications

Checking git state... no uncommitted changes (planning phase)
Skipping git stash.

Saving progress:
- Epic: user-authentication
- Phase: Planning
- Stories: 4 defined
- Tasks: 12 defined
- Last working on: Test specifications for password validation

✓ Work parked
✓ Context saved to workflow.yaml

Use `resume user-authentication` to continue tomorrow.
```

---

### Example 3: Multiple Parked Works

```
User: "Park this and work on something else"

Claude: Using park skill...

✓ Parked: payment-processing
✓ Git stash: stash@{0}

You now have 3 parked work items:
1. user-authentication (planning) - parked 2025-11-07
2. dashboard-analytics (tdd_implementation) - parked 2025-11-08
3. payment-processing (tdd_tests_written) - parked 2025-11-08 (just now)

Use `resume` to pick which to resume, or `add-work` for new work.
```

---

## Relationship to Other Skills

**Called by**:
- `add-work`: Automatic park for P0/P1 work
- User request: Manual park

**Calls**:
- Git commands (stash)
- Workflow.yaml updates

**Complementary**:
- `resume`: Restore parked work (reverse of park)
- `list-work`: View all parked work
- `add-work`: Create new work (may trigger park)

---

## Tips for Success

**DO**:
- ✅ Capture detailed progress (helps resume later)
- ✅ Use git stash for uncommitted code
- ✅ Include "why parked" context
- ✅ Note blockers or important considerations
- ✅ Track timestamp for later reference

**DON'T**:
- ❌ Park without saving progress details
- ❌ Forget to update workflow.yaml
- ❌ Lose git stash reference
- ❌ Park completed work (mark complete instead)
- ❌ Overwrite existing stashes (use push, not save)

---

## What's Next

**After parking work**:

1. **Switch to new work**:
   - Use `add-work` to create new Epic
   - Use `resume` to restore different parked work
   - Enter planning mode for different Epic

2. **Later resume**:
   - Use `resume` skill
   - Select parked Epic
   - Restore git stash (if exists)
   - Restore conceptual context
   - Continue from where you left off

---

## Verification Checklist

**Before considering work parked**:

- [ ] Epic status updated to "parked" in workflow.yaml
- [ ] Progress summary captured
- [ ] Git stash created (if uncommitted changes)
- [ ] Stash reference saved
- [ ] Timestamp recorded
- [ ] Reason documented
- [ ] User notified of park success

---

## Advanced: Stash Hygiene

**Periodically clean up stashes**:

```bash
# List all PARK stashes
git stash list | grep "PARK:"

# Remove stashes for completed Epics
git stash drop stash@{N}
```

**Auto-cleanup** (optional future enhancement):
- When Epic marked complete, offer to drop associated stash
- When resuming, offer to drop stash after successful apply
