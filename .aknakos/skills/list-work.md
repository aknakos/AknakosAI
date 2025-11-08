# Skill: List Work

**Purpose**: Display all work items with statuses, priorities, and progress

**Phase**: Any phase

**When to Use**: When user wants to see overview of all work (active, parked, backlog, complete)

---

## What This Skill Does

Provides comprehensive view of all Epics across all states, filtered and sorted by priority and status.

**Shows**:
- Epic name and description
- Current status (backlog, drafted, planning, in_progress, parked, complete)
- Priority (P0-P3)
- Progress summary
- Dependencies
- Blockers

**Enables**:
- Work prioritization decisions
- Context switching planning
- Progress tracking
- Identifying what to work on next

---

## When to Use This Skill

**Use when**:
- User asks "what's on my plate?"
- Need to decide what to work on next
- Want to see parked work
- Check backlog items
- Review overall progress
- User requests "list-work" or "show all work"

**Don't use when**:
- Only want current work (use `whats-next`)
- Only want parked work (handled by `resume`)
- Want detailed Epic info (read Epic file directly)

---

## Display Format

### Overview Section

```
Work Overview for: {product-name}

Active Work: {epic-name} ({phase}) ← Currently working
Parked Work: {count} items
Drafted Work: {count} items (ready for planning)
Backlog: {count} items
Complete: {count} epics

Total Epics: {total}
```

---

### Priority Sections

**Group by priority, then status within each priority**:

```
========================================
Priority P0 (Critical)
========================================

IN PROGRESS:
1. fix-auth-service
   Status: In Progress (TDD Implementation)
   Progress: 6/8 tests passing
   Started: 2025-11-08
   Complexity: 7
   Description: Fix critical authentication bug preventing user login

PARKED:
(none)

DRAFTED:
(none)

BACKLOG:
(none)

========================================
Priority P1 (Urgent)
========================================

IN PROGRESS:
(none)

PARKED:
2. user-authentication
   Status: Parked (TDD Implementation)
   Progress: 5/8 tests passing
   Parked: 2025-11-08 14:30 (2 hours ago)
   Reason: Switched to P0 work
   Complexity: 6
   Description: Implement user authentication with email/password
   Git stash: stash@{0}

DRAFTED:
3. password-reset-flow
   Status: Drafted (ready for planning)
   Created: 2025-11-08
   Complexity: 4
   Description: Add password reset functionality via email
   Quick validated: Yes
   Full validated: No

BACKLOG:
(none)

========================================
Priority P2 (Normal)
========================================

IN PROGRESS:
(none)

PARKED:
4. dashboard-analytics
   Status: Parked (Planning)
   Progress: 4 stories, 12 tasks defined
   Parked: 2025-11-07 16:45 (yesterday)
   Reason: End of session
   Complexity: 5
   Description: Build analytics dashboard with charts and filters

DRAFTED:
5. user-profile-management
   Status: Drafted
   Created: 2025-11-06
   Complexity: 3
   Description: User profile CRUD operations
   Full validated: Yes

BACKLOG:
6. notification-system
   Status: Backlog
   Created: 2025-11-05
   Complexity: 6
   Description: Email and in-app notifications
   Dependencies: user-authentication

========================================
Priority P3 (Low)
========================================

BACKLOG:
7. dark-mode-toggle
   Status: Backlog
   Created: 2025-11-04
   Complexity: 2
   Description: Add dark mode theme option

8. export-to-csv
   Status: Backlog
   Created: 2025-11-03
   Complexity: 3
   Description: Export analytics data to CSV
   Dependencies: dashboard-analytics

========================================
COMPLETE
========================================

✓ initial-setup (P2) - Completed: 2025-11-01
✓ database-schema (P1) - Completed: 2025-11-03
✓ fix-auth-bug (P0) - Completed: 2025-11-08
```

---

### Summary Footer

```
========================================
Next Actions
========================================

Suggested next steps:
1. Complete fix-auth-service (P0 in progress - 2 tests remaining)
2. Resume user-authentication (P1 parked - high priority)
3. Start password-reset-flow (P1 drafted - ready for planning)

Use:
- `resume {epic-name}` to restore parked work
- `add-work` to capture new work
- `promote-epic {epic-name}` to move backlog → drafted
- Planning mode (Shift+Tab×2) to work on drafted Epics
```

