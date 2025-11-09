---
name: resume
description: Restore parked work (code via git stash + context from workflow.yaml). Use when ready to continue parked Epic. Lists parked items, user selects, restores git stash (if exists), updates Epic status to in_progress, suggests next actions by phase.
---

## Instructions

Restore both code state (git stash apply) and conceptual progress (workflow.yaml) to continue parked work.

### When to Use

**Use**: Ready to return to parked Epic, completed urgent work, starting new session with parked work, user requests "resume {epic-name}"

**Don't Use**: No parked work exists, want to start new work (use `add-work`), Epic is complete

### Process (7 Steps)

**Step 1: List Parked Work**

Query workflow.yaml for `parked_work` entries.

**If multiple**: Display numbered list with Epic name, phase, progress, parked time, reason, git stash ref

**If one**: Auto-select, show context, proceed

**If none**: "No parked work found. Active work: {current Epic}. Use `list-work` to see all work items."

---

**Step 2: User Selection**

Accept: number (1, 2), Epic name ("user-authentication"), or "resume" (auto-select most recent)

Validate Epic exists in parked_work, retrieve full context from workflow.yaml

---

**Step 3: Check Current Work**

**If no active work**: Proceed with resume

**If active work exists**: Offer options:
1. Park current work and resume {selected Epic}
2. Cancel, continue current work

If Option 1: Call `park` skill → then resume

---

**Step 4: Restore Git State**

**If git stash exists**:
```bash
git stash list  # Verify exists
git stash apply {stash-ref}  # Don't drop yet (safety)
```

**Handle conflicts**: Notify user, show conflicted files, guide manual resolution

**If no git stash** (planning phase): Skip git restore, proceed with conceptual context

---

**Step 5: Restore Conceptual Context**

Display:
```
Resuming: {epic-name}
Phase: {phase}
Progress: {progress summary}
Last working on: {last_working_on}
Blockers: {blockers if any}
```

**Phase-specific guidance**:
- **Planning**: "Stories: {count}, Tasks: {count}. Enter planning mode: Shift+Tab×2"
- **TDD Tests**: "Tests written: {count}. Next: Review tests, then implement (GREEN)"
- **TDD Implementation**: "Tests passing: {X/Y}. Next: Make remaining {Y-X} pass"
- **TDD Refactor**: "All tests green. Next: Improve code quality"
- **Review**: "Reviews: {list}. Next: Address feedback"

---

**Step 6: Update Workflow State**

Remove from `parked_work`, update Epic status to `in_progress`, set `current_work` tracking

```yaml
parked_work: []  # Remove resumed Epic

products:
  {product-name}:
    epics:
      - name: "{epic-name}"
        status: "in_progress"  # Changed from "parked"
        resumed_at: "{YYYY-MM-DD HH:MM}"

current_work:
  epic: "{epic-name}"
  phase: "{phase}"
  resumed_at: "{YYYY-MM-DD HH:MM}"
```

---

**Step 7: Suggest Next Actions**

Based on phase:
- **Planning**: "Continue planning mode? Shift+Tab×2"
- **TDD Tests**: "Run tests to verify RED: `npm test`"
- **TDD Implementation**: "Run tests: `npm test`, then continue implementing"
- **Review**: "Review reports available. Address feedback?"

### Git Stash Cleanup

**Default**: Keep stash (safety net). User can manually drop later with `git stash drop {stash-ref}`

**Recommendation**: Keep stash until Epic complete, then offer cleanup

### Edge Cases

**Stash Missing**: Warn user code state lost, offer to restore conceptual context only or cancel

**Git Conflicts**: Notify user, show conflicted files, guide manual resolution (resolve → `git add` → continue)

**Epic Deleted**: Error message, offer options: Remove from parked (abandon), Recreate Epic file (manual), Cancel

### Success Guidelines

**DO**: ✅ Verify stash exists, restore conceptual context even if stash fails, update Epic status, show next actions, handle conflicts gracefully

**DON'T**: ❌ Drop stash on apply (use apply not pop), forget workflow.yaml updates, resume without checking active work, lose context if stash missing

### Examples

**See detailed scenarios**: `.aknakos/examples/workflows/resume-scenarios.md` (9 scenarios covering simple resume, multiple parked items, active work, planning work, edge cases, multi-work-stream juggling)

### Related Skills

- **`park`**: Opposite operation (save work)
- **`list-work`**: View all work including parked
- **`add-work`**: May trigger park, later resume previous

### Verification Checklist

Before complete:
- [ ] Epic retrieved from parked_work
- [ ] Git stash applied (if exists) or skipped
- [ ] Conceptual context displayed
- [ ] Epic status updated to "in_progress"
- [ ] Removed from parked_work in workflow.yaml
- [ ] Next actions suggested
- [ ] current_work tracking updated
