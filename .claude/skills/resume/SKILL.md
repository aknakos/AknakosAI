---
name: resume
description: Restore previously parked work context and code state Use when: **Use when**:
---


**Purpose**: Restore previously parked work context and code state

**Phase**: Any phase (when parked work exists)

**When to Use**: When ready to continue work that was previously parked

---

## What This Skill Does

Restores both **code state** (via git stash apply) and **conceptual progress** (from workflow.yaml) so you can seamlessly continue where you left off.

**Restores**:
- Git stash of uncommitted changes (if exists)
- Epic and phase information
- Progress summary (tests, tasks, notes)
- Blockers and context
- Updates Epic status back to in_progress

**Enables**:
- Seamless return to parked work
- Context restoration (not just code)
- Multi-work-stream juggling
- Mental state recovery

---

## When to Use This Skill

**Use when**:
- Ready to return to parked Epic
- Completed urgent work, returning to previous work
- Starting new session, continuing yesterday's parked work
- User requests "resume {epic-name}"

**Don't use when**:
- No parked work exists
- Want to start new work (use `add-work` or `epic-breakdown`)
- Epic is complete (nothing to resume)

---

## Process

### Step 1: List Parked Work

**Action**: Show all parked work items from workflow.yaml

**Display format**:
```
Parked work items:

1. user-authentication
   Phase: TDD Implementation
   Progress: 5/8 tests passing, working on password complexity
   Parked: 2025-11-08 14:30 (2 hours ago)
   Reason: Switched to P0 work
   Git stash: stash@{0}

2. dashboard-analytics
   Phase: Planning
   Progress: 4 stories, 12 tasks defined
   Parked: 2025-11-07 16:45 (yesterday)
   Reason: End of session
   Git stash: none

Which work would you like to resume? [1-2, or Epic name]
```

