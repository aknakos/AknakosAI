---
name: park
description: Save current work context and code state (git stash + progress tracking) for later resumption. Use when switching to different work mid-Epic. Captures code state, phase, progress summary, blockers, timestamp. Enables seamless context switching without losing place.
---

## Instructions

Save both code state (git stash) and conceptual progress (workflow.yaml) to enable seamless return to work later.

### When to Use

**Use**:
- Switching to P0/P1 urgent work (called automatically by `add-work`)
- User requests explicit park ("park this work")
- End of session with incomplete Epic
- Need to work on different Epic temporarily

**Don't Use**:
- Epic is complete (mark complete instead)
- Just taking a short break (no context switch needed)
- Abandoning work (use Epic status: "cancelled")

---

## Process

### Step 1: Identify Current Work State

Determine:
- Current Epic name
- Current phase (planning, tdd_tests_written, tdd_implementation, review, etc.)
- Progress within phase (Stories/Tasks defined, tests written/passing, implementation progress, review status)
- Any blockers or important notes

### Step 2: Check Git State

Check for uncommitted changes:
```bash
git status --porcelain
```

- If uncommitted changes exist: Offer to create git stash
- If no uncommitted changes: Skip git stash (code state is clean)

### Step 3: Create Git Stash (If Needed)

```bash
# Create stash with descriptive message
git stash push -u -m "PARK: {epic-name} - {phase} - {YYYY-MM-DD}"

# Example:
git stash push -u -m "PARK: user-authentication - tdd_implementation - 2025-11-08"

# Get stash reference
git stash list | head -n 1
# Output: stash@{0}: On main: PARK: user-authentication - tdd_implementation - 2025-11-08
```

**Stash naming convention**: `PARK: {epic-name} - {phase} - {YYYY-MM-DD}`
- `PARK:` prefix identifies as parked work
- Epic name for quick identification
- Phase shows where you were
- Date for chronological tracking

**Record stash ref**: Save `stash@{0}` to workflow.yaml

### Step 4: Capture Conceptual Progress

**Planning Phase**: Stories defined (count), Tasks defined (count), Test specifications (count), Last working on (specific story/task)

**TDD Phase**: Tests written (count), Tests passing (X/Y), Implementation progress (description), Last working on (specific test/feature)

**Review Phase**: Reviews complete (which ones), Issues found (count), Fixes applied (count), Status (pass/concerns/fail)

### Step 5: Update Workflow State

Add to workflow.yaml under `parked_work`:
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

Update Epic status:
```yaml
products:
  {product-name}:
    epics:
      - name: "{epic-name}"
        status: "parked"  # Changed from in_progress
```

### Step 6: Confirm and Document

Output to user:
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

### When to Stash

**YES**: Uncommitted code changes, untracked new files, modified test files, WIP implementation

**NO**: Working directory clean, all changes committed, just planning phase (no code yet)

### Stash Management

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

## Integration with Workflow

**Automatic parking** (via `add-work`):
- P0 detected → Automatically park current work
- User switches for P1 → Park current work

**Manual parking** (user request):
- User says "park this work" → Use park skill directly

**Multiple parked works supported**: workflow.yaml tracks all parked work items

See `.aknakos/examples/park/park-scenarios.md` for detailed examples.

---

## Tips

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

## Verification Checklist

- [ ] Epic status updated to "parked" in workflow.yaml
- [ ] Progress summary captured
- [ ] Git stash created (if uncommitted changes)
- [ ] Stash reference saved
- [ ] Timestamp recorded
- [ ] Reason documented
- [ ] User notified of park success

---

## What's Next

**After parking work**:
1. **Switch to new work**: Use `add-work` for new Epic, `resume` for different parked work, or enter planning mode for different Epic
2. **Later resume**: Use `resume` skill to restore git stash, context, and continue from where you left off

---

## Related Skills

- `resume`: Restore parked work (reverse of park)
- `list-work`: View all parked work
- `add-work`: Create new work (may trigger park)