---

## Filtering Options

**Basic (Default)**: Show all work across all priorities and statuses

**Filter by Priority**:
```
User: "list-work P1"
Claude: [Shows only P1 Epics]
```

**Filter by Status**:
```
User: "list-work parked"
Claude: [Shows only parked Epics across all priorities]

User: "list-work backlog"
Claude: [Shows only backlog items]
```

**Combined Filters**:
```
User: "list-work P1 parked"
Claude: [Shows P1 Epics that are parked]
```

---

## Sorting Options

**Default Sort**:
1. Priority (P0 → P3)
2. Status (in_progress → parked → drafted → backlog → complete)
3. Date (most recent first)

**Alternative Sorts** (user request):

**By Date**:
```
User: "list-work by date"
Claude: [Shows all work sorted by created/updated date]
```

**By Complexity**:
```
User: "list-work by complexity"
Claude: [Shows all work sorted by complexity estimate]
```

---

## Compact vs Detailed View

### Compact View (Default)

Show essentials only:
- Epic name
- Status and phase
- Priority
- Progress summary
- Key dates

### Detailed View (User Request)

```
User: "list-work detailed"
```

Include additional info:
- Full description
- All acceptance criteria
- Dependencies
- Blockers
- PRD requirement references
- Review status

---

## Example Usage

### Example 1: Quick Overview

```
User: "What work do I have?"

Claude: [Using list-work skill]

Work Overview for: my-product

Active Work: fix-auth-service (TDD Implementation)
Parked Work: 2 items
Drafted Work: 1 item
Backlog: 4 items
Complete: 3 epics

Priority P0 (Critical):
1. fix-auth-service (IN PROGRESS)
   Progress: 6/8 tests passing
   Description: Fix critical auth bug

Priority P1 (Urgent):
2. user-authentication (PARKED)
   Parked: 2 hours ago
   Progress: 5/8 tests passing

3. password-reset-flow (DRAFTED)
   Ready for planning
   Quick validated: Yes

Priority P2 (Normal):
4. dashboard-analytics (PARKED)
   Parked: Yesterday
   Progress: Planning phase, 4 stories defined

5. user-profile-management (DRAFTED)
   Full validated: Yes

[... continues ...]

Next Actions:
1. Complete fix-auth-service (2 tests remaining)
2. Resume user-authentication (high priority parked work)
```

---

### Example 2: Filter by Status

```
User: "Show me all parked work"

Claude: [Using list-work skill with filter]

Parked Work (2 items):

1. user-authentication (Priority: P1)
   Phase: TDD Implementation
   Progress: 5/8 tests passing
   Parked: 2025-11-08 14:30 (2 hours ago)
   Reason: Switched to P0 work
   Git stash: stash@{0}

2. dashboard-analytics (Priority: P2)
   Phase: Planning
   Progress: 4 stories, 12 tasks defined
   Parked: 2025-11-07 16:45 (yesterday)
   Reason: End of session
   Git stash: none

Use `resume {epic-name}` to restore parked work.
```

---

### Example 3: Backlog Planning

```
User: "What's in the backlog?"

Claude: [Using list-work skill with backlog filter]

Backlog Items (4 items):

Priority P2:
1. notification-system
   Complexity: 6
   Description: Email and in-app notifications
   Dependencies: user-authentication (in progress)
   Status: Blocked until user-authentication complete

Priority P3:
2. dark-mode-toggle
   Complexity: 2
   Description: Add dark mode theme option
   Dependencies: None
   Status: Ready to start

3. export-to-csv
   Complexity: 3
   Description: Export analytics to CSV
   Dependencies: dashboard-analytics (parked)
   Status: Blocked

4. email-templates
   Complexity: 4
   Description: Customizable email templates
   Dependencies: notification-system (backlog)
   Status: Blocked

Suggested Actions:
- Promote dark-mode-toggle (no blockers, quick win)
- Wait on notification-system until user-authentication complete
- Consider prioritizing dashboard-analytics to unblock export-to-csv

Use `promote-epic {name}` to move items from backlog to drafted.
```

