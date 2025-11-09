# Park Skill Usage Scenarios

## Scenario 1: Automatic Park (P0 Critical Work)

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

## Scenario 2: Manual Park (End of Session)

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

## Scenario 3: Multiple Parked Works

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

## Git Stash Examples

### Stash with Code Changes
```bash
# Create stash with descriptive message
git stash push -u -m "PARK: user-authentication - tdd_implementation - 2025-11-08"

# List parked stashes
git stash list | grep "PARK:"
# Output:
# stash@{0}: On main: PARK: user-authentication - tdd_implementation - 2025-11-08
```

### Stash Naming Convention
```
Format: PARK: {epic-name} - {phase} - {YYYY-MM-DD}

Examples:
- PARK: user-authentication - tdd_implementation - 2025-11-08
- PARK: dashboard-analytics - planning - 2025-11-08
- PARK: password-reset - tdd_tests_written - 2025-11-08
```

### Apply Specific Stash (done by resume skill)
```bash
git stash apply stash@{0}
```

---

## Workflow.yaml Tracking Example

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