**If only one parked item**:
- Auto-select (don't ask)
- Show context
- Proceed with resume

**If no parked items**:
```
No parked work found.

Active work: {current Epic if any}
Use `list-work` to see all work items.
```

---

### Step 2: User Selection

**Options**:
- User types number (1, 2, etc.)
- User types Epic name ("user-authentication")
- User says "resume" (auto-select most recent)
- User says "resume {epic-name}"

**Validate selection**:
- Ensure Epic exists in parked_work
- Retrieve full context from workflow.yaml

---

### Step 3: Check Current Work

**Before resuming, check if work in progress**:

**If no active work**:
- Proceed with resume

**If active work exists**:
```
You're currently working on: {current Epic name}
Phase: {current phase}
Progress: {current progress}

Options:
1. Park current work and resume {selected Epic}
2. Cancel resume, continue current work

Choose:
```

**If user chooses Option 1**:
- Call `park` skill for current work
- Then proceed with resume

---

### Step 4: Restore Git State

**If git stash exists in parked work metadata**:

```bash
# List stashes to verify it still exists
git stash list

# Apply the stash (don't drop it yet, in case conflicts)
git stash apply {stash-ref}
```

**Example**:
```bash
git stash apply stash@{0}
```

**Handle conflicts**:
- If conflicts occur: Notify user, show conflicted files
- User must resolve manually
- After resolution: Continue resume process

**If no git stash** (planning phase or clean state):
- Skip git restore
- Proceed with conceptual context restoration

---

### Step 5: Restore Conceptual Context

**Display context to user**:

```
Resuming: {epic-name}

Phase: {phase}
Progress: {progress summary}

Last working on: {last_working_on}
Blockers: {blockers if any}

Context restored from: {parked_at timestamp}
```

**Phase-specific context**:

**Planning Phase**:
```
Stories defined: {count}
Tasks defined: {count}
Test specs: {count}
Last working on: {specific story/task}

Ready to continue planning mode.
Enter planning mode: Shift+Tab×2
```

**TDD Tests Written**:
```
Tests written: {count}
Tests status: Not run yet
Last working on: {specific test}

Next step: Review tests against plan
Then: Implement to make tests pass (GREEN)
```

**TDD Implementation**:
```
Tests passing: {X/Y}
Implementation: {progress}
Last working on: {specific feature/test}

Next step: Make remaining {Y-X} tests pass
Keep tests unchanged during implementation
```

**TDD Refactor**:
```
Tests passing: {X/X} (all green)
Refactoring: {what was being refactored}

Next step: Improve code quality while keeping tests green
```

**Review Phase**:
```
Reviews complete: {which reviewers}
Issues found: {count}
Status: {pass/concerns/fail}

Next step: Address review feedback and re-run reviews
```

---

### Step 6: Update Workflow State

**Remove from parked_work**:
```yaml
parked_work:
  # Remove the resumed Epic entry
```

**Update Epic status**:
```yaml
products:
  {product-name}:
    epics:
      - name: "{epic-name}"
        status: "in_progress"  # Changed from parked
        resumed_at: "{YYYY-MM-DD HH:MM}"
        # ... other fields ...
```

**Update current work tracking**:
```yaml
current_work:
  epic: "{epic-name}"
  phase: "{phase}"
  resumed_at: "{YYYY-MM-DD HH:MM}"
```

---

### Step 7: Offer Next Actions

**Based on phase, suggest next steps**:

**Planning**:
```
Continue planning mode? [y/n]
Enter planning mode: Shift+Tab×2
Or manually define Stories/Tasks in Epic file.
```

**TDD Tests Written**:
```
Review tests against plan before implementing? [y/n]
Or run tests to verify RED state: npm test
```

**TDD Implementation**:
```
Run tests to see current status? [y/n]
Command: npm test
Then continue implementing to make tests pass.
```

**Review**:
```
Review reports available:
- {reviewer 1}: {status}
- {reviewer 2}: {status}

Address review feedback? [y/n]
```

---

## Git Stash Cleanup

**After successful resume**:

**Option 1: Keep stash** (default, safer):
- Stash remains in git stash list
- User can drop manually later
- Safety net if resume didn't work

**Option 2: Drop stash** (optional):
```bash
git stash drop {stash-ref}
```

**Recommendation**: Keep stash until Epic complete, then offer cleanup

---

## Multi-Work-Stream Example

**Scenario**: User has parked multiple items, juggling priorities

```
User: "Resume work"

Claude:
You have 3 parked work items:

1. user-authentication (TDD Implementation) - parked 2 hours ago
   5/8 tests passing, working on password complexity
   Reason: Switched to fix-auth-bug (now complete)

2. dashboard-analytics (Planning) - parked yesterday
   4 stories, 12 tasks defined
   Reason: End of session

3. payment-processing (TDD Tests Written) - parked 3 days ago
   8 tests written, ready for implementation
   Reason: Switched to user-authentication

Which would you like to resume? [1-3]

User: "1"

Claude:
Resuming: user-authentication

Restoring git stash... ✓
Git stash applied: stash@{0}

Phase: TDD Implementation
Progress: 5/8 tests passing
Last working on: Password complexity validation test

Next step: Make remaining 3 tests pass
Files modified:
- src/auth/validation.test.ts
- src/auth/validation.ts

Ready to continue. Run `npm test` to see current test status.
```

---

## Example Usage

### Example 1: Simple Resume (One Parked Item)

```
User: "Resume"

Claude:
Resuming: user-authentication

Only one parked item found, auto-selecting...

Restoring git stash... ✓
Applied stash@{0}

Phase: TDD Implementation
Progress: 5/8 tests passing
Last working on: Password complexity validation

Files restored:
- src/auth/validation.test.ts (modified)
- src/auth/validation.ts (modified)

Epic status: in_progress
Context: You were implementing password complexity rules

Next step: Make remaining 3 tests pass
Run: npm test

Ready to continue!
```

---

### Example 2: Resume with Active Work (Park Current)

```
User: "Resume dashboard-analytics"

Claude:
You're currently working on: payment-processing
Phase: TDD Implementation
Progress: 4/6 tests passing

Options:
1. Park payment-processing and resume dashboard-analytics
2. Cancel, continue payment-processing

User: "1"

Claude:
Parking current work: payment-processing
✓ Git stash created: stash@{0}
✓ Context saved

Resuming: dashboard-analytics

Restoring git stash... ✓
Applied stash@{1}

Phase: Planning
Progress: 4 stories defined, working on task breakdown
Last working on: Data fetching tasks

No git changes (planning phase - no code yet)

Ready to continue planning mode.
Enter: Shift+Tab×2
```

---

### Example 3: Resume After Completing Urgent Work

```
[User completed P0 fix-auth-bug, now returning to original work]

User: "What was I working on before the bug?"

Claude:
Before fix-auth-bug, you were working on: user-authentication

Parked work:
1. user-authentication (TDD Implementation)
   Progress: 5/8 tests passing
   Parked: 2 hours ago when switching to fix-auth-bug

Resume this work? [y/n]

User: "y"

Claude:
Resuming: user-authentication

Restoring git stash... ✓
Phase: TDD Implementation
Progress: 5/8 tests passing
Last working on: Password complexity validation

You left off implementing password validation rules.
3 tests still failing.

Run `npm test` to see current status.
```

---

### Example 4: Resume Planning Work (No Git State)

```
User: "Resume dashboard-analytics"

Claude:
Resuming: dashboard-analytics

Phase: Planning
Progress: 4 stories defined, 12 tasks defined
Last working on: Test specifications for chart rendering

No git stash found (planning phase - no code changes yet)

Context:
Stories:
1. Data fetching from API ✓
2. Chart rendering ✓
3. User filters ✓
4. Export functionality ✓

Tasks defined: 12/estimated 15
Test specs: In progress

Last notes: "Need to define edge cases for empty data states"

Ready to continue planning mode.
Enter: Shift+Tab×2
```

---

## Relationship to Other Skills

**Called by**:
- User request ("resume", "resume {epic-name}")
- `add-work` (after completing urgent work, offer to resume previous)

**Calls**:
- Git commands (stash apply)
- Workflow.yaml updates
- Potentially `park` (if parking current work first)

**Complementary**:
- `park`: Opposite operation (save work)
- `list-work`: View all work including parked
- `add-work`: May trigger park, later resume previous work

---

## Handling Edge Cases

### Edge Case 1: Stash No Longer Exists

```
Git stash reference: stash@{0}
Checking git stash list... NOT FOUND

Warning: Git stash was dropped or expired.
Code state cannot be restored.

Conceptual context:
Phase: {phase}
Progress: {progress}
Last working on: {item}

Continue resume without code restoration? [y/n]
```

**If yes**: Restore conceptual context only
**If no**: Cancel resume

---

### Edge Case 2: Git Conflicts on Apply

```
Applying git stash... CONFLICT

Conflicted files:
- src/auth/validation.ts
- src/auth/validation.test.ts

Manual resolution required.

Steps:
1. Resolve conflicts in files above
2. Run: git add {resolved-files}
3. Continue with Epic work

Conceptual context still restored.
Epic status: in_progress
Phase: {phase}
```

---

### Edge Case 3: Epic Deleted/Changed

```
Parked work: user-authentication
Checking Epic file... NOT FOUND

Error: Epic file was deleted or moved.
Cannot resume.

Options:
1. Remove from parked work (abandon)
2. Recreate Epic file (manual)
3. Cancel

Choose:
```

---

## Tips for Success

**DO**:
- ✅ Verify git stash exists before applying
- ✅ Restore conceptual context even if git stash fails
- ✅ Update Epic status to in_progress
- ✅ Show clear next actions based on phase
- ✅ Handle conflicts gracefully

**DON'T**:
- ❌ Drop stash on apply (use apply, not pop)
- ❌ Forget to update workflow.yaml
- ❌ Resume without checking for active work
- ❌ Lose context if git stash missing
- ❌ Auto-resume without user selection (if multiple parked)

---

## What's Next

**After resuming work**:

**Planning Phase**:
- Enter planning mode (Shift+Tab×2)
- Continue defining Stories/Tasks/Tests

**TDD Phase**:
- Run tests: `npm test`
- Continue TDD cycle (RED → GREEN → REFACTOR)

**Review Phase**:
- Read review reports
- Address feedback
- Re-run reviews

**Use `list-work` to see all work and priorities**

---

## Verification Checklist

**Before considering resume complete**:

- [ ] Epic retrieved from parked_work
- [ ] Git stash applied (if exists) or skipped (if none)
- [ ] Conceptual context displayed to user
- [ ] Epic status updated to "in_progress"
- [ ] Removed from parked_work in workflow.yaml
- [ ] Next actions suggested to user
- [ ] current_work tracking updated

---

## Integration with Workflow

**Common flow**:

1. **Work on Epic A** → progress made
2. **Urgent work arises** → `add-work` (P0/P1)
3. **`park` called automatically** → Epic A parked
4. **Complete urgent work** → Epic B done
5. **`resume` Epic A** → Return to original work
6. **Complete Epic A** → Done

**Multi-stream juggling**:

1. Epic A → parked (reason: end of session)
2. Epic B → parked (reason: blocker encountered)
3. Epic C → in progress
4. `resume` Epic A → restore and complete
5. `resume` Epic B → return after blocker resolved