---

## Data Source

**Pulls from**:
- `.aknakos/state/workflow.yaml`:
  - Epic list with statuses
  - Priority assignments (P0-P3)
  - Parked work metadata
  - Current work tracking

- Epic files (`products/{name}/epics/*.md`):
  - Full descriptions
  - Acceptance criteria
  - Dependencies
  - Complexity estimates
  - Notes

**Aggregates and displays**:
- Sorted by priority and status
- Formatted for readability
- Includes action suggestions

---

## Visual Indicators

**Status Symbols**:
- 🔴 P0 (Critical)
- 🟠 P1 (Urgent)
- 🟡 P2 (Normal)
- 🟢 P3 (Low)
- ✓ Complete
- ⏸ Parked
- 📝 Drafted
- 📋 Backlog
- 🚧 In Progress

**Progress Indicators**:
- Tests: `[██████░░░░] 6/10 passing`
- Tasks: `[████████░░] 8/10 complete`
- Stories: `4/5 defined`

---

## Relationship to Other Skills

**Complements**:
- `whats-next`: Shows current phase and next action (narrower scope)
- `resume`: Shows parked work (subset of list-work)
- `add-work`: Adds items shown in list-work
- `promote-epic`: Moves items between statuses shown in list-work

**Called by**:
- User request ("list-work", "show all work", "what's on my plate")
- After `add-work` completes (show updated list)
- After `resume` to show remaining parked items

---

## Tips for Success

**DO**:
- ✅ Group by priority (P0 first, most important)
- ✅ Show actionable next steps
- ✅ Highlight blockers and dependencies
- ✅ Include time context (how long parked, when created)
- ✅ Provide filtering options for large lists

**DON'T**:
- ❌ Overwhelm with too much detail (use compact view)
- ❌ Hide critical information (P0 should be prominent)
- ❌ Forget to show dependencies (affects prioritization)
- ❌ Omit git stash info for parked work
- ❌ Skip next action suggestions

---

## What's Next

**After viewing list-work**:

**To act on work**:
- `resume {epic-name}`: Restore parked work
- `add-work`: Create new Epic
- `promote-epic {epic-name}`: Move backlog → drafted
- Planning mode (Shift+Tab×2): Work on drafted Epic

**To understand current state**:
- `whats-next`: Current phase and next action
- Read Epic file: Detailed Epic information
- View workflow.yaml: Raw state data

---

## Advanced Features

### Dependency Graph (Optional)

**Show Epic dependencies**:
```
Dependencies:

user-authentication (P1, in progress)
  ↓
  └─ notification-system (P2, backlog) - BLOCKED
       ↓
       └─ email-templates (P3, backlog) - BLOCKED

dashboard-analytics (P2, parked)
  ↓
  └─ export-to-csv (P3, backlog) - BLOCKED
```

### Time Estimates (Optional)

**Based on complexity and historical data**:
```
Time Estimates:

In Progress:
- fix-auth-service: ~2 hours remaining (6/8 tests)

Drafted:
- password-reset-flow: ~1-2 days (complexity 4)
- user-profile-management: ~3-5 days (complexity 3)

Total backlog: ~3-4 weeks
```

### Burndown (Optional)

**Track completion rate**:
```
Completion Progress:

Week 1: 3 epics complete
Week 2: 2 epics complete (current)
Week 3: 4 epics planned

Velocity: ~2.5 epics/week
Estimated completion: 2-3 weeks for all drafted work
```

---

## Integration with Roadmap

**Cross-reference with roadmap.md**:
- Show which roadmap phase each Epic belongs to
- Highlight if Epic is ahead/behind roadmap schedule
- Suggest roadmap updates if priorities shifted

**Example**:
```
Roadmap Alignment:

Phase 1 (MVP - Due: 2025-11-15):
- ✓ database-schema (complete)
- 🚧 user-authentication (in progress - on track)
- 📝 password-reset-flow (drafted - on track)
- ⏸ dashboard-analytics (parked - AT RISK)

Recommendation: Resume dashboard-analytics to stay on MVP schedule
```
