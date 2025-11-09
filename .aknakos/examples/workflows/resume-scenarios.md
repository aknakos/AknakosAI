# Resume Skill - Usage Scenarios

This document shows common scenarios for resuming parked work.

---

## Scenario 1: Simple Resume (One Parked Item)

**Context**: User parked work and is ready to continue. Only one parked item exists.

**Command**: `resume` or `resume {epic-name}`

**Flow**:

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

## Scenario 2: Multiple Parked Items (User Selects)

**Context**: User has parked 3 different work items at various times.

**Flow**:

```
User: "Resume work"

Claude:
You have 3 parked work items:

1. user-authentication (TDD Implementation) - parked 2 hours ago
   5/8 tests passing, working on password complexity
   Reason: Switched to fix-auth-bug (now complete)
   Git stash: stash@{0}

2. dashboard-analytics (Planning) - parked yesterday
   4 stories, 12 tasks defined
   Reason: End of session
   Git stash: none

3. payment-processing (TDD Tests Written) - parked 3 days ago
   8 tests written, ready for implementation
   Reason: Switched to user-authentication
   Git stash: stash@{2}

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

## Scenario 3: Resume with Active Work (Park Current First)

**Context**: User is working on Epic A, wants to resume Epic B.

**Flow**:

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
✓ Context saved to workflow.yaml

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

## Scenario 4: Resume After Completing Urgent Work

**Context**: User switched to P0 urgent work (fix-auth-bug), now returning to original work.

**Flow**:

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

## Scenario 5: Resume Planning Work (No Git State)

**Context**: User parked work during planning mode (no code written yet).

**Flow**:

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

## Scenario 6: Git Stash No Longer Exists (Edge Case)

**Context**: Git stash was manually dropped or expired.

**Flow**:

```
User: "Resume user-authentication"

Claude:
Git stash reference: stash@{0}
Checking git stash list... NOT FOUND

Warning: Git stash was dropped or expired.
Code state cannot be restored.

Conceptual context:
Phase: TDD Implementation
Progress: 5/8 tests passing
Last working on: Password complexity validation

Continue resume without code restoration? [y/n]

User: "y"

Claude:
Resuming conceptual context only...

Epic: user-authentication
Phase: TDD Implementation
Progress: 5/8 tests passing
Last working on: Password complexity validation

Code changes lost. You'll need to re-implement:
- src/auth/validation.test.ts (tests)
- src/auth/validation.ts (implementation)

Context restored. Epic status: in_progress
```

---

## Scenario 7: Git Conflicts on Apply (Edge Case)

**Context**: Code has diverged since parking (e.g., merge from main).

**Flow**:

```
User: "Resume user-authentication"

Claude:
Applying git stash... CONFLICT

Conflicted files:
- src/auth/validation.ts
- src/auth/validation.test.ts

Manual resolution required.

Steps:
1. Resolve conflicts in files above
2. Run: git add {resolved-files}
3. Continue with Epic work

Conceptual context still restored:
Epic status: in_progress
Phase: TDD Implementation
Progress: 5/8 tests passing
Last working on: Password complexity validation

After resolving conflicts, run `npm test` to verify tests still pass.
```

---

## Scenario 8: No Parked Work Found

**Context**: User tries to resume but no parked work exists.

**Flow**:

```
User: "Resume"

Claude:
No parked work found.

Active work: payment-processing (TDD Implementation, 4/6 tests passing)
Use `list-work` to see all work items.
```

---

## Scenario 9: Multi-Work-Stream Juggling

**Context**: User manages multiple streams, switching frequently based on priority.

**Flow**:

```
Timeline:
Day 1 Morning: Start Epic A (user-authentication)
Day 1 Afternoon: P0 bug arrives → park Epic A, start Epic B (fix-auth-bug)
Day 1 Evening: Epic B complete → resume Epic A
Day 2 Morning: Continue Epic A
Day 2 Afternoon: Epic C arrives (payment-processing, P1) → park Epic A, start Epic C
Day 3 Morning: Blocker on Epic C → park Epic C, resume Epic A
Day 3 Afternoon: Epic A complete
Day 3 Evening: Resume Epic C (blocker resolved)

User: "Resume"

Claude:
You have 1 parked work item:

1. payment-processing (TDD Implementation) - parked yesterday
   4/6 tests passing
   Reason: Blocker encountered (waiting for API docs)

Resume this work? [y/n]

User: "y"

Claude:
Resuming: payment-processing

Restoring git stash... ✓
Phase: TDD Implementation
Progress: 4/6 tests passing
Parked reason: Blocker - waiting for API docs

Is the blocker resolved? [y/n]

User: "y"

Claude:
Great! Continuing with Epic implementation.

Files restored:
- src/payments/stripe.test.ts
- src/payments/stripe.ts

Next step: Complete remaining 2 tests
Run `npm test` to verify current state
```

---

## Common Patterns

**Pattern 1: Single Parked Item**
- Auto-select (don't ask for confirmation)
- Restore git state
- Show context
- Suggest next action

**Pattern 2: Multiple Parked Items**
- Display numbered list with context
- User selects by number or Epic name
- Restore selected item

**Pattern 3: Active Work Exists**
- Offer to park current work first
- User decides: park-and-resume or cancel
- If park: call `park` skill → then resume

**Pattern 4: No Git State**
- Planning phase or clean state
- Restore conceptual context only
- Guide user to planning mode or next phase

**Pattern 5: Edge Cases**
- Stash missing: Restore conceptual context, warn about code loss
- Conflicts: Guide manual resolution, maintain conceptual context
- Epic deleted: Error, offer to remove from parked work

---

## State Transitions

**Before Resume**:
```yaml
parked_work:
  - epic: "user-authentication"
    phase: "tdd_implementation"
    status: "parked"
    git_stash: "stash@{0}"

current_work: null  # No active work
```

**After Resume**:
```yaml
parked_work: []  # Removed from parked

current_work:
  epic: "user-authentication"
  phase: "tdd_implementation"
  resumed_at: "2025-11-09 14:30"

products:
  {product-name}:
    epics:
      - name: "user-authentication"
        status: "in_progress"  # Changed from "parked"
```

---

## Next Actions by Phase

**Planning**:
- Enter planning mode: Shift+Tab×2
- Continue defining Stories/Tasks/Test specs

**TDD Tests Written**:
- Run tests to verify RED state: `npm test`
- Review tests against plan
- Proceed to implementation

**TDD Implementation**:
- Run tests to see current status: `npm test`
- Continue implementing to make tests pass
- Keep tests unchanged

**TDD Refactor**:
- Improve code quality while keeping tests green
- Run tests after each refactor

**Review**:
- Read review reports
- Address feedback
- Re-run reviews if needed
